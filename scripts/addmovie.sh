#!/usr/bin/env zsh

source ~/.colorrc

put_command "ADDING MOVIES TO ARCHIVE"

for item in "$@"; do
	echo;
	put_note "Moving $(highlight "$item") to pooled storage ($(highlight "Movies"))";
	gcp "$item" "/mnt/pool/data/public/Movies/";
	put_note "Deleting $(highlight "$item")";
	rm "$item";
	
	# Temporarily disabled
	while false; do
		put_prompt "Remove torrent from sandbox?";
		read yn;
		case $yn in
				[Yy]* )
						put_note "Deleting $(highlight "$item")"
						rm "$item"
						break;
				;;
				[Nn]* )
						break;
				;;
				* ) echo "Please answer yes [Y/y] or no [N/n].";;
		esac
	done;
done;
