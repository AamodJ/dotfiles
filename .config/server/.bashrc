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
    mapfile -t bash_configs < <(find "./.config/bash" -type f ! -name "root_login_init.sh")
    for config in "${bash_configs[@]}"; do
        logit "Sourcing $config"
        # shellcheck disable=SC1090
        . "$config"
    done
fi

# ------------------------- GNU Readline settings -------------------------
bind 'set show-all-if-ambiguous on'
## Enable vim mode
bind 'set editing-mode vi'
bind 'set show-mode-in-prompt on'
bind 'set vi-cmd-mode-string \1\e[2 q\2'
bind 'set vi-ins-mode-string \1\e[6 q\2'
## Smart history search
## these are for vi-command mode
bind -m vi-command '"\e[A": history-search-backward'
bind -m vi-command '"\e[B": history-search-forward'
bind -m vi-command 'j: history-search-forward'
bind -m vi-command 'k: history-search-backward'
bind -m vi-command '"gc": insert-comment'
bind -m vi-command '"Y": yank-last-arg'
# these are for vi-insert mode
bind -m vi-command '"\e[A": history-search-backward'
bind -m vi-command '"\e[B": history-search-forward'
bind 'set keyseq-timeout 0'
## Don't echo control characters
bind 'set echo-control-characters off'
## Safer paste
bind 'set enable-bracketed-paste on'
# -------------------------------------------------------------------------

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

# Source my bashrc when switching to root
#
# This is achieved by sourcing /root profile -> my bashrc on top of that
# This ensures the root environment is loaded and the custom bashrc either
# adds new settings or overrides existing ones with sane defaults
#
# shellcheck disable=SC2120
init_sudo_login() {
    # To do this, we create a root_login_init.sh script which handles the
    # bash config loading for us. This helper function is necessary because when
    # you run sudo -i, this part of code is rerun. Therefore the last source is
    # re-evaluated and the file get's overwritten with the path /root/.bash_profile
    # instead of my bashrc (because this bashrc is run as root). So we setup the
    # init script once and provide a helper function to re-initialize
    #
    # 4 conditions are possible
    # |                  | File Exists   | Does not exist      |
    # |------------------|---------------|---------------------|
    # | with --overwrite | Write to file | Create file (Write) |
    # | no --overwrite   | Do not Write  | Create file (Write) |
    #
    # So we only need to check for no --overwrite + File Exists and exit the function with error
    if [[ "$1" != "--overwrite" && -e "$HOME/.config/bash/root_login_init.sh" ]]; then
        logit "root_login_init config already exists and --overwrite not specified. Ignoring."
        return 0
    fi

    # Exit if running as root. We don't want to create a root_login_init.sh for root user
    if [[ "$(whoami)" = "root" ]]; then
        logit "Running as root. Not creating root_login_init.sh"
        return 0
    fi

    logit "Writing to $HOME/.config/bash/root_login_init.sh"
    cat <<EOF >|"$HOME/.config/bash/root_login_init.sh"
# Check if we have .bash_profile in /root. If yes, load that
if [ -e "/root/.bash_profile" ]; then
    echo "user=\$(whoami): [Note]: Loading /root/.bash_profile"
    . "/root/.bash_profile"
# If not, load .profile instead
else
    echo "user=\$(whoami): [Note]: Loading /root/.profile"
    . "/root/.profile"
fi

echo "user=\$(whoami): [Note]: Loading $HOME/.bash_profile"
. "$HOME/.bashrc"

# Move to /root once bashrc has been loaded
cd /root
EOF
}

# If you end up breaking the root_login_init.sh script, you can run
# init_sudo_login --overwrite to regenerate the file
init_sudo_login

sudo() {
    # Run the custom sudo only if not running as root
    if [[ "$1" = "-i" && "$#" -eq 1 && "$(whoami)" != "root" ]]; then
        command sudo bash --rcfile "$HOME/.config/bash/root_login_init.sh"
    else
        command sudo "$@"
    fi
}
