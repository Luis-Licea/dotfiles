local term_opnes_group = vim.api.nvim_create_augroup('Terminal Opens Group', {})

-- Turn off spelling in terminal.
vim.api.nvim_create_autocmd('TermOpen', {
    group = term_opnes_group,
    pattern = '*',
    command = 'setlocal nospell',
})

-- Disable line numbering in terminal.
vim.api.nvim_create_autocmd('TermOpen', {
    group = term_opnes_group,
    pattern = '*',
    command = 'setlocal nonumber',
})

-- Press escape twice to exit. Add only to zsh because it conflicts with fzf.
-- Press ctrl+q to scroll freely in terminal, as opposed to ctrl+\ ctrl+n.
vim.api.nvim_create_autocmd('TermOpen', {
    group = term_opnes_group,
    pattern = '*',
    command = 'if expand("%:t") == "zsh" | tnoremap <c-q> <c-\\><c-n> | endif',
})

local buffer_check_group = vim.api.nvim_create_augroup('Check Buffer Group', {})

-- Resize windows equally when the window size changes.
vim.api.nvim_create_autocmd('VimResized', {
    group = buffer_check_group,
    pattern = '*',
    command = 'wincmd =',
})
-- Reload config file on change.
vim.api.nvim_create_autocmd('BufWritePost', {
    group = buffer_check_group,
    pattern = vim.env.MYVIMRC,
    command = 'source %',
})

-- Highlight yanks.
vim.api.nvim_create_autocmd('TextYankPost', {
    group = buffer_check_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})

-- Start terminal in insert mode.
vim.api.nvim_create_autocmd('TermOpen', {
    group = buffer_check_group,
    pattern = '*',
    command = 'startinsert | set winfixheight',
})

-- Start git messages in insert mode. Set color-column relative to
-- text-width.
vim.api.nvim_create_autocmd('FileType', {
    group = buffer_check_group,
    pattern = { 'gitcommit' },
    command = 'startinsert | 1 | setlocal colorcolumn=+1',
})

-- Remember file position.
vim.api.nvim_create_autocmd('BufReadPost', {
    group = buffer_check_group,
    pattern = '*',
    callback = function()
        if vim.fn.line('\'"') > 0 and vim.fn.line('\'"') <= vim.fn.line('$') then
            vim.fn.setpos('.', vim.fn.getpos('\'"'))
        end
    end,
})

-- Quit overly large files before loading them to avoid slowness.
vim.api.nvim_create_autocmd('BufReadPre', {
    group = buffer_check_group,
    pattern = '*',
    callback = function()
        local fsize = vim.fn.getfsize(vim.fn.expand('%:p:f'))
        local mega_byte = 1024 * 1024
        if fsize > 5 * mega_byte then
            vim.ui.input(
                { prompt = 'File exceeds recommended file size. Continue [y/n]? ' },
                function(input)
                    if input ~= 'y' then
                        vim.cmd('quit')
                    end
                end
            )
        end
    end,
})

-- Turn off syntax highlighting that conflicts with treesitter.
-- vim.api.nvim_create_autocmd('BufEnter', {
--     group = buffer_check_group,
--     pattern = '*',
--     callback = function()
--         local noSyntaxFor = {
--             lua = true,
--             markdown = true,
--             sh = true,
--             json = true,
--             -- yaml = true,
--             python = true,
--             c = true,
--             cpp = true,
--             rust = true,
--             tex = true,
--         }
--         local noTreeSitterFor = { gitcommit = true }
--         if noSyntaxFor[vim.bo.filetype] then
--             vim.bo.syntax = false
--         end
--         if noTreeSitterFor[vim.bo.filetype] then
--             vim.cmd('TSBufDisable highlight')
--         end
--     end,
-- })

local xresources_group = vim.api.nvim_create_augroup('Xresources Group', {})
-- Apply .Xresources file after editing the file.
vim.api.nvim_create_autocmd('BufWritePost', {
    group = xresources_group,
    pattern = '.Xresources',
    callback = function()
        vim.fn.execute('!xrdb && xrdb -merge ~/.Xresources')
    end,
})

local cpp_group = vim.api.nvim_create_augroup('C++ Group', {})

-- C++ and Nix code settings.
vim.api.nvim_create_autocmd('FileType', {
    group = cpp_group,
    pattern = {
        'cpp',
        'dart',
        'nix',
        'toml',
    },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.tabstop = 2
    end,
})
