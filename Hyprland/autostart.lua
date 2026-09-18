-- Everything that runs automatically when Hyprland starts

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("ags run " .. os.getenv("HOME") .. "/.config/ags")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd(os.getenv("HOME") .. "/.local/bin/hypr-random-wallpaper")
end)

-- Workspace overview (quickshell)
hl.on("hyprland.start", function()
    hl.exec_cmd("qs -c overview")
end)

-- Fix systemd graphical-session target (needed for xdg-desktop-portal,
-- dark-mode detection in GTK apps like Gnote, etc.)
hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)
hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop graphical-session.target")
end)
