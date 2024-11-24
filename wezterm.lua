local wezterm = require("wezterm")
local act = wezterm.action
local config = {} --wezterm.config_builder()

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Color Scheme
local themefile = dofile(wezterm.config_dir .. "/development/dotfiles/wezterm-theme.lua")
config.color_scheme = themefile

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" })
config.font_size = 10.5
config.line_height = 1.20
config.cell_width = 1.05

config.hide_mouse_cursor_when_typing = false

-- Window
config.enable_tab_bar = true
config.window_decorations = "RESIZE"
-- config.enable_tab_bar = true
config.window_padding = {
	left = 4,
	right = 4,
	top = 0,
	bottom = 0,
}

-- config.window_background_opacity = 0.9
-- config.text_background_opacity = 1

-- config.window_frame = {
-- 	active_titlebar_bg = "#1C212A",
-- 	inactive_titlebar_bg = "#282B30",
-- }

-- Custom Colors that were not covered in color scheme (Mainly tab)
-- config.colors = {
-- 	tab_bar = {
-- 		background = "#1C212A",
-- 		active_tab = {
-- 			bg_color = "#2A313C",
-- 			fg_color = "#FFFFFF",
-- 		},
-- 		inactive_tab = {
-- 			bg_color = "#14191A",
-- 			fg_color = "#AAAAAA",
-- 		},
-- 		inactive_tab_hover = {
-- 			bg_color = "#252A2B",
-- 			fg_color = "#FFFFFF",
-- 		},
-- 	},
-- }

-- KeyMaps
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 } -- timeout_milliseconds defaults to 1000 and can be omitted
config.keys = {
	{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
	{
		key = '"',
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "%",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "h",
		mods = "ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "ALT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "LeftArrow",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "RightArrow",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "UpArrow",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "DownArrow",
		mods = "LEADER",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "f",
		mods = "ALT",
		action = act.ToggleFullScreen,
	},
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },
	{ key = "l", mods = "LEADER", action = act.ActivateLastTab },
}

config.use_fancy_tab_bar = false
-- Function to extract and format tab titles
wezterm.on("format-tab-title", function(tab)
	local active_pane = tab.active_pane
	if active_pane then
		local cwd = active_pane.current_working_dir
		local path = cwd.file_path
		local last_dir = path:match(".*/(.*)")
		return " " .. tab.tab_index + 1 .. ": " .. last_dir .. " "
	end
	return tab.tab_title
end)

local function get_battery_icon(state)
	if state < 20 then
		return "󰁻"
	elseif state < 40 then
		return "󰁽"
	elseif state < 60 then
		return "󰁿"
	elseif state < 80 then
		return "󰂁"
	elseif state < 90 then
		return "󰂂"
	else
		return "󰁹"
	end
end

wezterm.on("update-right-status", function(window)
	-- Get the current date in the desired format
	local date = wezterm.strftime("%d-%m-%Y %I:%M %p") -- Indian date format with 12-hour time
	-- Set it as the right status
	local pane = window:active_pane()
	local title = pane:get_title()
	local battery_info = wezterm.battery_info()
	local battery_status = ""

	if #battery_info > 0 then
		local battery = battery_info[1] -- Assuming single battery; use a loop if multiple.
		local state = battery.state_of_charge * 100
		local status = battery.state

		-- Format the battery status
		if status == "Charging" then
			battery_status = string.format("󰂄 %.0f%%", state)
		else
			local battery_icon = get_battery_icon(state)
			battery_status = string.format("%s %.0f%%", battery_icon, state)
		end
	else
		battery_status = "No Battery"
	end
	window:set_right_status(battery_status .. " | " .. title .. " | " .. date)
end)

return config
