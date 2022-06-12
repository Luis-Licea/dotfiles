" Use "K" to follow man page under cursor.
" Do not map "K" to anything else.
"
" Fast movement with j, k and slow movement with  J, K.
" Add the following keybindings to this file:
" /usr/share/nvimpager/runtime/lua/nvimpager.lua
" map('n', 'k', '<C-u>')
" map('n', 'j', '<C-d>')
" map('n', '<c-k>', '<C-Y>')
" map('n', '<c-j>', '<C-E>')

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

"
" nnoremap <c-k> <c-u>
" unmap <buffer> k
" nnoremap k <c-u>
" nnoremap <buffer> k <c-u>
" Move a page down.
" nnoremap <c-j> <c-d>
" unmap <buffer> j
" nnoremap j <c-d>
" nnoremap <buffer> j <c-d>
map <buffer> j <c-d>

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
