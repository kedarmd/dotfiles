local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Color Scheme
config.color_scheme = "nord"

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" })
config.font_size = 10.25
config.line_height = 1.20
config.cell_width = 1.05

config.hide_mouse_cursor_when_typing = false

-- Window
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 4,
	right = 4,
	top = 0,
	bottom = 0,
}
config.window_background_opacity = 0.9
config.text_background_opacity = 1

return config
