-- Related: ./nvim-dap.lua
return {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'williamboman/mason.nvim',
        'nvim-lua/plenary.nvim',
        'jay-babu/mason-null-ls.nvim',
    },
    config = function()
        local programs = {
            'black', -- Python formatter.
            'checkstyle', -- Java linter.
            'cmakelang', -- CMake linter.
            'flake8', -- Python linter.
            'google-java-format', -- Java formatter.
            'isort', -- Python formatter.
            'jq', -- JSON formatter.
            'perlnavigator', -- Perl linter.
            'prettier', -- Markdown formatter.
            'ruff', -- Python linter.
            'shellcheck', -- Bash linter.
            'shellharden', -- Bash linter, formatter.
            'shfmt', -- Bash formatter.
            'stylua', -- Lua formatter.

            -- Debug adapters.
            'bash-debug-adpater', -- Bash, Sh.
            'cpptools', -- C++, C, Rust.
            'debugpy', -- Python.
            'js-debug-adapter', -- JavaScript, TypeScript.
        }
        local not_installed = {}
        for _, program in ipairs(programs) do
            if vim.fn.executable(program) == 0 then
                table.insert(not_installed, program)
            end
        end
        -- Automatically install linters, formatters, and debug adapters.
        require('mason-null-ls').setup({ ensure_installed = not_installed })

        local null_ls = require('null-ls')
        null_ls.setup({
            diagnostics_format = '[#{s}] (#{c}) #{m}',
            sources = {
                ------------------------------------------------------------
                -- Problematic.
                ------------------------------------------------------------
                -- Is not very useful.
                -- null_ls.builtins.hover.printenv,
                -- Refactoring for JavaScript and TypeScript, but doesn't work.
                -- null_ls.builtins.code_actions.refactoring,
                -- Useful but may leak information.
                -- null_ls.builtins.hover.dictionary,
                -- No visible changes.
                -- null_ls.builtins.code_actions.cspell,
                -- For Markdown and LaTeX: Not very useful.
                -- null_ls.builtins.diagnostics.proselint,
                -- null_ls.builtins.code_actions.proselint,
                -- This functionality is provided by the "snowball" plugin.
                -- null_ls.builtins.diagnostics.trail_space,
                -- I don't even know what this does.
                -- null_ls.builtins.code_actions.ltrs,
                -- Not mature. Use StyLua.
                -- null_ls.builtins.diagnostics.selene,
                -- Tags need to be manually created with ctags -R.
                -- null_ls.builtins.completion.tags,
                -- Already provided by cmp_luasnip and luasnip plugins.
                -- null_ls.builtins.completion.luasnip,
                -- Does not have as many options as shfmt.
                -- null_ls.builtins.formatting.beautysh,
                -- Provide text auto completion.
                -- null_ls.builtins.completion.spell,
                -- nixfmt is slow and does not use an AST for formatting.
                -- null_ls.builtins.formatting.nixfmt,
                -- nixpkgs_fmt does not use an AST for formatting.
                -- null_ls.builtins.formatting.nixpkgs_fmt,

                -- Python.
                null_ls.builtins.formatting.isort,
                null_ls.builtins.diagnostics.ruff,
                null_ls.builtins.diagnostics.flake8,

                -- Groovy
                -- null_ls.builtins.diagnostics.npm_groovy_lint,
                -- null_ls.builtins.formatting.npm_groovy_lint,

                ------------------------------------------------------------
                -- Useful.
                ------------------------------------------------------------
                -- Add action to preview, reset, select, and stage hunks.
                null_ls.builtins.code_actions.gitsigns,
                -- Auto-complete CMake commands and keywords.
                null_ls.builtins.diagnostics.cmake_lint,
                -- Show Python lint errors.
                null_ls.builtins.diagnostics.pylint.with({
                    -- Do not save code analysis to ~/.cache/pylint.
                    extra_args = { '--persistent', 'n' },
                    dynamic_command = function()
                        local command = { 'pylint' }
                        local environment = os.getenv('VIRTUAL_ENV')
                        if environment then
                            command = { 'python3', '-m', 'pylint' }
                            if vim.fn.executable(environment .. '/bin/pylint') == 0 then
                                error(
                                    'Pylint is not installed in the virtualenv. Run `pip install pylint`.'
                                )
                            end
                        end
                        return command
                    end,
                }),
                -- Show messages when bad indentation occurs.
                null_ls.builtins.formatting.cmake_format,
                -- Format Lua files based on .stylua.toml file.
                null_ls.builtins.formatting.stylua.with({
                    extra_args = {
                        '--column-width',
                        '100',
                        '--quote-style',
                        'AutoPreferSingle',
                    },
                }),
                -- Format Python code and comments consistently.
                null_ls.builtins.formatting.black.with({
                    extra_args = { '--line-length', '100' },
                }),

                -- Bash code actions.
                null_ls.builtins.code_actions.shellcheck,
                null_ls.builtins.diagnostics.shellcheck,

                -- Use either shfmt or shellharden for formatting, not both.

                -- Bash, Msh, Shell formatter. Format spacing, does not add
                -- quotes around variables.
                null_ls.builtins.formatting.shfmt.with({
                    extra_args = { '--indent', '2', '--case-indent', '--binary-next-line' },
                }),
                -- Shell. Format spacing and add quotes around variables.
                -- Stricter than shfmt.
                -- null_ls.builtins.formatting.shellharden,

                -- Nix formatting.
                null_ls.builtins.diagnostics.statix,
                null_ls.builtins.code_actions.statix,
                null_ls.builtins.formatting.alejandra,

                -- Formats Markdown tables.
                null_ls.builtins.formatting.prettier.with({
                    filetypes = {
                        -- 'javascript',
                        -- 'javascriptreact',
                        -- 'typescript',
                        -- 'typescriptreact',
                        'vue',
                        'css',
                        'scss',
                        'less',
                        -- 'html',
                        'json',
                        'jsonc',
                        'yaml',
                        'markdown',
                        'markdown.mdx',
                        'graphql',
                        'handlebars',
                    },
                }),

                -- Java linter.
                null_ls.builtins.diagnostics.checkstyle.with({
                    extra_args = { '-c', '/google_checks.xml' }, -- or "/sun_checks.xml" or path to self written rules
                }),
                -- Java formatter.
                null_ls.builtins.formatting.google_java_format,
            },
            -- Set correct encoding to avoid gitsigns warning: multiple
            -- different client offset_encodings detected for buffer, this
            -- is not supported yet.
            on_init = function(new_client, _)
                if vim.bo.filetype == 'cpp' then
                    new_client.offset_encoding = 'utf-8'
                end
            end,
        })
    end,
}
