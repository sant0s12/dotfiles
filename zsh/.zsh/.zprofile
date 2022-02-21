if [ $(tty) = "/dev/tty1" ]; then
	exec startx
elif [ $(tty) = "/dev/tty2" ]; then
	export QT_QPA_PLATFORM=wayland
	export MOZ_ENABLE_WAYLAND=1

	exec sway
fi
