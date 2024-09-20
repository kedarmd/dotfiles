local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Color Scheme
config.color_scheme = "nord"

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Regular" })
config.font_size = 10.25
config.line_height = 1.20
config.cell_width = 1.05

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

return config
