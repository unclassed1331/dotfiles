-- Background logic for the scratchpad apps, transparency toggle, window
-- shrink/restore, and cursor zoom

hl.on("workspace.active", function(ws)
    if ws.id > 0 then
        lastNormalWorkspace = ws.id
    end
end)

hl.on("window.open", function(win)
    if win.workspace and win.workspace.id < 0 and not specialWorkspaceApps[win.class] then
        hl.dispatch(hl.dsp.window.move({ workspace = tostring(lastNormalWorkspace) }))
    end
end)

-- Transparency toggle (Alt+T)
local transparencyOn = true
function toggleTransparency()
    return function()
        transparencyOn = not transparencyOn
        local opacity = transparencyOn and 0.6 or 1
        hl.config({ decoration = { inactive_opacity = opacity } })
    end
end

-- Shrink/restore active window (Alt+Shift+- / Alt+Shift+=)
local originalGeometry = {}

function halfSize()
    return function()
        local win = hl.get_active_window()
        if win == nil then return end
        local addr = win.address

        if originalGeometry[addr] == nil then
            originalGeometry[addr] = {
                x = win.at.x, y = win.at.y,
                w = win.size.x, h = win.size.y,
                floating = win.floating,
            }
        end

        local x, y = win.at.x, win.at.y
        local w = math.floor(win.size.x / 2)
        local h = math.floor(win.size.y / 2)

        if not win.floating then
            hl.dispatch(hl.dsp.window.float({ action = "set" }))
        end
        hl.dispatch(hl.dsp.window.resize({ x = w, y = h, relative = false }))
        hl.dispatch(hl.dsp.window.move({ x = x, y = y, relative = false }))
    end
end

function restoreSize()
    return function()
        local win = hl.get_active_window()
        if win == nil then return end
        local orig = originalGeometry[win.address]
        if orig == nil then return end

        hl.dispatch(hl.dsp.window.resize({ x = orig.w, y = orig.h, relative = false }))
        hl.dispatch(hl.dsp.window.move({ x = orig.x, y = orig.y, relative = false }))
        if not orig.floating then
            hl.dispatch(hl.dsp.window.float({ action = "unset" }))
        end
        originalGeometry[win.address] = nil
    end
end

-- Cursor zoom (Alt+R toggle, Alt+= / Alt+- step)
local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end
