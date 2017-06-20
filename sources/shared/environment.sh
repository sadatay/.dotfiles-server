########################
# ENVIRONMENT SETTINGS #
########################

# load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH=/usr/local/bin:$PATH
#source ~/.profile

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

source ~/.nvm/nvm.sh