-- Hyprland config, split into modules for maintainability.
-- See ~/.config/hypr/*.lua for each piece.

require("variables")
require("environment")
require("autostart")
require("appearance")
require("input")
require("scratchpad-logic")
require("keybinds")
require("media-keys")
require("windowrules")

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1.33",
})
