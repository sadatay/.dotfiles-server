#!/bin/sh

wget --cookies=on --keep-session-cookies --save-cookies=/tmp/cookie.txt --user-agent=Mozilla -q -O/dev/null 'http://localhost:4040/login.view?user=admin&password=yardbird'
wget --referer='http://localhost:4040' --cookies=on --load-cookies=/tmp/cookie.txt --keep-session-cookies --save-cookies=/tmp/cookie.txt -q -O/dev/null 'http://localhost:4040/musicFolderSettings.view?scanNow'
