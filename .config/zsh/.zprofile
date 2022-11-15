# Persistent PATH variable
export PATH="$PATH:$HOME/.local/bin/:$HOME/.local/sbin/"
export PATH="$PATH:$HOME/.local/share/applications/Write/"

echo "BSPWM (1), Hyprland (2), KDE-Wayland (3), KDE-X11 (4), tty (5)?"
read WM

case $WM in
"1")
	export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
	exec startx $HOME/.config/X11/.xinitrc
	;;

"2")
	unset XAUTHORITY
	. $HOME/.config/wayland/wrapperhl
	;;
"3")
	unset XAUTHORITY
	export DESKTOP_SESSION=plasma
	. $HOME/.config/wayland/plasma-wayland
	;;
"4")
	export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
	export DESKTOP_SESSION=plasma
	exec startx $HOME/.config/X11/.xinitrc-plasma-x11
	;;
"5")
	;;
*) 
	echo "Invalid input"
	;;
esac
