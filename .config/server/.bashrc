# shellcheck disable=SC2148,SC1090,SC1091
# Get sourced only on interactive prompt
[[ $- != *i* ]] && return

logit() {
    local msg="$1"
    local level="${2:-Note}"
    local running_as

    running_as="$(whoami)"
    echo "user=$running_as: [$level]: $msg"
}

# Source bash configs
# We don't arbitrarily source all files inside the .config/bash dir
bash_configs=(
    "$HOME/.config/bash/aliases.sh"
    "$HOME/.config/bash/configure.sh"
    "$HOME/.config/bash/shell_options.sh"
    "$HOME/.config/bash/prompt.sh"
)
for config in "${bash_configs[@]}"; do
    logit "Sourcing $config"
    . "$config"
done

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

define_locale() {
    local locale locales=(
        C.utf8
        C.UTF-8
        en_US.utf8
        en_IE.utf8
        en_GB.utf8
        C
    )

    for locale in "${locales[@]}"; do
        if locale -a | grep -q "^$locale"; then
            export LC_ALL="$locale"
            return
        fi
    done
}

define_locale

# Preserve my env when switching to root
# This ensures that all my bashrc loaded configs get loaded when switching to root
sudo() {
    # Run the custom sudo only if not running as root
    if [[ "$1" = "-i" && "$#" -eq 1 && "$(whoami)" != "root" ]]; then
        command sudo --preserve-env=HOME -s
    else
        command sudo "$@"
    fi
}
