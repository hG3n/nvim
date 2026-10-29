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
                if is_dir then
                    vim.cmd.cd(data.file)
                    -- Create a scratch buffer in the main window before the tree opens,
                    -- so after nvim-tree wipes the directory buffer there is still a
                    -- non-NvimTree window — otherwise the auto-quit BufEnter fires.
                    local scratch = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_set_current_buf(scratch)
                    require('nvim-tree.api').tree.open({ focus = true })
                elseif not no_file then
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

        vim.api.nvim_create_autocmd('BufEnter', {
            nested = true,
            callback = function()
                if #vim.api.nvim_list_wins() == 1
                    and vim.bo.filetype == 'NvimTree' then
                    -- Open a new empty buffer rather than quitting, so the session
                    -- survives when the user closes the last editing window.
                    vim.cmd('enew')
                end
            end,
        })

        vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
        vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFocus<CR>', { desc = 'Focus file tree' })
    end,
}
