# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\u@\h \W\$ '
eval $(opam env)

alias ls='ls --color=auto'
alias dotfiles='git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'
