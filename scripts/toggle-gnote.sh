#!/bin/bash
if hyprctl clients | grep -q "class: org.gnome.Gnote"; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("gnote")'
else
    gsettings set org.gnome.gnote search-window-splitter-pos 90
    gnote &
fi
