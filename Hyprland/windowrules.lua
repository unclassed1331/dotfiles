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
    workspace = "special:signal silent", float = true, suppress_event = "maximize fullscreen", size = "625 862", move = "813 34",
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

hl.window_rule({
    name = "love2d-float", match = { class = "love" },
    float = true, center = true,
})

-- for brave pip
hl.window_rule({
    name = "brave-pip-float",
    match = { 
        class = "brave-browser",
        title = ".*Picture in picture.*"
    },
    float = true,
   -- pin = true,
    size = "800 440",
    move = "72% 65%"
})


-- Float standard modal dialogs and file pickers
hl.window_rule({
    name = "float-dialogs",
    match = { title = ".*(Properties|Preferences|Settings|Open File|Select a File|Save As).*" },
    float = true
})

-- Float system utility windows
hl.window_rule({
    name = "float-pavucontrol",
    match = { class = "pavucontrol" },
    float = true
})

hl.window_rule({
    name = "float-nm-editor",
    match = { class = "nm-connection-editor" },
    float = true
})

-- Float all Steam windows (properties dialogs, popups, etc.)
hl.window_rule({
    name = "float-steam-windows",
    match = { class = "^steam$" },
    float = true
})

-- ...but keep the main Steam window tiled
hl.window_rule({
    name = "tile-steam-main",
    match = { class = "^steam$", title = "^Steam$" },
    float = false
})


-- Float all Blueman Bluetooth windows
hl.window_rule({
    name = "float-bluetooth-manager",
    match = { class = ".*[bB]lueman.*" },
    float = true
})

-- Float cpu system
hl.window_rule({
	name = "float-cpu-monitor",
	match = { class = "org.gnome.SystemMonitor" },
	float = true
})

-- Audio Manager
hl.window_rule({
	name = "float-audio",
	match = { class = "org.pulseaudio.pavucontrol" },
	float = true
})


hl.window_rule({ name = "floating-border", match = { float = true },  border_color = "rgba(3da693aa) rgba(1a88a3aa)" })
hl.window_rule({ name = "tiled-border",    match = { float = false }, border_color = "rgba(9d4eddaa) rgba(008080aa)" })
