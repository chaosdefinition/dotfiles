#!/usr/bin/env bash

# Chaos's bashrc, source this file in .profile.

# We have executed .bashrc
BASHRC_DEFINED=1

# Source .profile if we haven't done so
if [ -f "$HOME/.profile" ] && [ -z ${PROFILE_DEFINED+x} ]; then
    . "$HOME/.profile"
fi

# File creation mask, 644 for regular files, 755 for directories
umask 022

# If not running interactively, don't do anything
case $- in
*i*)
    ;;
*)
    return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

if which vim >/dev/null 2>&1; then
    export EDITOR="vim"     # Default editor
fi
if which less >/dev/null 2>&1; then
    export PAGER="less"     # Default pager
fi

# Set aliases
if [[ -f "$HOME/.bash_aliases" ]]; then
    . "$HOME/.bash_aliases"
fi

# Function to print a useful prompt
prompt_command() {
    local exit_status="$?"

    # Color definitions
    local normal="\[\e[0m\]"        # Normal color
    local fGbBb="\[\e[1;32;44m\]"   # Green foreground, blue background, bold
    local fYbBb="\[\e[1;33;44m\]"   # Yellow foreground, blue background, bold
    local fP="\[\e[35m\]"           # Purple foreground
    local fBb="\[\e[1;34m\]"        # Blue foreground, bold
    local fY="\[\e[0;33m\]"         # Yellow foreground
    local fR="\[\e[0;31m\]"         # Red foreground

    # Git prompt
    local git_branch=`__git_ps1 2> /dev/null`

    # Set PS1
    if [[ "$PS1" ]]; then
        PS1="$fGbBb"
        PS1="$PS1\u"                    # Username
        PS1="$PS1$fYbBb"
        PS1="$PS1@"                     # @
        PS1="$PS1$fGbBb"
        PS1="$PS1\h"                    # Hostname
        PS1="$PS1$normal"
        PS1="$PS1 "                     # <Space>
        PS1="$PS1$fP"
        PS1="${PS1}bash"                # bash
        PS1="$PS1$normal"
        PS1="$PS1 "                     # <Space>
        PS1="$PS1$fBb"
        PS1="$PS1\w"                    # PWD
        PS1="$PS1$fY"
        if [[ -n "$git_branch" ]]; then
            PS1="$PS1$git_branch"       # Current Git branch name
        fi
        PS1="$PS1$normal"
        PS1="$PS1\n"                    # Newline
        if [[ "$exit_status" != 0 ]]; then
            PS1="$PS1$fR"
        fi
        PS1="$PS1\\$"                   # UID indicator
        PS1="$PS1$normal"
        PS1="$PS1 "                     # <Space>
        export PS1
    fi
}
export PROMPT_COMMAND=prompt_command

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS="-S -R -Q --mouse --wheel-lines=1"

# Custom ls colors
if [[ -f "$HOME/.dir_colors" ]]; then
    eval `dircolors "$HOME/.dir_colors"`
elif [[ -f "/etc/DIR_COLORS" ]]; then
    eval `dircolors "/etc/DIR_COLORS"`
fi

# Set up bash-completion and git-prompt
BASH_COMP=(
    "/usr/share/bash-completion/bash_completion"
    "/usr/local/share/bash-completion/bash_completion"
    "/usr/local/etc/bash_completion"
    "$HOME/etc/bash-completion/bash_completion"
)
GIT_PROMPT=(
    "/usr/share/git/completion/git-prompt.sh"
    "/usr/share/git-core/contrib/completion/git-prompt.sh"
    "/usr/local/share/git/completion/git-prompt.sh"
    "/usr/local/share/git-core/contrib/completion/git-prompt.sh"
    "$HOME/share/git/completion/git-prompt.sh"
    "$HOME/share/git-core/contrib/completion/git-prompt.sh"
    "/usr/share/git-core/contrib/completion/git-completion.bash"
    "/usr/local/share/git-core/contrib/completion/git-completion.bash"
    "$HOME/share/git-core/contrib/completion/git-completion.bash"
)
for file in ${BASH_COMP[@]}; do
    if [[ -f "$file" ]]; then
        . "$file"
        break
    fi
done
for file in ${GIT_PROMPT[@]}; do
    if [[ -f "$file" ]]; then
        . "$file"
        break
    fi
done
unset BASH_COMP
unset GIT_PROMPT

###############################################################################
# Additional settings #########################################################
###############################################################################

# Move cursor backward a word
bind '"\e[1;5D": backward-word' # Ctrl + Left
bind '"\e[1;3D": backward-word' # Alt + Left

# Move cursor forward a word
bind '"\e[1;5C": forward-word'  # Ctrl + Right
bind '"\e[1;3C": forward-word'  # Alt + Right

# Delete a word
bind '"\C-_": backward-kill-word'   # Ctrl + Backspace
bind '"\e\C-?": backward-kill-word' # Alt + Backspace

# Home and End
bind '"\e[1~": beginning-of-line'   # Home
bind '"\e[4~": end-of-line'         # End

#
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#
shopt -s checkwinsize

#
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#
shopt -s globstar

#
# Allow "*" to match no entry.
#
# Disabled for now; it breaks bash-completion. Bash-completion 3.0 will
# hopefully fix it.
#
shopt -u nullglob

#
# Reset completion of 'op' to default as we use it as an alias.
#
complete -o default op

#
# Output all combinations of terminal colors.
#
function colors {
    # Background
    for clbg in {40..47} {100..107} 49; do
        # Foreground
        for clfg in {30..37} {90..97} 39; do
            # Formatting
            for attr in 0 1 2 3 4 5 7 8 9; do
                # Print the result
                printf "\e[${attr};${clbg};${clfg}m \\\\e[${attr};${clbg};${clfg}m \e[0m"
            done
            printf "\n"
        done
    done
}
