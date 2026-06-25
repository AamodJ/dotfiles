hl.config({
	ecosystem = {
		no_update_news = true,
	},
})
hl.config({
	input = {
		kb_options = "caps:escape, shift:both_capslock",
		repeat_rate = 70,
		repeat_delay = 250,
		follow_mouse = 1,

		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
			scroll_factor = 1.5,
		},

		sensitivity = 0.25,
		accel_profile = adaptive,
	},
})
hl.config({ cursor = { inactive_timeout = 2 } })
hl.config({
	general = {
		border_size = 1,
		gaps_in = 0,
		gaps_out = 0,
		col = {
			active_border = "0xFFdfc5a4",
			inactive_border = "0x33dfc5a4",
		},
		layout = dwindle,
	},
	binds = {
		allow_workspace_cycles = true,
	},
})
-- Decor
hl.config({
	decoration = {
		rounding = 0,
		blur = {
			enabled = false,
			size = 7,
			passes = 2,
			new_optimizations = 1,
		},
		dim_inactive = true,
		dim_strength = 0.25,
		shadow = {
			enabled = false,
			-- range = 20,
			-- render_power = 2,
			-- ignore_window = 1,
			-- offset =  8 8,
			-- color = 0x44000000,
		},
	},
	animations = {
		enabled = false,
		-- Need to lua-fy this but I don't use anims anymore
		-- bezier = overshot, 0.13, 0.99, 0.29, 1,
		-- animation = windows, 1, 5, overshot, slide,
		-- animation = workspaces, 1, 6, overshot, slide,
	},
})
-- Window layouts
hl.config({
	master = {
		new_on_top = true,
		new_status = "master",
	},

	dwindle = {
		preserve_split = false,
		smart_split = true,
	},
})
-- Others
hl.config({
	misc = {
		disable_hyprland_logo = true,
		mouse_move_enables_dpms = true,
		enable_swallow = true,
		swallow_regex = kitty,
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})
