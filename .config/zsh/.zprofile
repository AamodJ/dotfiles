# Persistent PATH variable
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/applications/Write/"
export PATH="$PATH:$HOME/.local/share/applications/Discord"

if [[ "$(tty)" == "/dev/tty1" ]]; then
	pgrep bspwm || exec startx $HOME/.config/X11/.xinitrc
fi
