#!/bin/bash
addr=$(hyprctl clients -j | jq -r '.[] | select(.class=="kitty-scratch" and .workspace.name=="special:magic") | .address' | head -n1)

if [ -n "$addr" ]; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("magic")'
else
    kitty --class kitty-scratch -o background_opacity=0.10 &
fi
