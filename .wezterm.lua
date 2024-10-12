-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- my coolnight colorscheme

config.font = wezterm.font("Jetbrains Mono")
config.color_scheme = "OneDark (base16)"
config.font_size = 19
config.window_padding = {
    left = 0,
    right = 0,
    bottom = 0,
    top = 0,
}


config.enable_tab_bar = false

config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
