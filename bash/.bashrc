#!/usr/bin/env bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# colors
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
red=$(tput setaf 9)
reset=$(tput sgr0)

# prompt
PS1="\[${blue}\]strand:\[${reset}\]"
PS1+="\[${yellow}\]\w"
PS1+="\[${red}\] \[❯\] \[${reset}\]"
export PS1;

# aliases
alias ls='exa'
alias vim='nvim'
alias tmux='tmux -u'
alias mutt='neomutt'
alias gdb='gdb -tui'
alias valgrind='valgrind --leak-check=full --show-leak-kinds=all'

# colored manpages
export LESS_TERMCAP_mb=$'\e[01;32m'
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;32m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;4;31m'

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
[ -f ~/.fzf.bash ] && source /home/jason/.fzf.bash

if [ "$(tty)" = "/dev/tty1" ]; then
	export XDG_SESSION_TYPE=wayland
	exec sway
fi
