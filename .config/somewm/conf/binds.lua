local awful = require("awful")

local function spawn(cmd)
    return function()
        awful.spawn(cmd)
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
awful.keyboard.append_global_keybindings({
    awful.key({ super }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, { description = "go back", group = "client" }),
    awful.key(
        { super, ctrl },
        "j",
        exec(awful.screen.focus_relative(1)),
        { description = "focus the next screen", group = "screen" }
    ),
    awful.key(
        { super, ctrl },
        "k",
        exec(awful.screen.focus_relative(-1)),
        { description = "focus the previous screen", group = "screen" }
    ),
    awful.key({ super, ctrl }, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:activate({ raise = true, context = "key.unminimize" })
        end
    end, { description = "restore minimized", group = "client" }),

    -- Focus client hjkl
    awful.key({ alt }, "h", exec(awful.client.focus.bydirection, "left"), { desc = "Focus up", group = "client" }),
    awful.key({ alt }, "j", exec(awful.client.focus.bydirection, "down"), { desc = "Focus down", group = "client" }),
    awful.key({ alt }, "k", exec(awful.client.focus.bydirection, "up"), { desc = "Focus up", group = "client" }),
    awful.key({ alt }, "l", exec(awful.client.focus.bydirection, "right"), { desc = "Focus right", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ super }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
    -- Swap client hjkl
    awful.key({ super }, "h", exec(awful.client.swap.bydirection, "left"), { desc = "Swap up", group = "client" }),
    awful.key({ super }, "j", exec(awful.client.swap.bydirection, "down"), { desc = "Swap down", group = "client" }),
    awful.key({ super }, "k", exec(awful.client.swap.bydirection, "up"), { desc = "Swap up", group = "client" }),
    awful.key({ super }, "l", exec(awful.client.swap.bydirection, "right"), { desc = "Swap right", group = "client" }),
})

-- @DOC_NUMBER_KEYBINDINGS@

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

-- @DOC_CLIENT_BUTTONS@
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

-- @DOC_CLIENT_KEYBINDINGS@
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ alt }, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "toggle fullscreen", group = "client" }),
        awful.key({ alt }, "q", function(c)
            c:kill()
        end, { description = "close", group = "client" }),
        awful.key({ alt }, "s", awful.client.floating.toggle, { description = "toggle floating", group = "client" }),
        awful.key({ super, "Control" }, "Return", function(c)
            c:swap(awful.client.getmaster())
        end, { description = "move to master", group = "client" }),
        awful.key({ super }, "o", function(c)
            c:move_to_screen()
        end, { description = "move to screen", group = "client" }),
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
    awful.key({ super }, "v", spawn("cliphist list | rofi -dmenu -display-columns 2 | cliphist decode | wl-copy")),
    awful.key(
        { super },
        "p",
        spawn(
            "rofi -theme-str 'element-icon { size: 3ch;}' -combi-modi 'snippets:snippy-snippet rofi' -show combi -modi combi"
        )
    ),
    awful.key({ super }, "o", spawn("rofi-kpxc")),
})
