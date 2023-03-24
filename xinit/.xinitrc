# Source /etc/X11/xinit/xinitrc.d/
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export XDG_SESSION_TYPE=x11

# gnome keyring
export $(/usr/bin/gnome-keyring-daemon --start)

# Xresources, they should be merged before the wm starts, so no exec
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

exec i3
