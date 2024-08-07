return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {
        theme = 'doom',
        config = {
            header = {
                'Neovim',
                '',
            },
            center = {
                { action = 'Lazy', desc = ' Lazy', icon = '💤', key = 'l' },
                { action = 'qa', desc = ' Quit', icon = ' ', key = 'q' },
            },
            footer = function()
                local stats = require('lazy').stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
            end,
        },
        hide = {
            tabline = false,
        },
    },
}
