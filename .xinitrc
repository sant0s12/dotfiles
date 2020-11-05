setxkbmap -option caps:escape

# gnome keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
dbus-update-activation-environment --systemd DISPLAY

exec i3
