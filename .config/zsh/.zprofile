# Persistent PATH variable
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/applications/Write/"

if [[ "$(tty)" == "/dev/tty1" ]]; then
	pgrep bspwm || exec startx $HOME/.config/X11/.xinitrc
fi
