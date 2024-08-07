-- get lazy before starting anythig
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable', -- latest stable release
        lazyrepo,
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- leader has to be set before plugin loading
vim.g.mapleader = ','
vim.g.maplocalleader = ','



-- settings
require('core.settings')
-- keymaps
require('core.keymaps')
-- custom commands
require('core.commands')
-- auto commands
require('core.autocommands')

-- lazy options
local opts = {
    ui = {
        border = 'single',
        icons = {
            lazy = '💤',
        },
    },
    checker = {
        enabled = true,
    },
}

--require('lazy').setup({ { import = 'plugins' }, { import = 'plugins.lsp' } }, opts)
require('lazy').setup(
    {
        { import = 'plugins' } 
    },
    opts
)
