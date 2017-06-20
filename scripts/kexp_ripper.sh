#!/bin/bash

#script invoked by cron to record WRCT's web stream 

now=$(date +"%m.%d.%y")
filename=$(echo "$2" | sed 's/ /_/g')

streamripper http://live-mp3-128.kexp.org:8000/listen.pls --quiet -d /mnt/pool/data/"Stream Rips" -l $1 -a ${filename}/${filename}_%D -A


#echo "Downloaded new radio from KEXP" | mail -s "[nas] New Streamrip \"$2\" ($now)" jdlasala@gmail.com

sh ./subscan.sh
