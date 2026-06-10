return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufReadPost', 'BufNewFile' },
    config = function()
        local border = {
            { '┌', 'FloatBorder' }, { '─', 'FloatBorder' }, { '┐', 'FloatBorder' },
            { '│', 'FloatBorder' }, { '┘', 'FloatBorder' }, { '─', 'FloatBorder' },
            { '└', 'FloatBorder' }, { '│', 'FloatBorder' },
        }

        -- apply to all servers: cmp capabilities + bordered hover/signature
        vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            handlers = {
                ['textDocument/hover']         = vim.lsp.with(vim.lsp.handlers.hover,          { border = border }),
                ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
            },
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local bufopts = function(desc)
                    return { buffer = ev.buf, desc = desc }
                end
                vim.keymap.set('n', 'K',            vim.lsp.buf.hover,           bufopts('Hover'))
                vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action,     bufopts('LSP Code Action'))
                vim.keymap.set('n', 'grn',          vim.lsp.buf.rename,          bufopts('LSP Rename'))
                vim.keymap.set('n', 'grr',          vim.lsp.buf.references,      bufopts('LSP References'))
                vim.keymap.set('n', 'grd',          vim.lsp.buf.definition,      bufopts('LSP Go to Definition'))
                vim.keymap.set('n', 'grD',          vim.lsp.buf.declaration,     bufopts('LSP Go to Declaration'))
                vim.keymap.set('n', 'gri',          vim.lsp.buf.implementation,  bufopts('LSP Go to Implementation'))
                vim.keymap.set('n', 'grf',          function()
                    vim.lsp.buf.format({ async = true })
                end,                                                              bufopts('LSP Format'))
                vim.keymap.set('n', 'grk',          vim.lsp.buf.signature_help,  bufopts('LSP Signature Help'))
                vim.keymap.set('n', 'grs',          vim.lsp.buf.document_symbol, bufopts('LSP Document Symbols'))
                vim.keymap.set('n', 'grt',          vim.lsp.buf.type_definition, bufopts('LSP Type Definition'))

                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client and client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true)
                end
            end,
        })

        -- javascript / typescript
        -- npm install -g typescript typescript-language-server
        vim.lsp.config('ts_ls', {
            init_options = {
                preferences = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                    importModuleSpecifierPreference = 'non-relative',
                },
            },
        })
        vim.lsp.enable('ts_ls')
    end,
}
