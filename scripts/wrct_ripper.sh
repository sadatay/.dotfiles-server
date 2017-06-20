#/bin/bash

#script invoked by cron to record WRCT's web stream 

now=$(date +"%m.%d.%y")
filename=$(echo "$2" | sed 's/ /_/g')

streamripper http://stream.wrct.org:8000/wrct-hi.mp3.m3u --quiet -d ./streams -l $1 -a ${filename}/${filename}_%D 

echo "Downloaded new radio from WRCT" | mail -s "[nas] New Streamrip \"$2\" ($now)" jdlasala@gmail.com

sh ./subscan.sh
