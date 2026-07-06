local float_persistent = {
	"mpv",
	"vlc",
	"nomacs",
	"Image Lounge",
	"qimgv",
	"feh",
	"mirage",
	"Mirage",
	"ristretto",
	"copyq",
	"minecraft-launcher",
	"flameshot",
	"xdg-desktop-portal-gtk",
}

for _, cls in ipairs(float_persistent) do
	hl.window_rule({
		name = "float-" .. cls,
		match = { class = cls },
		float = true,
		persistent_size = true,
	})
end

hl.window_rule({
	name = "tile-emacs",
	match = { class = "Emacs" },
	tile = true,
})

hl.window_rule({
	name = "xwaylandvideobridge",
	match = { class = "^(xwaylandvideobridge)$" },
	opacity = "0.0 override",
	no_anim = true,
	no_initial_focus = true,
	max_size = { 1, 1 },
	no_blur = true,
	no_focus = true,
})

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})
