local awful = require("awful")

awful.spawn.once("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
awful.spawn.once("wl-paste --watch cliphist store")

awful.spawn.once("volnoti")
awful.spawn.once("mpd ~/.config/mpd/mpdconf.example")
