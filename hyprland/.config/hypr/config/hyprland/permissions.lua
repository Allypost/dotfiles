hl.config({
	ecosystem = {
		no_donation_nag = true,
	},
})

hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
