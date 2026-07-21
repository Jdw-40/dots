#!/usr/bin/env bash

# Path to your glyph database
glyph_file="$HOME/.config/rofi/db/glyphs.db"

# Show Rofi menu with your clipboard theme
selected=$(cat "$glyph_file" | rofi -dmenu -i -l 14 -theme ~/.config/rofi/clipboard.rasi -p "Glyph: ")

# Exit if nothing selected
[ -z "$selected" ] && exit 0

# Get the glyph character (first field)
glyph_char=$(echo "$selected" | awk '{print $1}')

# Copy to Wayland clipboard only
printf "%s" "$glyph_char" | wl-copy

# Notify
notify-send "Glyph" "'$glyph_char' copied to clipboard."
