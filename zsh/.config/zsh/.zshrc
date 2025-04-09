#  ____              _    ___      _ ____
# / ___|  __ _ _ __ | |_ / _ \ ___/ |___ \ 
# \___ \ / _` | '_ \| __| | | / __| | __) |
#  ___) | (_| | | | | |_| |_| \__ \ |/ __/
# |____/ \__,_|_| |_|\__|\___/|___/_|_____|

[ -d $XDG_DATA_HOME/zsh ] || mkdir -p $XDG_DATA_HOME/zsh

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=$XDG_DATA_HOME/zsh/history

fpath+="$ZDOTDIR/completions"

# Share history across open terminals
# setopt share_history

KEYTIMEOUT=1

# Zinit stuff
ZINIT_HOME="${XDG_DATA_HOME}/zsh/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

ZINIT[ZCOMPDUMP_PATH]="${XDG_DATA_HOME}/zsh/zinit/zcompdump"
ZINIT[COMPINIT_OPTS]="-d ${ZINIT[ZCOMPDUMP_PATH]}"

setopt promptsubst

zinit wait lucid for \
	OMZL::git.zsh \
	OMZP::git

zinit wait'!' lucid for \
	is-snippet $ZDOTDIR/themes/robbyrussell.zsh-theme

zinit wait lucid for \
	atinit"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
	atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
	blockf atpull'zinit creinstall -q .' atinit"zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'" zsh-users/zsh-completions

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

unsetopt correct_all
setopt correct

# Kitty
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="no-sudo"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

# git push --force-with-lease
git() {
  if [[ $@ == 'push -f'* || $@ == 'push --force '*  ]]; then
    echo Hey stupid, use --force-with-lease instead
  else
    command git "$@"
  fi
}

flatten_pdf() {
  inkscape "$1" --export-type pdf --export-filename "$1"
}

bindkey "${key[Up]}" history-beginning-search-backward
bindkey "${key[Down]}" history-beginning-search-forward

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitten ssh"

alias ls='ls --color=auto'
alias la='ls -la'
alias lf='[ -n "$LF_LEVEL" ] && exit || lf'
type bat &> /dev/null && alias cat=bat
alias dotfiles='git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME/.dotfiles'
alias py='python'
alias i3conf='$EDITOR $XDG_CONFIG_HOME/i3/config'
alias hyprconf='$EDITOR $XDG_CONFIG_HOME/hypr/hyprland.conf'
alias conda-activate='source ~/.miniconda3/bin/activate'
alias make="make -j $(($(nproc) + 1))"
alias paru-remove-unused="paru -Qtdq | paru -Rns -"
alias activate="source venv/bin/activate"
alias vim=nvim
alias vimrc="$EDITOR $XDG_CONFIG_HOME/nvim/init.lua"
alias gef="gdb -ex 'source /usr/share/gef/gef.py'"
