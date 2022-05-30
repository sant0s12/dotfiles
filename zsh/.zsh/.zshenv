export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export ZDOTDIR=$HOME/.zsh

export TRASH=$XDG_DATA_HOME/Trash

export TERMINAL=kitty
export BROWSER=firefox
export EDITOR=nvim
export EXPLORER="$TERMINAL -e lf"

export MOZ_USE_XINPUT2=1
export _JAVA_AWT_WM_NONREPARENTING=1

export RISCV=/opt/riscv

export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

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

if [ -d "$HOME/.opam/default/bin" ] ; then
	PATH="$HOME/.opam/default/bin:$PATH"
fi

if [ -d "$RISCV/bin" ] ; then
	PATH="$RISCV/bin:$PATH"
fi
