return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufReadPost', 'BufNewFile' },
    config = function() 

        -- lsp config 
        --------------------------------------------------------------------------------
        local lspconfig = require('lspconfig')

        -- lsp cmp capabilities
        --------------------------------------------------------------------------------
        local lsp_defaults = lspconfig.util.default_config
        lsp_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lsp_defaults.capabilities, 
            require('cmp_nvim_lsp').default_capabilities()
        )


        -- lsp attach autocommand
        --------------------------------------------------------------------------------
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                --- keymaps
                local bufopts = function(desc)
                    return { buffer = ev.buf, desc = desc }
                end
                -- All lsp keymaps starts with gr except K.
                -- Default lsp keymaps. Setting the keymaps again, only to change the description.
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts('Hover'))
                vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, bufopts('LSP Code Action'))
                vim.keymap.set('n', 'grn', vim.lsp.buf.rename, bufopts('LSP Rename'))
                vim.keymap.set('n', 'grr', vim.lsp.buf.references, bufopts('LSP References'))
                -- Custom lsp keymaps.
                vim.keymap.set('n', 'grd', vim.lsp.buf.definition, bufopts('LSP Go to Definition'))
                vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, bufopts('LSP Go to Declaration'))
                vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, bufopts('LSP Go to Implementation'))
                vim.keymap.set('n', 'grf', function()
                    vim.lsp.buf.format({ async = true })
                end, bufopts('LSP Formatting'))
                vim.keymap.set('n', 'grk', vim.lsp.buf.signature_help, bufopts('LSP Singature Help'))
                vim.keymap.set('n', 'grs', vim.lsp.buf.document_symbol, bufopts('LSP Document Symbols'))
                vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, bufopts('LSP Type Definition'))
                vim.keymap.set('n', 'grwa', vim.lsp.buf.add_workspace_folder, bufopts('LSP Add Workspace Folder'))
                vim.keymap.set('n', 'grwr', vim.lsp.buf.remove_workspace_folder, bufopts('LSP Remove Workspace Folder'))
                vim.keymap.set('n', 'grwl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts('LSP List Workspace Folder'))

                -- Get client
                local client = vim.lsp.get_client_by_id(ev.data.client_id)

                -- inlay hints
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true)
                else
                    vim.lsp.inlay_hint.enable(false)
                end

                -- ╭────────────╮
                -- │ NVIM-NAVIC │
                -- ╰────────────╯
                -- if client.server_capabilities.documentSymbolProvider then vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
                --     navic.attach(client, ev.buf)
                -- end
            end,
        })


        -- lsp window borders
        --------------------------------------------------------------------------------
        local border = {
            { '┌', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '┐', 'FloatBorder' },
            { '│', 'FloatBorder' },
            { '┘', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '└', 'FloatBorder' },
            { '│', 'FloatBorder' },
        }

        local handlers = { 
            ['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = border }
            ),
            ['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = border }
            ),
        }

        --------------------------------------------------------------------------------------------------------------
        -- language servers
        --------------------------------------------------------------------------------------------------------------

        -- javascript / typescript
        -- https://github.com/typescript-language-server/typescript-language-server
        -- npm install -g typescript typescript-language-server
        ------------------------------------------------------------------------------------------
        lspconfig.tsserver.setup({
            handlers = handlers,
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
            -- on_attach = function(client, bufnr)
            --     client.server_capabilities.document_formatting = false
            --     client.server_capabilities.document_range_formatting = false
            --     on_attach(client, bufnr)
            -- end,
        })


        -- json
        -- https://github.com/hrsh7th/vscode-langservers-extracted
        -- npm i -g vscode-langservers-extracted
        ------------------------------------------------------------------------------------------
        lspconfig.jsonls.setup({
            handlers = handlers,
            filetypes = { 'json', 'jsonc' },
            init_options = {
                provideFormatter = true,
            },
        })

        -- html
        -- https://github.com/hrsh7th/vscode-langservers-extracted
        -- npm i -g vscode-langservers-extracted
        ------------------------------------------------------------------------------------------
        lspconfig.html.setup({
            handlers = handlers,
            settigns = {
                css = {
                    lint = {
                        validProperties = {},
                    },
                },
            },
        })

        -- yaml
        -- ls: https://github.com/redhat-developer/yaml-language-server
        -- yarn global add yaml-language-server
        ------------------------------------------------------------------------------------------
        lspconfig.yamlls.setup({
            handlers = handlers,
            settings = {
                yaml = {
                    validate = true,
                    hover = true,
                    completion = true,
                    format = {
                        enable = true,
                        singleQuote = true,
                        bracketSpacing = true,
                    },
                    editor = {
                        tabSize = 2,
                    },
                    schemaStore = {
                        enable = true,
                    },
                },
                editor = {
                    tabSize = 2,
                },
            },
        })
    end
}
