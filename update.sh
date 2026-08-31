#!/bin/bash
cd ~/dotfiles || exit 1

# Hyprland
mkdir -p Hyprland scripts
cp ~/.config/hypr/hyprland.lua Hyprland/
cp ~/.config/hypr/scripts/*.sh scripts/ 2>/dev/null

# AGS bar
mkdir -p AGS
cp ~/.config/ags/widget/Bar.tsx AGS/
cp ~/.config/ags/style.scss AGS/

# SwayOSD
mkdir -p swayosd
cp ~/.config/swayosd/style.css swayosd/ 2>/dev/null
cp ~/.config/swayosd/config.toml swayosd/ 2>/dev/null

# Kitty
mkdir -p kitty
cp ~/.config/kitty/kitty.conf kitty/
cp ~/.config/kitty/current-theme.conf kitty/

git add .

if git diff --cached --quiet; then
    echo "No changes to commit."
    exit 0
fi

read -p "Commit message: " msg
git commit -m "$msg"
git push
