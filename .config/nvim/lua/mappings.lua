local key = require('Key')

local map = key.map
local nnoremap = key.nnoremap
local cnoremap = key.cnoremap
local inoremap = key.inoremap
local tnoremap = key.tnoremap

--------------------------------------------------------------------------------
-- Ungrouped Mappings.
--------------------------------------------------------------------------------
-- Map localleader to CTRL-W.
map('<localleader>', '<c-w>')
-- Save file.
nnoremap('<leader>w', ':write<cr>')
-- nnoremap('<leader>w', ':update<cr>')

-- Quit vim.
nnoremap('<leader>q', ':quit<cr>')
-- Load .vimrc.
nnoremap('<leader>so', ':source ~/.config/nvim/init.vim<cr>')
-- Fix syntax highlighting.
nnoremap('<leader>fs', ':syntax sync fromstart<cr>')
-- Remove trailing white space.
nnoremap('<leader>rw', ':%s/\\s\\+$//e<cr>')
-- Remove swap file. Make the command long in purpose.
nnoremap('<leader>rswap', ':!rm "%.swp"<cr>')
-- Unset the last search pattern register.
nnoremap('<esc>', ':nohl<cr>', { silent = true })
-- Paste last thing yanked, not deleted.
nnoremap('<leader>p', '"0p')
nnoremap('<leader>P', '"0P')

--------------------------------------------------------------------------------
-- Tab, window, and buffer navigation.
--------------------------------------------------------------------------------
-- Open the current buffer in a new tab.
nnoremap('<leader>tn', ':tabnew %<cr>')
-- Close the tab.
nnoremap('<leader>tc', ':tabclose<cr>')

-- Go to tab by number.
nnoremap('<localleader>1', '1gt')
nnoremap('<localleader>2', '2gt')
nnoremap('<localleader>3', '3gt')
nnoremap('<localleader>4', '4gt')
nnoremap('<localleader>5', '5gt')
nnoremap('<localleader>6', '6gt')
nnoremap('<localleader>7', '7gt')
nnoremap('<localleader>8', '8gt')
nnoremap('<localleader>9', '9gt')
nnoremap('<localleader>0', ':tablast<cr>')

-- Go to window by number.
nnoremap('g1', ':call win_gotoid(win_getid(1))<cr>')
nnoremap('g2', ':call win_gotoid(win_getid(2))<cr>')
nnoremap('g3', ':call win_gotoid(win_getid(3))<cr>')
nnoremap('g4', ':call win_gotoid(win_getid(4))<cr>')
nnoremap('g5', ':call win_gotoid(win_getid(5))<cr>')
nnoremap('g6', ':call win_gotoid(win_getid(6))<cr>')
nnoremap('g7', ':call win_gotoid(win_getid(7))<cr>')
nnoremap('g8', ':call win_gotoid(win_getid(8))<cr>')
nnoremap('g9', ':call win_gotoid(win_getid(9))<cr>')
nnoremap('g0', ':call win_gotoid(win_getid(10))<cr>')

-- Go to buffer by number:
-- ./lua/plugins/bufferline.lua

--------------------------------------------------------------------------------
-- Command mode mappings.
--------------------------------------------------------------------------------
-- Move up autocomplete options in Command mode.
cnoremap('<c-k>', '<c-p>')
-- Move down autocomplete options in Command mode.
cnoremap('<c-j>', '<c-n>')
-- Leave command mode without executing command.
cnoremap('<esc>', '<c-c>')

--------------------------------------------------------------------------------
-- Insert mode mappings.
--------------------------------------------------------------------------------
-- Move up autocomplete options in insert mode.
inoremap('<c-k>', '<c-p>')
-- Move down autocomplete options in insert mode.
inoremap('<c-j>', '<c-n>')

--------------------------------------------------------------------------------
-- Normal mode mappings. Fast movement.
--------------------------------------------------------------------------------
-- Move a page up.
nnoremap('<s-k>', '<c-u><c-u>')
-- Move a page down.
nnoremap('<s-j>', '<c-d><c-d>')

--------------------------------------------------------------------------------
-- Resize Window mappings.
--------------------------------------------------------------------------------
-- Increase height by N lines.
nnoremap('<up>', '10<c-w>+')
-- Decrease height by N lines.
nnoremap('<down>', '10<c-w>-')
-- Increase width by N lines.
nnoremap('<right>', '10<c-w>>')
-- Decrease width by N lines.
nnoremap('<left>', '10<c-w><')

--------------------------------------------------------------------------------
-- File mappings. Prefix f means "file".
--------------------------------------------------------------------------------
-- Print file name.
nnoremap('<leader>fn', ':echo expand("%:t")<cr>')
-- Print file path (full).
nnoremap('<leader>fp', ':echo expand("%:p")<cr>')
-- Print file directory.
nnoremap('<leader>fd', ':echo expand("%:p:h")<cr>')

--------------------------------------------------------------------------------
-- Yank mappings. Prefix y means "yank".
--------------------------------------------------------------------------------
-- Copy file name to clipboard.
nnoremap('yn', ':let @+=expand("%:t") | echo "Yanked file:" @+<cr>')
-- Copy file path to clipboard.
nnoremap('yp', ':let @+=expand("%:p") | echo "Yanked path:" @+<cr>')
-- Copy pwd to clipboard.
nnoremap('yd', ':let @+=expand("%:p:h") | echo "Yanked cwd:" @+<cr>')
-- Copy buffer contents to clipboard.
nnoremap('yb', ':%y<cr>')

--------------------------------------------------------------------------------
-- Switch mappings. Prefix s means "switch".
--------------------------------------------------------------------------------
-- Switch numbered lines.
nnoremap('<leader>sn', ':set number! number?<cr>')
-- Switch automatic indentation.
nnoremap('<leader>sa', ':set autoindent! autoindent?<cr>')
-- Switch wrap.
nnoremap('<leader>sw', ':set wrap! wrap?<cr>')
-- Switch highlight search.
nnoremap('<leader>sh', ':set hlsearch! hlsearch?<cr>')
-- Switch auto-changing directory.
nnoremap('<leader>sc', ':set autochdir! autochdir?<cr>')

--------------------------------------------------------------------------------
-- Spellcheck mappings. Prefix s means "spell".
--------------------------------------------------------------------------------
-- Switch spellcheck for English.
nnoremap('<leader>sse', ':setlocal spell! spelllang=en spell?<cr>')
-- Switch spellcheck for Spanish.
nnoremap('<leader>sss', ':setlocal spell! spelllang=es spell?<cr>')
-- Switch spellcheck for Russian.
nnoremap('<leader>ssr', ':setlocal spell! spelllang=ru spell?<cr>')

--------------------------------------------------------------------------------
-- Buffer mappings. Prefix b means "buffer".
--------------------------------------------------------------------------------
-- Go to the next buffer.
nnoremap('<Tab>', ':bn<cr>')
-- Go to the previous buffer.
nnoremap('<S-Tab>', ':bp<cr>')
-- Go to the next buffer.
nnoremap('<leader>bn', ':bn<cr>')
-- Go to the previous buffer.
nnoremap('<leader>bp', ':bp<cr>')
-- Go back (to last) buffer.
nnoremap('<leader>bb', ':b#<cr>')
-- Show open buffers.
nnoremap('<leader>bs', ':buffers<cr>')
-- Delete (close) buffer from buffers list.
nnoremap('<leader>bd', ':bd<cr>')

--------------------------------------------------------------------------------
-- Embedded terminal settings and mappings.
--------------------------------------------------------------------------------
-- Move cursor to the left window.
tnoremap('<localleader>h', '<c-\\><c-n><cr><c-w>h')
-- Move cursor to the window above.
tnoremap('<localleader>j', '<c-\\><c-n><cr><c-w>j')
-- Move cursor to the window below.
tnoremap('<localleader>k', '<c-\\><c-n><cr><c-w>k')
-- Move cursor to the right window.
tnoremap('<localleader>l', '<c-\\><c-n><cr><c-w>l')
-- Escape window.
tnoremap('<Esc><Esc>', '<c-\\><c-n><cr>')

--------------------------------------------------------------------------------
-- Window settings.
--------------------------------------------------------------------------------
-- Next window. Move cursor clockwise to the next window
nnoremap('<c-j>', '<c-w>w')
-- Previous window. Move cursor counter-clockwise to the previous window.
nnoremap('<c-k>', '<c-w>W')

--------------------------------------------------------------------------------
-- Vim Terminal.
--------------------------------------------------------------------------------
-- Close tab immediately after closing terminal.
-- au! TermClose * :q
--
-- nnoremap <silent> <leader>tt :terminal<CR>
-- nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
-- nnoremap <silent> <leader>th :new<CR>:terminal<CR>
-- tnoremap <C-x> <C-\><C-n><C-w>q
