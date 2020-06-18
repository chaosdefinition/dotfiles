#!/bin/sh

# We have executed .profile
PROFILE_DEFINED=1

#
# Add a path to a specified environment variable.
#
# $1: the path
# $2: before or after
# $3: name of the environment variable
#
add_path() {
    eval "_tmp=\$$3"
    case ":$_tmp:" in
    *":$1:"* )
        # Ignore duplicates
        ;;
    * )
        if [ -d "$1" ]; then
            if [ -z "$_tmp" ]; then
                eval "$3=$1"
            elif [ "$2" = "before" ]; then
                eval "$3=$1:$_tmp"
            else
                eval "$3=$_tmp:$1"
            fi
        fi
        ;;
    esac
    unset _tmp
}

# File creation mask, 644 for regular files, 755 for directories
umask 022

# Expand PATH
add_path "$HOME/bin" before PATH
add_path "$HOME/.local/bin" before PATH
if which ruby >/dev/null 2>&1 && which gem >/dev/null 2>&1; then
    GEM_PATH="`ruby -r rubygems -e 'puts Gem.user_dir'`/bin"
    add_path "$GEM_PATH" before PATH
    unset GEM_PATH
fi
export PATH

# Reconfigure MANPATH
unset MANPATH
MANPATH=`manpath 2>/dev/null`
add_path "$HOME/man" before MANPATH
add_path "$HOME/share/man" before MANPATH
export MANPATH

export EDITOR="vi"      # Default editor
export PAGER="less"     # Default pager

# Set PS1
if [ "$PS1" ]; then
    export PS1="\$ "
fi

# Set aliases
if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases"
fi

###############################################################################
# Put additional settings here before we go to bash ###########################
###############################################################################

# Source .bashrc
if [ "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && [ -z ${BASHRC_DEFINED+x} ]; then
    . "$HOME/.bashrc"
fi
