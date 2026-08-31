#!/bin/bash
cd ~/dotfiles || exit 1

# Hyprland
cp ~/.config/hypr/hyprland.lua .
cp ~/.config/hypr/hyprpaper.conf .
mkdir -p scripts
cp ~/.config/hypr/scripts/*.sh scripts/ 2>/dev/null

# AGS bar
cp ~/.config/ags/widget/Bar.tsx .
cp ~/.config/ags/style.scss .

# SwayOSD
mkdir -p swayosd
cp ~/.config/swayosd/style.css swayosd/ 2>/dev/null
cp ~/.config/swayosd/config.toml swayosd/ 2>/dev/null

git add .

if git diff --cached --quiet; then
    echo "No changes to commit."
    exit 0
fi

read -p "Commit message: " msg
git commit -m "$msg"
git push
