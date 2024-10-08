-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- my coolnight colorscheme

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.color_scheme = 'OneDark (base16)'
config.font_size = 17

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
