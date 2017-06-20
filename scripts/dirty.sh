#!/usr/bin/env zsh

function get_torrent_info() {
  name="$1"
	name="$(echo "$name" | sed -e 's/\[/?/g' -e 's/\]/?/g' -e 's/,/?/g')"
  torrent_status="$(rtcontrol -o essential "$name" | head -n -2 | grep --color=never "$_input_dir")"
  percent_done="$(echo "$torrent_status" | awk '{print $1;}')"
  ratio="$(echo "$torrent_status" | awk '{print $2;}')"
  tracker="$(echo "$torrent_status" | awk '{print $3;}')"
  traits="$(echo "$torrent_status" | awk '{print $4;}')"
  #path=$(echo "$torrent_status" | awk -F\" '{print $2;}')
  
  #echo "name3 $name status $torrent_status percent $percent_done ratio $ratio tracker $tracker traits $traits"

  traits_icon=""
  if [[ "$traits" =~ "audio" ]]; then
    traits_icon="♬ "
  else
    traits_icon="🎬 " 
  fi

	ratio="$(printf "%1.3f" $ratio)"
	ratio="$(echo "$ratio" | cut -c1-5)"
  ratio_fmt="$ratio"

	if [[ ! -z $ratio ]]; then
		if (( $(echo "$ratio == 0" | bc -l) )); then
			ratio_fmt="${RED}$ratio${RESET}"
		fi

		if (( $(echo "$ratio > 0" | bc -l) )); then
			ratio_fmt="${YELLOW}$ratio${RESET}"
		fi
	
		if (( $(echo "$ratio >= 1" | bc -l) )); then
			ratio_fmt="${GREEN}$ratio${RESET}"
		fi
	fi

	percent_done="$(echo "$percent_done" | sed -n 's/^\([0-9]*\).*$/\1/p' | xargs printf "%3d%%")"
	tracker_short="PUB"

	if [[ "$percent_done" = "100%" ]]; then
		percent_done="${GREEN}$percent_done${RESET}"
	else
		percent_done="${RED}$percent_done${RESET}"
	fi

	case "$tracker" in
		passthepopcorn.me)
			tracker_short="PTP"
		;;
		apollo.rip)
			tracker_short="APL"
		;;
		bitmetv.org)
			tracker_short="BTV"
		;;
		myspleen.org)
			tracker_short="MYS"
		;;
		sceneaccess.eu)
			tracker_short="SCC"
		;;
	esac		

  if [ ! -z "$torrent_status" ]; then
    echo -e "${BLUE}[${RESET} ${GREEN}↑${RED}↓${RESET} $ratio_fmt | $percent_done | $tracker_short ${BLUE}]${RESET}"
  else
		echo -e "${BLUE}[${RESET}      ${YELLOW}NOT TRACKED${RESET}      ${BLUE}]${RESET}"
	fi
}

function process_find() {
  while read -r line; do
		_size=$(echo "$line" | awk '{print $1;}')
		_type=$(echo "$line" | awk '{print $2;}')
		_octal=$(echo "$line" | awk '{print $3;}')
		_user=$(echo "$line" | awk '{print $4;}')
		_group=$(echo "$line" | awk '{print $5;}')
		_name="$(echo "$line" | awk -F\" '{print $2}')"
		_path=$(echo "$line" | awk -F\# '{print $2}')
		_indent_count=$(echo -n "(1111) [$_user:$_group] " | wc -c);
		_indent=$(printf " %.0s" {1..${_indent_count}});
		_icon=" ";
    if [ "$_type" = "d" ]; then
      _size=$(du -cksb "$_path" | tail -n 1 | awk '{print $1;}')
      _icon=" "
    fi
		
    _size_human=$(numfmt --to=si --padding=4 $_size)
    _colorized_size="${GREEN}$_size_human${RESET}"
	
    if (( $_size > $MED_FILESIZE )); then
      _colorized_size="${YELLOW}$_size_human${RESET}"
    fi
		
    if (( $_size > $LARGE_FILESIZE )); then
      _colorized_size="${RED}$_size_human${RESET}"
    fi
		
    if (( $_size > 4096 )); then
      _torrent_info=$(get_torrent_info "$_name")
      echo -e "${BLUE}(${RESET}$_colorized_size${BLUE})${RESET} $_torrent_info  $_icon $_name"
			#if [ "$_type" = "d" ]; then
			#	echo -e "${DIM}$(tree -nh "$_path" | sed -n '1!p' | sed "s/^/$_indent/" | head -n -2)${RESET}"
			#fi
    fi
  done;   	
}

function main() {
  source ~/.colorrc

  MED_FILESIZE=1000000000
  LARGE_FILESIZE=10000000000
  EXTRA_LARGE_FILESIZE=30000000000
  
  _input_dir=$1


  if [ -z $_input_dir ]; then
    _input_dir='.'
  fi

	_input_dir=$(readlink -f $_input_dir)
  
	#echo "DEBUG: working on directory $_input_dir"
  
	process_find < <(find $_input_dir -maxdepth 1 -mindepth 1 -printf '%s %y %m %u %g "%f" #%p#\n')
}

main "$@"
