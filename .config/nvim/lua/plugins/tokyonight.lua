-- Tokyo night color scheme.
return {
    'folke/tokyonight.nvim',
    config = function()
        -- vim.cmd.colorscheme('lunaperche')
        -- vim.cmd.colorscheme('habamax')
        require('tokyonight').setup({
            style = 'moon',
            -- Enable this to disable setting the background color.
            transparent = true,
            styles = {
                -- Background styles. Can be "dark", "transparent" or "normal".
                sidebars = 'transparent', -- Style for sidebars.
                floats = 'transparent', -- Style for floating windows
            },
        })
        require('tokyonight').colorscheme()
    end,
}
