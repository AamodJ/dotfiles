-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- @DOC_REQUIRE_SECTION@
require("awful.autofocus")
local naughty = require("naughty")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
-- @DOC_ERROR_HANDLING@
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message,
    })
end)

-- Make these global
_G.super = "Mod4"
_G.alt = "Mod1"
_G.ctrl = "Control"
_G.shift = "Shift"
_G.terminal = "kitty"

require("conf.theme")

require("conf.monitor")

-- Initialize lockscreen (must be after beautiful.init)
require("lockscreen").init()

-- {{{ Tag persistence across monitor hotplug
-- The save handler lives in awful.permissions.tag_screen and stores tag
-- metadata into awful.permissions.saved_tags keyed by connector name.
-- To disable or replace it:
--   tag.disconnect_signal("request::screen", awful.permissions.tag_screen)
-- }}}

require("conf.rules")
require("conf.binds")
require("conf.input")
require("conf.tags")
require("conf.notifications")
require("conf.status-bar")
