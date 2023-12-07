local Table = require('Table')
local key = require('Key')

local nnoremap = key.nnoremap

local console = nil
if vim.fn.executable('alacritty') == 1 then
    console = { 'alacritty', '--working-directory' }
elseif vim.fn.executable('konsole') == 1 then
    console = { 'konsole', '--workdir' }
end

if console then
    function NewTerminal()
        local path = vim.fn.expand('%:p:h')
        vim.fn.system(Table.merge('setsid', '--fork', console, path))
    end

    function NewRanger()
        local path = vim.fn.expand('%:p:h')
        vim.fn.system(Table.merge('setsid', '--fork', console, path, '-e', 'ranger'))
    end

    -- Spawn a new terminal in the folder of the current file.
    nnoremap('<leader>nt', NewTerminal)
    -- Spawn a new ranger terminal in the folder of the current file.
    nnoremap('<leader>nr', NewRanger)

    vim.api.nvim_create_user_command(
        'Nt',
        NewTerminal,
        { nargs = 0, desc = 'Launch a new terminal.' }
    )
    vim.api.nvim_create_user_command(
        'Nr',
        NewRanger,
        { nargs = 0, desc = 'Launch a new ranger terminal.' }
    )
end

return console
