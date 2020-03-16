" Leader Mappings
map <Space> <Leader>
map ; <LocalLeader>
" Fix syntax highlighting 
nnoremap <silent> <Leader>c :syntax sync fromstart<CR> 
" Stiwch between relative and absolute numbers 
nnoremap <silent> <Leader>r :set nu! rnu!<CR>
" Print file name
nnoremap <Leader>p :echo expand('%')<CR>
" Save file
nnoremap <Leader>w :write<CR>
" Quit vim
nnoremap <Leader>q :quit<CR>
" Close all vim windows
nnoremap <Leader>q :qall<CR>
nnoremap <Leader>gs :Gstatus<CR>

" Recently edited files
nnoremap <Leader>h :history<CR>
inoremap ;e <Esc> 
 
" CtrlP use FZF (faster!)
noremap <C-p> :files<Cr>

"-------------------------------------------------------------------------------
" Program mappings
"-------------------------------------------------------------------------------
" Running Python code in Vim (edit and insert modes)
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>

" Running C/C++ code in Vim 
autocmd FileType cpp map <buffer> <F5> :w<CR>:exec '!clear; g++ -o %< % && ./%<' shellescape(@%, 1)<CR>
autocmd FileType cpp imap <buffer> <F5> <esc>:w<CR>:exec '!clear; g++ -o %< % && ./%<' shellescape(@%, 1)<CR>

" Formats text in gitcommits
autocmd Filetype gitcommit setlocal spell textwidth=72 "Spell check and automatic wrapping for commit messages

" autocmd Filetype scss if getfsize(@%) > 300 | setlocal syntax=OFF | endif

set autoread                          	" Auto reload changed files
set history=500 			" History file is at most 500 lines
set ignorecase smartcase              	" Search queries intelligently set case
" set splitright                        " Open new splits to the right
" set splitbelow                        " Open new splits to the bottom
" set noerrorbells novisualbell         " Turn off visual and audible bells
" set hlsearch                          " Highlight search results
" set incsearch                         " Show search results as you type
" set timeoutlen=1000 ttimeoutlen=0     " Remove timeout when hitting escape
" set showcmd                           " Show size of visual selection

"-------------------------------------------------------------------------------
" Interface
"-------------------------------------------------------------------------------
set number            	" Enable line numbers
syntax on 		" Highlights texts

"-------------------------------------------------------------------------------
" Colors & Formatting
"-------------------------------------------------------------------------------
colorscheme desert 
set background=dark

" Showcase comments in italics
highlight Comment cterm=italic gui=italic

" Open most recently used files on start
" autocmd VimEnter * Mru .

" Easy tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Find/replace
" vnoremap <C-r> "hy:%s/<C-r>h//g<left><left><left>

" Get off my lawn - helpful when learning Vim :)
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
