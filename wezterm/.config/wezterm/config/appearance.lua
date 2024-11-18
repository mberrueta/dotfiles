local wezterm = require 'wezterm'

return function(config)


    -- Font configuration
    config.font = wezterm.font_with_fallback({
        'CaskaydiaCove Nerd Font',
        'Noto Color Emoji',
        'Symbols Nerd Font' ,
        'JetBrains Mono',
        'Fira Code',
        'DengXian',
    })
    config.font_size = 11.0

    config.warn_about_missing_glyphs = false

    -- Color scheme
    config.color_scheme = 'Tokyo Night'

    -- Window configuration
    config.window_background_opacity = 0.85
    config.window_padding = {
        left = 2,
        right = 2,
        top = 0,
        bottom = 0,
    }

    -- Tab bar
    -- config.use_fancy_tab_bar = false
    -- config.hide_tab_bar_if_only_one_tab = true

    -- Cursor configuration
    config.default_cursor_style = 'SteadyBar'
    config.tab_bar_at_bottom = true
    config.use_fancy_tab_bar = false

    config.enable_scroll_bar = true
end
