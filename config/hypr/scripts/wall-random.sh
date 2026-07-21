#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpaper/hyprland-walls/pngs/"
CACHE_WALL="$HOME/.cache/hyprland/walls/current-wallpaper.png"

# Ensure cache directory exists
mkdir -p "$(dirname "$CACHE_WALL")"

# Get a random wallpaper that is not the current one
CURRENT_WALL=$(cat "$CACHE_WALL" 2>/dev/null || echo "")
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Copy the selected wallpaper to the cache file
cp "$WALLPAPER" "$CACHE_WALL"

# Apply the cached wallpaper
hyprctl hyprpaper reload ,"$CACHE_WALL"
