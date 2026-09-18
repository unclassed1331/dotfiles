-- Environment variables and platform/compat tweaks

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Fix Steam window scaling
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
