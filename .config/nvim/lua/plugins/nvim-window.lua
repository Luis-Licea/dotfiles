-- Window picker for using with Dap UI because it opens many windows.
return {
    'https://gitlab.com/yorickpeterse/nvim-window',
    config = function()
        local window = require('nvim-window')
        local set = vim.keymap.set
        window.setup({
            -- The characters available for hinting windows.
            chars = {
                '1',
                '2',
                '3',
                '4',
                '5',
                '6',
                '7',
                '8',
                '9',
                '0',
                'k',
                'l',
                'm',
                'n',
                'o',
                'p',
                'q',
                'r',
                's',
                't',
                'u',
                'v',
                'w',
                'x',
                'y',
                'z',
            },
            -- The border style to use for the floating window.
            border = 'rounded',
        })
        set('n', '<leader><leader>', window.pick, {noremap = true})
    end,

}
