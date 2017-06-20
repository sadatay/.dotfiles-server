########################
# ENVIRONMENT SETTINGS #
########################

# Add `rvm` to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# Load `pyenv`
export PATH="/home/joe/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# load pyroadmin
export PATH="/home/joe/bin:$PATH"

# configure DBUS for `gcp`
# TODO: check for existing session before spawning a new one
export DBUS_SESSION_BUS_ADDRESS="$(eval 'dbus-launch --auto-syntax' | head -n 1 | sed -n 's/^DBUS_SESSION_BUS_ADDRESS=\(.*\)$/\1/p' | sed -e 's/;//g' -e "s/'//g")"