# shellcheck disable=SC2148,SC2034,SC1091
if [ ! -x /usr/bin/tput ] || ! tput setaf 1 >&/dev/null; then
    color_prompt=
    PS1='\u@\h:\w\$ '
    unset color_prompt force_color_prompt
    return
fi

# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
#
# PS1 colours for easy configuration
# Source: https://bigdinosaur.org/easy-ps1-colors/
# Good resource to understand prompt customization: https://wiki.archlinux.org/title/Bash/Prompt_customization
PS1_BLACK="\[\e[0;30m\]"
PS1_BLACKBOLD="\[\e[1;30m\]"
PS1_RED="\[\e[0;31m\]"
PS1_REDBOLD="\[\e[1;31m\]"
PS1_GREEN="\[\e[0;32m\]"
PS1_GREENBOLD="\[\e[1;32m\]"
PS1_YELLOW="\[\e[0;33m\]"
PS1_YELLOWBOLD="\[\e[1;33m\]"
PS1_BLUE="\[\e[0;34m\]"
PS1_BLUEBOLD="\[\e[1;34m\]"
PS1_PURPLE="\[\e[0;35m\]"
PS1_PURPLEBOLD="\[\e[1;35m\]"
PS1_CYAN="\[\e[0;36m\]"
PS1_CYANBOLD="\[\e[1;36m\]"
PS1_WHITE="\[\e[0;37m\]"
PS1_WHITEBOLD="\[\e[1;37m\]"
PS1_RESET="\[\e[0m\]"

color_prompt=yes
user_color="$PS1_BLUEBOLD"
if [ "$(whoami)" = root ]; then
    user_color="$PS1_REDBOLD"
fi

if [ -r /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt
elif [ -r /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# Display exit status
exitstatus() {
    local exitcode="$?"

    # We have to escape our colours with \001 (hex: \x01) and \002 (hex: \x02)
    # Source: https://superuser.com/questions/301353/escape-non-printing-characters-in-a-function-for-a-bash-prompt/301355#301355
    #
    # If you try \001 \002, you'll quickly find that SIGINT (exit code = 130) gets printed as 30
    # So we gotta use the hexadecimal values here
    # That stack overflow thread is goated for this tip
    local RED="\x01\e[0;31m\x02"
    local REDBOLD="\x01\e[1;31m\x02"
    local GREEN="\x01\e[0;32m\x02"
    local RESET="\x01\e[0m\x02"

    if [[ "$exitcode" -ne 0 ]]; then
        # Get error code description
        if [[ "$exitcode" -eq 1 ]]; then
            desc=" FAIL "
        elif [[ "$exitcode" -gt 128 ]]; then
            desc=" $(kill -l "$((exitcode - 128))") "
        else
            desc=" "
        fi
        echo -en "$REDBOLD$exitcode$desc$RESET"
    fi
}

prompt_command() {
    # For elapsed time calculation
    local -i start_time end_time \
        elapsed_hours elapsed_minutes elapsed_seconds
    end_time=$(date +%s)

    # Draw clock
    local SERVERCLOCK MUTCLOCK clocksize fillsize \
        fill clockline PS1_GIT_PRE PS1_GIT_POST

    SERVERCLOCK="$(date +"%H:%M:%S %Z") "
    MUTCLOCK=" $(TZ="Indian/Mauritius" date +"%H:%M:%S MUT")"
    clocksize=$((${#SERVERCLOCK} + ${#MUTCLOCK}))
    fillsize=$((COLUMNS - clocksize))
    fill=""
    while [ "$fillsize" -gt 0 ]; do
        fill="$fill-"
        fillsize=$((fillsize - 1))
    done
    clockline="$SERVERCLOCK$fill$MUTCLOCK"

    # Execution time
    start_time=$(HISTTIMEFORMAT='%s ' history | tail -n 1 | awk '{ print $2 }')
    ## We defined end_time above
    elapsed_seconds=$((end_time - start_time))

    elapsed_hours=$((elapsed_seconds / 3600))
    elapsed_minutes=$(((elapsed_seconds % 3600) / 60))
    elapsed_seconds=$((elapsed_seconds % 60))

    if [[ $elapsed_hours -gt 0 ]]; then
        execution_time="Took ${elapsed_hours}h ${elapsed_minutes}m ${elapsed_seconds}s"
    elif [[ $elapsed_minutes -gt 0 ]]; then
        execution_time="Took ${elapsed_minutes}m ${elapsed_seconds}s"
    else
        execution_time="Took ${elapsed_seconds}s"
    fi

    PS1_GIT_PRE="\n$clockline\n${user_color}\u$PS1_YELLOWBOLD@$PS1_CYANBOLD\h \$(exitstatus)$PS1_YELLOWBOLD\w$PS1_RESET"
    PS1_GIT_POST=" ${user_color}❯$PS1_RESET "

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
    if [[ $(type -t __git_ps1) == function ]] && [[ $PROMPT_COMMAND != *__git_ps1* ]]; then
        __git_ps1 "$PS1_GIT_PRE" "$PS1_GIT_POST" " [%s]"
    else
        PS1="$PS1_GIT_PRE$PS1_GIT_POST"
    fi
}

PROMPT_COMMAND='history -a; prompt_command'
unset color_prompt force_color_prompt
