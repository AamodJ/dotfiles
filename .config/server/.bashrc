# shellcheck disable=SC2148,SC1091
# Get sourced only on interactive prompt
[[ $- != *i* ]] && return

logit() {
    local msg="$1"
    local level="${2:-Note}"
    local running_as

    running_as=$(whoami)
    echo "user=$running_as: [$level]: $msg"
}

# Source bash configs when run as normal user
if [[ "$(whoami)" != "root" ]]; then
    bash_configs=("$HOME/.config/bash/aliases.sh" "$HOME/.config/bash/configure.sh" "$HOME/.config/bash/shell_options.sh")

    for config in "${bash_configs[@]}"; do
        logit "Sourcing $config"
        # shellcheck disable=SC1090
        . "$config"
    done
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    user_color="\[\e[1;34m\]"
    if [ "$(whoami)" = root ]; then
        user_color="\[\e[1;31m\]"
    fi

    if [ -r /etc/bash_completion.d/git-prompt ]; then
        source /etc/bash_completion.d/git-prompt
    elif [ -r /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
        source /usr/share/git-core/contrib/completion/git-prompt.sh
    fi

    PS1_GIT_PRE="\[\e[0;37m\]\\t ${user_color}\u\[\e[01;33m\]@\[\e[01;36m\]\h \[\e[01;33m\]\w\[\e[0m\]"
    PS1_GIT_POST=" ${user_color}❯\[\e[0m\] "
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1="$PS1_GIT_PRE$PS1_GIT_POST"
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if command -v dircolors >/dev/null 2>&1; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    export LS_OPTIONS='--color=auto -h'
fi

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

if [[ $(type -t __git_ps1) == function ]] && [[ $PROMPT_COMMAND != *__git_ps1* ]]; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM=auto
    export GIT_PS1_DESCRIBE_STYLE=branch
    export GIT_PS1_SHOWCOLORHINTS=1
    # GIT_PS1_SHOWCOLORHINTS requires __git_ps1 to build PS1 itself (via
    # PROMPT_COMMAND) instead of being command-substituted inside PS1,
    # otherwise its color codes aren't wrapped in \[..\] and bash miscounts
    # the prompt width.
    PROMPT_COMMAND='history -a; __git_ps1 "$PS1_GIT_PRE" "$PS1_GIT_POST" " [%s]"'
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
