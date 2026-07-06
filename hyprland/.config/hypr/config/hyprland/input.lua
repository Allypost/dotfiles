hl.config({
	input = {
		kb_layout = "us,hr",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:escape,grp:win_space_toggle,fkeys:basic_13-24",
		kb_rules = "",
		repeat_rate = 50,
		repeat_delay = 250,
		numlock_by_default = true,
		accel_profile = "flat",
		sensitivity = 0.4,
		follow_mouse = 2,
		mouse_refocus = false,
		float_switch_override_focus = false,
		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

pcall(require, "config.hyprland.input.local")
