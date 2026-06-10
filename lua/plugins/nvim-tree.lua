local TREE_WIDTH = 35
vim.g.nvim_tree_width = TREE_WIDTH

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- disable netrw (required by nvim-tree)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require('nvim-tree').setup({
            view = {
                side = 'left',
                width = TREE_WIDTH,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
            tab = {
                sync = {
                    open = true,
                    close = true,
                },
            },
        })

        vim.api.nvim_create_autocmd('VimEnter', {
            callback = function(data)
                local is_dir = vim.fn.isdirectory(data.file) == 1
                local no_file = data.file == '' or vim.fn.filereadable(data.file) == 0
                if is_dir or no_file then
                    require('nvim-tree.api').tree.toggle({ focus = false })
                else
                    require('nvim-tree.api').tree.toggle({ focus = false })
                    -- wipe the empty buffer left behind when dashboard bails on file open
                    vim.schedule(function()
                        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                            if vim.api.nvim_buf_get_name(buf) == ''
                                and vim.bo[buf].filetype == ''
                                and not vim.bo[buf].modified then
                                vim.api.nvim_buf_delete(buf, { force = true })
                            end
                        end
                    end)
                end
            end,
        })

        vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
        vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Focus file tree' })
    end,
}
