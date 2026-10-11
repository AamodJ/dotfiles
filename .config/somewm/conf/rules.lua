-- {{{ Rules
-- Rules to apply to new clients.
-- @DOC_RULES@
local ruled = require("ruled")
local awful = require("awful")

ruled.client.connect_signal("request::rules", function()
    -- @DOC_GLOBAL_RULE@
    -- All clients will match this rule.
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    })

    -- @DOC_FLOATING_RULE@
    -- Floating clients.
    ruled.client.append_rule({
        id = "floating",
        rule_any = {
            instance = { "pinentry" },
            class = {
                "Arandr",
                "blueman-manager",
                "Gpick",
                "Kruler",
                "Nsxiv",
            },
            title = {
                "wayland-boomer",
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up",
            },
        },
        properties = {
            floating = true,
            placement = awful.placement.centered,
        },
    })

    ruled.client.append_rule({
        rule = { class = "firefox" },
        properties = { tag = "2" },
    })
end)
-- }}}
