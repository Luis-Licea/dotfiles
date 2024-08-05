-- Ensure lspconfig servers are installed.
return {
    'neovim/nvim-lspconfig',
    -- Configurations for Nvim LSP.
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'b0o/schemastore.nvim' },
    config = function()
        local set = vim.keymap.set

        local servers = {
            -- 'java-test' -- Java?
            -- awk_ls = 'awk-language-server', -- AWK
            -- clangd = 'clangd', -- C/C++
            -- dockerls = 'dockerls', -- Docker
            -- groovyls = 'groovyls', -- Groovy
            -- java_debug_adapter = -- 'java-debug-adapter' -- Java?
            -- java_language_server = 'java-language-server' -- Java
            -- jdtls = 'jdtls', -- Java
            -- ltex = 'ltex-ls', -- Tex and Markdown spell checking. Note: It uses a lot of RAM.
            -- phpactor = 'phpactor', -- PHP
            -- sqls = 'sqls', -- SQL

            perlnavigator = 'perlnavigator',
            bashls = 'bashls', -- Bash
            ccls = 'ccls', -- C/C++
            cssls = 'cssls', -- CSS
            eslint = 'eslint', -- JavaScript, TypeScript; Linter needs .eslintrc.yml.
            html = 'html', -- HTML
            jsonls = 'jsonls', -- JSON
            lua_ls = 'lua-language-server', -- Lua
            marksman = 'marksman', -- Markdown language server; Provides TOC code action, and help with Markdown links, and references, not spelling.
            neocmake = 'neocmakelsp', -- CMake
            nil_ls = 'nil', -- Nix language server.
            nixd = 'nixd', -- Nix language server.
            pyright = 'pyright',
            rust_analyzer = 'rust-analyzer', -- Rust
            taplo = 'taplo', -- TOML
            texlab = 'texlab', -- LaTeX
            tsserver = 'tsserver', -- JavaScript, TypeScript; LSP functionality.
            typst_lsp = 'typst-lsp', -- Typst
            yamlls = 'yaml-language-server', -- YAML
        }
        local not_installed = {}
        for configuration, server in pairs(servers) do
            if vim.fn.executable(server) == 0 then
                table.insert(not_installed, configuration)
            end
        end

        -- Install servers via lspconfig.
        require('mason-lspconfig').setup({ ensure_installed = not_installed })

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
        -- Enable (broadcasting) snippet capability for completion.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

        capabilities.textDocument.completion.completionItem.snippetSupport = true

        local lspconfig = require('lspconfig')

        -- Ignore these servers.
        servers.lua_ls = nil
        servers.jsonls = nil

        for server, _ in pairs(servers) do
            lspconfig[server].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        lspconfig.jsonls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                -- Completion support when typing "$schema: ..." in JSON files.
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        lspconfig.lua_ls.setup({
            cmd = { 'lua-language-server', '--logpath=/tmp/lua_language_server' },
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
