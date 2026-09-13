#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class=="kitty-scratch" and (.workspace.name=="special:magic"))' > /dev/null; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("magic")'
else
    kitty --class kitty-scratch &
fi
