# XDG env variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Clean up 
export VIMINIT="source $HOME/.config/vim/.vimrc" 
export ZSHZ_DATA="$HOME/.config/z/.z" 
export VLC="/Applications/VLC.app/Contents/MacOS/VLC"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export GOPATH="$XDG_DATA_HOME"/go
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export ANDROID_HOME="$XDG_DATA_HOME"/android
export CARGO_HOME="XDG_DATA_HOME"/cargo

# Environment variables
export VISUAL=vim
export EDITOR=vim
export TERMINAL=kitty
