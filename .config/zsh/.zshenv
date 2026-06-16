# Clean up 
export ZSHZ_DATA="$XDG_CONFIG_HOME/z/.z" 
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export GOPATH="$XDG_DATA_HOME/go"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export ANSIBLE_HOME="$XDG_DATA_HOME"/ansible
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship/cache"
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android

# fzf completion customization
export FZF_COMPLETION_TRIGGER="."
export FZF_COMPLETION_OPTS="--border --info=inline"

# Timezone 
export TZ="Indian/Mauritius"

# Environment variables
export VISUAL=nvim
export EDITOR=nvim
export TERMINAL=kitty
export TERM="xterm-256color"

# Podman rootless 
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
export PODMAN_COMPOSE_WARNING_LOGS=false

# ssh-agent 
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
