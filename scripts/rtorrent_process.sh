#!/bin/sh

#email notification
echo "$(date) : $1 - Download completed." | mail -s "[nas] Downloaded: $1" jdlasala@gmail.com

#update the subsonic library
echo yardbird | sudo -S sh /home/joe/scripts/subscan.sh

#unpack / move any tv episodes of active shows into library
# (wait 20 seconds for show to unpack)
#sleep 20
#echo "[$(date)]--------------------------" >> /home/rtor/scripts/automtv.log
#echo yardbird | sudo -S automtv $1 >> /home/rtor/scripts/automtv.log
