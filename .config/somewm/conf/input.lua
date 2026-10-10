local awful = require("awful")

awful.input.xkb_options = "caps:escape,shift:both_capslock"
awful.input.keyboard_repeat_delay = 250
awful.input.keyboard_repeat_rate = 70

awful.input.natural_scrolling = 1

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate({ context = "mouse_enter", raise = false })
end)
