#!/bin/bash
addr=$(hyprctl clients -j | jq -r '.[] | select(.class=="signal") | .address')

if [ -z "$addr" ]; then
    ~/Applications/signal-desktop.AppImage &
    sleep 2
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("signal")'
else
    workspace=$(hyprctl clients -j | jq -r '.[] | select(.class=="signal") | .workspace.name')
    if [ "$workspace" = "special:signal" ]; then
        hyprctl dispatch 'hl.dsp.workspace.toggle_special("signal")'
    else
        hyprctl dispatch "hl.dsp.window.float({ action = 'set', window = 'address:$addr' })"
        sleep 0.15
        hyprctl dispatch "hl.dsp.window.move({ workspace = 'special:signal', window = 'address:$addr' })"
        sleep 0.15
        hyprctl dispatch "hl.dsp.window.resize({ x = 625, y = 862, relative = false, window = 'address:$addr' })"
        sleep 0.1
        hyprctl dispatch "hl.dsp.window.move({ x = 813, y = 34, relative = false, window = 'address:$addr' })"
    fi
fi
