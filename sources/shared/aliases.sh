############
# ALIASES  #
############

# TODO: add safety semicolons

# General
alias rs='redis-server &'
alias top='htop'
alias weather='curl wttr.in/Austin'
alias dotfiles='~/.dotfiles/install'

# Development

## Javascript

### Yarn
alias yarn-nuke='rm -rf ./node_modules/ && yarn cache clean'
alias yarn-top='while true; do clear; echo "$(ps -ef | grep '"'"'yarn'"'"' | grep -v grep | awk '"'"'{print $2}'"'"' | xargs lsof -p)"; sleep 2; done;'
alias yarn-rebuild='yarn-nuke && yarn install'

### Bower
alias bower-nuke='rm -rf ./bower_components/ && bower cache clean'
alias bower-rebuild='bower-nuke && bower install'

### Node-sass
alias sass='nvm use && npm rebuild node-sass'

### Yarn & Bower
alias barn='nvm use && yarn install && bower install && sass'
alias barn-hard='nvm use && yarn-rebuild && bower-rebuild && sass'


# Version Control
alias git='hub'
alias ggraph="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)-                     %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias branches='git branch -vvvv'
alias bs='branches'

## These should be overridden based on environment
alias rebase-upstream-master='git remote update && git rebase -i upstream/master'
alias rebase-origin-master='git remote update && git rebase -i origin/master'
alias fixup-upstream-master='git commit -m "fixup" && rebase-upstream'
alias fixup-origin-master='git commit -m "fixup" && rebase-origin'
alias track-origin-master='git branch -u origin/master'
alias track-upstream-master='git branch -u upstream/master'

