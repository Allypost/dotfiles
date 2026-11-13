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

local function do_relabel_workspaces()
	local workspaces_per_monitor = smw.get_amount_of_workspaces()
	local function mapped_monitor_count()
		local count = 0
		for _, m in ipairs(hl.get_monitors()) do
			if m.enabled and not m.is_mirror then
				count = count + 1
			end
		end
		return count
	end
	local function relabel_workspaces()
		-- Only the first workspaces_per_monitor ids per monitor are bound to keys;
		-- higher ids (e.g. manually created workspaces) keep their default names.
		local max_id = workspaces_per_monitor * mapped_monitor_count()
		for _, ws in ipairs(hl.get_workspaces()) do
			if ws.id and ws.id >= 1 and ws.id <= max_id then
				local n = (ws.id - 1) % workspaces_per_monitor + 1
				hl.dispatch(hl.dsp.workspace.rename({
					workspace = tostring(ws.id),
					name = n == 10 and "0" or tostring(n),
				}))
			end
		end
	end
	relabel_workspaces()
end

do_relabel_workspaces()
hl.on("workspace.created", do_relabel_workspaces)
hl.on("monitor.added", do_relabel_workspaces)

-- For Noctalia Color templates
local noctalia_ok, noctalia = pcall(require, "noctalia")
if noctalia_ok then
	noctalia.apply_theme()
end

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
do
	local path = os.getenv("HOME") .. "/.config/hypr/hyprmoncfg-monitors.lua"
	local file = io.open(path, "r")
	if file then
		file:close()
		dofile(path)
	end
end
