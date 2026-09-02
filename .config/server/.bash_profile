# shellcheck disable=SC2148
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="$PATH:$HOME/.local/bin"

# shellcheck disable=SC1091
[[ $- == *i* ]] && . "$XDG_CONFIG_HOME/bash/bashrc"
