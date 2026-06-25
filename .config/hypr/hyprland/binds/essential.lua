hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

hl.bind(
	"SUPER + SHIFT + q",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind("ALT + q", hl.dsp.window.close())
hl.bind("ALT + s", hl.dsp.window.float())
hl.bind("ALT + f", hl.dsp.window.fullscreen())
hl.bind("SUPER + m", hl.dsp.window.pin())

hl.bind("SUPER + BACKSPACE", hl.dsp.exec_cmd("lockscreen"))
hl.bind("SUPER + n", hl.dsp.exec_cmd("dunstctl history-pop"))
hl.bind("SUPER + 8", hl.dsp.exec_cmd("togglebar"))

-- Client keybinds
hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + c", hl.dsp.exec_cmd("librewolf"))
hl.bind("SUPER + e", hl.dsp.exec_cmd("nautilus"))
hl.bind("SUPER + s", hl.dsp.exec_cmd("slack"))

-- rofi keybinds
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("rofi -terminal kitty -show drun"))
hl.bind("SUPER + ALT + m", hl.dsp.exec_cmd("rofi -show run"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("rofi -show calc -no-show-match -no-sort"))
hl.bind("SUPER + r", hl.dsp.exec_cmd("rofi -show emoji"))
hl.bind("SUPER + y", hl.dsp.exec_cmd("rofi -show ssh"))
hl.bind("SUPER + v", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy"))
hl.bind(
	"SUPER + p",
	hl.dsp.exec_cmd(
		"rofi -theme-str 'element-icon { size: 3ch;}' -combi-modi 'snippets:snippy-snippet rofi' -show combi -modi combi"
	)
)
hl.bind("SUPER + o", hl.dsp.exec_cmd("rofi-kpxc"))

-- macOS like screenshots
hl.bind("SUPER + SHIFT + 3", hl.dsp.exec_cmd("screenshot"))
hl.bind("SUPER + SHIFT + 4", hl.dsp.exec_cmd("screenshot region"))
hl.bind(
	"SUPER + SHIFT + 5",
	hl.dsp.exec_cmd(
		"grim -t jpeg -o \"$(hyprctl monitors | awk '/Monitor/{mon=$2} /focused: yes/{print mon}')\" - | wayland-boomer -ms $(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .scale')"
	)
)
