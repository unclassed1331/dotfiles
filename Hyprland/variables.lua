-- Shared variables and state used across other config files

mainMod = "ALT"

terminal    = "kitty"
fileManager = "dolphin"
menu        = "hyprlauncher"

-- Tracks the last normal (non-special) workspace you were on,
-- used by the scratchpad promote/recall system
lastNormalWorkspace = 1

-- Apps that are allowed to open directly into a special workspace
specialWorkspaceApps = {
    ["kitty-scratch"]   = true,
    ["org.gnome.Gnote"] = true,
    ["org.kde.dolphin"] = true,
}
