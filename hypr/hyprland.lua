-- Main Hyprland Lua config.
-- Based on the official example from:
-- https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "wofi"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("wlsunset -l -19.92 -L -43.93")
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("~/.config/hypr/Scripts/notificacao_pausa.sh")
    hl.exec_cmd("~/.config/hypr/Scripts/notificacao_descanso.sh")
    hl.exec_cmd("aw-qt")
    hl.exec_cmd("~/.config/hypr/Scripts/low_battery_notify.sh")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XCURSOR_SIZE", "14")
hl.env("HYPRCURSOR_SIZE", "14")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    cursor = {
        inactive_timeout = 3,
    },

    decoration = {
        rounding       = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "br",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.device({
    name = "pebble-k380s",
    kb_layout = "us",
    kb_variant = "intl"
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + N",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())
hl.bind(mainMod .. " + E",      hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + O",      hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + I",      hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + U",      hl.dsp.exec_cmd("google-chrome-stable"))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("kitty dev"))

-- Move active window.
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ x = 30,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ x = -30, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ x = 0,   y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ x = 0,   y = 30,  relative = true }), { repeating = true })

-- Fn bindings.
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })

hl.bind("F10",   hl.dsp.exec_cmd("~/.config/hypr/Scripts/screenshot.sh screenshot"))
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/Scripts/screenshot.sh annotate"))
hl.bind("F8",    hl.dsp.exec_cmd("~/.config/hypr/Scripts/screenshot.sh record"))

-- Move focus with mainMod + arrow keys.
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Move focus with mainMod + vim motions.
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

-- Monitor control scripts.
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/hypr/Scripts/modo_jogo.sh"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/Scripts/modo_note.sh"))

-- Switch workspaces and move active windows.
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize mode.
hl.bind(mainMod .. " + R", function()
    hl.exec_cmd('notify-send "Modo resize ativado" -r 100 -t 1000 -u low')
    hl.dispatch(hl.dsp.submap("resize"))
end)

hl.define_submap("resize", function()
    hl.bind("right", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
    hl.bind("left",  hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
    hl.bind("up",    hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
    hl.bind("down",  hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })

    hl.bind("L", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
    hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
    hl.bind("K", hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
    hl.bind("J", hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })

    hl.bind("escape", function()
        hl.exec_cmd('notify-send "Modo de resize desativado" -r 100 -t 1000 -u low')
        hl.dispatch(hl.dsp.submap("reset"))
    end)
end)


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name = "ignore-maximize-events",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.workspace_rule({
    workspace = "10",
    on_created_empty = "LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify",
})

hl.workspace_rule({
    workspace = "9",
    on_created_empty = "kitty --class=btop btop",
})
