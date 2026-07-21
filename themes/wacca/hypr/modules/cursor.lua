--contains variables for cursors, and some startup settings to make them apply
--sets xcursor to be the same as gsettings
hl.config({
    cursor={
        sync_gsettings_theme = true
    }
})

--set cursor size
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

--set cursor theme
hl.env("XCURSOR_THEME", "Capitaine-​Cursors-​Tokyonight")
hl.env("HYPRCURSOR_THEME", "Capitaine-​Cursors-​Tokyonight")

--manualy set cursor theme and size for both XCURSOR and hyprcursor
hl.exec_cmd("hyprctl setcursor Capitaine-​Cursors-​Tokyonight 24")
hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Capitaine-​Cursors-​Tokyonight'")
