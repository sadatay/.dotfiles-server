########################
# CUSTOM CONFIGURATION #
########################

# Antigen
ANTIGEN_LOG=~/.antigen.log
source $HOME/antigen.zsh
antigen use oh-my-zsh

# Dotfiles

## Shared
for file in ~/.sources/shared/*.sh; do
    source "$file"
done

## zsh specific
for file in ~/.sources/zsh/*; do
    source "$file"
done

antigen apply

# Antigen and oh-my-zsh can't seem to wrap their
# heads around my custom theme, so let's just source
# it manually here
source ~/.themes/joe.zsh-theme

# Options

# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates are not
# contiguous.
setopt hist_find_no_dups
