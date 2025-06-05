export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export ZDOTDIR=$XDG_CONFIG_HOME/zsh

export TRASH=$XDG_DATA_HOME/Trash

export TERMINAL=ghostty
export BROWSER=firefox
export EDITOR=nvim
export EXPLORER="$TERMINAL -e yazi"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export DOOMDIR="$XDG_CONFIG_HOME/doom"

export MOZ_USE_XINPUT2=1
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=gasp"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"

export PNPM_HOME="/home/santos/.local/share/pnpm"

export NIXOS_CONFIG_DIR=$(readlink -f "$XDG_CONFIG_HOME/nixos")

# Fix programs putting stuff in ~
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export _JAVA_OPTIONS="$_JAVA_OPTIONS -Djava.util.prefs.userRoot=\"$XDG_CONFIG_HOME/java\""
export KODI_DATA="$XDG_DATA_HOME"/kodi
export LEIN_HOME="$XDG_DATA_HOME"/lein
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export WAKATIME_HOME="$XDG_CONFIG_HOME"/wakatime
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export OCTAVE_HISTFILE="$XDG_CACHE_HOME"/octave-hsts
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME"/octave/octaverc
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME"/python
export PYTHONUSERBASE="$XDG_DATA_HOME"/python
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export ANDROID_HOME="$XDG_DATA_HOME"/android
export HISTFILE="$XDG_DATA_HOME"/shell_history
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export W3M_DIR="$XDG_DATA_HOME"/w3m
export PUB_CACHE="$XDG_CACHE_HOME"/pub
export KUBECONFIG="$XDG_CONFIG_HOME"/kube/config
export KREW_ROOT="$XDG_DATA_HOME"/krew
export GDBHISTFILE="$XDG_CONFIG_HOME"/gdb/gdb_history
export IPFS_PATH="$XDG_DATA_HOME"/ipfs
export MINIKUBE_HOME="$XDG_DATA_HOME"/minikube
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"

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

if [ -d "$CARGO_HOME/bin" ] ; then
	PATH="$CARGO_HOME/bin:$PATH"
fi

if [ -d "$HOME/.opam/default/bin" ] ; then
	PATH="$HOME/.opam/default/bin:$PATH"
fi

if [ -d "$HOME/.local/share/flutter/bin" ] ; then
	PATH="$HOME/.local/share/flutter/bin:$PATH"
fi

if [ -d "$PUB_CACHE/bin" ] ; then
	PATH="$PUB_CACHE/bin:$PATH"
fi

if [ -d "$RISCV/bin" ] ; then
	PATH="$RISCV/bin:$PATH"
fi

if [ -d "${KREW_ROOT:-$HOME/.krew}" ] ; then
	PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

if [ -d "$PNPM_HOME" ] ; then
	PATH="$PNPM_HOME:$PATH"
fi
