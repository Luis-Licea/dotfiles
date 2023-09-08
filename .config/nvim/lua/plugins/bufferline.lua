-- View open buffers and tabs in the top row.
return {
    'akinsho/bufferline.nvim',
    config = function()
        require('bufferline').setup({
            options = {
                numbers = 'ordinal',
                -- diagnostics = 'nvim_lsp',
                show_buffer_close_icons = false,
                -- show_close_icon = false,
            },
        })

        local set = vim.keymap.set
        local noremap = { noremap = true }
        local function got_to_buffer(number)
            require('bufferline').go_to_buffer(number, true)
        end

        -- Go to buffer by number.
        set('n', '<leader>1', function()
            got_to_buffer(1)
        end, noremap)
        set('n', '<leader>2', function()
            got_to_buffer(2)
        end, noremap)
        set('n', '<leader>3', function()
            got_to_buffer(3)
        end, noremap)
        set('n', '<leader>4', function()
            got_to_buffer(4)
        end, noremap)
        set('n', '<leader>5', function()
            got_to_buffer(5)
        end, noremap)
        set('n', '<leader>6', function()
            got_to_buffer(6)
        end, noremap)
        set('n', '<leader>7', function()
            got_to_buffer(7)
        end, noremap)
        set('n', '<leader>8', function()
            got_to_buffer(8)
        end, noremap)
        set('n', '<leader>9', function()
            got_to_buffer(9)
        end, noremap)
        set('n', '<leader>0', function()
            got_to_buffer(10)
        end, noremap)
    end,
    dependencies = 'kyazdani42/nvim-web-devicons',
}
