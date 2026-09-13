#!/bin/bash
if hyprctl clients -j | jq -e '.[] | select(.class=="org.gnome.Gnote" and (.workspace.name=="special:gnote"))' > /dev/null; then
    hyprctl dispatch 'hl.dsp.workspace.toggle_special("gnote")'
else
    gsettings set org.gnome.gnote search-window-splitter-pos 339
    gnote &
fi
