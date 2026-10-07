output.connect_signal("added", function(o)
    if o.name:match("^eDP") then
        o.scale = 2
    end
end)
