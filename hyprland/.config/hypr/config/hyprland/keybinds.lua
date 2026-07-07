local terminal = "ghostty"
local fileManager = "dolphin"
local mainMod = "SUPER"

hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
-- hl.bind(mainMod .. " + CONTROL + SHIFT + Q", hl.dsp.exec_cmd("hyprctl dispatch forcekillactive"))
hl.bind(mainMod .. " + CONTROL + SHIFT + Q", hl.dsp.window.kill())
hl.bind(
	mainMod .. " + CONTROL + SHIFT + ALT + Q",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + CONTROL + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + W", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + tab", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + tab", hl.dsp.window.cycle_next({ prev = true }))

hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))

-- for i = 1, 10 do
-- 	local key = i % 10
-- 	hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd("hyprctl dispatch split-workspace " .. i))
-- 	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.exec_cmd("hyprctl dispatch split-movetoworkspacesilent " .. i))
-- end

-- hl.bind(mainMod .. " + tab", hl.dsp.exec_cmd("hyprctl dispatch split-workspace +1"))
-- hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.exec_cmd("hyprctl dispatch split-workspace -1"))
-- hl.bind(mainMod .. " + ALT + tab", hl.dsp.exec_cmd("hyprctl dispatch split-cycleworkspaces +1"))
hl.bind(mainMod .. " + CONTROL + tab", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + tab", hl.dsp.focus({ monitor = "-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
	"SHIFT + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"SHIFT + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"SHIFT + XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 1%+"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind(
	"SHIFT + XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 1%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("vicinae open"))
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd("swap-audio-output-device.py"))
hl.bind(mainMod .. " + CONTROL + ALT + V", hl.dsp.exec_cmd("swap-audio-output-device-gui.py"))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + CONTROL + E", hl.dsp.exec_cmd(fileManager .. " ~/MEMES"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + CONTROL + ALT + C", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd("meme-download"))
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("~/.scripts/mpv-play"))
hl.bind("Print", hl.dsp.exec_cmd("~/.scripts/screenshot-region"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.scripts/screenshot-region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.scripts/screenshot-window -c"))
hl.bind("SHIFT + ALT + Print", hl.dsp.exec_cmd("~/.scripts/screenshot-window"))
hl.bind(mainMod .. " + CONTROL + SHIFT + S", hl.dsp.exec_cmd("~/.scripts/screenshot-window"))
