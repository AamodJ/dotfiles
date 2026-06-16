# Profiling
# zmodload zsh/zprof 

# Plugins
source $XDG_CONFIG_HOME/zsh/zsh-z.plugin.zsh

# Functions
# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
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

# Custom prompt
eval "$(starship init zsh)"

export FZF_DEFAULT_OPTS="--multi --height=40% --preview='cat {}' --preview-window=right:60%:wrap"

# Sourcing files
source $XDG_CONFIG_HOME/zsh/aliases
source $XDG_CONFIG_HOME/lf/icons

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf keybindings
source <(fzf --zsh)

# Keybinds
bindkey -s '^o' 'lfcd\n'
bindkey -s '^y' 'install-pac\n'
bindkey -s '^p' 'rm-pac\n'

autoload -Uz compinit
compinit

# kitty-scrollback.nvim 
autoload -Uz edit-command-line
zle -N edit-command-line
function kitty_scrollback_edit_command_line() {
  local VISUAL='/home/aj/.local/share/nvim/lazy/kitty-scrollback.nvim/scripts/edit_command_line.sh'
  zle edit-command-line
  zle kill-whole-line
}
zle -N kitty_scrollback_edit_command_line
bindkey '^e' kitty_scrollback_edit_command_line
# [optional] pass arguments to kitty-scrollback.nvim in command-line editing mode
# by using the environment variable KITTY_SCROLLBACK_NVIM_EDIT_ARGS
# export KITTY_SCROLLBACK_NVIM_EDIT_ARGS=''

# pfetch 
fortune | cowsay -f stegosaurus

# Profiling
# zprof
