local mainMod = "SUPER"

require("config.hyprland")

package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")
smw.setup({
	workspace_count = 10, -- This will create 5 persistent workspaces on each monitor at startup
	keep_focused = true,
	enable_notifications = true,
	enable_persistent_workspaces = true,
	enable_wrapping = true,
})
for i = 1, smw.get_amount_of_workspaces() do
	local n = tostring(i)
	if n == "10" then
		n = "0"
	end -- Optional if you configured 10 workspaces: bind workspace 10 to SUPER + 0
	-- Switch to the Nth workspace on the currently focused monitor.
	hl.bind(mainMod .. " + " .. n, smw.workspace(n))
	-- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change).
	hl.bind(mainMod .. " + SHIFT + " .. n, smw.move_to_workspace_silent(n))
end
hl.bind(mainMod .. " + tab", smw.cycle_workspaces("+1"))
hl.bind(mainMod .. " + SHIFT + tab", smw.cycle_workspaces("-1"))
hl.bind(mainMod .. " + ALT + G", smw.grab_rogue_windows())
