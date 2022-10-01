local function dict_append(dict1, dict2)
    for key, value in pairs(dict2) do
        dict1[key] = value
    end
end

local function keymap(mode, shortcut, command, options)
    local default_options = {}
    if options then dict_append(default_options, options) end
    vim.api.nvim_set_keymap(mode, shortcut, command, default_options)
end

local function map(shortcut, command, options)
    keymap('', shortcut, command)
end
local function nnoremap(shortcut, command, options)
    keymap('n', shortcut, command, {noremap = true})
end
local function cnoremap(shortcut, command, options)
    keymap('c', shortcut, command, {noremap = true})
end
local function inoremap(shortcut, command, options)
    keymap('i', shortcut, command, {noremap = true})
end
local function tnoremap(shortcut, command, options)
    keymap('t', shortcut, command, {noremap = true})
end
--------------------------------------------------------------------------------
-- Ungrouped Mappings. NOTE: Do not place comments in the same line as mappings.
--------------------------------------------------------------------------------
-- Leader Mapping.
vim.g.mapleader = " "
-- Local Leader Mapping.
vim.g.maplocalleader=","
-- Map localleader to CTRL-W.
map('<localleader>', '<c-w>')
-- Save file.
nnoremap('<leader>w', ':write<cr>')
-- Spawn a new terminal in the folder of the current file.
nnoremap('<leader>t', ':let $VIM_DIR=expand("%:p:h")<cr>:sil !setsid --fork \
    alacritty --working-directory $VIM_DIR &<cr>')
-- Spawn a new ranger terminal in the folder of the current file.
nnoremap('<leader>rt', ':let $VIM_DIR=expand("%:p:h")<cr>:sil !setsid --fork \
    alacritty --working-directory $VIM_DIR -e ranger<cc>')
-- Open tag bar and close it after selecting a tag.
nnoremap('<leader>ta', ':TagbarOpenAutoClose<cr>')
-- Find current file in tree.
nnoremap('<leader>tf', ':NERDTreeFind<cr>')
-- Quit vim.
nnoremap('<leader>q', ':quit<cr>')
-- Load .vimrc.
nnoremap('<leader>so', ':source ~/.config/nvim/init.vim<cr>')
-- Fix syntax highlighting.
nnoremap('<leader>fs', ':syntax sync fromstart<cr>')
-- Check script to make it POSIX compliant.
nnoremap('<leader>sc', ':!shellcheck "%"<cr>')
-- Remove trailing white space.
nnoremap('<leader>rw', ':%s/\\s\\+$//e<cr>')
-- Remove swap file. Make the command long in purpose.
nnoremap('<leader>rswap', ':!rm "%.swp"<cr>')
-- Unset the last search pattern register.
nnoremap('<esc>', ':nohl<cr>', { silent = true })
-- -----------------------------------------------------------------------------
-- Command mode mappings.
-- -----------------------------------------------------------------------------
-- Move up autocomplete options in Command mode.
cnoremap('<c-k>', '<c-p>')
-- Move down autocomplete options in Command mode.
cnoremap('<c-j>', '<c-n>')

-- -----------------------------------------------------------------------------
-- Insert mode mappings.
-- -----------------------------------------------------------------------------
-- Move up autocomplete options in insert mode.
inoremap('<c-k>', '<c-p>')
-- Move down autocomplete options in insert mode.
inoremap('<c-j>', '<c-n>')

-- -----------------------------------------------------------------------------
-- Normal mode mappings. Fast movement.
-- -----------------------------------------------------------------------------
-- Move a page up.
nnoremap('<c-k>', '<c-u>')
-- Move a page down.
nnoremap('<c-j>', '<c-d>')

-- -----------------------------------------------------------------------------
-- Resize Window mappings.
-- -----------------------------------------------------------------------------
-- Increase height by N lines.
nnoremap('<up>', '4<c-w>+')
-- Decrease height by N lines.
nnoremap('<down>', '4<c-w>-')
-- Increase width by N lines.
nnoremap('<right>', '4<c-w>>')
-- Decrease width by N lines.
nnoremap('<left>', '4<c-w><')

-- -----------------------------------------------------------------------------
-- File mappings. Prefix f means "file".
-- -----------------------------------------------------------------------------
-- Print file name.
nnoremap('<leader>fn', ':echo expand("%:t")<cr>')
-- Print file path (full).
nnoremap('<leader>fp', ':echo expand("%:p")<cr>')
-- Print file directory.
nnoremap('<leader>fd', ':echo expand("%:p:h")<cr>')

-- -----------------------------------------------------------------------------
-- Yank mappings. Prefix y means "yank".
-- -----------------------------------------------------------------------------
-- Copy file name to clipboard.
nnoremap('yn', ':let @+=expand("%:t")<cr>')
-- Copy file path to clipboard.
nnoremap('yp', ':let @+=expand("%:p")<cr>')
-- Copy pwd to clipboard.
nnoremap('yd', ':let @+=expand("%:p:h")<cr>')
-- Copy buffer contents to clipboard.
nnoremap('yb', ':%y<cr>')

-- -----------------------------------------------------------------------------
-- Switch mappings. Prefix s means "switch".
-- -----------------------------------------------------------------------------
-- Switch relative numbers.
nnoremap('<leader>sr', 'set relativenumber!<cr>')
-- Switch numbered lines.
nnoremap('<leader>sn', 'set number!<cr>')
-- Switch paste.
nnoremap('<leader>sp', 'set paste!<cr>')
-- Switch automatic indentation.
nnoremap('<leader>sa', 'set autoindent!<cr>')
-- Switch wrap.
nnoremap('<leader>sw', 'set wrap!<cr>')
-- Switch highlight search.
nnoremap('<leader>sh', 'set hlsearch!<cr>')

-- -----------------------------------------------------------------------------
-- Spellcheck mappings. Prefix s means "spell".
-- -----------------------------------------------------------------------------
-- Switch spellcheck for English.
nnoremap('<leader>sse', 'setlocal spell spelllang=en<cr>')
-- Switch spellcheck for Spanish.
nnoremap('<leader>sss', 'setlocal spell spelllang=es<cr>')
-- Switch spellcheck for Russian.
nnoremap('<leader>ssr', 'setlocal spell spelllang=ru<cr>')
-- Switch spellcheck.
nnoremap('<leader>sso', 'setlocal spell!<cr>')

-- -----------------------------------------------------------------------------
-- Buffer mappings. Prefix b means "buffer".
-- -----------------------------------------------------------------------------
-- Go to the next buffer.
nnoremap('L', ':bn<cr>')
-- Go to the previous buffer.
nnoremap('H', ':bp<cr>')
-- Go to the next buffer.
nnoremap('<leader>bn', 'bn<cr>')
-- Go to the previous buffer.
nnoremap('<leader>bp', 'bp<cr>')
-- Go back (to last) buffer.
nnoremap('<leader>bb', 'b#<cr>')
-- Show open buffers.
nnoremap('<leader>bs', 'buffers<cr>')
-- Delete (close) buffer from buffers list.
nnoremap('<leader>bd', 'bd<cr>')

-- -----------------------------------------------------------------------------
-- Window mappings.
-- -----------------------------------------------------------------------------
-- Move cursor to the left window.
nnoremap('<leader>h', '<c-w>h')
-- Move cursor to the window below.
nnoremap('<leader>j', '<c-w>j')
-- Move cursor to the window above.
nnoremap('<leader>k', '<c-w>k')
-- Move cursor to the right window.
nnoremap('<leader>l', '<c-w>l')
-- Remaping localleader to CTRL-W enabled the following mappings.
-- <localleader>= - make all windows equal height & width
-- <localleader>h - move cursor to the left window
-- <localleader>j - move cursor to the window below
-- <localleader>k - move cursor to the window above
-- <localleader>l - move cursor to the right window
-- <localleader>q - quit a window
-- <localleader>r - rotate windows upwards N times
-- <localleader>w - switch windows
-- <localleader>x - exchange current window with next one
-- <localleader>s - split window
-- <localleader>v - split window vertically
-- Split window (add for responsiveness).
-- nnoremap <localleader>s :sp<cr>
-- Split window vertically (add for responsiveness).
-- nnoremap <localleader>v :vsp<cr>

-- -----------------------------------------------------------------------------
-- Embedded terminal settings and mappings.
-- -----------------------------------------------------------------------------
-- Move cursor to the left window.
tnoremap('<localleader>h', '<c-\\><c-n><cr><c-w>h')
-- Move cursor to the window above.
tnoremap('<localleader>j', '<c-\\><c-n><cr><c-w>j')
-- Move cursor to the window below.
tnoremap('<localleader>k', '<c-\\><c-n><cr><c-w>k')
-- Move cursor to the right window.
tnoremap('<localleader>l', '<c-\\><c-n><cr><c-w>l')

local when_term_opens = vim.api.nvim_create_augroup("When Terminal Opens", {
    -- Clear previous group auto commands to avoid duplicate definitions.
    clear = true
})

    -- Turn off spelling in terminal.
    vim.api.nvim_create_autocmd('TermOpen', {
        group = when_term_opens,
        pattern = '*',
        command = 'setlocal nospell'
    })

    -- Disable line numbering in terminal.
    vim.api.nvim_create_autocmd('TermOpen', {
        group = when_term_opens,
        pattern = '*',
        command = 'setlocal nonumber'
    })

    -- Press escape twice to exit. Add only to zsh because it conflicts with fzf.
    -- Press ctrl+q to scroll freely in terminal, as opposed to ctrl+\ ctrl+n.
    vim.api.nvim_create_autocmd('TermOpen', {
       group = when_term_opens,
       pattern = '*',
       command = 'if expand("%:t") == "zsh" | tnoremap <c-q> <c-\\><c-n> | endif'
   })

local buffer_check = vim.api.nvim_create_augroup('Check Buffer', {
    clear = true
})

    -- Reload config file on change.
    vim.api.nvim_create_autocmd('BufWritePost', {
        group    = buffer_check,
        pattern  = vim.env.MYVIMRC,
        command  = 'source %'})

    -- Highlight yanks.
    vim.api.nvim_create_autocmd('TextYankPost', {
        group    = buffer_check,
        pattern  = '*',
        callback = function() vim.highlight.on_yank{timeout=150} end})

    -- -- sync clipboards because I'm easily confused
    -- vim.api.nvim_create_autocmd('TextYankPost', {
        -- group    = 'bufcheck',
        -- pattern  = '*',
        -- callback = function() fn.setreg('+', fn.getreg('*')) end })

    -- Start terminal in insert mode.
    vim.api.nvim_create_autocmd('TermOpen',     {
        group    = buffer_check,
        pattern  = '*',
        command  = 'startinsert | set winfixheight'})

    -- Start git messages in insert mode.
    vim.api.nvim_create_autocmd('FileType',     {
        group    = buffer_check,
        pattern  = { 'gitcommit', 'gitrebase', },
        command  = 'startinsert | 1'})
 
   -- -- pager mappings for Manual
   -- vim.api.nvim_create_autocmd('FileType',     {
        -- group    = 'bufcheck',
        -- pattern  = 'man',
        -- callback = function()
          -- vim.keymap.set('n', '<enter>'    , 'K'    , {buffer=true})
          -- vim.keymap.set('n', '<backspace>', '<c-o>', {buffer=true})
          -- end })

    -- Return to last edit position when opening files
    -- vim.api.nvim_create_autocmd('BufReadPost',  {
        -- group    = 'bufcheck',
        -- pattern  = '*',
        -- callback = function()
          -- if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
             -- fn.setpos('.', fn.getpos("'\""))
             -- -- vim.cmd('normal zz') -- how do I center the buffer in a sane way??
             -- vim.cmd('silent! foldopen')
         -- end end })
--------------------------------------------------------------------------------
-- Interface.
--------------------------------------------------------------------------------
-- Share clipboard with operating system.
vim.o.clipboard = 'unnamedplus'
-- Reminder to keep lines at most 80 characters long.
vim.o.colorcolumn = '81'

--------------------------------------------------------------------------------
-- Other.
--------------------------------------------------------------------------------
-- Define tab and trailing space characters.
vim.opt.listchars = { tab = '◃―▹', trail = '●' }

