# XDG env variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Clean up 
export ZSHZ_DATA="$XDG_CONFIG_HOME/z/.z" 
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export GOPATH="$XDG_DATA_HOME"/go
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export ANDROID_HOME="$XDG_DATA_HOME"/android
export CARGO_HOME="XDG_DATA_HOME"/cargo
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# Environment variables
export VISUAL=nvim
export EDITOR=nvim
export TERMINAL=kitty
