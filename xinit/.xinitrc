setxkbmap -option caps:escape_shifted_capslock

# gnome keyring
export $(/usr/bin/gnome-keyring-daemon --start)
dbus-update-activation-environment --systemd DISPLAY

# Xresources, they should be merged before the wm starts, so no exec
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

exec i3
