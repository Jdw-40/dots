-------------------
--- KEYBINDINGS ---
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local terminal = "kitty"
local browser = "zen-browser"
local menu = "rofi -show drun"
local fileManager = "thunar"

-- Example binds
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))                                                                                      -- open kitty
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))                                                                                       -- open firefox
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("firefox --private-window"))                                                            -- firefox private window
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(menu))                                                                                          -- open rofi
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -theme ~/.config/rofi/clipboard.rasi | cliphist decode | wl-copy")) -- open rofi clipboard
hl.bind(mainMod .. " + Q", hl.dsp.window.close())                                                                                          -- close active window
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))                                                                                   -- open dolphin (file manager)
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("wlogout --layout ~/.config/wlogout/layout --css ~/.config/wlogout/style.css --buttons-per-row 4")) -- open wlogout
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))                                                                                    -- lock screen
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))                                                                     -- toggle floating
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())                                                                                         -- dwindle pseudo
hl.bind("ALT + Tab", hl.dsp.exec_cmd("hypr-alttab"))

-- Dwindle split
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"), { description = "[Screen Capture] toggle split" })

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))   -- move focus left
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))  -- move focus right
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))     -- move focus up
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))   -- move focus down

--active window management
hl.bind("ALT + Tab", function()
hl.dispatch(hl.dsp.window.cycle_next())   -- change focus to another window
hl.dispatch(hl.dsp.window.bring_to_top()) -- bring it to the top
end)

-- Desktop Utilities
hl.bind(mainMod .. " + slash",          hl.dsp.exec_cmd("keybind-hint.sh"))                                         -- keybind list
hl.bind(mainMod .. " + period",         hl.dsp.exec_cmd("emoji.sh"))                                                -- emoji picker
hl.bind(mainMod .. " + comma",          hl.dsp.exec_cmd("glyph.sh"))                                                -- glyph picker
hl.bind(mainMod .. " + R",              hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))                                 -- hide waybar
hl.bind(mainMod .. " + SHIFT + R",      hl.dsp.exec_cmd("~/scripts/waybar_reload.sh"))                                        -- reload waybar
hl.bind(mainMod .. " + CTRL + W",       hl.dsp.exec_cmd("~/.config/hypr/scripts/wall-random.sh"))                  -- random wallpaper
hl.bind(mainMod .. " + SHIFT + W",      hl.dsp.exec_cmd("~/scripts/wallpaper-select"))                                        -- select wallpaper
hl.bind(mainMod .. " + SHIFT + A",      hl.dsp.exec_cmd("rofi -show drun -theme ~/.config/rofi/fullscreenLauncher.rasi")) -- full screen rofi drun menu
hl.bind("ALT + F4",                     hl.dsp.exec_cmd("hyprctl kill"))                                            -- kill active window
hl.bind(mainMod .. " + SHIFT + T",      hl.dsp.exec_cmd("~/scripts/theme-picker.sh"))                                         -- change theme
hl.bind(mainMod .. " + H",              hl.dsp.exec_cmd("killall -SIGUSR1 hypr-dock"))
hl.bind(mainMod .. " + F11",            hl.dsp.window.fullscreen())
hl.bind("ALT + SHIFT + C",              hl.dsp.exec_cmd("pkill -SIGUSR1 ie-r"))
hl.bind("ALT + SHIFT + H",              hl.dsp.exec_cmd("pkill -SIGUSR2 ie-r"))

-- Screen Capture / Screenshot Binds
hl.bind(mainMod .. " + CTRL + P",  hl.dsp.exec_cmd("hyprpicker -an"),                                                                                                                                                                   { description = "[Screen Capture] color picker" })
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m region -D 0.5 -z --clipboard-only"),                                                                                                                                    { description = "[Screen Capture] freeze and snip screen" })
hl.bind(mainMod .. " + ALT + P",   hl.dsp.exec_cmd("hyprshot output -m output -m active -D 0.3 --clipboard-only"),                                                                                                                      { description = "[Screen Capture] print monitor" })
hl.bind("Print",                   hl.dsp.exec_cmd("sh -c 'dir=$(mktemp -d) && hyprshot -m output -o \"$dir\" && file=$(find \"$dir\" -type f -name \"*.png\" | head -n1) && satty -f \"$file\" --copy-command wl-copy && rm -rf \"$dir\"'"), { description = "[Screen Capture] print all monitors" })

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move focused window to a workspace silently
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i }), { silent = true, description = "[ws | Navigation | Move window silently] move to workspace " .. i .. " (silent)" })
end

-- Scratchpad (Special Workspaces)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))          -- toggle scratchpad
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" })) -- send window to scratchpad

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume +1"),        { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("swayosd-client --output-volume -1"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness +5"),           { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness -5"),           { locked = true, repeating = true })

-- Media keys (requires playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),    { locked = true })
