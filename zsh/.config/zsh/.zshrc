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

# Plugins
# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $ZDOTDIR/.antidote/antidote.zsh
antidote load

setopt promptsubst

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

# mosh tmux
function tmosh() {
    mosh $1 -- tmux new -As0
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

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
