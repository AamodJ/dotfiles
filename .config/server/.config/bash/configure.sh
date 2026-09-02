# shellcheck disable=SC2148
# Don't check mail when opening terminal.
unset MAILCHECK

# Set default permission to 644 for files, 755 for directories
umask 022

# fzf completion
export FZF_COMPLETION_TRIGGER="."
export FZF_COMPLETION_OPTS="--border --info=inline"

export VISUAL=vim
export EDITOR=vim
export GIT_EDITOR='vim'
export TERM="xterm-256color"

# Less configuration
export LESS='--chop-long-lines --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS --no-init'
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;48;5;121;91;1;4m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export MANPAGER="less --no-init --RAW-CONTROL-CHARS"
export MANROFFOPT=-c

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export GREP_COLORS='sl=49;39:cx=49;39:mt=48;5;121;91;1;4:fn=49;35:ln=49;32:bn=49;32:se=49;36'

# History
HISTFILE="$HOME/.bash_history"
HISTFILESIZE=9999999
HISTSIZE=9999999
# Add time in history
HISTTIMEFORMAT="%F %T "
# Write history after each command
export PROMPT_COMMAND="history -a"
mkdir -p "$(dirname "$HISTFILE")"
