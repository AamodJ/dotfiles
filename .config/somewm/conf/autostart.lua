local awful = require("awful")

awful.spawn.once("wl-paste --watch cliphist store")
awful.spawn.once("volnoti")
awful.spawn.with_shell("mpd ~/.config/mpd/mpdconf.example")
