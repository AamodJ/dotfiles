-- hl.config({
-- 	debug = { enable_stdout_logs = true },
-- })

local load_configs = function(dir)
	local path = os.getenv("XDG_CONFIG_HOME") .. "/hypr/hyprland/" .. dir
	for filename in io.popen("ls " .. path .. " | xargs -n 1 basename"):lines() do
		local name = filename:match("^(.*).lua$")
		if name then
			require("hyprland." .. dir .. "." .. name)
		end
	end
end

load_configs("envvars")
load_configs("configs")
load_configs("binds")
load_configs("layouts")

-- hl.plugin.reload()

hl.config({
	plugin = {
		hyprcapture = {
			allow_quick = true,
			default_mode = "fullscreen",
			save = true,
			clipboard = true,
			save_dir = "~/pics/screenshots/",
			filename_template = "%Y%m%d%H%M%S.png",
		},
	},
})

hl.bind("SUPER + SHIFT + y", function()
	hl.plugin.hyprcapture.quick()
	hl.dispatch(hl.dsp.exec_cmd("wl-paste | wayland-boomer -ms 2"))
end)

hl.config({
	general = {
		layout = "lua:grid",
	},
})
