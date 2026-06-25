local M = {}

M.load_configs = function(dir)
	local path = os.getenv("XDG_CONFIG_HOME") .. "/hypr/hyprland/" .. dir
	for filename in io.popen("ls " .. path .. " | xargs -n 1 basename"):lines() do
		local name = filename:match("^(.*).lua$")
		if name then
			require("hyprland." .. dir .. "." .. name)
		end
	end
end

return M
