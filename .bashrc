# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

source /usr/share/bash-completion/bash_completion

PROMPT_DIRTRIM=2
PS1='\[\e[0;1;3;97m\]\u\[\e[0m\]@\[\e[0m\]\h\[\e[m\] \[\e[0m\]\w\[\e[m\]$(parse_git_branch)\$ \[\e0'

eval $(opam env)

alias ls='ls --color=auto'
alias dotfiles='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'

