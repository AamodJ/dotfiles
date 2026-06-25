-- Window navigation binds
hl.bind("ALT + h", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + j", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + k", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + ALT + S", hl.dsp.layout("togglesplit"))

hl.bind("SUPER + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + j", hl.dsp.window.swap({ direction = "down" }))
hl.bind("SUPER + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + l", hl.dsp.window.swap({ direction = "right" }))

-- Workspace binds
for i = 1, 10 do
	local key = i % 10
	hl.bind("CTRL + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind("CTRL + Space", hl.dsp.focus({ workspace = "previous" }))
hl.bind("ALT + Return", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SHIFT + ALT + Return", hl.dsp.window.move({ workspace = "special:magic" }))

-- XF86 binds
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("sink up"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("sink up"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("sink down"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("sink togglemute"), { locked = true })
hl.bind("SUPER + q", hl.dsp.exec_cmd("sink set"), { locked = true })

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("sink mic-mute"), { locked = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("backlight monup"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("backlight mondown"), { locked = true })
hl.bind("SUPER + w", hl.dsp.exec_cmd("backlight setmon"), { locked = true })

hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("backlight kbdup"), { locked = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("backlight kbddown"), { locked = true })

-- Make sure swaylock starts upon lid close
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("lockscreen"), { locked = true })

hl.bind("SUPER + u", hl.dsp.exec_cmd("handle_monitors normal"))
hl.bind("SUPER + i", hl.dsp.exec_cmd("handle_monitors mirror"))

-- TODO: Need to lua-fy
-- OBS hotkeys
-- hl.bind(SUPERSHIFT, r, pass, ^(com.obsproject.Studio)$
-- hl.bind(SUPERSHIFT, t, pass, ^(com.obsproject.Studio)$
