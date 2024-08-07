---------------------------------------------------------------------------
-- jump to last edited line on open
---------------------------------------------------------------------------
vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'Jump to last edited line on open',
    pattern = '*',
    command = 'silent! normal! g`"zv',
})
