# Plugins
source $XDG_CONFIG_HOME/zsh/zsh-z.plugin.zsh

# Functions
# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lfrun -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
## Needed for changing cursors when changing vim mode
zle-keymap-select () {
	if [ $KEYMAP = vicmd ]; then
    	printf "\033[2 q"
	else
    	printf "\033[6 q"
	fi
}
zle-line-init () {
	zle -K viins
	printf "\033[6 q"
}

# Enable vi-mode and change cursor accordingly
KEYTIMEOUT=5
zle -N zle-keymap-select
zle -N zle-line-init
bindkey -v

# Some export options
export HISTFILE="$XDG_CONFIG_HOME/zsh/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=1000

# export PROMPT="%~ %(?.%F{green}✓.%F{red}?%?)%f %(!.#.>) "
# export RPROMPT="%T"
autoload -U promptinit; promptinit
prompt spaceship

export FZF_DEFAULT_OPTS="--multi --height=40% --preview='cat {}' --preview-window=right:60%:wrap"

# Sourcing files
source $XDG_CONFIG_HOME/zsh/aliases
source $XDG_CONFIG_HOME/lf/icons
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Keybinds
bindkey -s '^o' 'lfcd\n'
bindkey -s '^r' 'resource\n'
bindkey -s '^y' 'sensors | grep Core\n'

# Run neofetch and print appointments on startup
neofetch
calcurse -Q
