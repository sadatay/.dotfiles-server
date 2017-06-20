#########################
# ANTIGEN CONFIGURATION #
#########################

# Desc:   Optimized zsh-syntax-highlighting
# Repo:   https://github.com/zdharma/fast-syntax-highlighting
# Usage:  None
antigen bundle zdharma/fast-syntax-highlighting


##################
# NATIVE PLUGINS #
##################

# None for now

##################
# CUSTOM PLUGINS #
##################

# Desc:   Open a git project or file on GitHub
# Repo:   https://github.com/peterhurford/git-it-on.zsh
# Usage: `gitit` <item>
antigen bundle peterhurford/git-it-on.zsh

# Desc:   Git helper script compilation
# Repo:   https://github.com/unixorn/git-extra-commands
# Usage:  See Documentation
antigen bundle unixorn/git-extra-commands

# Desc:   Change iTerm tab color based on `pwd`
# Repo:   https://github.com/tysonwolker/iterm-tab-colors
# Usage:  None
antigen bundle tysonwolker/iterm-tab-colors

# Desc:   Show CI build status in prompt
# Repo:   https://github.com/raymondjcox/hub-ci-zsh-plugin
# Usage:  Use $(hub_ci_status) in prompt definition.  
#         Customizable with constants: 
#         $ZSH_THEME_HUB_CI_PROMPT_{SUCCESS | PENDING | FAIL | NO_STATUS}
antigen bundle raymondjcox/hub-ci-zsh-plugin

# Desc:   `ls` with Git status, colorized file size and rotting timestamps
# Repo:    https://github.com/supercrabtree/k
# Usage:   `k`
antigen bundle supercrabtree/k

# Desc:   Simple bash listbox prompt with options. `listbox`
# Repo:   https://github.com/gko/listbox
# Usage:  `listbox -t title -o "one | two | three" -r result`
antigen bundle gko/listbox

# Desc:   Index, search and open SublimeText projects
# Repo:   https://github.com/david-treblig/locate-sublime-projects-cli
# Usage:  Define SublimeText projects with .sublime-project files
#         `sp $name` - search for project and open
#         `spo $name` - search for project and open parent dir
#         `spcd $name` - search for project and `cd` to parent dir
antigen bundle david-treblig/locate-sublime-projects-cli

# Desc:   Adds `lj` command for logging shell scripts
# Repo:   https://github.com/molovo/lumberjack
# Usage:  `lj --file <file> --level <log_level>
#         [emergency, alert, critical, error, warning, notice, info, debug]
antigen bundle molovo/lumberjack

# Desc:   Add a spinner to any command
# Repo:   https://github.com/molovo/revolver
# Usage:  `revolver start <message>`
#         `revolver update <message>`
#         `revolver stop`
antigen bundle molovo/revolver

# Desc:   Colorized manpages for solarized theme
# Repo:   https://github.com/zlsun/solarized-man
# Usage:  None.
antigen bundle zlsun/solarized-man

# Desc:   Simple ssh history and selector
# Repo:   https://github.com/gko/ssh-connect
# Usage:  `ssh-connect`
antigen bundle gko/ssh-connect

# Desc:   Reads `$?` and attempts to dump human readable output
# Repo:   https://github.com/aphelionz/strerror.plugin.zsh
# Usage:  Use `$(strerror)` in prompt definition
antigen bundle aphelionz/strerror.plugin.zsh

# Desc:   Enable 256 colors
# Repo:   https://github.com/chrissicool/zsh-256color
# Usage:  None
antigen bundle chrissicool/zsh-256color

# Desc:   Adds a bevy of OSX specific commands
# Repo:   https://github.com/unixorn/tumult.plugin.zsh
# Usage:  See Documentation
antigen bundle unixorn/tumult.plugin.zsh

# Desc:   Navigate up x levels
# Repo:   https://github.com/peterhurford/up.zsh
# Usage:  `up 2`, `up 3`, etc.
antigen bundle peterhurford/up.zsh

# Desc:   Open pull request against upstream or origin master
# Repo:   https://github.com/caarlos0/zsh-open-pr
# Usage:  `git open-pr` after a push
antigen bundle caarlos0/zsh-open-pr

# Desc:   Higher order functions (lambdas) for zsh
# Repo:   https://github.com/Tarrasch/zsh-functional
# Usage:  See Documentation
antigen bundle Tarrasch/zsh-functional

##################
# BROKEN PLUGINS #
##################
# antigen bundle LockonS/host-switch
# antigen bundle git

####################
# DISABLED PLUGINS #
####################
# antigen bundle mafredri/zsh-async
# https://github.com/psprint/ztrace
# https://github.com/rocky/zshdb # shell script debugger
# https://github.com/molovo/zunit # shell script unit tests
# antigen bundle chrissicool/zsh-bash # better bash backwards compatibility
# antigen theme iam4x/zsh-iterm-touchbar
# antigen bundle AlexisBRENON/oh-my-zsh-reminder


