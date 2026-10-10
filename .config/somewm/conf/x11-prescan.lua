local gears = require("gears")
local naughty = require("naughty")

-- Show notification if the config pre-scan found X11-specific patterns
if awesome.x11_fallback_info then
    -- Defer notification until after startup (naughty needs event loop running)
    gears.timer.delayed_call(function()
        local info = awesome.x11_fallback_info
        local msg = string.format(
            "Your config contains X11-specific code that won't work on Wayland. "
                .. "It was loaded anyway; the code below will not do anything.\n\n"
                .. "File: %s:%d\n"
                .. "Pattern: %s\n"
                .. "Code: %s\n\n"
                .. "Suggestion: %s\n\n"
                .. "Run `somewm --check` on your config for the full list.",
            info.config_path or "unknown",
            info.line_number or 0,
            info.pattern or "unknown",
            info.line_content or "",
            info.suggestion or "See somewm migration guide"
        )
        naughty.notification({
            urgency = "critical",
            title = "Config contains X11 patterns",
            message = msg,
            timeout = 0, -- Don't auto-dismiss
        })
    end)
end
-- }}}
