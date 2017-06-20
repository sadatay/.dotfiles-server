#!/usr/bin/env zsh

source ~/.colorrc

put_command "STAGING FILES"

for item in "$@"; do
	echo;
	put_note "Moving $(highlight "$item") to sandbox ($(highlight "/seed/sandbox/"))";
	mv -v "$item" "/seed/sandbox"
	
	name="$(echo "$item" | sed -e 's/\[/?/g' -e 's/\]/?/g' -e 's/,/?/g' -e 's/\///g')"
	
	while true; do
		put_prompt "Remove torrent from client?";
		read yn;
		case $yn in
				[Yy]* )
						put_note "Removing torrent: $(highlight "$item")"
						#echo -e "${DIM}$(rtcontrol --delete "$name")${RESET}";
						rtcontrol --delete "$name"
						break;
				;;
				[Nn]* )
						put_note "Stopping torrent: $(highlight "$item")"
						rtcontrol --stop "$name" 
						break;
				;;
				* ) echo "Please answer yes [Y/y] or no [N/n].";;
		esac
	done;

done
