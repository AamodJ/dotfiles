# shellcheck disable=SC2148
# Source blesh if it exists
# shellcheck disable=SC2164,SC1094,SC1091
[[ $- == *i* ]] && source -- /usr/share/blesh/ble.sh --attach=none

export BASHHOME="$XDG_CONFIG_HOME/bash"

[[ -f "$BASHHOME/.bashenv" ]] && . "$BASHHOME/.bashenv"
[[ -f "$BASHHOME/aliases" ]] && . "$BASHHOME/aliases"
[[ -f "$BASHHOME/other-aliases" ]] && . "$BASHHOME/other-aliases"

# History
HISTFILE="$BASHHOME/.bash_history"
HISTFILESIZE=9999999
HISTSIZE=9999999
mkdir -p "$(dirname "$HISTFILE")"

# Enable vim mode
set -o vi

# autocd
shopt -s autocd

# Prevent overwriting files with >
# Appending with >> works as normal
# To overwrite with intent, run >|
set -o noclobber

# lf
lfcd() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        if [ -d "$dir" ] && [ "$dir" != "$(pwd)" ]; then
            zoxide add "$dir"
            cd "$dir"
        fi
    fi
}
bind -x '"\C-o":"lfcd"'
source "$XDG_CONFIG_HOME/lf/icons"

# direnv
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

# Prompt
eval "$(starship init bash)"

# zoxide
eval "$(zoxide init bash)"

[[ ! ${BLE_VERSION-} ]] || ble-attach
