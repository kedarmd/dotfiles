local wezterm = require("wezterm")
local act = wezterm.action
local config = {} --wezterm.config_builder()
local nvim_wez_navigator = require("plugins.nvim-wez-navigator")

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
config.window_padding = {
	left = 0,
	right = 0,
	top = 5,
	bottom = 0,
}

config.window_frame = {
	border_left_width = "1px",
	border_right_width = "1px",
	border_bottom_height = "1px",
	border_top_height = "1px",
	border_left_color = "Black",
	border_right_color = "Black",
	border_bottom_color = "Black",
	border_top_color = "Black",
}

-- config.window_background_opacity = 0.9
-- config.text_background_opacity = 1

-- config.window_frame = {
-- 	active_titlebar_bg = "#1C212A",
-- 	inactive_titlebar_bg = "#282B30",
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
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		key = "r",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter new name for workspace" },
			}),
			action = wezterm.action_callback(function(_, pane, line)
				if line then
					pane:split({
						direction = "Bottom",
						size = 0.1,
						args = {
							"wezterm",
							"cli",
							"rename-workspace",
							line,
						},
					})
				end
			end),
		}),
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
local keybindings = nvim_wez_navigator.keybindings()
for _, keybinding in ipairs(keybindings) do
	table.insert(config.keys, keybinding)
end

config.use_fancy_tab_bar = false
config.tab_max_width = 60
-- Function to extract and format tab titles
wezterm.on("format-tab-title", function(tab)
	local active_pane = tab.active_pane
	if active_pane then
		local cwd = active_pane.current_working_dir
		if not cwd then
			return tab.tab_index + 1 .. ": Home "
		end
		local path = cwd.file_path
		local last_dir = path:match(".*/(.*)")
		return " " .. tab.tab_index + 1 .. ": " .. last_dir .. " "
	end
	return tab.tab_title
end)

local function get_styled_icon(icon)
	local styled_icon = string.format(
		"%s",
		wezterm.format({
			{ Foreground = { AnsiColor = "White" } },
			{ Text = icon },
		})
	)
	return styled_icon
end

local function get_battery_icon(state, status)
	if state < 20 then
		return get_styled_icon(status == "Charging" and "󰂄" or "󰁻")
	elseif state < 40 then
		return get_styled_icon(status == "Charging" and "󰂄" or "󰁽")
	elseif state < 60 then
		return get_styled_icon(status == "Charging" and "󰂄" or "󰁾")
	elseif state < 80 then
		return get_styled_icon(status == "Charging" and "󰂄" or "󰂁")
	elseif state < 90 then
		return get_styled_icon(status == "Charging" and "󰂄" or "󰂂")
	elseif state == 100 then
		return get_styled_icon("󰂄")
	else
		return get_styled_icon(status == "Charging" and "󰂄" or "󰁹")
	end
end

---Returns a formatted status field
---@param text string
---@param background string
---@return string
local function get_status_field(text, background, icon)
	local pre = wezterm.format({
		{ Foreground = { AnsiColor = background } },
		{ Text = "" },
	})
	local post = wezterm.format({
		{ Foreground = { AnsiColor = background } },
		{ Text = "█" },
	})
	local icon_styles = wezterm.format({
		{ Foreground = { AnsiColor = "Black" } },
		{ Background = { AnsiColor = background } },
		{ Text = icon },
	})

	return string.format(
		"%s%s%s%s",
		pre,
		icon_styles,
		post,
		wezterm.format({
			{ Foreground = { AnsiColor = "White" } },
			{ Text = " " .. text .. " " },
		})
	)
end

local function get_leader_status_color(is_active)
	if is_active then
		return "Red"
	else
		return "Aqua"
	end
end

wezterm.on("update-right-status", function(window)
	local date = get_status_field(wezterm.strftime("%d/%m/%Y %I:%M %p"), "Fuchsia", "󰃰") -- Indian date format with 12-hour time
	local pane = window:active_pane()
	local title = get_status_field(pane:get_title(), "Blue", "󰄨")
	local battery_info = wezterm.battery_info()
	local battery_status = ""
	local is_leader_active = window:leader_is_active() or false
	local workspace_color = get_leader_status_color(is_leader_active)
	local workspace = get_status_field(window:active_workspace(), workspace_color, "")

	local battery = battery_info[1] -- Assuming single battery; use a loop if multiple.
	local state = battery.state_of_charge * 100
	local status = battery.state

	local battery_icon = get_battery_icon(state, status)
	battery_status = string.format("%.0f%%", state)
	battery_status = get_status_field(battery_status, "Grey", battery_icon)

	local final_Status = string.format("%s%s%s%s", battery_status, workspace, title, date)
	window:set_right_status(final_Status)
end)

return config
