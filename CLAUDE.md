# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

**Entry point:** `init.lua` — bootstraps lazy.nvim, sets leader key (`,`), loads `core.*` modules, then calls `require('lazy').setup()`.

**Directory layout:**
- `lua/core/` — editor fundamentals loaded at startup (settings, keymaps, commands, autocommands)
- `lua/plugins/` — one file per plugin, each returning a lazy.nvim plugin spec table
- `lua/plugins/lsp/` — LSP-related plugin specs (`lsp-config.lua` for `nvim-lspconfig`, `lazydev.lua`)

**Plugin loading:** `lazy.setup` imports both `{ import = 'plugins' }` and `{ import = 'plugins.lsp' }`.

## Key conventions

- Leader: `,` (both `mapleader` and `maplocalleader`)
- Indent: 4 spaces, expanded tabs
- Colorscheme: `kanagawa-dragon` (loaded eagerly with `priority = 1000`)
- Status line: `lualine.nvim`; tab bar: `bufferline.nvim` + `scope.nvim`
- File tree: `nvim-tree.lua`; fuzzy finder: `fzf-lua`
- Completion: `nvim-cmp` with `vsnip` snippets and LSP source
- `lazydev.nvim` provides Lua/Neovim API completions for Lua files

## Custom commands & keymaps

- `:ReloadConfig` — re-sources `init.lua` without restarting
- `jk` (insert) — escape to normal mode
- `<Tab>` (normal) — cycle between splits
- `<S-Tab>` (normal) — next tab; `tn` new tab; `tq` close tab
- `H` / `L` — go to start/end of line (normal & visual)
- `n` / `N` — centered search navigation (`nzz` / `Nzz`)

## Adding a new plugin

Create `lua/plugins/<name>.lua` returning a lazy.nvim spec table. It will be auto-imported on next startup (or `:Lazy sync`).

## LSP

Servers are configured with the native `vim.lsp.config` / `vim.lsp.enable` API in `lua/plugins/lsp/lsp-config.lua`. Language servers must be installed separately (install commands are documented in comments inside that file).
