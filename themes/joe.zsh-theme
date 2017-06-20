#!/usr/bin/env zsh

local LAMBDA="%(?,%{$fg_bold[green]%}λ,%{$fg_bold[red]%}λ)"
if [[ "$USER" == "root" ]]; then USERCOLOR="red"; else USERCOLOR="yellow"; fi

# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function check_git_prompt_info() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ -z $(git_prompt_info) ]]; then
            echo "%{$fg[blue]%}detached-head%{$reset_color%}) $(git_prompt)
%{$fg[yellow]%}→ "
        else
            echo "$(git_prompt)
%{$fg_bold[cyan]%}→ "
        fi
    else
    echo
        echo "%{$fg_bold[cyan]%}→ "
    fi
}

function git_prompt() {
  echo "%{$fg[red]%}« %{$fg[magenta]%}∫ $(git_prompt_info) $(diff_info) $(get_sha) %{$fg[red]%}»"
}

function get_right_prompt() {
  echo ""
}

function get_sha() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # echo -n "%{$fg[cyan]%}#%{$reset_color%}$(git_prompt_short_sha)%{$fg[cyan]%}#%{$reset_color%}"
        echo -n "%{$fg[cyan]%}$(git_prompt_short_sha)%{$reset_color%}"
    else
        echo -n ""
    fi
}

function files_changed() {
  file_count=$(git diff --shortstat | sed -n -E 's/.*([0-9]+) file.*/\1/p')
  if [ -z $file_count ]; then
    file_count='0'
  fi
  echo $file_count
}
function lines_added() {
  file_count=$(git diff --shortstat | sed -n -E 's/.*([0-9]+) insert.*/\1/p')
  if [ -z $file_count ]; then
    file_count='0'
  fi
  echo $file_count
}
function lines_removed() {
  file_count=$(git diff --shortstat | sed -n -E 's/.*([0-9]+) delet.*/\1/p')
  if [ -z $file_count ]; then
    file_count='0'
  fi
  echo $file_count
}

function diff_info() {
  echo "%{$fg[yellow]%}⟅✴ $(files_changed)⟆ %{$fg[green]%}⟅↑ $(lines_added)⟆ %{$fg[red]%}⟅↓ $(lines_removed)⟆%{$reset_color%}"
}

PROMPT='
${LAMBDA}\
 %{$fg_no_bold[red]%}‹ %{$fg[yellow]%}josephlasala@macbook %{$fg[red]%}›\
 %{$fg_no_bold[red]%}[%{$reset_color%} %3~ %{$fg[red]%}]\
 $(check_git_prompt_info)\
%{$reset_color%}'

# RPROMPT='$(get_right_prompt)'

# Format for git_prompt_info()
#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}« %{$fg[magenta]%}∫ "
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} %{$fg[blue]%}»"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
# Format for git_prompt_status()
#ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}$(files_changed)⊕ "
#ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⊙ "
#ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}⊖ "
ZSH_THEME_GIT_PROMPT_RENAMED=""
ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$fg_bold[white]%}^"


# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=""
ZSH_THEME_GIT_PROMPT_SHA_AFTER=""
