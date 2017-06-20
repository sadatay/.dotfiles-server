#!/bin/bash  
# April 4, 2009  
# m3u_cp.sh  
#  
# Take an m3u file and copy all associated mp3 files  
# to a destination directory and generate a new m3u.  
#  
# Used to copy m3u playlists from computer to Garmin.  
if [ $# -lt 2 ]; then  
    echo "Usage: m3u_cp.sh some.m3u /dst"  
    exit 0  
fi  
# Read the m3u file into an array  
declare -a M3U  
exec 10<"$1"  
let count=0  
while read LINE <&10; do  
    M3U[$count]=$LINE  
    ((count++))  
done  
exec 10>&-  
# Determine the m3u's filename  
if [[ $1 =~ [^/]*m3u ]]; then  
    m3u_path="$2/$BASH_REMATCH"  
fi  
# If playlist arleady exists, delete it  
if [ -f "$m3u_path" ]; then  
    rm -f "$m3u_path"  
fi  
# Loop through the m3u lines  
i=0  
while [ $i -lt ${#M3U[@]} ]; do  
    # The current line is a comment, do nothing with it  
    if [ ${M3U[$i]:0:1} = "#" ]; then  
        echo ${M3U[$i]} >> "$m3u_path"  
        #Current line is a path to an mp3 file  
    else  
        # Get the current songs filename  
        if [[ ${M3U[$i]} =~ [^/]*mp3 ]]; then  
            song=$BASH_REMATCH  
            mpath=$( echo ${M3U[$i]} | tr -d '\r' )  
            # if the song doesn't exist, copy it to the desitnation folder  
            if [ -f "$2/$song" ]; then  
                echo File Exists -- $song  
            else  
                echo Copying -- $song  
                cp "$mpath" "$2/$song"  
            fi  
            # Write the song in the m3u file  
            echo $song >> "$m3u_path"  
        else  
            echo "The regex for finding the song's filename is fraked up."  
        fi  
    fi  
    let i=i+1  
done  
exit 0  
