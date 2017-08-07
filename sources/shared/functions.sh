#############
# FUNCTIONS #
#############

av() {
   mediainfo --Inform="General;Duration=%Duration/String3%\nFile size=%FileSize/String1%" "$@"
   mediainfo --Inform="Video;Resolution=%Width%x%Height%\nCodec=%CodecID%" "$@";
}

mupload() {
  for item in "$@"; do
    cp -r "$item" "/seed/music_uploads"; 
  done; 
}

filter() {
  ls . | grep -i "$1";
}

################
# HTPC HELPERS #
################

export HTPC_ENV_SEED="/seed";
export HTPC_ENV_STAGE="/seed/.htpc/stage";
export HTPC_ENV_DEPLOY="/seed/.htpc/deploy";
export HTPC_ENV_POOL="/mnt/pool/data/public";

export HTPC_FILEBOT_FORMATS=(
  "Base : {n} [{vf}]" 
  "TV : {n.upperInitial()}/{n.upperInitial()} S{s.pad(2)}/{n.upperInitial().space('.')}.{s00e00} [{vf}] - {t}"
  "Movies : {n} ({y}) [{vf}]"
);

htpc-rm() {
  put_command "REMOVE TORRENTS AND DELETE ITEMS";

  put_note "Marked for removal:";
  for item in "$@"; do
    put_bullet_1 "$item"
  done;

  proceed_prompt;

  remove_torrents $@;

  put_note "Deleting data..."
  for item in "$@"; do
    put_bullet_1 "\"$item\"";
    rm -rf "$item";
  done;
}

htpc-stage() {
  put_command "STAGE ITEMS";

  put_note "Marked for staging:";
  for item in "$@"; do
    put_bullet_1 "$item"
  done;

  proceed_prompt;

  remove_torrents $@;

  put_note "Moving items to staging zone ($(highlight "${HTPC_ENV_STAGE}"))";
  for item in "$@"; do
    put_bullet_1 "$(mv -v "$item" "${HTPC_ENV_STAGE}")";
  done;
}

htpc-search() {
  query="${@:1}";
  zone='/mnt/pool/data/public';
  if [[ "$1" == "${HTPC_ENV_SEED}" ]]; then
    zone="${HTPC_ENV_SEED}";
    query="${@:2}";
  fi;
  find $zone | fzf --border --height=20% --prompt='? ' -i -q "$query";
}

htpc-fmt() {
  put_command "FORMATTING ITEMS FOR DEPLOYMENT";

  for item in "$@"; do
    put_note "Preparing Item [ $(highlight "${item}") ]";

    # TODO: clear zero length files
    # TODO: workflow is too slow.  find a way to apply settings to batch?

    put_prompt "Select Destination:"; echo;
    select destination in ${HTPC_ENV_DEPLOY}/*; do 
      test -n "$destination" && break; 
      echo ">>> Invalid Selection"; 
    done

    put_prompt "Select Filebot Format:"; echo;
    select filebot_format in ${HTPC_FILEBOT_FORMATS}; do 
      test -n "$filebot_format" && break; 
      echo ">>> Invalid Selection"; 
    done

    # TODO: tie metadata source to format, only expose this prompt if flagged
    put_prompt "Select Metadata Source:"; echo;
    select database in "none" "themoviedb" "thetvdb"; do 
      test -n "$database" && break; 
      echo ">>> Invalid Selection"; 
    done

    put_note "Formatting Item [ $(highlight "${item}") ]";
    if [[ "$database" == "none" ]]; then
      filebot -rename -non-strict --mode interactive --db "$database" --format "${destination}/${filebot_format#* : }" $item;
    else
      filebot -rename -non-strict --mode interactive --format "${destination}/${filebot_format#* : }" $item;
    fi;
  done;

  # TODO: clear empty directories

  put_note "Ready to Deploy:";
  ls ${HTPC_ENV_DEPLOY}/*;
}

htpc-deploy() {
  put_command "DEPLOYING ITEMS TO POOL (RSYNC)"

  put_note "Clearing zero-length files...";
  find ${HTPC_ENV_DEPLOY} -size 0 -delete;

  put_note "Marked for Sync:";
  find ${HTPC_ENV_DEPLOY} -maxdepth 1 ! -path ${HTPC_ENV_DEPLOY} -print | while read media_type; do
    find ${media_type} -maxdepth 1 ! -path ${media_type} -print | while read item; do
      put_bullet_1 "$item"
    done;
  done;

  put_note "Sync (Dry Run):";
  rsync --dry-run -nthri --stats "${HTPC_ENV_DEPLOY}/" "${HTPC_ENV_POOL}/";
  proceed_prompt;

  put_note "Syncing...";
  rsync --progress --ignore-existing -thri --stats "${HTPC_ENV_DEPLOY}/" "${HTPC_ENV_POOL}/";

  put_note "Summary [ $(highlight "$(du -cksh "${HTPC_ENV_DEPLOY}" | cut -f1 | uniq)") moved to $(highlight "${HTPC_ENV_POOL}") ]";
  echo;
  find ${HTPC_ENV_DEPLOY} -maxdepth 1 ! -path ${HTPC_ENV_DEPLOY} -print | while read media_type; do

    if [ ! -z "$(ls "${media_type}")" ]; then
      echo -e "${GREEN}|---${BLUE}$(basename ${media_type})${RESET} ($(highlight "$(du -cksh "${media_type}" | cut -f1 | uniq)") pooled)${RESET}";
    fi;

    find ${media_type} -mindepth 1 -maxdepth 1 ! -path ${media_type} -not -empty -print | while read item; do
      tree -Q "${HTPC_ENV_POOL}" | grep -C 1 "$(tree_sanitize $item)";
      echo "${GREEN}|...${RESET}";
    done;

    if [ ! -z "$(ls "${media_type}")" ]; then
      echo -e "${GREEN}|----------------------${RESET}";
      echo;
    fi;
  done;

  put_note "Cleaning Deployment Zone...";
  proceed_prompt;
  rm -rf ${HTPC_ENV_DEPLOY}/*/*
}

remove_torrents() {
  put_note "Removing torrents...";

  for item in "$@"; do
    result=$(\
      rtcontrol --delete --yes "$(rtc_sanitize $item)" | \
      sed -n 's/.*DELETE \([0-9]\+\).*/\1/p' | \
      tr -d '\n'\
    );
    printf "       ${BOLD}${BLUE}↳  [ ${RESET}$(dim "$item")\t\t";
    if [[ $result > 0 ]]; then
      printf "${SUCCESS_MARK}";
    else
      printf "${FAILURE_MARK}";
    fi;
    printf "\t${BOLD}${BLUE}]${RESET}\n";
  done;
}

# Helpers
rtc_sanitize() {
  echo "$1" | sed -e 's/\[/?/g' -e 's/\]/?/g' -e 's/,/?/g' -e 's/\///g';
}

tree_sanitize() {
  basename "$1" | sed -e 's/\[/\\[/g' -e 's/\]/\\]/g';
}

proceed_prompt() {
  echo;
  while true; do
    put_prompt "Would you like to proceed?";
    read yn;
    case $yn in
        [Yy]* ) echo; break ;;
        [Nn]* ) exit 0 ;;
        * ) echo "Please answer yes [Y/y] or no [N/n].";;
    esac
  done;
}
