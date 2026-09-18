-- Window rules

hl.window_rule({ name = "suppress-maximize-events", match = { class = ".*" }, suppress_event = "maximize" })

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

hl.window_rule({
    name = "scratch-terminal", match = { class = "kitty-scratch" },
    workspace = "special:magic", float = true, size = "800 500", center = true,
})

hl.window_rule({
    name = "signal-float", match = { class = "signal" },
    workspace = "special:signal silent", float = true, size = "625 862", move = "813 34",
})

hl.window_rule({
    name = "gnote-float", match = { class = "org.gnome.Gnote" },
    workspace = "special:gnote", float = true, size = "900 500", center = true,
})

hl.window_rule({
    name = "dolphin-float", match = { class = "org.kde.dolphin" },
    workspace = "special:dolphin", float = true, size = "900 500", center = true,
})

hl.window_rule({
    name = "move-hyprland-run", match = { class = "hyprland-run" },
    move = "20 monitor_h-120", float = true,
})

hl.window_rule({ name = "floating-border", match = { float = true },  border_color = "rgba(3da693aa) rgba(1a88a3aa)" })
hl.window_rule({ name = "tiled-border",    match = { float = false }, border_color = "rgba(9d4eddaa) rgba(008080aa)" })
