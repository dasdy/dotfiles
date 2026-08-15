-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Window switcher (was: focus next window / reveal active window on top).
hl.unbind("ALT + TAB")
o.bind("ALT + TAB", "Switch window", "walker-window-switcher")

-- Passwords with KeePassXC (was: 1Password).
hl.unbind("SUPER + SHIFT + SLASH")
o.bind("SUPER + SHIFT + SLASH", "Passwords", { launch = "keepassxc" })

-- Activity monitor on the key it used to live on.
o.bind("SUPER + SHIFT + T", "Activity", { tui = "btop" })

-- Readwise Reader.
o.bind("SUPER + SHIFT + R", "Readwise Reader", { webapp = "https://read.readwise.io/feed/unseen" })

-- Web apps kept off deliberately.
hl.unbind("SUPER + SHIFT + C") -- was: Calendar
hl.unbind("SUPER + SHIFT + E") -- was: Email
hl.unbind("SUPER + SHIFT + ALT + E") -- was: New email
hl.unbind("SUPER + SHIFT + X") -- was: X
hl.unbind("SUPER + SHIFT + ALT + X") -- was: X Post
