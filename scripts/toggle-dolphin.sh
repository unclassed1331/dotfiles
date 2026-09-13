#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class=="org.kde.dolphin" and (.workspace.name=="special:dolphin"))' > /dev/null; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("dolphin")'
else
    dolphin &
fi
