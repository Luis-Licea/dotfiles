-- Import custom modules.
local Path = require('Path')
local Table = require('Table')


--------------------------------------------------------------------------------
-- Ungrouped Mappings.
--------------------------------------------------------------------------------
-- Leader Mapping.
vim.g.mapleader = ' '
-- Local Leader Mapping.
vim.g.maplocalleader = ';'

require('mappings')

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
    pattern = { 'nix', 'cpp', 'toml' },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.tabstop = 2
    end,
})

--------------------------------------------------------------------------------
-- Load templates for newly created files.
--------------------------------------------------------------------------------
local template_group = vim.api.nvim_create_augroup('Template Group', {})

---Load a template in the current buffer. The template will be determined
---based on the file extension and the file name.
---@param name string? The path to the template to load.
local function LoadTemplateFromType(name)
    -- The place where the templates are saved.
    local templateDir = vim.fn.expand('~/.config/nvim/templates/')

    -- The path to the template to with the same file extension.
    -- Examples: skeleton.c, skeleton.html, skeleton.awk, etc.
    local pathSameExt = templateDir .. 'skeleton.' .. vim.fn.expand('%:e')

    -- The path to the template to with the same file name.
    local pathSameName = templateDir .. vim.fn.expand('%:t')

    -- The path to the template to load.
    local template = nil

    -- Check if the template has the same file name or extension.
    for _, path in ipairs({ pathSameExt, pathSameName }) do
        if vim.fn.filereadable(path) == 1 then
            template = path
        end
    end

    -- Override the template path if a template name is given.
    if name then
        template = name
    end

    if template then
        vim.fn.execute('0r ' .. template)
    end
end

vim.api.nvim_create_user_command('LoadTemplate', function(opts)
    LoadTemplateFromType(opts.args)
end, {
    nargs = '*',
    complete = function()
        local regular_templates = vim.api.nvim_get_runtime_file('templates/*', true)
        local hidden_templates = vim.api.nvim_get_runtime_file('templates/.*', true)
        -- Remove the "." directory.
        table.remove(hidden_templates, 1)
        -- Remove the ".." directory.
        table.remove(hidden_templates, 1)
        return Table.merge(regular_templates, hidden_templates)
    end,
    desc = 'Load the given template',
})

local function ChooseTemplate()
    local regular_templates = vim.api.nvim_get_runtime_file('templates/**', true)
    local hidden_templates = vim.api.nvim_get_runtime_file('templates/**/.*', true)
    local templates = {}
    for _, path in ipairs(Table.merge(hidden_templates, regular_templates)) do
        local tail = vim.fs.basename(path)
        -- Do not include special "." and ".." directories.
        if tail ~= '.' and tail ~= '..' and vim.fn.isdirectory(path) == 0 then
            table.insert(templates, path)
        end
    end
    vim.ui.select(templates, { prompt = 'Select template to load into file:' }, function(choice)
        LoadTemplateFromType(choice)
    end)
end

vim.api.nvim_create_user_command(
    'ChooseTemplate',
    ChooseTemplate,
    { nargs = 0, desc = 'Chose a template and load it into the buffer.' }
)

-- Load a template if one is available when creating a file.
vim.api.nvim_create_autocmd('BufNewFile', {
    group = template_group,
    pattern = '*',
    callback = function()
        LoadTemplateFromType(nil)
    end,
})

require('runner')

--------------------------------------------------------------------------------
-- Interface.
--------------------------------------------------------------------------------
-- Share clipboard with operating system.
vim.o.clipboard = 'unnamedplus'
-- Reminder to keep lines at most 80, 120 characters long.
vim.o.colorcolumn = '81,101,121'
-- Enable mouse wheel in normal modes.
vim.o.mouse = 'a'
-- Support true color in vim.
vim.o.termguicolors = true
-- Hide quotes in JSON files.
vim.o.conceallevel = 1
-- When using gq, wrap the line at this many characters.
vim.o.textwidth = 80

--------------------------------------------------------------------------------
-- Tabs & spaces.
--------------------------------------------------------------------------------
-- Tells vim to replace tabs with spaces.
vim.o.expandtab = true
-- Control how text is indented when using << and >>.
vim.o.shiftwidth = 4
-- Mixes tabs and spaces unless equal to tabstop.
vim.o.softtabstop = 4
-- Tell vim how many columns a tab counts for.
vim.o.tabstop = 4

--------------------------------------------------------------------------------
-- Other.
--------------------------------------------------------------------------------
-- Treat keybindings the same when using a different keyboard layout.
vim.o.langmap =
    'йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:\'"zZxXcCvVbBnNmM\\,<.>?'
-- Open history file using :q.
vim.o.history = 200
-- Ignore case in search patterns.
vim.o.ignorecase = true
-- Search queries intelligently using case. Only used if ignorecase is on.
vim.o.smartcase = vim.o.ignorecase
-- Set spelling on.
vim.o.spell = true
-- Define tab and trailing space characters.
vim.opt.listchars = {
    tab = '◃―▹',
    trail = '●',
    extends = '◣',
    precedes = '◢',
    nbsp = '○',
    -- eol = '↴',
    -- space = '⋅',
}
-- Show tabs and trailing spaces.
vim.o.list = true
-- Add indentation when S or cc is pressed.
vim.o.cindent = true
-- Change cwd to file's directory.
-- vim.o.autochdir = true
vim.o.shell = Path.first_execuable({ '/usr/bin/zsh', '/usr/bin/bash', '/usr/bin/nu' })
vim.opt.undodir = '/tmp/'
vim.opt.shada = ''
vim.opt.shadafile = 'NONE'

--------------------------------------------------------------------------------
-- File finder.
--------------------------------------------------------------------------------
-- Looks into subfolders to find and open a file. :find filename - finds the
-- file in subfolders. Press Tab for suggesting files. Use * as a wild card for
-- beginnings or endings.
vim.o.path = vim.o.path .. '**'

--------------------------------------------------------------------------------
-- Plugins.
--------------------------------------------------------------------------------

-- Bootsrap lazy.nvim.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
    print('Installed lazy.nvim. Reopen Neovim.')
else
    vim.opt.rtp:prepend(lazypath)
    -- Load plugins from files that match the pattern "lua/plugins/*.lua".
    require('lazy').setup('plugins', {
        change_detection = {
            -- Automatically check for configuration changes and reload the UI.
            enabled = true,
            notify = false,
        },
    })
end
