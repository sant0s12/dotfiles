export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export ZDOTDIR=$HOME/.zsh

export TRASH=$XDG_DATA_HOME/Trash

export TERMINAL=kitty
export BROWSER=librewolf
export EDITOR=nvim
export EXPLORER="$TERMINAL -e lf"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export DOOMDIR="$XDG_CONFIG_HOME/doom"

export MOZ_USE_XINPUT2=1
export _JAVA_AWT_WM_NONREPARENTING=1

export RISCV=/opt/riscv

if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
	export GOBIN="$HOME/.local/bin"
fi

if [ -d "$HOME/.local/bin/scripts" ] ; then
	PATH="$HOME/.local/bin/scripts:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
	PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.opam/default/bin" ] ; then
	PATH="$HOME/.opam/default/bin:$PATH"
fi

if [ -d "$RISCV/bin" ] ; then
	PATH="$RISCV/bin:$PATH"
fi
