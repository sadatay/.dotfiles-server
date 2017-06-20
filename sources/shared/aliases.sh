############
# ALIASES  #
############

# storage management
alias biggest='du -ah . | sort -h -r | head -n 10'
alias backup='rsync -av --delete --partial --stats --log-file=/home/joe/rsync.log /mnt/pool/data /mnt/pool/.backup'
alias restore='rsync -av --partial --stats --log-file=/home/joe/rsync.log /mnt/pool/.backup/data/ /mnt/pool/data'
alias size='du -cksh'
alias rmdirs='find . -maxdepth 1 -type d  -exec rm -r "{}" \;'
alias storage_off='sudo umount -l /mnt/pool/data && sudo umount -l /mnt/pool/.backup && sudo cp /etc/fstab.base /etc/fstab && cat /etc/fstab'
alias storage_on='sudo cp /etc/fstab.storage /etc/fstab && sudo mount -a'
alias killinvisibles='find . -name "._*" -exec rm "{}" \;'
alias lsinvisibles='find . -name "._*"'
alias pwn='sudo chown -R joe:joe . && sudo chmod -R 744 .'
alias flatten="find . -mindepth 2 -type f -exec mv -iv '{}' . ';' && rmdirs"

# media management
alias bitrate='mp3info -r a -p "%f %r\n"'
alias unpackdirs="find . -maxdepth 4 | grep -i .rar | xargs -I '{}' unrar e -o- {}"
alias unpackavi="find . -name '*.avi' | grep -iv sample | xargs -I '{}' mv {} ."
alias unpackmkv="find . -name '*.mkv' | grep -iv sample | xargs -I '{}' mv {} ."
alias unpackmp4="find . -name '*.mp4' | grep -iv sample | xargs -I '{}' mv {} ."
alias fmt_mov="filebot -rename -non-strict --mode interactive --format '{n} ({y}) [{vf}]' --db TheMovieDB"
alias fmt_tv="filebot -rename -non-strict --mode interactive --format \"{n.upperInitial().space('.')}.{s00e00} [{vf}] - {t}\" --db TheTVDB"

# directory aliases
hash -d public='/mnt/pool/data/public/'
hash -d movies='/mnt/pool/data/public/Movies'
hash -d movies_documentary='/mnt/pool/data/public/Movies [Documentary]'
hash -d movies_nanar='/mnt/pool/data/public/Movies [Nanar]'
hash -d movies_oddities='/mnt/pool/data/public/Movies [Oddities]'
hash -d tv='/mnt/pool/data/public/Television'
hash -d tv_animated='/mnt/pool/data/public/Television [Animated]'
hash -d tv_documentary='/mnt/pool/data/public/Television [Documentary]'
hash -d tv_oddities='/mnt/pool/data/public/Television [Oddities]'

# misc
alias wakedisplay='xrandr -d :0 --auto'
alias version='cat /etc/*-release'
alias rc='source ~/.zshrc'

# scripts
alias lsd='~/scripts/dirty.sh'
alias stage='~/scripts/stage.sh'
alias addmovie='~/scripts/addmovie.sh'
alias adddoc='~/scripts/adddoc.sh'

# overrides
# unalias gcp