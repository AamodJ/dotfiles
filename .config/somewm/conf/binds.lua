local awful = require("awful")

-- Helper functions
local function spawn(cmd)
    return function()
        awful.spawn(cmd)
    end
end
local function spawn_with_shell(cmd)
    return function()
        awful.spawn.with_shell(cmd)
    end
end

local function exec(cmd, arguments)
    local args = arguments or {}
    return function()
        cmd(args)
    end
end

-- {{{ Mouse bindings
-- @DOC_ROOT_BUTTONS@
awful.mouse.append_global_mousebindings({
    awful.button({}, 3, function()
        mymainmenu:toggle()
    end),
    awful.button({}, 4, awful.tag.viewprev),
    awful.button({}, 5, awful.tag.viewnext),
})

-- }}}
-- {{{ Key bindings
-- @DOC_GLOBAL_KEYBINDINGS@

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ super, shift }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ super, shift }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
    awful.key({ super }, "Backspace", exec(awesome.lock), { description = "lock screen", group = "awesome" }),
    awful.key({ super }, "Return", spawn(terminal), { description = "open a terminal", group = "launcher" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ super }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
    awful.key({ super }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
    awful.key({ ctrl }, "Space", awful.tag.history.restore, { description = "go back", group = "tag" }),
})

-- Focus related keybindings

-- Helper function to center the mouse when changing focus / swapping windows
local function focus_or_swap(cmd, dir)
    return function()
        if cmd == "focus" then
            awful.client.focus.bydirection(dir)
        elseif cmd == "swap" then
            awful.client.swap.bydirection(dir)
        else
            error('Unknown command. You tried to focus or swap but got "' .. cmd .. '" instead')
        end

        -- Warp cursor to center of the client when switching focus
        local g = client.focus:geometry()
        mouse.coords({ x = g.x + g.width / 2, y = g.y + g.height / 2 })
    end
end

awful.keyboard.append_global_keybindings({
    awful.key({ super }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, { description = "go back", group = "client" }),
    awful.key(
        { alt, shift },
        "h",
        exec(awful.screen.focus_bydirection, "left"),
        { description = "focus left screen", group = "screen" }
    ),
    awful.key(
        { alt, shift },
        "l",
        exec(awful.screen.focus_bydirection, "right"),
        { description = "focus right screen", group = "screen" }
    ),
    awful.key({ super, ctrl }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:activate({ raise = true, context = "key.unminimize" })
        end
    end, { description = "restore minimized", group = "client" }),

    -- Focus client hjkl
    awful.key({ alt }, "h", focus_or_swap("focus", "left"), { desc = "Focus up", group = "client" }),
    awful.key({ alt }, "j", focus_or_swap("focus", "down"), { desc = "Focus down", group = "client" }),
    awful.key({ alt }, "k", focus_or_swap("focus", "up"), { desc = "Focus up", group = "client" }),
    awful.key({ alt }, "l", focus_or_swap("focus", "right"), { desc = "Focus right", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ super }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
    -- Swap client hjkl
    awful.key({ super }, "h", focus_or_swap("swap", "left"), { desc = "Swap up", group = "client" }),
    awful.key({ super }, "j", focus_or_swap("swap", "down"), { desc = "Swap down", group = "client" }),
    awful.key({ super }, "k", focus_or_swap("swap", "up"), { desc = "Swap up", group = "client" }),
    awful.key({ super }, "l", focus_or_swap("swap", "right"), { desc = "Swap right", group = "client" }),

    -- Swap client across monitors
    awful.key({ super, alt }, "l", function()
        local c = client.focus
        c:move_to_screen(c.screen:get_next_in_direction("right"))
    end, { desc = "Swap to right screen", group = "client" }),
    awful.key({ super, alt }, "h", function()
        local c = client.focus
        c:move_to_screen(c.screen:get_next_in_direction("left"))
    end, { desc = "Swap to left screen", group = "client" }),
})

awful.keyboard.append_global_keybindings({
    awful.key({
        modifiers = { ctrl },
        keygroup = "numrow",
        description = "only view tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    }),
    awful.key({
        modifiers = { ctrl, shift },
        keygroup = "numrow",
        description = "move focused client to tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end,
    }),
    awful.key({
        modifiers = { super },
        keygroup = "numpad",
        description = "select layout directly",
        group = "layout",
        on_press = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }),
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c)
            c:activate({ context = "mouse_click" })
        end),
        awful.button({ super }, 1, function(c)
            c:activate({ context = "mouse_click", action = "mouse_move" })
        end),
        awful.button({ super }, 3, function(c)
            c:activate({ context = "mouse_click", action = "mouse_resize" })
        end),
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ alt }, "q", function(c)
            c:kill()
        end, { description = "close", group = "client" }),
        awful.key({ alt }, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "toggle fullscreen", group = "client" }),
        -- awful.key({ alt }, "m", function(c)
        --     c.sticky = not c.sticky
        --     c.floating = not c.floating
        -- end, { description = "toggle sticky", group = "client" }),
        awful.key({ alt }, "s", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
        awful.key({ super, "Control" }, "Return", function(c)
            c:swap(awful.client.getmaster())
        end, { description = "move to master", group = "client" }),
        awful.key({ super }, "t", function(c)
            c.ontop = not c.ontop
        end, { description = "toggle keep on top", group = "client" }),
        awful.key({ super }, "n", function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, { description = "minimize", group = "client" }),
        awful.key({ super }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "client" }),
        awful.key({ super, "Control" }, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, { description = "(un)maximize vertically", group = "client" }),
        awful.key({ super, "Shift" }, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, { description = "(un)maximize horizontally", group = "client" }),
    })
end)

-- Apps
awful.keyboard.append_global_keybindings({
    awful.key({ super }, "s", spawn("slack")),
    awful.key({ super }, "c", spawn("librewolf")),
    awful.key({ super }, "e", spawn("nautilus")),
})

-- menu
awful.keyboard.append_global_keybindings({
    awful.key({ alt }, "Space", spawn("rofi -terminal kitty -show drun")),
    awful.key({ super, alt }, "m", spawn("rofi -show run")),
    awful.key({ super }, "Space", spawn("rofi -show calc -no-show-match -no-sort")),
    awful.key({ super }, "r", spawn("rofi -show emoji")),
    awful.key({ super }, "y", spawn("rofi -show ssh")),
    awful.key(
        { super },
        "v",
        spawn_with_shell("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy")
    ),
    awful.key(
        { super },
        "p",
        spawn(
            "rofi -theme-str 'element-icon { size: 3ch;}' -combi-modi 'snippets:snippy-snippet rofi' -show combi -modi combi"
        )
    ),
    awful.key({ super }, "o", spawn("rofi-kpxc")),
})

-- XF86 keybinds
awful.keyboard.append_global_keybindings({
    -- Audio
    awful.key({}, "XF86AudioRaiseVolume", spawn("sink up")),
    awful.key({}, "XF86AudioLowerVolume", spawn("sink down")),
    awful.key({}, "XF86AudioMute", spawn("sink togglemute")),
    awful.key({}, "XF86AudioMicMute", spawn("sink mic-mute")),
    awful.key({ super }, "q", spawn("sink set")),

    awful.key({}, "XF86AudioPlay", spawn("playerctl play-pause")),
    awful.key({}, "XF86AudioNext", spawn("playerctl next")),
    awful.key({}, "XF86AudioPrev", spawn("playerctl previous")),

    -- Display
    awful.key({}, "XF86MonBrightnessUp", spawn("backlight monup")),
    awful.key({}, "XF86MonBrightnessDown", spawn("backlight mondown")),
    awful.key({ super }, "w", spawn("backlight setmon")),
    awful.key({}, "XF86KbdBrightnessUp", spawn("backlight kbdup")),
    awful.key({}, "XF86KbdBrightnessDown", spawn("backlight kbddown")),
})

-- macOS like screenshots
awful.keyboard.append_global_keybindings({
    -- Audio
    awful.key({ super, shift }, "3", spawn("screenshot")),
    awful.key({ super, shift }, "4", spawn("screenshot region")),
    awful.key({ super, shift }, "5", spawn("zoom")),
})
