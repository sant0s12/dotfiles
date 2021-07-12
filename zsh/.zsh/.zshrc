#  ____              _    ___      _ ____  
# / ___|  __ _ _ __ | |_ / _ \ ___/ |___ \ 
# \___ \ / _` | '_ \| __| | | / __| | __) |
#  ___) | (_| | | | | |_| |_| \__ \ |/ __/ 
# |____/ \__,_|_| |_|\__|\___/|___/_|_____|

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export ZDOTDIR=$HOME/.zsh

export TRASH=$XDG_DATA_HOME/Trash

export TERMINAL=urxvt
export BROWSER=firefox
export EDITOR=vim
export EXPLORER="$TERMINAL -e ranger"

export MOZ_USE_XINPUT2=1

if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/bin/scripts" ] ; then
	PATH="$HOME/.local/bin/scripts:$PATH"
fi

if [ -d "$HOME/.opam/default/bin" ] ; then
	PATH="$HOME/.opam/default/bin:$PATH"
fi

[ -d $XDG_CACHE_HOME/zsh ] || mkdir -p $XDG_CACHE_HOME/zsh

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=$XDG_CACHE_HOME/zsh/history

KEYTIMEOUT=1

# Zinit stuff
source $ZDOTDIR/.zinit/bin/zinit.zsh

setopt promptsubst

zinit wait for \
	OMZL::git.zsh \
	OMZP::git

zinit wait'!' for \
	is-snippet $ZDOTDIR/themes/robbyrussell.zsh-theme

zinit wait lucid for \
	atinit"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
	atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
	blockf atpull'zinit creinstall -q .' atinit"zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'" zsh-users/zsh-completions \
	softmoth/zsh-vim-mode

unsetopt correct_all  
setopt correct

alias ls='ls --color=auto'
alias dotfiles='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias py='python'
alias i3conf='$EDITOR $XDG_CONFIG_HOME/i3/config'

if [ $(tty) = "/dev/tty1" ]; then
	exec startx;
fi
