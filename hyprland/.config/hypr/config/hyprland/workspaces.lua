hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "float-modal",
	match = { modal = true },
	float = true,
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "idle-inhibit-fullscreen-class",
	match = { class = "^(.*)$", fullscreen = true },
	idle_inhibit = "fullscreen",
})

hl.window_rule({
	name = "idle-inhibit-fullscreen-title",
	match = { title = "^(.*)$", fullscreen = true },
	idle_inhibit = "fullscreen",
})

hl.layer_rule({
	name = "blur-modal",
	match = { modal = true },
	blur = true,
})
