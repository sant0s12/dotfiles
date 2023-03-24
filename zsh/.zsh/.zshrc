#  ____              _    ___      _ ____
# / ___|  __ _ _ __ | |_ / _ \ ___/ |___ \ 
# \___ \ / _` | '_ \| __| | | / __| | __) |
#  ___) | (_| | | | | |_| |_| \__ \ |/ __/
# |____/ \__,_|_| |_|\__|\___/|___/_|_____|

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

# Kitty
if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

alias ls='ls --color=auto'
alias la='ls -la'
alias lf=lfcd
type bat &> /dev/null && alias cat=bat
alias dotfiles='git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME/.dotfiles'
alias py='python'
alias i3conf='$EDITOR $XDG_CONFIG_HOME/i3/config'
alias swayconf='$EDITOR $XDG_CONFIG_HOME/sway/config'
alias spotify='spotify-launcher'
alias conda-activate='source ~/.miniconda3/bin/activate'
alias make="make -j $(($(nproc) + 1))"
alias sudoedit="doasedit"
alias paru-remove-unused="paru -Qtdq | paru -Rns -"
