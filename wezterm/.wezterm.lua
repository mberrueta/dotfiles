local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.enable_wayland = false

require('config.appearance')(config)
require('config.tabbar')(config)
require('config.keybindings')(config)

config.scrollback_lines = 99999

return config
