-- Context-aware comment plugin.
return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({
            -- LHS of toggle mappings in NORMAL mode.
            toggler = {
                line = '<C-/>', -- Line-comment toggle keymap.
                block = 'gbc', -- Block-comment toggle keymap.
            },
            -- LHS of operator-pending mappings in NORMAL and VISUAL mode.
            opleader = {
                line = '<C-/>', -- Line-comment keymap.
                block = 'gb', -- Block-comment keymap.
            },
            -- Enable keybindings: `false` to not create mappings
            mappings = { basic = true, extra = false },
        })
    end,
}
