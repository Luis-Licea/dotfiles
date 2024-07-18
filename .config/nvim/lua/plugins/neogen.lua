-- Add JSDoc, Doxygen, etc support.
return {
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    cmd = 'Neogen',
    keys = {
        {
            '<leader>nf',
            function()
                require('neogen').generate({ type = 'func' })
            end,
        },
    },
    config = function()
        require('neogen').setup({
            snippet_engine = 'luasnip',
            languages = {
                lua = {
                    template = {
                        annotation_convention = 'ldoc',
                    },
                },
                python = {
                    template = {
                        annotation_convention = 'google_docstrings',
                    },
                },
                rust = {
                    template = {
                        annotation_convention = 'rustdoc',
                    },
                },
                javascript = {
                    template = {
                        annotation_convention = 'jsdoc',
                    },
                },
                typescript = {
                    template = {
                        annotation_convention = 'tsdoc',
                    },
                },
                typescriptreact = {
                    template = {
                        annotation_convention = 'tsdoc',
                    },
                },
            },
        })
    end,
}
