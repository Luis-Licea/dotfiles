--------------------------------------------------------------------------------
-- Feline.
--------------------------------------------------------------------------------
-- Prettify status line.
return {
    'feline-nvim/feline.nvim',
    -- Show trailing spaces and mixed indents in Feline.
    dependencies = 'stumash/snowball.nvim',
    config = function()
        local snowball = require('snowball')
        snowball.setup({ labels = snowball.labels_alternate })
        require('feline').setup({
            custom_providers = { [snowball.provider_name] = snowball.provider },
            components = snowball.reverse_scroll_bar(
                snowball.add_whitespace_component(require('feline.default_components').statusline.icons)
            ),
        })
    end
}
