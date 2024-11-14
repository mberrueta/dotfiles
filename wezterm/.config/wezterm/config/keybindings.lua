local wezterm = require 'wezterm'
local act = wezterm.action


return function(config)

    local mod = {}

    config.keys = {
        -- { key = 'c', mods = mod.SUPER_REV, action = 'ActivateCopyMode' }, Ctrl Shift X
        { key = 'q', mods = 'CTRL|SHIFT', action = 'QuickSelect' }, -- too Ctrl Shift Space
        { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
        { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
        {
            key = 'u',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.QuickSelectArgs({
                label = 'url mode',
                patterns = {
                    '\\((https?://\\S+)\\)',
                    '\\[(https?://\\S+)\\]',
                    '\\{(https?://\\S+)\\}',
                    '<(https?://\\S+)>',
                    '\\bhttps?://\\S+[)/a-zA-Z0-9-]+'
                },
                action = wezterm.action_callback(function(window, pane)
                    local url = window:get_selection_text_for_pane(pane)
                    wezterm.log_info('opening: ' .. url)
                    wezterm.open_with(url)
                end),
            }),
        },
        {
            key = 'p',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.QuickSelectArgs({
                label = 'Select Kubernetes Pod',
                patterns = {
                -- Regex pattern to match Kubernetes pod names
                '\\b[a-zA-Z0-9-]+-[a-z0-9]{9,}-[a-z0-9]{5}\\b',
                },
                action = wezterm.action_callback(function(window, pane)
                local pod_name = window:get_selection_text_for_pane(pane)
                wezterm.log_info('Selected pod: ' .. pod_name)
                window:copy_to_clipboard(pod_name)
                end),
            }),
            },

            -- Map Ctrl+h/j/k/l to Left/Down/Up/Right Arrow keys
            { key = 'h', mods = 'CTRL', action = wezterm.action.SendKey { key = 'LeftArrow' } },
            { key = 'j', mods = 'CTRL', action = wezterm.action.SendKey { key = 'DownArrow' } },
            { key = 'k', mods = 'CTRL', action = wezterm.action.SendKey { key = 'UpArrow' } },
            { key = 'l', mods = 'CTRL', action = wezterm.action.SendKey { key = 'RightArrow' } },

            -- Map Shift+h/l to Ctrl+A/Ctrl+E (start/end of line)
            { key = 'H', mods = 'CTRL|SHIFT', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' } },
            { key = 'L', mods = 'CTRL|SHIFT', action = wezterm.action.SendKey { key = 'e', mods = 'CTRL' } },

            -- Map Shift+j/k to Alt+B/Alt+F (previous/next word)
            { key = 'J', mods = 'CTRL|SHIFT', action = wezterm.action.SendKey { key = 'b', mods = 'ALT' } },
            { key = 'K', mods = 'CTRL|SHIFT', action = wezterm.action.SendKey { key = 'f', mods = 'ALT' } },

            -- Delete one word to the left with CTRL + Backspace
            {key="Backspace", mods="CTRL", action=wezterm.action{SendString="\x1b\x7f"}},
            -- Delete one word to the right with CTRL + Delete
            {key="Delete", mods="CTRL", action=wezterm.action{SendString="\x1bd"}},
    }

    config.mouse_bindings = {
        -- Right click to paste
        {
            event = { Down = { streak = 1, button = 'Right' } },
            mods = 'NONE',
            action = wezterm.action.PasteFrom 'Clipboard',
        },
    }
end
