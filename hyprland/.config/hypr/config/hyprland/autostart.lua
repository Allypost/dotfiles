hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")

	-- Start Polkit
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

	-- -- Load Bar and Notification Daemon
	-- hl.exec_cmd("waybar")
	-- hl.exec_cmd("swaync")
	-- hl.exec_cmd("qs -c noctalia-shell") -- all in one bar + notif
	hl.exec_cmd("noctalia") -- all in one bar + notif

	-- Load cliphist history
	hl.exec_cmd("wl-paste --watch cliphist store")

	-- Application launcher daemon
	hl.exec_cmd("vicinae server")

	-- hl.exec_cmd("hypridle")
	-- hl.exec_cmd("hyprsunset")

	hl.exec_cmd("~/.config/hypr/scripts/keep-windows-on-screen.py")
end)

hl.on("config.reloaded", function()
	hl.exec_cmd("hyprpm reload -n")
end)
