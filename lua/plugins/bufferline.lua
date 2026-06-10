return {
    {
        'tiagovla/scope.nvim',
        lazy = false,
        config = function()
            require('scope').setup()
        end,
    },
    {
        'akinsho/bufferline.nvim',
        version = '*',
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'tiagovla/scope.nvim',
        },
        config = function()
            local tree_width = vim.g.nvim_tree_width or 35

            require('bufferline').setup({
                options = {
                    mode = 'buffers',
                    numbers = 'none',
                    close_command = 'bdelete! %d',
                    indicator = { style = 'icon', icon = '▎' },
                    modified_icon = '●',
                    diagnostics = 'nvim_lsp',
                    offsets = {
                        {
                            filetype = 'NvimTree',
                            text = 'File Explorer',
                            text_align = 'center',
                            separator = true,
                        },
                    },
                    show_tab_indicators = true,
                    separator_style = 'thin',
                    always_show_bufferline = true,
                    sort_by = 'insert_after_current',
                },
            })

            vim.keymap.set('n', '<C-k>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev buffer' })
            vim.keymap.set('n', '<C-j>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
            vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>',     { desc = 'Close buffer' })
            vim.keymap.set('n', '<leader>bD', '<cmd>bdelete!<CR>',    { desc = 'Force close buffer' })

            for i = 1, 9 do
                vim.keymap.set('n', '<leader>' .. i,
                    '<cmd>BufferLineGoToBuffer ' .. i .. '<CR>',
                    { desc = 'Go to buffer ' .. i })
            end
        end,
    },
}
