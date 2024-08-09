-- necessary for plugins to work
vim.opt.termguicolors = true

-- leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- general
vim.opt.number = true
vim.opt.mouse = 'a'

-- split pane default directions
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show cursor line
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- display whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- show matching brackets / parentheses
vim.opt.showmatch = true

-- use the systems clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- soft wrap and indent lines
vim.opt.breakindent = true
vim.opt.showbreak="\\"

