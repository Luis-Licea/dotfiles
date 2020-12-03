"-------------------------------------------------------------------------------
" Mappings
"-------------------------------------------------------------------------------
" Leader Mappings
map <Space> <Leader>
" Fix syntax highlighting 
nnoremap <silent> <Leader>c :syntax sync fromstart<CR> 
" Stiwch relative numbers 
nnoremap <silent> <Leader>r :set relativenumber!<CR>
" Swith numbered lines 
nnoremap <silent> <Leader>n :set number!<CR>
" Stiwch paste
nnoremap <Leader>p :set paste!<CR>
" Load .vimrc
nnoremap <Leader>v :source ~/.vimrc<CR>
" Print file name
nnoremap <Leader>f :echo expand('%')<CR>
" Save file
nnoremap <Leader>w :write<CR>
" Quit vim
nnoremap <Leader>q :quit<CR>
" Recently edited files
nnoremap <Leader>h :history<CR>
" Switch autoindentation 
nnoremap <Leader>a :set autoindent!<CR>
" CtrlP use FZF (faster!)
noremap <C-p> :files<Cr>
"-------------------------------------------------------------------------------
" Program mappings
"-------------------------------------------------------------------------------
" Running Python code in Vim (edit and insert modes)
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>

" Running C/C++ code in Vim 
autocmd FileType c map <buffer> <F5> :w<CR>:exec '!clear; gcc "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>
autocmd FileType c imap <buffer> <F5> <esc>:w<CR>:exec '!clear; gcc "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>
autocmd FileType cpp map <buffer> <F5> :w<CR>:exec '!clear; g++ "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>
autocmd FileType cpp imap <buffer> <F5> <esc>:w<CR>:exec '!clear; g++ "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>

" Running C# code in Vim (using Mono C# compiler or regular C# compiler)	
" autocmd FileType cs map <buffer> <F5> :w<CR>:exec '!clear; mcs "%" && ./"%<.exe"' shellescape(@%, 1)<CR>
" autocmd FileType cs imap <buffer> <F5> <esc>:w<CR>:exec '!clear; mcs "%" && ./"%<.exe"' shellescape(@%, 1)<CR>
autocmd FileType cs map <buffer> <F5> :w<CR>:exec '!clear; csc.exe "%" && ./"%<.exe"' shellescape(@%, 1)<CR>
autocmd FileType cs imap <buffer> <F5> <esc>:w<CR>:exec '!clear; csc.exe "%" && ./"%<.exe"' shellescape(@%, 1)<CR>

" Running Java code in Vim 
autocmd FileType java map <buffer> <F5> :w<CR>:exec '!clear; javac "%" && java "%<"' shellescape(@%, 1)<CR>
autocmd FileType java imap <buffer> <F5> <esc>:w<CR>:exec '!clear; javac "%" && java "%<"' shellescape(@%, 1)<CR>

" Compiling LaTex code in Vim 
autocmd FileType tex map <buffer> <F5> :w<CR>:exec '!clear; pdflatex.exe "%"' shellescape(@%, 1)<CR>
autocmd FileType tex imap <buffer> <F5> <esc>:w<CR>:exec '!clear; pdflatex.exe "%"' shellescape(@%, 1)<CR> <CR>
autocmd FileType tex map <buffer> <F4> :w<CR>:exec '!sumatrapdf.exe "%"<.pdf &'<CR> <CR>
autocmd FileType tex imap <buffer> <F4> <esc>:w<CR>:exec '!sumatrapdf.exe "%"<.pdf &'<CR> <CR>
"-------------------------------------------------------------------------------
" File finder
"-------------------------------------------------------------------------------
set path+=** 				" Looks into subfolders to find and open a file. 
							" :find filename - finds the file in subfolders
							" Press Tab for suggesting files
							" Use the * as a wildcard for beginnings or endings
set wildmenu				" Display all matching files when tab is pressed
							" :b filename - goes to other buffers
							" Can use Tab or specify unique substring of filename
"-------------------------------------------------------------------------------
" Snippets
"-------------------------------------------------------------------------------
" Paste the following code from the specified file into the buffer
nnoremap <Leader>cpp :-1read ~/Templates/code.cpp<CR> 
"-------------------------------------------------------------------------------
" Interface
"-------------------------------------------------------------------------------
set colorcolumn=81			" Reminder to keep lines at most 80 characters long
set clipboard=unnamed		" Share clipboard with operating system
set backspace=2				" Enable backspace when using gVim
set number          		" Enable line numbers
set tabstop=4				" Shortens the tab size to 4 spaces
set shiftwidth=4			" Set tab size to 4 spaces
set autoindent				" Automatic indentation when goint to next line
set nocompatible			" Not compatible with Vi (embrace the future)
set autoread				" Auto reload changed files
set history=20 				" History file is at most 500 lines
set ignorecase smartcase	" Search queries intelligently set case
set incsearch				" Show search results as you type
set smartindent				" Indent text inside brackets
syntax on 					" Highlights texts
filetype plugin on			" Enable plugins
"-------------------------------------------------------------------------------
" Colors & Formatting
"-------------------------------------------------------------------------------
" Set colorscheme for terminal
colorscheme desert 
set background=dark

" Change gVim looks depending on operating system
if has("gui_running")
	if has("gui_gtk3")
		set guifont=Inconsolata\ 12
	elseif has("gui_win32")
		set guifont=Consolas:h11:cANSI
		colorscheme slate
	endif
endif

" Showcase comments in italics
highlight Comment cterm=italic gui=italic

" Open most recently used files on start
" autocmd VimEnter * Mru .

" Easy tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Find/replace
" vnoremap <C-r> "hy:%s/<C-r>h//g<left><left><left>

" Helpful when learning Vim
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Spell check and automatically wrap commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72
"-------------------------------------------------------------------------------
" Other
"-------------------------------------------------------------------------------
" autocmd Filetype scss if getfsize(@%) > 300 | setlocal syntax=OFF | endif
" set splitright						" Open new splits to the right
" set splitbelow						" Open new splits to the bottom
" set noerrorbells novisualbell			" Turn off visual and audible bells
" set hlsearch							" Highlight search results
" set timeoutlen=1000 ttimeoutlen=0		" Remove timeout when hitting escape
"-------------------------------------------------------------------------------
