#!/usr/bin/env bash

THEME="$1"
THEME_DIR="$HOME/themes/$THEME"
echo "$THEME" > ~/.cache/current_theme
# check if $THEME is empty, and if $THEME_DIR exists, if not, exits script
[ -z "$THEME" ] && exit 1
[ ! -d "$THEME_DIR" ] && exit 1
# set gtk theme, will also have to symlink the settings.ini files, also if blank, default to adwaita
case "$THEME" in
    "tokyo_night")      GTK_THEME="Colloid-Dark-Tokyo_night" ;;
    "catppuccin_mocha") GTK_THEME="Colloid-Dark-Catppuccin_mocha" ;;
    "muichiro")         GTK_THEME="Colloid-Dark-Muichiro";;
    "kanagawa_wave")    GTK_THEME="Colloid-Dark-Kanagawa_wave";;
    *)                  GTK_THEME="Adwaita-dark" ;;
esac

# gtk 4, if gsettings does not work, also $GTK_THEME was exported in ~/.config/zsh/.zshrc
ln -sf "$HOME/.themes/$GTK_THEME/gtk-4.0/gtk.css" "$HOME/.config/gtk-4.0/gtk.css"
ln -sf "$HOME/.themes/$GTK_THEME/gtk-4.0/gtk-dark.css" "$HOME/.config/gtk-4.0/gtk-dark.css"
ln -sf "$HOME/.themes/$GTK_THEME/gtk-4.0/assets" "$HOME/.config/gtk-4.0/assets"
ln -sf "$THEME_DIR/gtk4/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"
# gsettings for gtk3
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"

# symlinks to change theme

# hyprland colours (need to reload as it is not a direct change to the file itself):
ln -sf "$THEME_DIR/hypr/theme.lua" "$HOME/.config/hypr/look-and-feel.lua"
ln -sfn "$THEME_DIR/hypr/modules" "$HOME/.config/hypr/modules"
hyprctl reload

# hyprlock:
ln -sf "$THEME_DIR/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"

# waybar colours:
ln -sf "$THEME_DIR/waybar/theme.css" "$HOME/.config/waybar/theme.css" && waybar_reload.sh

# rofi colours, maybe style in the future?
ln -sf "$THEME_DIR/rofi/theme.rasi" "$HOME/.config/rofi/theme.rasi"

# kitty term colours:
ln -sf "$THEME_DIR/kitty/theme.conf" "$HOME/.config/kitty/theme.conf" && killall -SIGUSR1 kitty

# swaync notification centre + notifications
ln -sf "$THEME_DIR/swaync/style.css" "$HOME/.config/swaync/style.css" && swaync-client -rs -R

# restart swayosd to update theme
pkill swayosd-server
swayosd-server &

#link waybar colours to ags
ln -sf "$THEME_DIR/ags/theme.css" "$HOME/.config/ags/barColours.scss"
sleep 0.2
#reload ags
pkill gjs
ags run ~/.config/ags/Bar.tsx --gtk 4 &
# send notification of success
notify-send -i "preferences-desktop-theme" "Theme Applied" "Switched to $THEME"
