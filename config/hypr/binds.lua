-- ###################
-- ### KEYBINDINGS ###
-- ###################

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod   = "SUPER"
local terminal   = "kitty"
local browser    = "zen-browser"
local fileManager = "thunar"
local menu       = "rofi -show drun"

-- -------------------------
-- | Applications / Launch |
-- -------------------------

hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd(terminal),      { description = "Open terminal" })
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(browser),       { description = "Open browser" })
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("firefox --private-window"), { description = "Firefox private window" })
hl.bind(mainMod .. " + A",         hl.dsp.exec_cmd(menu),          { description = "Open rofi launcher" })
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager),   { description = "Open file manager" })
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("rofi -show drun -theme ~/.config/rofi/fullscreenLauncher.rasi"), { description = "Fullscreen rofi launcher" })
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("~/scripts/theme-picker.sh"), { description = "Change theme" })
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("qs -p ~/.config/quickshell/notifications ipc call notifications toggle"), { description = "toggle quickshell notification centre" })
-- -----------------------
-- | Clipboard / Pickers |
-- -----------------------

hl.bind(mainMod .. " + V",      hl.dsp.exec_cmd("cliphist list | rofi -dmenu -theme ~/.config/rofi/clipboard.rasi | cliphist decode | wl-copy"), { description = "Open clipboard history" })
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("~/scripts/emoji.sh"),       { description = "Open emoji picker" })
hl.bind(mainMod .. " + comma",  hl.dsp.exec_cmd("~/scripts/glyph.sh"),       { description = "Open glyph picker" })
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("hyprpicker -an"), { description = "[Screen Capture] Color picker" })

-- ----------------------
-- | Screenshot / Screen |
-- ----------------------

hl.bind(mainMod .. " + SHIFT + P",
    hl.dsp.exec_cmd("hyprshot -m region -D 0.5 -z --clipboard-only"),
    { description = "[Screen Capture] Freeze and snip region" })

hl.bind(mainMod .. " + ALT + P",
    hl.dsp.exec_cmd("hyprshot output -m output -m active -D 0.3 --clipboard only"),
    { description = "[Screen Capture] Screenshot active monitor" })

hl.bind("Print",
    hl.dsp.exec_cmd("sh -c 'dir=$(mktemp -d) && hyprshot -m output -o \"$dir\" && file=$(find \"$dir\" -type f -name \"*.png\" | head -n1) && satty -f \"$file\" --copy-command wl-copy && rm -rf \"$dir\"'"),
    { description = "[Screen Capture] Screenshot all monitors" })

-- -----------------------
-- | Session / System UI |
-- -----------------------

hl.bind("CTRL + ALT + Delete",
    hl.dsp.exec_cmd("wlogout --layout ~/.config/wlogout/layout --css ~/.config/wlogout/style.css --buttons-per-row 4"),
    { description = "Open logout menu" })
hl.bind(mainMod .. " + L",     hl.dsp.exec_cmd("hyprlock"),        { description = "Lock screen" })
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("~/scripts/keybind-hint.sh"), { description = "Show keybind list" })

-- -----------------
-- | Waybar / Dock |
-- -----------------

hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd("killall -SIGUSR1 waybar"),  { description = "Toggle waybar visibility" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/scripts/waybar_reload.sh"),         { description = "Reload waybar" })
hl.bind(mainMod .. " + H",         hl.dsp.exec_cmd("killall -SIGUSR1 hypr-dock"), { description = "Toggle dock" })
hl.bind("ALT + SHIFT + C",         hl.dsp.exec_cmd("pkill -SIGUSR1 ie-r"),      { description = "Send SIGUSR1 to ie-r" })
hl.bind("ALT + SHIFT + H",         hl.dsp.exec_cmd("pkill -SIGUSR2 ie-r"),      { description = "Send SIGUSR2 to ie-r" })

-- --------------
-- | Wallpapers |
-- --------------

hl.bind(mainMod .. " + CTRL + W",  hl.dsp.exec_cmd("~/.config/hypr/scripts/wall-random.sh"), { description = "Set random wallpaper" })
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/scripts/wallpaper-select"),                       { description = "Select wallpaper" })

-- ------------------
-- | Window Control |
-- ------------------

hl.bind(mainMod .. " + Q",   hl.dsp.window.close(),                 { description = "Close active window" })
hl.bind("ALT + F4",          hl.dsp.exec_cmd("hyprctl kill"),       { description = "Kill window (cursor pick)" })
hl.bind(mainMod .. " + W",   hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating" })
hl.bind(mainMod .. " + F11", hl.dsp.window.fullscreen(),            { description = "Toggle fullscreen" })
hl.bind(mainMod .. " + P",   hl.dsp.layout("pseudo"),               { description = "Toggle dwindle pseudo-tiling" })
hl.bind(mainMod .. " + J",   hl.dsp.layout("togglesplit"),          { description = "Toggle dwindle split direction" })

-- Alt+Tab: two actions on one bind
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())    -- change focus to another window
    hl.dispatch(hl.dsp.window.bring_to_top())  -- bring it to the top
end, { description = "Cycle focus and raise window" })

hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("rofi -show window"),  { description = "Show open windows (rofi)" })
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hypr-alttab"),  { description = "hypr-alttab switcher" })

-- -------------------
-- | Focus Movement  |
-- -------------------

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }), { description = "Move focus left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }), { description = "Move focus right" })
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }), { description = "Move focus up" })
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }), { description = "Move focus down" })

-- ----------------------
-- | Mouse Move/Resize  |
-- ----------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })    -- ALT + LMB: Move a window
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })  -- ALT + RMB: Resize a window

-- -----------------
-- | Mouse Scroll  |
-- -----------------

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll to next workspace" })
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll to previous workspace" })

-- -------------------------
-- | Scratchpad / Special  |
-- -------------------------

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special({ workspace = "magic" }), { description = "Toggle scratchpad" })
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }),       { description = "Send window to scratchpad" })

-- ----------------------------------
-- | Workspace Switch (mainMod+0-9) |
-- ----------------------------------

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,
            hl.dsp.focus({ workspace = tostring(i) }),
            { description = "Switch to workspace " .. i })
    end
hl.bind(mainMod .. " + 0",
        hl.dsp.focus({ workspace = "10" }),
        { description = "Switch to workspace 10" })
-- ------------------------------------------
-- | Move Window to Workspace (Shift+0-9)   |
-- ------------------------------------------

for i = 1, 9 do
    hl.bind(mainMod .. " + SHIFT + " .. i,
            hl.dsp.window.move({ workspace = tostring(i) }),
            { description = "Move window to workspace " .. i })
    end
hl.bind(mainMod .. " + SHIFT + 0",
    hl.dsp.window.move({ workspace = "10" }),
    { description = "Move window to workspace 10" })
-- ------------------------------------------------
-- | Move Window to Workspace Silently (Alt+0-9) |
-- ------------------------------------------------
for i = 1, 9 do
    hl.bind(mainMod .. " + ALT + " .. i,
            hl.dsp.exec_cmd("hyprctl dispatch movetoworkspacesilent " .. i),
            { description = "[ws | Navigation | Move window silently] Move to workspace " .. i .. " (silent)" })
    end
hl.bind(mainMod .. " + ALT + 0",
    hl.dsp.exec_cmd("hyprctl dispatch movetoworkspacesilent 10"),
    { description = "[ws | Navigation | Move window silently] Move to workspace 10 (silent)" })

-- ----------------
-- | Volume / OSD |
-- ----------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +1"),           { repeating = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -1"),           { repeating = true, description = "Volume down" })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),  { repeating = true, description = "Toggle mute" })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),{ repeating = true, description = "Toggle mic mute" })

-- ----------------
-- | Brightness   |
-- ----------------

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness +5"), { repeating = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -5"), { repeating = true, description = "Brightness down" })

-- ---------------
-- | Media Keys  |
-- ---------------

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),     { locked = true, description = "Next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Previous track" })
hl.bind("XF86AudioPlay", function()
    hl.dispatch(hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"))
    hl.dispatch(hl.dsp.exec_cmd("playerctl play-pause"))
end, { locked = true, description = "Play/pause media" })
