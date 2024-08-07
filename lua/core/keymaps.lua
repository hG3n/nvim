-- improve overall qol
vim.keymap.set('i', 'jk', '<esc>');

-- use <tab> to switch between panes qul feature
vim.keymap.set('n', '<tab>', '<C-w><C-w>');

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

