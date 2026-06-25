hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("wl-paste --watch cliphist store")

	hl.exec_cmd("hypridle")
	hl.exec_cmd("dunst ")
	hl.exec_cmd("waybar -c ~/.config/waybar/hypr-config.jsonc")
	-- hl.exec_cmd("qs")
	hl.exec_cmd("hyprpaper")

	hl.exec_cmd("kitty")
end)
