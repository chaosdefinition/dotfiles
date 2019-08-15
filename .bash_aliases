#
# NOTE: Add a trailing space to keep aliases.
#

alias ls='ls --color --group-directories-first '
alias ll='ls -la '
alias cls='printf "\033c" '
alias grep='grep --color '
alias sudo='sudo '
alias op='xdg-open 2> /dev/null '

if which vim >/dev/null 2>&1; then
    alias vi='vim '
fi
