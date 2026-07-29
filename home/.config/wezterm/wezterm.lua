local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0
config.window_background_opacity = 1.0 
macos_window_background_blur = 50
config.initial_cols = 120
config.initial_rows = 35
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "TITLE | RESIZE"

return config
