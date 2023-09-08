-- Highlight colors such as #315fff or #f8f or Aqua.
return {
    'norcalli/nvim-colorizer.lua',
    config = function()
        require('colorizer').setup()
    end,
}
