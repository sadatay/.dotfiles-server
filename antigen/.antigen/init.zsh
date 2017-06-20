#-- START ZCACHE GENERATED FILE
#-- GENERATED: Tue Jun 20 00:00:17 CDT 2017
#-- ANTIGEN v2.2.0
_antigen () {
	local -a _1st_arguments
	_1st_arguments=('apply:Load all bundle completions' 'bundle:Install and load the given plugin' 'bundles:Bulk define bundles' 'cleanup:Clean up the clones of repos which are not used by any bundles currently loaded' 'cache-gen:Generate cache' 'init:Load Antigen configuration from file' 'list:List out the currently loaded bundles' 'purge:Remove a cloned bundle from filesystem' 'reset:Clears cache' 'restore:Restore the bundles state as specified in the snapshot' 'revert:Revert the state of all bundles to how they were before the last antigen update' 'selfupdate:Update antigen itself' 'snapshot:Create a snapshot of all the active clones' 'theme:Switch the prompt theme' 'update:Update all bundles' 'use:Load any (supported) zsh pre-packaged framework') 
	_1st_arguments+=('help:Show this message' 'version:Display Antigen version') 
	__bundle () {
		_arguments '--loc[Path to the location <path-to/location>]' '--url[Path to the repository <github-account/repository>]' '--branch[Git branch name]' '--no-local-clone[Do not create a clone]'
	}
	__list () {
		_arguments '--simple[Show only bundle name]' '--short[Show only bundle name and branch]' '--long[Show bundle records]'
	}
	__cleanup () {
		_arguments '--force[Do not ask for confirmation]'
	}
	_arguments '*:: :->command'
	if (( CURRENT == 1 ))
	then
		_describe -t commands "antigen command" _1st_arguments
		return
	fi
	local -a _command_args
	case "$words[1]" in
		(bundle) __bundle ;;
		(use) compadd "$@" "oh-my-zsh" "prezto" ;;
		(cleanup) __cleanup ;;
		(update|purge) compadd $(type -f \-antigen-get-bundles &> /dev/null || antigen &> /dev/null; -antigen-get-bundles --simple 2> /dev/null) ;;
		(theme) compadd $(type -f \-antigen-get-themes &> /dev/null || antigen &> /dev/null; -antigen-get-themes 2> /dev/null) ;;
		(list) __list ;;
	esac
}
antigen () {
  local MATCH MBEGIN MEND
  [[ "$ZSH_EVAL_CONTEXT" =~ "toplevel:*" || "$ZSH_EVAL_CONTEXT" =~ "cmdarg:*" ]] && source "/Users/josephlasala/.dotfiles/antigen/antigen/antigen.zsh" && eval antigen $@;
  return 0;
}
typeset -gaU fpath path
fpath+=(/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/zdharma/fast-syntax-highlighting /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/peterhurford/git-it-on.zsh /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/unixorn/git-extra-commands /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/tysonwolker/iterm-tab-colors /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/raymondjcox/hub-ci-zsh-plugin /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/supercrabtree/k /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/gko/listbox /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/david-treblig/locate-sublime-projects-cli /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/molovo/lumberjack /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/molovo/revolver /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/zlsun/solarized-man /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/gko/ssh-connect /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/aphelionz/strerror.plugin.zsh /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/chrissicool/zsh-256color /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/unixorn/tumult.plugin.zsh /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/peterhurford/up.zsh /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/caarlos0/zsh-open-pr /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/Tarrasch/zsh-functional) path+=(/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/zdharma/fast-syntax-highlighting /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/peterhurford/git-it-on.zsh /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/unixorn/git-extra-commands /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/tysonwolker/iterm-tab-colors /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/raymondjcox/hub-ci-zsh-plugin /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/supercrabtree/k /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/gko/listbox /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/david-treblig/locate-sublime-projects-cli /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/molovo/lumberjack /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/molovo/revolver /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/zlsun/solarized-man /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/gko/ssh-connect /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/aphelionz/strerror.plugin.zsh /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/chrissicool/zsh-256color /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/unixorn/tumult.plugin.zsh /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/peterhurford/up.zsh /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/caarlos0/zsh-open-pr /Users/josephlasala/.dotfiles/antigen/.antigen/bundles/Tarrasch/zsh-functional)
_antigen_compinit () {
  autoload -Uz compinit; compinit -d "/Users/josephlasala/.antigen/.zcompdump"; compdef _antigen antigen
  add-zsh-hook -D precmd _antigen_compinit
}
autoload -Uz add-zsh-hook; add-zsh-hook precmd _antigen_compinit
compdef () {}

if [[ -n "/Users/josephlasala/.antigen/bundles/robbyrussell/oh-my-zsh" ]]; then
  ZSH="/Users/josephlasala/.antigen/bundles/robbyrussell/oh-my-zsh"; ZSH_CACHE_DIR="/Users/josephlasala/.antigen/bundles/robbyrussell/oh-my-zsh/cache/"
fi
#--- BUNDLES BEGIN
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/bzr.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/clipboard.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/compfix.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/completion.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/correction.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/diagnostics.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/directories.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/functions.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/git.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/grep.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/history.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/key-bindings.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/misc.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/nvm.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/prompt_info_functions.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/spectrum.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/termsupport.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/robbyrussell/oh-my-zsh/lib/theme-and-appearance.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/zdharma/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/peterhurford/git-it-on.zsh/git-it-on.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/unixorn/git-extra-commands/git-extra-commands.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/tysonwolker/iterm-tab-colors/zsh-tab-colors.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/raymondjcox/hub-ci-zsh-plugin/hub-ci-status.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/supercrabtree/k/k.sh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/gko/listbox/listbox.sh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/david-treblig/locate-sublime-projects-cli/sublime-completion.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/zlsun/solarized-man/solarized-man.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/gko/ssh-connect/ssh-connect.sh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/aphelionz/strerror.plugin.zsh/strerror.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/chrissicool/zsh-256color/zsh-256color.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/unixorn/tumult.plugin.zsh/tumult.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/peterhurford/up.zsh/up.plugin.zsh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/caarlos0/zsh-open-pr/git-open-pr.sh';
source '/Users/josephlasala/.dotfiles/antigen/.antigen/bundles/Tarrasch/zsh-functional/functional.plugin.zsh';

#--- BUNDLES END
typeset -gaU _ANTIGEN_BUNDLE_RECORD; _ANTIGEN_BUNDLE_RECORD=('https://github.com/robbyrussell/oh-my-zsh.git lib plugin true' 'https://github.com/zdharma/fast-syntax-highlighting.git / plugin true' 'https://github.com/peterhurford/git-it-on.zsh.git / plugin true' 'https://github.com/unixorn/git-extra-commands.git / plugin true' 'https://github.com/tysonwolker/iterm-tab-colors.git / plugin true' 'https://github.com/raymondjcox/hub-ci-zsh-plugin.git / plugin true' 'https://github.com/supercrabtree/k.git / plugin true' 'https://github.com/gko/listbox.git / plugin true' 'https://github.com/david-treblig/locate-sublime-projects-cli.git / plugin true' 'https://github.com/molovo/lumberjack.git / plugin true' 'https://github.com/molovo/revolver.git / plugin true' 'https://github.com/zlsun/solarized-man.git / plugin true' 'https://github.com/gko/ssh-connect.git / plugin true' 'https://github.com/aphelionz/strerror.plugin.zsh.git / plugin true' 'https://github.com/chrissicool/zsh-256color.git / plugin true' 'https://github.com/unixorn/tumult.plugin.zsh.git / plugin true' 'https://github.com/peterhurford/up.zsh.git / plugin true' 'https://github.com/caarlos0/zsh-open-pr.git / plugin true' 'https://github.com/Tarrasch/zsh-functional.git / plugin true')
typeset -g _ANTIGEN_CACHE_LOADED=true ANTIGEN_CACHE_VERSION='v2.2.0'

#-- END ZCACHE GENERATED FILE
