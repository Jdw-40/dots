#!/usr/bin/env bash

THEMES_DIR="$HOME/themes"

THEME=$(ls "$THEMES_DIR" | rofi -dmenu -theme ~/.config/rofi/clipboard.rasi -p "Select theme")

# if user preses esc, close and don't take a variable
[ -z "$THEME" ] && exit 0

# pass variable to application script as a parameter
bash ~/scripts/switch-theme.sh "$THEME"
