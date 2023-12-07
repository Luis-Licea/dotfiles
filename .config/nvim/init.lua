-- Import custom modules.
local Path = require('Path')


--------------------------------------------------------------------------------
-- Ungrouped Mappings.
--------------------------------------------------------------------------------
-- Leader Mapping.
vim.g.mapleader = ' '
-- Local Leader Mapping.
vim.g.maplocalleader = ';'

require('mappings')
require('auto-commands')
require('template-loader')
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
