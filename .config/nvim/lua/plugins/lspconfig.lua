-- Ensure lspconfig servers are installed.
return {
    'neovim/nvim-lspconfig',
    -- Configurations for Nvim LSP.
    dependencies = 'williamboman/mason-lspconfig.nvim',
    config = function()
        local set = vim.keymap.set
        require('mason-lspconfig').setup({
            -- Install servers set up via lspconfig.
            automatic_installation = true,
        })

        --------------------------------------------------------------------------------
        -- Nvim LspConfig.
        --------------------------------------------------------------------------------
        vim.lsp.handlers['textDocument/hover'] =
            vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

        -- Mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        local opts = { noremap = true, silent = true }
        set('n', '<leader>e', vim.diagnostic.open_float, opts)
        set('n', '[d', vim.diagnostic.goto_prev, opts)
        set('n', ']d', vim.diagnostic.goto_next, opts)
        -- nmap <buffer> [g <plug>(lsp-previous-diagnostic)
        -- nmap <buffer> ]g <plug>(lsp-next-diagnostic)
        set('n', '<leader>L', vim.diagnostic.setloclist, opts)
        set('n', '<leader>Q', vim.diagnostic.setqflist, opts)

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            set('n', 'gd', vim.lsp.buf.definition, bufopts)
            -- set('n', 'K', vim.lsp.buf.hover, bufopts)
            set('n', '<space>K', vim.lsp.buf.hover, bufopts)

            set('n', '<space>gi', vim.lsp.buf.implementation, bufopts)
            -- set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
            set('n', 'gs', vim.lsp.buf.document_symbol, bufopts)
            set('n', 'gS', vim.lsp.buf.workspace_symbol, bufopts)
            set('n', '<leader><s-s>', vim.lsp.buf.signature_help, bufopts)
            -- set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            -- set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            -- set('n', '<leader>wl', function()
            -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, bufopts)
            set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
            set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
            set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
            set('x', '<leader>ca', vim.lsp.buf.code_action, bufopts)
            set('n', '<C-.>', vim.lsp.buf.code_action, bufopts)
            set('n', 'gr', vim.lsp.buf.references, bufopts)
            set('n', '<c-a>', vim.lsp.buf.code_action, bufopts)
            -- Use gq for LPS formatting and gw for regular formatting.
            set('x', '<leader>f', vim.lsp.buf.format, bufopts)
            vim.api.nvim_create_user_command('FormatDocument', function()
                vim.lsp.buf.format()
            end, {
                nargs = 0,
                desc = 'Format the document to fix indentation and spacing issues',
            })
        end

        --------------------------------------------------------------------------------
        -- Language servers.
        --------------------------------------------------------------------------------
        local servers = {
            'awk_ls', -- AWK
            'bashls', -- Bash
            'clangd', -- C/C++
            'neocmake', -- CMake
            'cssls', -- CSS
            -- 'dockerls', -- Docker
            'eslint', -- JavaScript, TypeScript; Linter needs .eslintrc.yml.
            'groovyls', -- Groovy
            'html', -- HTML
            -- 'jdtls', -- Java
            -- 'java-debug-adapter' -- Java
            -- 'java-language-server' -- Java
            -- 'java-test' -- Java
            'jsonls', -- JSON
            'ltex',
            'marksman', -- Markdown
            -- 'phpactor', -- PHP
            'pyright',
            'rust_analyzer', -- Rust
            -- 'sqls', -- SQL
            'taplo', -- TOML
            'texlab', -- LaTeX
            'tsserver', -- JavaScript, TypeScript; LSP functionality.
            'typst_lsp', -- Typst
        }

        -- Enable (broadcasting) snippet capability for completion.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

        capabilities.textDocument.completion.completionItem.snippetSupport = true

        local lspconfig = require('lspconfig')

        for _, server in ipairs(servers) do
            lspconfig[server].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        lspconfig.yamlls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                yaml = {
                    schemas = {
                        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
                        -- ["../path/relative/to/file.yml"] = "/.github/workflows/*"
                        -- ["/path/from/root/of/project"] = "/.github/workflows/*"
                    },
                },
            },
        })

        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file('', true),
                        -- Don't ask to configure workspace for luassert, luv, etc.
                        checkThirdParty = false,
                    },
                    -- Do not send telemetry data containing a randomized but unique
                    -- identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end,
}
