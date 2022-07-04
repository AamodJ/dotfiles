export PATH="$PATH:$HOME/.local/bin"

if [[ "$(tty)" == "/dev/tty1" ]]; then
	pgrep bspwm || exec startx $HOME/.config/X11/.xinitrc
fi
