return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    keys = { '<C-p>', '<leader>fg', '<leader>fb', '<leader>fh' },
    config = function()
        local fzf = require('fzf-lua')

        fzf.setup({
            winopts = {
                height = 0.6,
                width = 0.8,
                preview = { layout = 'horizontal', ratio = 55 },
            },
            files = { hidden = true },
        })

        vim.keymap.set('n', '<C-p>',      fzf.files,      { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fg', fzf.live_grep,  { desc = 'Live grep' })
        vim.keymap.set('n', '<leader>fb', fzf.buffers,    { desc = 'Find buffers' })
        vim.keymap.set('n', '<leader>fh', fzf.help_tags,  { desc = 'Find help' })
    end,
}
