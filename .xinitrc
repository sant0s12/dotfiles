setxkbmap -option caps:escape

# gnome keyring
export $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
dbus-update-activation-environment --systemd DISPLAY

exec i3
