--  ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗██████╗
--  ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔══██╗
--  ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║██║  ██║
--  ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║██║  ██║
--  ██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║██████╔╝
--  ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝

local MOD = "SUPER"
local TERMINAL = os.getenv("TERMINAL") or "kitty"
local BROWSER = os.getenv("BROWSER") or "firefox"
local EXPLORER = os.getenv("EXPLORER") or "nautilus"

-- helper functions
local function focus_or_launch(execute, class)
  class = class or execute
  for _, w in pairs(hl.get_windows()) do
    if w.class == class then
      hl.dispatch(hl.dsp.focus({ window = w }))
      return
    end
  end
  hl.exec_cmd(execute)
end

-- monitors
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- core config
hl.config({
  input = {
    kb_layout = "ch-qwerty",
    kb_variant = "",
    kb_model = "",
    kb_options = "caps:swapescape",
    kb_rules = "",
    follow_mouse = 1,
    touchpad = { natural_scroll = true, disable_while_typing = false },
  },
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 1,
    resize_on_border = true,
    col = {
      active_border = "rgba(f1f1f1ff)",
      inactive_border = "rgba(595959aa)",
    },
    layout = "dwindle",
  },
  misc = {
    disable_hyprland_logo = true,
    enable_anr_dialog = false,
  },
  decoration = {
    rounding = 5,
    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
    active_opacity = 0.9,
    inactive_opacity = 0.9,
    blur = {
      size = 8,
      passes = 3,
      brightness = 1.0,
      vibrancy = 0.2,
    },
  },
  xwayland = {
    force_zero_scaling = true,
  },
  animations = {
    enabled = true,
  },
  dwindle = {
    preserve_split = true,
    force_split = 2,
  },
})

hl.curve("smooth", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
hl.animation({ leaf = "windows", enabled = false, speed = 1, bezier = "default", style = "popin" })
hl.animation({ leaf = "windowsOut", enabled = false, speed = 1, bezier = "default" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "fade", enabled = false })
hl.animation({ leaf = "layers", enabled = false })
hl.animation({ leaf = "layersIn", enabled = true, speed = 0.5, bezier = "default" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 0.5, bezier = "default" })

-- device
hl.device({
  name = "synps/2-synaptics-touchpad",
  sensitivity = 0.1,
})

-- workspaces
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8", default_name = "󰺻", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "9", default_name = "󰍩", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "10", default_name = "󰋋", monitor = "eDP-1" })

for i = 1, 10 do
  local key = tostring(i % 10)
  hl.bind(MOD .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(MOD .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- media / system keys (noctalia handles OSD natively)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl -a pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.bind(MOD .. " + left", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(MOD .. " + right", hl.dsp.exec_cmd("playerctl next"))
hl.bind(MOD .. " + down", hl.dsp.exec_cmd("playerctl -a pause"))
hl.bind(MOD .. " + up", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("XF86Display", hl.dsp.exec_cmd("pkill wdisplays || wdisplays"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("xbacklight -set $(expr $(xbacklight -get) \\* 3 \\/ 2 + 1) -fps 60"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("xbacklight -set $(expr $(xbacklight -get) \\* 2 \\/ 3) -fps 60"), { repeating = true })

-- main binds
hl.bind(MOD .. " + return", hl.dsp.exec_cmd(TERMINAL))
hl.bind(MOD .. " + q", hl.dsp.window.close())
hl.bind(MOD .. " + d", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))

hl.bind(MOD .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(MOD .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(MOD .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(MOD .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind(MOD .. " + SHIFT + h", hl.dsp.exec_raw("movewindoworgroup l"))
hl.bind(MOD .. " + SHIFT + l", hl.dsp.exec_raw("movewindoworgroup r"))
hl.bind(MOD .. " + SHIFT + k", hl.dsp.exec_raw("movewindoworgroup u"))
hl.bind(MOD .. " + SHIFT + j", hl.dsp.exec_raw("movewindoworgroup d"))

hl.bind(MOD .. " + SHIFT + z", hl.dsp.exec_raw("togglegroup"))
hl.bind(MOD .. " + z", hl.dsp.exec_raw("changegroupactive"))

hl.bind(MOD .. " + f", hl.dsp.window.fullscreen())
hl.bind(MOD .. " + space", hl.dsp.window.float({ action = "toggle" }))

hl.bind(MOD .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(MOD .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(MOD .. " + SHIFT + e", hl.dsp.exit())

hl.bind(MOD .. " + w", hl.dsp.exec_cmd(BROWSER))
hl.bind(MOD .. " + CTRL + w", hl.dsp.exec_cmd(BROWSER .. " --private-window"))

hl.bind(MOD .. " + m", function() focus_or_launch("pear-desktop", "com.github.th-ch.youtube-music") end)
hl.bind(MOD .. " + comma", function() focus_or_launch("signal-desktop", "signal") end)
hl.bind(MOD .. " + period", function() focus_or_launch("ferdium") end)
hl.bind(MOD .. " + e", hl.dsp.exec_cmd(EXPLORER))
hl.bind(MOD .. " + n", function() focus_or_launch("thunderbird") end)

hl.bind(MOD .. " + SHIFT + p", hl.dsp.exec_cmd("systemctl suspend-then-hibernate"))
hl.bind(MOD .. " + p", hl.dsp.exec_cmd("noctalia msg session lock"))

hl.bind(MOD .. " + u", hl.dsp.focus({ urgent_or_last = true }))
hl.bind("CTRL + space", hl.dsp.exec_cmd("noctalia msg notification-clear-active"))

hl.bind(MOD .. " + s", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind(MOD .. " + SHIFT + s", hl.dsp.exec_cmd("GRIM_DEFAULT_DIR=~/Pictures/screenshots grim -g \"$(slurp)\""))

hl.bind(MOD .. " + SHIFT + o", hl.dsp.exec_cmd("hyprctl setprop active opaque toggle"))

hl.bind(MOD .. " + CTRL + 0", hl.dsp.exec_raw("movecurrentworkspacetomonitor 0"))
hl.bind(MOD .. " + CTRL + 9", hl.dsp.exec_raw("movecurrentworkspacetomonitor 1"))

-- gestures
hl.gesture({
  fingers = 3,
  direction = "right",
  action = function()
    hl.dispatch(hl.dsp.send_shortcut({ mods = "ALT", key = "left" }))
  end,
})

hl.gesture({
  fingers = 3,
  direction = "left",
  action = function()
    hl.dispatch(hl.dsp.send_shortcut({ mods = "ALT", key = "right" }))
  end,
})

-- window rules
hl.window_rule({ match = { class = "thunderbird" }, workspace = "8" })
hl.window_rule({ match = { class = "ferdium" }, workspace = "9" })
hl.window_rule({ match = { class = "signal" }, workspace = "9" })
hl.window_rule({ match = { class = "com.github.th-ch.youtube-music" }, workspace = "10" })

hl.window_rule({ match = { class = "Spotify" }, tile = true })

hl.window_rule({ match = { class = "org.kde.polkit-kde-authentication-agent-1" }, float = true })
hl.window_rule({ match = { class = "blueman-manager" }, float = true })
hl.window_rule({ match = { class = "pavucontrol" }, float = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true })
hl.window_rule({ match = { class = "wdisplays" }, float = true })
hl.window_rule({ match = { class = "Matplotlib" }, float = true })
hl.window_rule({ match = { class = "anki.desktop", title = "^(Preview)$" }, float = true })

hl.window_rule({ match = { class = "com.nextcloud.desktopclient.nextcloud" }, float = true })
hl.window_rule({ match = { class = "com.nextcloud.desktopclient.nextcloud" }, size = "30% 30%" })
hl.window_rule({ match = { class = "com.nextcloud.desktopclient.nextcloud" }, move = "100%-w-10 40" })

hl.window_rule({ match = { class = ".*" }, idle_inhibit = "fullscreen" })

hl.window_rule({ match = { class = "LibreWolf" }, opaque = true })
hl.window_rule({ match = { class = "firefox" }, opaque = true })
hl.window_rule({ match = { class = "kitty" }, opaque = true })
hl.window_rule({ match = { class = "org.pwmt.zathura" }, opaque = true })
hl.window_rule({ match = { class = "org.inkscape.Inkscape" }, opaque = true })
hl.window_rule({ match = { title = "^(Android Emulator -)" }, opaque = true })
hl.window_rule({ match = { class = "Gimp" }, opaque = true })
hl.window_rule({ match = { class = "virt-manager" }, opaque = true })
hl.window_rule({ match = { class = "org.kde.kdenlive" }, opaque = true })
hl.window_rule({ match = { class = "eog" }, opaque = true })
hl.window_rule({ match = { class = "remote-viewer" }, opaque = true })
hl.window_rule({ match = { class = "evince" }, opaque = true })
hl.window_rule({ match = { class = "Zotero" }, opaque = true })

hl.window_rule({ match = { class = "firefox", title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { class = "firefox", title = "^(Picture-in-Picture)$" }, pin = true })

hl.window_rule({ match = { class = "^(LibreWolf)$", title = "^(LibreWolf — Sharing Indicator)$" }, float = true })
hl.window_rule({ match = { class = "^(LibreWolf)$", title = "^(LibreWolf — Sharing Indicator)$" }, no_focus = true })
hl.window_rule({ match = { class = "^(LibreWolf)$", title = "^(LibreWolf — Sharing Indicator)$" }, move = "49% 30" })

hl.window_rule({ match = { xwayland = true, float = true }, no_blur = true })
hl.window_rule({ match = { xwayland = true, float = true }, opaque = true })

hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

hl.window_rule({ match = { class = "dragon-drop" }, move = "cursor -50% -50%" })
hl.window_rule({ match = { class = "dragon-drop" }, size = "5% 1%" })

-- auto focus urgent windows
hl.on("window.urgent", function(window)
  hl.dispatch(hl.dsp.focus({ window = window }))
end)

-- layer rules
hl.layer_rule({ match = { namespace = "selection" }, no_anim = true })
hl.layer_rule({ match = { namespace = "noctalia" }, blur = true })

-- smart gaps
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

-- autostart (exec-once)
-- Note: noctalia is started via systemd user service (programs.noctalia.systemd.enable = true)
hl.on("hyprland.start", function()
  hl.exec_cmd("uwsm app -- hyprctl setcursor capitaine-cursors 24")
  hl.exec_cmd("uwsm app -- gnome-keyring-daemon --start")
  hl.exec_cmd("uwsm app -- udiskie -s")
  hl.exec_cmd("uwsm app -- hypridle")
end)

-- Removed launch-waybar and setwallpaper as they are handled by noctalia
-- Removed swayosd-server as it is handled by noctalia
