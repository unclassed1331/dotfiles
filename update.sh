#!/bin/bash
cd ~/dotfiles || exit 1

command -v rsync >/dev/null || { echo "Install rsync first: sudo dnf install rsync"; exit 1; }

# Mirror a config folder into the repo (skips backups and generated files)
sync_dir() {
    [ -d "$1" ] || return 0
    mkdir -p "$2"
    rsync -a --delete --exclude='*.bak' --exclude='node_modules' --exclude='@girs' "$1/" "$2/"
}

# Hyprland
mkdir -p Hyprland scripts bin
cp ~/.config/hypr/*.lua Hyprland/
cp ~/.config/hypr/scripts/*.sh scripts/ 2>/dev/null
cp ~/.local/bin/hypr-random-wallpaper bin/

# App configs
sync_dir ~/.config/ags      AGS
sync_dir ~/.config/kitty    kitty
sync_dir ~/.config/swayosd  swayosd
sync_dir ~/.config/qt6ct    qt6ct
sync_dir ~/.config/rofi     rofi

# GTK theme settings
mkdir -p gtk/gtk-3.0 gtk/gtk-4.0
cp ~/.config/gtk-3.0/settings.ini gtk/gtk-3.0/ 2>/dev/null
cp ~/.config/gtk-4.0/settings.ini gtk/gtk-4.0/ 2>/dev/null

# Quickshell overview (only the files you edited, the rest is upstream)
mkdir -p quickshell/common
cp ~/.config/quickshell/overview/config.json quickshell/ 2>/dev/null
cp ~/.config/quickshell/overview/common/Appearance.qml quickshell/common/ 2>/dev/null
git -C ~/.config/quickshell/overview remote get-url origin > quickshell/UPSTREAM.txt 2>/dev/null

# Shell
mkdir -p shell
cp ~/.bashrc shell/bashrc

# System lists, for rebuilding on a new drive
mkdir -p system
dnf repoquery --userinstalled --qf '%{name}\n' 2>/dev/null | sort -u > system/packages.txt
dnf copr list > system/copr-repos.txt 2>/dev/null

git add .

if git diff --cached --quiet; then
    echo "No changes to commit."
    exit 0
fi

read -p "Commit message: " msg
git commit -m "$msg"
git push
