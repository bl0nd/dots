#!/usr/bin/env bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# colors
red=$(tput setaf 9)
blue=$(tput setaf 39)
reset=$(tput sgr0)

# prompt
PS1="\[${red}\]\u"
PS1+="\[${reset}\] at "
PS1+="\[${red}\]\h"
PS1+="\[${reset}\] \w"
PS1+="\[${blue}\] \[❯\] "
PS1+="\[${reset}\]"
export PS1;

# aliases
alias ls='exa'
alias vim='nvim'

# colored manpages
export LESS_TERMCAP_MB=$'\e[01;31m'
export LESS_TERMCAP_MD=$'\e[01;31m'
export LESS_TERMCAP_ME=$'\e[0m'
export LESS_TERMCAP_SE=$'\e[0m'
export LESS_TERMCAP_SO=$'\e[01;44;33m'

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

if [ "$(tty)" = "/dev/tty1" ]; then
	export XDG_SESSION_TYPE=wayland
	exec sway
fi
