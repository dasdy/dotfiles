-- Auto-assign apps to workspaces.
-- Class names verified from running clients / .desktop StartupWMClass.
-- Workspace 3 is intentionally left unassigned (work-themed).

-- WS1 - Browser
o.window("^zen$", { workspace = "1" })

-- WS2 - Messengers
o.window("^org\\.telegram\\.desktop$", { workspace = "2" })
o.window("^signal$", { workspace = "2" })
o.window("^discord$", { workspace = "2" })

-- WS4 - Music
o.window("^spotify$", { workspace = "4" })
o.window("^org\\.qbittorrent\\.qBittorrent$", { workspace = "4" })

-- WS5 - Gaming
o.window("^steam$", { workspace = "5" })
o.window("^net\\.lutris\\.Lutris$", { workspace = "5" })
o.window("^Heroic$", { workspace = "5" })

-- WS6 - AI
o.window("^LM Studio$", { workspace = "6" })

-- WS7 - Utilities
o.window("^keepassxc$", { workspace = "7" })
