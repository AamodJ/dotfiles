-- KeePass
hl.window_rule({
	name = "KeePassXC rules",
	match = {
		class = "KeePassXC",
	},

	float = true,
	center = true,
	size = { "(monitor_w*0.75)", "(monitor_h*0.75)" },
	workspace = "special:magic",
})

-- wayland-boomer
hl.window_rule({
	match = { title = "wayland-boomer" },
	float = true,
	move = "0 0",
	size = { "(monitor_w)", "(monitor_h)" },
})

-- Thunderbird
hl.window_rule({ match = { class = ".*Thunderbird.*" }, workspace = 1 })

-- Slack
hl.window_rule({ match = { class = "Slack" }, workspace = 1 })
hl.window_rule({ match = { title = "^Huddle.*" }, float = true })
hl.window_rule({ match = { title = "^(default) Active$" }, float = true })

-- QjackCtl
hl.window_rule({
	match = {
		class = "QjackCtl",
		title = "Graph.*",
	},
	center = true,
	float = true,
	size = { "(monitor_w*0.75)", "(monitor_h*0.75)" },
})
hl.window_rule({
	match = {
		title = "\\(default\\) Active",
	},
	float = true,
	move = { "(monitor_w*0.75)", "(monitor_h*0.9)" },
})
