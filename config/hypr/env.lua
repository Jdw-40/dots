--env variables

--qt stuff:
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1") --automatic scaling
hl.env("QT_QPA_PLATFORM", "wayland;xcb") --use wayland, fall back to X11 if unavailiable
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1") --disable window decorations
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") --get theme data from QT6ct

--xcursor stuff:
hl.env("XCURSOR_THEME", "Capitaine-Cursors-Toykonight")
hl.env("XCURSOR_SIZE", "24")