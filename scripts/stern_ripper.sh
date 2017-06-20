#!/bin/bash

#script invoked by cron to record WRCT's web stream 

now=$(date +"%m.%d.%y")

filename="Howard_Stern_Show"

streamripper http://www.g000gle.net:8069/ --quiet -d /mnt/pool/data/"Stream Rips" -l $1 -a ${filename}/${filename}_%D -A 

echo "Downloaded new Howard Stern Show" | mail -s "[nas] New Howard Stern Rip ($now)" jdlasala@gmail.com

echo "Downloaded new Howard Stern Show ($now)- Rips can be found listed chronologically at http://jdl55.dyndns.org/Radio_Rips/PirateStation.Net/" | mail -s "[nas] New Howard Stern Show ($now)" dstrick18@gmail.com

sh ./subscan.sh
