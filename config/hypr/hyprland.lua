-- This is an example Hyprland config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can split this configuration into multiple files
-- and load them using require() with paths relative to hyprland.lua

-------------------
--- MY PROGRAMS ---
-------------------

-- See https://wiki.hypr.land/Configuring/Keywords/
-- Set programs that you use
local terminal = "kitty"
local fileManager = "thunar"
local menu = "rofi -show drun"
local browser = "zen-browser"
local code = "visual-studio-code-bin"

----------------
--- CONFIGS  ---
----------------
require("monitors")         -- nwg-displays managed (monitors.conf, no .lua variant)
require("env")              -- env variables
require("look-and-feel")    -- general window look + animations
require("input")            -- input devices config
require("binds")            -- keybinds, SUPER+/ for list
require("autostart")        -- programs to start with hyprland
require("workspaces")       -- loads persistent workspaces
--require("hyprland-gui")     -- hyprmod support

------------------
--- WORKSPACES ---
------------------

-- See https://wiki.hypr.land/Configuring/Monitors/
-- hl.config({ monitor = { { name = "HDMI-A-1", resolution = "1920x1080@180.0", position = "0x0", scale = 1 } } })

-------------------
--- PERMISSIONS ---
-------------------

-- See https://wiki.hypr.land/Configuring/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
-- hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
-- hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })
hl.permission({ binary = "/usr/bin/hypr-dock", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/bin/hypr-alttab", type = "screencopy", mode = "allow" })

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name = "ignoreMaximize",
    suppress_event = "maximize",
    match = { class = ".*" },
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "draggingFix",
    no_focus = true,
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
})

-- xwayland settings
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

-- hyprexpo plugin config
--hl.config({
--    plugin = {
--       hyprexpo = {
--            columns = 3,
--            gap_size = 5,
 --           bg_col = "rgb(262738)",
 --         workspace_method = "center current",
  --        -- gesture_distance = 300,
   --     },
   -- },
--})

-- misc:
hl.config({
    input = {
        numlock_by_default = true,
    },
})
