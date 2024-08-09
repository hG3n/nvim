return {
    'hrsh7th/nvim-cmp',
    event = { 
        'InsertEnter',
        'CmdlineEnter' 
    },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip'
    },
    config = function()
        -- complete options
        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

        local kind_icons = {
            Class = ' ',
            Color = ' ',
            Comment = '//',
            Constant = ' ',
            Constructor = ' ',
            Enum = ' ',
            EnumMember = ' ',
            Event = '',
            Field = '󰄶 ',
            File = ' ',
            Folder = ' ',
            Function = 'ƒ ',
            Interface = ' ',
            Keyword = '󰌆 ',
            Method = ' ',
            Module = '󰏗 ',
            Operator = '󰆕 ',
            Property = ' ',
            Reference = ' ',
            Snippet = ' ',
            String = '󱌯 ',
            Struct = ' ',
            Text = ' ',
            TypeParameter = '󰅲 ',
            Unit = ' ',
            Value = '󰎠 ',
            Variable = '󰀫',
        }

        -- load cmp
        local cmp = require('cmp')

        -- setup
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- todo maybe switch to luasnip?
                end,
            },
            window = {
                completion = {
                    border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
                },
                documentation = {
                    border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
                },
            },
            view = {
                entries = {
                    name = 'custom',
                    selection_order = 'near_cursor',
                    follow_cursor = true,
                },
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
            }),
            -- formatting = {
            --     fields = { 'abbr', 'kind', 'menu' },
            --     format = function(entry, vim_item)
            --         -- Kind icons
            --         -- This concatonates the icons with the name of the item kind
            --         vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            --         -- Trim text function
            --         function trim(text)
            --             local max = 40
            --             if text and text:len(1, max) > max then
            --                 text = text:sub(1, max) .. '...'
            --             end
            --             return text
            --         end
            --         vim_item.abbr = trim(vim_item.abbr)
            --         -- Source
            --         vim_item.menu = ({
            --             nvim_lsp = '( LSP )',
            --             nvim_lsp_signature_help = '( Signature )',
            --             luasnip = '( LuaSnip )',
            --             buffer = '( Buffer )',
            --             -- cmp_yanky = '( Yanky )',
            --             path = '( Path )',
            --             nvim_lua = '( Lua )',
            --             look = '( Look )',
            --             -- cmdline = '(CMDLine)',
            --         })[entry.source.name]
            --         return vim_item
            --     end,
            -- },
            -- sorting = {
            --     comparators = {
            --         cmp.config.compare.score,
            --         cmp.config.compare.offset,
            --         cmp.config.compare.exact,
            --         cmp.config.compare.recently_used,
            --         cmp.config.compare.length,
            --         cmp.config.compare.locality,
            --         cmp.config.compare.kind,
            --         cmp.config.compare.sort_text,
            --         cmp.config.compare.order,
            --     },
            -- },
            experimental = {
                ghost_text = true,
            },
        })

        -- cmp cmndline for / and ?
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })

        -- cmp cmdline for :
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            -- sources = cmp.config.sources({
            --     { name = 'path' },
            -- }, {
            --     { name = 'cmdline' },
            -- }),
            -- Same as above
            sources = cmp.config.sources({
                { name = 'path', group_index = 1 },
                { name = 'cmdline', group_index = 2 },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })

    end,
}
