awesome.connect_signal("idle::start", function()
    awesome.spawn("loginctl lock_session")
end)

awesome.connect_signal("idle::stop", function()
    awesome.dpms_on()
    awesome.spawn("brightnessctl -r")
end)

awesome.set_idle_timeout("dim brightness", 150, function()
    awful.spawn("brightnessctl -s set 10")
end)

awesome.set_idle_timeout("lock session", 300, function()
    awesome.lock()
end)

awesome.set_idle_timeout("dpms off", 330, function()
    awesome.dpms_off()
end)

awesome.set_idle_timeout("suspend", 1800, function()
    awesome.spawn("systemctl suspend")
end)
