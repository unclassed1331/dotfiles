#!/bin/bash
if hyprctl clients | grep -q "class: org.kde.dolphin"; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("dolphin")'
else
    dolphin &
fi
