local terminal = "ghostty"
local fileManager = "dolphin"

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 4,
		border_size = 2,
		col = {
			active_border = "rgb(8e24aa)",
			inactive_border = "rgba(20202b69)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
})

-- hl.workspace_rule({ workspace = "f[0]", gaps_out = 2, gaps_in = 2, no_border = false, rounding = true })
hl.workspace_rule({ workspace = "f[0]", gaps_out = 2, gaps_in = 2, no_border = false })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
	name = "no-gaps-f1",
	match = { float = false, workspace = "f[1]" },
	border_size = 0,
	rounding = 0,
})

hl.config({
	decoration = {
		rounding = 4,
		rounding_power = 4,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = false,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
})

hl.config({
	animations = {
		enabled = false,
		workspace_wraparound = true,
	},
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 3.5, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 1.12, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.21, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.config({
	render = {
		cm_enabled = false,
		cm_auto_hdr = 0,
	},
})

hl.config({
	dwindle = {
		preserve_split = true,
		force_split = 2,
		use_active_for_splits = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		initial_workspace_tracking = 1,
		font_family = "IosevkAlly Nerd Font",
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		mouse_move_focuses_monitor = false,
		on_focus_under_fullscreen = 1,
	},
})

hl.config({
	cursor = {
		no_warps = true,
		no_hardware_cursors = 1,
		use_cpu_buffer = 1,
		zoom_disable_aa = true,
		no_break_fs_vrr = 1,
	},
})

require("config.hyprland.window-rules")
