local wezterm = require 'wezterm'

return function(config)


    local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
    tabline.setup({
    options = {
        icons_enabled = true,
        theme = 'Tokyo Night',
        color_overrides = {},
        section_separators = {
        right = wezterm.nerdfonts.pl_right_hard_divider,
        },
        component_separators = {
        right = wezterm.nerdfonts.pl_right_soft_divider,
        },
        tab_separators = {
        right = wezterm.nerdfonts.pl_right_hard_divider,
        },
    },
    sections = {
        tabline_a = { 'mode' },
        tabline_b = { 'workspace' },
        tab_active = {'index', { 'cwd' },},
        tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
        tabline_x = {},
        tabline_y = { 'datetime'},
        tabline_z = { 'hostname' },
    },
    extensions = {},
    })
end
