hl.layout.register("fair", {
	recalculate = function(ctx)
		local window_count = #ctx.targets
		if window_count == 0 then
			return
		end

		for _, target in ipairs(ctx.targets) do
			target:place({
				x = 0,
				y = 0,
				w = 100,
				h = 100,
			})
		end
	end,
})
