#############
# FUNCTIONS #
#############

av() {
   mediainfo --Inform="General;Duration=%Duration/String3%\nFile size=%FileSize/String1%" "$@"
   mediainfo --Inform="Video;Resolution=%Width%x%Height%\nCodec=%CodecID%" "$@";
}
marchive() { for item in "$@" ; do mv -v "$item" "/mnt/pool/data/public/Music Archive"; done; }
# stage() { for item in "$@" ; do mv -v "$item" "/seed/sandbox"; done; }
# addmovie() { put_command "ADDING MOVIES"; for item in "$@" ; do put_note "Moving $(highlight "$item") to pooled storage ($(highlight "Movies"))"; gcp "$item" "/mnt/pool/data/public/Movies"; done; }
#adddoc()   { for item in "$@" ; do mv -v "$item" "/mnt/pool/data/public/Movies [Documentary]"; done; }
mupload() { for item in "$@" ; do cp -r "$item" "/seed/music_uploads"; done; }
filter() { ls . | grep -i "$1"; }