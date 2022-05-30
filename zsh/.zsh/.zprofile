if [ $(tty) = "/dev/tty1" ]; then
	exec startx
elif [ $(tty) = "/dev/tty2" ]; then
	exec startsway
fi
