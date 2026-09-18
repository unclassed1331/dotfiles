-- Keyboard, touchpad, mouse, and gesture settings

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0.5,

        touchpad = {
            natural_scroll          = false,
            middle_button_emulation = true,
            clickfinger_behavior    = true,
            tap_button_map          = "lmr",
        },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.device({ name = "razer-razer-deathadder", sensitivity = 0.1, accel_profile = "flat" })
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })
