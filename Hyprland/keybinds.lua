-- All keybindings except media keys (see media-keys.lua)

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-dolphin.sh"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(menu)) -- hyprlauncher; not used day-to-day, rofi (Alt+D) is the real launcher
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + W", hl.dsp.layout("togglesplit")) -- moved off L to fix conflict with vim-nav
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("kill -USR1 $(cat ~/.cache/hypr-random-wallpaper.pid)"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("~/.config/hypr/scripts/reload-overview.sh"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-signal.sh"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-gnote.sh"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("hyprpicker -a"))

-- Vim-style focus movement
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/scratch-terminal.sh"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("ALT + SHIFT + A", hl.dsp.window.move({ workspace = "special:scratch" }))
hl.bind("ALT + A",         hl.dsp.workspace.toggle_special("scratch"))

hl.bind(mainMod .. " + T", toggleTransparency())

hl.bind("PRINT", hl.dsp.exec_cmd(
    "grim - | wl-copy && grim ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd(
    "bash -c 'g=$(slurp); grim -g \"$g\" - | wl-copy; grim -g \"$g\" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png'"
))

hl.bind(mainMod .. " + SHIFT + minus", halfSize())
hl.bind(mainMod .. " + SHIFT + equal", restoreSize())

hl.bind(mainMod .. " + Q", function()
    hl.dispatch(hl.dsp.window.move({ workspace = tostring(lastNormalWorkspace) }))
    hl.dispatch(hl.dsp.window.float({ action = "unset" }))
end)

hl.bind(mainMod .. " + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

hl.bind(mainMod .. " + R", zoom)
hl.bind(mainMod .. " + equal", function() zoom(0.5) end)
hl.bind(mainMod .. " + minus", function() zoom(-0.5) end)

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
