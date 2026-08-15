-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    -- Use multiple keyboard layouts and switch between them with Alt + Shift.
    kb_layout = "us,ua,ru",
    kb_options = "grp:alt_shift_toggle",

    -- Change speed of keyboard repeat.
    repeat_rate = 40,
    repeat_delay = 600,

    -- Lower sensitivity for mouse/trackpad (default: 0).
    sensitivity = -0.5,

    touchpad = {
      -- Use natural (inverse) scrolling.
      natural_scroll = true,
    },
  },
})

-- App-specific touchpad scroll speeds.
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })
