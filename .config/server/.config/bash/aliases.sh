# shellcheck disable=SC2148,SC1091
# Aliases
## General aliases
if [ -r /etc/bash_aliases ]; then
    . /etc/bash_aliases
fi

## Convenience
alias :q="exit"
alias ..='cd ..'
alias ...='cd ../..'
export LS_OPTIONS="-p --color=auto --group-directories-first"
alias l='LC_COLLATE=C ls $LS_OPTIONS'
alias ll='LC_COLLATE=C ls -lah $LS_OPTIONS'
alias ls='LC_COLLATE=C ls -lah $LS_OPTIONS'
alias ping="ping -O"
alias p1="ping 1.1.1.1"

alias gdsh='ls -la $HOME/.dsh/group'

## Cleanup
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

## Vim aliases
alias v='$EDITOR'
alias vim='$EDITOR'
alias vi='$EDITOR'

## Ansible QOL
alias ag="ansible-galaxy"
alias ap="ansible-playbook"
alias aa="ansible"

## Autocorrect
alias chomd="chmod"
alias ..="echo 'cd ..' && cd .."
alias ncim='$VISUAL'
alias nxim='$VISUAL'
alias nivm='$VISUAL'
alias nicm='$VISUAL'

# Git
alias gg='git log --graph --pretty=format:"%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(reset) %C(cyan)%cd %C(blue)(%cr)%Creset" --date=format:"%Y-%m-%d %Hh%M"'
alias ggs='gg --stat'
alias gs='git status'
alias gss='git status -s'
alias gd='git diff'
alias gwc='git whatchanged'

# Color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias bzgrep='bzgrep --color=auto'
alias zgrep='zgrep --color=auto'
alias zstdgrep='zstdgrep --color=auto'
