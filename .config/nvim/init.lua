-- Import custom modules.
local Path = require('Path')

--------------------------------------------------------------------------------
-- Essential Mappings.
--------------------------------------------------------------------------------
-- Leader Mapping.
vim.g.mapleader = ' '
-- Local Leader Mapping.
vim.g.maplocalleader = ';'

-- Disable providers for faster startup.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

--------------------------------------------------------------------------------
-- Change temporary file locations.
--------------------------------------------------------------------------------
local tmp_dir = '/tmp'
vim.fn.setenv('XDG_STATE_HOME', tmp_dir)

local state_dir = tmp_dir .. '/nvim'
-- Change undo directory.
vim.opt.undodir = state_dir .. '/undo'
-- Keep track of my undos between sessions.
vim.opt.undofile = true
-- Change swapfile directory.
vim.opt.directory = state_dir .. '/swap'
-- Change log file path.
-- vim.fn.setenv('NVIM_LOG_FILE', statedir .. '/log')
-- Create share data file.
-- vim.opt.shadafile = 'NONE'

--------------------------------------------------------------------------------
-- Interface.
--------------------------------------------------------------------------------
-- Share clipboard with operating system.
vim.o.clipboard = 'unnamedplus'
-- Reminder to keep lines at most 80, 120 characters long.
vim.o.colorcolumn = '81,101,121'
-- Enable mouse wheel .
vim.o.mouse = 'a'
-- Support true color in vim.
vim.o.termguicolors = true
-- Hide quotes in JSON files.
vim.o.conceallevel = 1
-- When using gq, wrap the line at this many characters.
vim.o.textwidth = 80
-- Highlight line cursor is on.
vim.opt.cursorline = true

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
    -- eol = '↴',
    -- extends = '◣',
    -- nbsp = "␣",
    -- precedes = '◢',
    -- space = '⋅',
    -- trail = "·",
    extends = '…',
    leadmultispace = ' ', -- ...but don't show any when they're at the start
    multispace = '·', -- show chars if I have multiple spaces between text
    nbsp = '○',
    precedes = '…',
    tab = '◃―▹',
    trail = '●',
}
-- Show `listchars`.
vim.o.list = true
-- Add indentation when S or cc is pressed.
vim.o.cindent = true
-- Change cwd to file's directory.
-- vim.o.autochdir = true
vim.o.shell = Path.first_execuable({ '/usr/bin/zsh', '/usr/bin/bash', '/usr/bin/nu' })

--------------------------------------------------------------------------------
-- File finder.
--------------------------------------------------------------------------------
-- Looks into subfolders to find and open a file. :find filename - finds the
-- file in subfolders. Press Tab for suggesting files. Use * as a wild card for
-- beginnings or endings.
vim.o.path = vim.o.path .. '**'

--------------------------------------------------------------------------------
-- Import settings, mappings, auto-commands, etc.
--------------------------------------------------------------------------------
require('mappings')
require('auto-commands')
require('template-loader').setup()
require('runner')

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

--------------------------------------------------------------------------------
-- Not decided.
--------------------------------------------------------------------------------
-- vim.opt.splitkeep = 'screen' -- keep text on screen the same when splitting
-- vim.opt.completeopt = { 'menuone', 'noselect' }
-- vim.opt.swapfile = true
-- vim.opt.signcolumn = 'yes' -- show the sign column always
-- vim.opt.grepprg = 'rg --vimgrep --smart-case --no-heading' -- search with rg
-- vim.opt.grepformat = '%f:%l:%c:%m' -- filename:line number:column number:error message
-- vim.opt.scrolloff = 10 -- padding between cursor and top/bottom of window
-- vim.opt.foldlevelstart = 99 -- open files with all folds open
-- vim.opt.linebreak = true -- Break between words if `wrap` is ON.
-- vim.opt.smartindent = true -- add extra indent when it makes sense

-- Colors
if vim.fn.has('nvim-0.9.5') ~= 0 then
    vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'
    -- vim.opt.foldtext = vim.treesitter.foldtext()
end

-- More defined window borders.
vim.opt.fillchars:append({
    vert = '┃',
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vertleft = '┫',
    vertright = '┣',
    verthoriz = '╋',
    diff = '╱',
})
