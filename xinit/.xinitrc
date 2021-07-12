setxkbmap -option caps:escape_shifted_capslock

# gnome keyring
export $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
dbus-update-activation-environment --systemd DISPLAY

# ssh-agent
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

exec i3
