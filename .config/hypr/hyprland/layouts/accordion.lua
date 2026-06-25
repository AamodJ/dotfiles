local accordion_state = {
	gap = 60,
	dir = "horizontal",
}

hl.layout.register("accordion", {
	recalculate = function(ctx)
		local n = #ctx.targets
		if n == 0 then
			return
		end

		if accordion_state.dir == "horizontal" then
			local width = ctx.area.w - (n - 1) * accordion_state.gap

			for i, target in ipairs(ctx.targets) do
				target:place({
					x = ctx.area.x + (i - 1) * accordion_state.gap,
					y = ctx.area.y,
					w = width,
					h = ctx.area.h,
				})
			end
		else
			local height = ctx.area.h - (n - 1) * accordion_state.gap

			for i, target in ipairs(ctx.targets) do
				target:place({
					x = ctx.area.x,
					y = ctx.area.y + (i - 1) * accordion_state.gap,
					w = ctx.area.w,
					h = height,
				})
			end
		end
	end,

	layout_msg = function(ctx, msg)
		local command = msg:match("^(%S+)$")
		if command == "toggle_dir" then
			accordion_state.dir = accordion_state.dir == "horizontal" and "vertical" or "horizontal"
		end
	end,
})
