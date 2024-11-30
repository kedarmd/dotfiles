local wezterm = require("wezterm")
local act = wezterm.action
local M = {}

---@param window unknown
---@param command unknown
---@param key string
---@param mods string
function M.nvim_wez_nav(window, command, key, mods)
	local pane = window:active_pane()

	if not pane then
		wezterm.log_error("No active pane found.")
		return
	end
	local title = pane:get_title()
	if title == "nvim" then
		wezterm.log_info("inside if block")
		window:perform_action(act.SendKey({ key = key, mods = mods }), pane)
	else
		window:perform_action(command, pane)
	end
end

function M.keybindings()
	local keybindings = {
		{
			key = "h",
			mods = "CTRL",
			action = wezterm.action_callback(function(window)
				M.nvim_wez_nav(window, act.ActivatePaneDirection("Left"), "h", "CTRL")
			end),
		},
		{
			key = "j",
			mods = "CTRL",
			action = wezterm.action_callback(function(window)
				M.nvim_wez_nav(window, act.ActivatePaneDirection("Down"), "j", "CTRL")
			end),
		},
		{
			key = "k",
			mods = "CTRL",
			action = wezterm.action_callback(function(window)
				M.nvim_wez_nav(window, act.ActivatePaneDirection("Up"), "k", "CTRL")
			end),
		},
		{
			key = "l",
			mods = "CTRL",
			action = wezterm.action_callback(function(window)
				M.nvim_wez_nav(window, act.ActivatePaneDirection("Right"), "l", "CTRL")
			end),
		},
	}
	return keybindings
end

return M
