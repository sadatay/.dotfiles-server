########################
# CUSTOM CONFIGURATION #
########################

#Dotfiles

## Shared
for file in ~/.sources/shared/*.sh; do
    source "$file"
done

## Bash specific
for file in ~/.sources/bash/*; do
    source "$file"
done

##########
# PROMPT #
##########

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\[\e[00;31m\]\u@nas:[\[\e[0m\]\[\e[00;34m\]\W\[\e[0m\]\[\e[00;31m\]]\[\e[0m\]\[\e[00;33m\]\$(parse_git_branch)\[\e[0m\]\[\e[00;31m\] -> \[\e[0m\]"

