-- improve overall qol
vim.keymap.set('i', 'jk', '<esc>');

-- cycle splits, skipping nvim-tree
vim.keymap.set('n', '<tab>', function()
    local start = vim.api.nvim_get_current_win()
    vim.cmd('wincmd w')
    while vim.api.nvim_get_current_win() ~= start do
        local ft = vim.bo[vim.api.nvim_get_current_buf()].filetype
        if ft ~= 'NvimTree' then return end
        vim.cmd('wincmd w')
    end
end)

-- disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- movement
vim.keymap.set('n', 'H', '0')
vim.keymap.set('v', 'H', '0')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('v', 'L', '$')

-- stupid shift key fixes
vim.keymap.set('c', 'X', 'x')
vim.keymap.set('c', 'W', 'w')
vim.keymap.set('c', 'Q', 'q')
vim.keymap.set('c', 'wQ', 'wq')
vim.keymap.set('c', 'Wq', 'wq')
vim.keymap.set('c', 'Tabe', 'tabe')

-- helpers
vim.keymap.set('c', 'qq', 'q!')
vim.keymap.set('c', 'xx', 'x!')
vim.keymap.set('c', 'ww', 'w!')

-- tabs
vim.keymap.set('n', 'tn', ':tabnew<CR>')
vim.keymap.set('n', 'tq', ':tabclose<CR>')
vim.keymap.set('n', '<S-tab>', ':tabnext<CR>')

-- center cursor on current search result
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- quit all with floating confirmation
vim.keymap.set('n', '<leader>qq', function()
    vim.api.nvim_set_hl(0, 'QuitFloatBorder', { fg = '#C4746E', bold = true })
    local lines = { '', '  Quit Neovim?  ', '', '  [y] Yes   [n] No  ', '' }
    local width = 20
    local height = #lines
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = 'minimal',
        border = 'rounded',
    })
    vim.api.nvim_set_option_value('winhighlight', 'FloatBorder:QuitFloatBorder', { win = win })
    vim.api.nvim_set_option_value('cursorline', false, { win = win })

    local function close(quit)
        vim.api.nvim_win_close(win, true)
        if quit then vim.cmd('qa!') end
    end

    for _, key in ipairs({ 'y', 'Y', '<CR>' }) do
        vim.keymap.set('n', key, function() close(true) end, { buffer = buf, nowait = true })
    end
    for _, key in ipairs({ 'n', 'N', 'q', '<Esc>' }) do
        vim.keymap.set('n', key, function() close(false) end, { buffer = buf, nowait = true })
    end
end, { desc = 'Quit all with confirmation' })

