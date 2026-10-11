local awful = require("awful")

awful.input.xkb_options = "caps:escape,shift:both_capslock"
awful.input.keyboard_repeat_delay = 250
awful.input.keyboard_repeat_rate = 70
awesome._set_keyboard_setting("numlock", false)

awful.input.natural_scrolling = 1
awful.input.tap_to_click = 1
awful.input.accel_speed = 0.25
awful.input.disable_while_typing = 1
awful.input.dwtp = 1

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate({ context = "mouse_enter", raise = false })
end)

-- Warp cursor to center of the client when switching focus
client.connect_signal("focus", function(c)
    local g = c:geometry()
    mouse.coords({ x = g.x + g.width / 2, y = g.y + g.height / 2 })
end)
