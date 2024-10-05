local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Color Scheme
config.color_scheme = "nord"

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" })
config.font_size = 10
config.line_height = 1.20
config.cell_width = 1.05

config.hide_mouse_cursor_when_typing = false

-- Window
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.window_padding = {
	left = 4,
	right = 4,
	top = 0,
	bottom = 0,
}
config.window_background_opacity = 0.9
config.text_background_opacity = 1

config.window_frame = {
	active_titlebar_bg = "#2A303A",
	inactive_titlebar_bg = "#282B30",
}

-- Custom Colors that were not covered in color scheme (Mainly tab)
config.colors = {
	tab_bar = {
		background = "#1E1E1E",
		active_tab = {
			bg_color = "#2A313C",
			fg_color = "#FFFFFF",
		},
		inactive_tab = {
			bg_color = "#14191A",
			fg_color = "#AAAAAA",
		},
		inactive_tab_hover = {
			bg_color = "#252A2B",
			fg_color = "#FFFFFF",
		},
	},
}

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
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
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
}

return config
