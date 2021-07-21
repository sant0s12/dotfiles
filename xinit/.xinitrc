setxkbmap -option caps:escape_shifted_capslock

# gnome keyring
export $(/usr/bin/gnome-keyring-daemon --start)
dbus-update-activation-environment --systemd DISPLAY

exec i3
