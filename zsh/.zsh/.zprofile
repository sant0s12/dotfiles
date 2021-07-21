if [ $(tty) = "/dev/tty1" ]; then
	startx;exit
elif [ $(tty) = "/dev/tty2" ]; then
	export QT_QPA_PLATFORM=wayland
	export MOZ_ENABLE_WAYLAND=1
	sway;exit
fi
