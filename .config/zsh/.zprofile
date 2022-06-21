if [[ "$(tty)" == "/dev/tty1" ]]; then
	pgrep bspwm || exec startx ~/.config/X11/.xinitrc
fi
