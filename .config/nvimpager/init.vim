" Fast up movement.
au CursorMoved * nnoremap <buffer> j <c-d>
" Fast down movement.
au CursorMoved * nnoremap <buffer> k <c-u>
" Open manual entry.
nnoremap <cr> K
" Slow down movement.
nnoremap J j
" Slow up movement.
nnoremap K k

"-------------------------------------------------------------------------------
" Search mappings.
"-------------------------------------------------------------------------------
" Toggle case sensitivity.
nnoremap <leader>c :set ignorecase!<cr>
" Unset the last search pattern register.
nnoremap <silent> <esc> :nohl<cr><cr>

"-------------------------------------------------------------------------------
" Command mode mappings.
"-------------------------------------------------------------------------------
" Move up autocomplete options in Command mode.
cnoremap <c-k> <c-p>
" Move down autocomplete options in Command mode.
cnoremap <c-j> <c-n>

"-------------------------------------------------------------------------------
" Normal mode mappings. Fast movement.
"-------------------------------------------------------------------------------
" Move a page up.
nnoremap <c-k> <c-u>
" Move a page down.
nnoremap <c-j> <c-d>

"-------------------------------------------------------------------------------
" Buffer mappings.
"-------------------------------------------------------------------------------
" Close all window tabs.
function! CloseWintab()
  try
    WintabsClose
  catch
    quit
  endtry
endfunction
" Leader Mapping.
let mapleader="\<space>"
" Go to the next buffer.
nnoremap L :bn<cr>
" Go to the previous buffer.
nnoremap H :bp<cr>
" Go to the next buffer.
nnoremap <leader>bn :bn<cr>
" Go to the previous buffer.
nnoremap <leader>bp :bp<cr>
" Go back (to last) buffer.
nnoremap <leader>bb :b#<cr>
" Show open buffers.
nnoremap <leader>bs :buffers<cr>
" Delete (close) buffer from buffers list.
nnoremap <leader>bd :bd<cr>
" Close all buffers even if more than one is open.
nnoremap <leader>q :call CloseWintab()<cr>
" Source the configuration file.
nnoremap <leader>so :so ~/.config/nvimpager/init.vim<cr>

"-------------------------------------------------------------------------------
" Window mappings.
"-------------------------------------------------------------------------------
" Move cursor to the left window.
nnoremap <leader>h <c-w>h
" Move cursor to the window below.
nnoremap <leader>j <c-w>j
" Move cursor to the window above.
nnoremap <leader>k <c-w>k
" Move cursor to the right window.
nnoremap <leader>l <c-w>l

"-------------------------------------------------------------------------------
" Interface.
"-------------------------------------------------------------------------------
set background=dark         " Tell Vim if the background is light or dark.
set clipboard=unnamedplus   " Share clipboard with operating system.
set encoding=utf-8          " Set encoding to UTF-8 to recognize Greek/Cyrillic.
set incsearch               " Show search results as you type.
set mouse=a                 " Enable mouse wheel in all Vim modes.
set nocompatible            " Not compatible with Vi (embrace the future).
set showcmd                 " Show commands as they are typed on the banner.
set termguicolors           " Support true color in vim.
set title                   " Set window title to value of the manual entry.

"-------------------------------------------------------------------------------
" TUI Colors.
"-------------------------------------------------------------------------------
" Clear the font color for very first line in the man page.
hi manHeader            guifg=none
" Highlight options and inputs with a muted green color.
hi manUnderline         cterm=underline gui=none guifg=#b9ca4a
" A link to other man page, such as man(1).
hi manReference         guifg=LightMagenta
" Highlight bold letters using a muted red color.
hi manBold              guifg=#d54e53
" Items matching search should be green.
hi Search               guibg=LightGreen
" Item before entering search should be orange.
hi IncSearch            guibg=reverse guifg=Orange
" Regular pop-up menu item should have dark backgrounds.
hi Pmenu                guibg=Black guifg=White
" Selected pop-up menu item should have light backgrounds.
hi PmenuSel             guibg=Gray guifg=White

lua << EOF
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
EOF
