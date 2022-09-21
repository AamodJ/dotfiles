# Persistent PATH variable
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/applications/Write/"

# if [[ "$(tty)" == "/dev/tty1" ]]; then
# 	pgrep bspwm || exec startx $HOME/.config/X11/.xinitrc
# fi

echo "BSPWM (1), Sway (2), KDE-Wayland (3), KDE-X11 (4)?"
read WM

case $WM in
"1")
	exec startx $HOME/.config/X11/.xinitrc
	;;

"2")
	exec sway
	;;
"3")
	export DESKTOP_SESSION=plasma
	. $HOME/.config/wayland/plasma-wayland
	;;
"4")
	export DESKTOP_SESSION=plasma
	exec startx $HOME/.config/X11/.xinitrc-plasma-x11
	;;
esac
