local function redraw_screens()
    return function(_)
        -- print(screen.count())

        -- table.sort(output)
        -- for o in output do
        --     print("Output: " .. o.name)
        --     local m = o.current_mode
        --     print("x: " .. m.width .. " y: " .. m.height)
        -- end

        -- print(sorted_outputs)
        for o in output do
            local m = o.current_mode
            if o.name:match("^eDP") and m.width == 3840 then
                o.scale = 2
            elseif o.name:match("^DP-8|^DP-10") then
                o.scale = 1
                o.position = { x = 1920, y = 0 }
            elseif o.name:match("^DP-9|^DP-11") then
                o.scale = 1
                o.position = { x = 4480, y = 0 }
            end
        end
    end
end

output.connect_signal("added", redraw_screens())
output.connect_signal("removed", redraw_screens())
