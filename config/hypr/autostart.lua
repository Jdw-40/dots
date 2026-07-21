hl.on("hyprland.start", function () 
  --idle, notifications, plugins
  hl.exec_cmd("hypridle")
  hl.exec_cmd("qs -p ~/.config/quickshell/notifications")
  hl.exec_cmd("hyprpm reload -n")
  
  --bar, wallpaper, OSD, and dock
  hl.exec_cmd("ags run ~/.config/ags/Bar.tsx --gtk 4") --bar
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("swayosd-server")
  hl.exec_cmd("hypr-dock")

  -- tray stuff, bluetooth, wifi, updater, MPD
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("arch-update --tray")
  hl.exec_cmd("mpDris2")

  --clipboard manager
  hl.exec_cmd("wl-paste --watch cliphist store")
  hl.exec_cmd("ie-r") --colour picker
  --cursor stuff:
  hl.exec_cmd("hyprctl setcursor Capitaine-​Cursors-​Tokyonight 24")

  --hl.exec_cmd("waybar & hyprpaper & firefox")
end)
