-- Completion plugin.
return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        -- Completion sources.
        'f3fora/cmp-spell',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-emoji',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'octaltree/cmp-look',
        -- Icons before source names.
        'onsails/lspkind.nvim',

        -- Set luasnip.
        'saadparwaiz1/cmp_luasnip',
        -- Code snippets. Needed by cmp-vim.
        'L3MON4D3/LuaSnip',
    },
    config = function()
        --------------------------------------------------------------------------------
        -- Completion.
        --------------------------------------------------------------------------------
        local t = function(str)
            return vim.api.nvim_replace_termcodes(str, true, true, true)
        end

        local cmp = require('cmp')

        cmp.setup({
            snippet = {
                -- NOTE: You must specify a snippet engine.
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                format = function(entry, vim_item)
                    -- Fancy icons and a name of kind.
                    vim_item.kind = require('lspkind').presets.default[vim_item.kind]
                        .. ' '
                        .. vim_item.kind

                    -- Set a name for each source.
                    vim_item.menu = ({
                        calc = '[Calc]',
                        emoji = '[Emoji]',
                        look = '[Look]',
                        luasnip = '[Snip]',
                        nvim_lsp = '[LSP]',
                        nvim_lsp_signature_help = '[Signature]',
                        nvim_lua = '[Lua]',
                        path = '[Path]',
                        spell = '[Spell]',
                    })[entry.source.name]
                    return vim_item
                end,
            },
            mapping = {
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                -- ['<Esc>'] = cmp.mapping.close(),

                ['<Esc>'] = cmp.mapping(function(fallback)
                    if vim.fn.pumvisible() == 1 then
                        vim.fn.feedkeys(t('<Esc><Esc>'), 'n')
                    else
                        fallback()
                    end
                end, { 'i' }), -- Only apply in insert mode, not "s".

                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
            },
            sources = {
                { name = 'calc' }, -- Source for math calculation.
                { name = 'emoji' },
                { name = 'look' },
                { name = 'luasnip' }, -- Snippets.
                { name = 'nvim_lsp' }, -- Language server.
                { name = 'nvim_lsp_signature_help' }, -- Display function signatures with current parameter emphasized.
                { name = 'nvim_lua', keyword_length = 2 }, -- Complete neovim's Lua runtime API such vim.lsp.*.
                { name = 'path' }, -- File paths.
                { name = 'spell', keyword_length = 4 },
            },
            -- menuone: popup even when there's only one match
            -- noinsert: Do not insert text until a selection is made
            -- noselect: Do not select, force to select one from the menu
            completion = { completeopt = 'menu,menuone,noinsert,noselect' },
        })

        -- local entries = { entries = { name = 'wildmenu', separator = ' ' } }
        -- local entries  = { name = 'custom', selection_order = 'near_cursor' }
        local entries = { name = 'custom' }
        local mappings = {
            ['<C-j>'] = { c = cmp.mapping.select_next_item() },
            ['<C-k>'] = { c = cmp.mapping.select_prev_item() },
            ['<Tab>'] = { c = cmp.mapping.select_next_item() },
            ['<S-Tab>'] = { c = cmp.mapping.select_prev_item() },
            -- ['<CR>'] = { c = cmp.mapping.confirm({
            -- behavior = cmp.ConfirmBehavior.Insert,
            -- select = true
            -- })},
            ['<Esc>'] = { c = cmp.mapping.close() },
            -- ['<Tab>'] = { c = cmp.mapping.confirm({
            -- behavior = cmp.ConfirmBehavior.Insert,
            -- select = true
            -- })},
        }

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            view = { entries = entries },
            mapping = cmp.mapping.preset.cmdline(mappings),
            sources = {
                { name = 'buffer' }, -- Source text in current buffer.
            },
            completion = { completeopt = 'menu,menuone,noinsert,noselect' },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            view = { entries = entries },
            mapping = cmp.mapping.preset.cmdline(mappings),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                -- Remove cmp-cmdline from global sources because it will produce
                -- errors, so add cmp-cmdline for the cmdline setup function.
                { name = 'cmdline' },
            }),
            completion = { completeopt = 'menu,menuone,noinsert,noselect' },
        })
    end,
}
