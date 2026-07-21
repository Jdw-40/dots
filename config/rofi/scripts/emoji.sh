#!/usr/bin/env bash

# Path to your emoji database
emoji_file="$HOME/.config/rofi/db/emoji.db"

# Show Rofi menu with your theme
selected=$(cat "$emoji_file" | rofi -dmenu -i -l 14 -theme ~/.config/rofi/clipboard.rasi -p "Emoji: ")

# Exit if nothing selected
[ -z "$selected" ] && exit 0

# Get the emoji character (first field)
emoji_char=$(echo "$selected" | awk '{print $1}')

# Copy to Wayland clipboard only
printf "%s" "$emoji_char" | wl-copy

# Notify
notify-send "Emoji" "'$emoji_char' copied to clipboard."
