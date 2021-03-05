"-------------------------------------------------------------------------------
" Mappings
" Note: It is important that comments not be in the same line as commands.
" Prefix s means "switch". Prefix f means "file".
"-------------------------------------------------------------------------------
" Leader Mappings.
map <Space> <Leader>
" Save file.
nnoremap <Leader>w :write<CR>
" Quit vim.
nnoremap <Leader>q :quit<CR>
" Add indentation when S or cc is pressed.
nnoremap <Leader>c :set cindent<CR>
" Load .vimrc.
nnoremap <Leader>v :source ~/.vimrc<CR>
" Print file name.
nnoremap <Leader>fn :echo expand('%')<CR>
" Print file path (full).
nnoremap <Leader>fp :echo expand("%:p")<CR>
" Print file directory.
nnoremap <Leader>fd :echo expand("%:p:h")<CR>
" Switch relative numbers.
nnoremap <Leader>sr :set relativenumber!<CR>
" Switch numbered lines.
nnoremap <Leader>sn :set number!<CR>
" Switch paste.
nnoremap <Leader>sp :set paste!<CR>
" Switch spellcheck.
nnoremap <Leader>ss :set spell!<CR>
" Switch autoindent.
nnoremap <Leader>sa :set autoindent!<CR>
" Switch wrap.
nnoremap <Leader>sw :set wrap!<CR>
" Fix syntax highlighting.
nnoremap <Leader>fs :syntax sync fromstart<CR>
" Prevent arrow keys.
nnoremap <Left> :echoe "Use h"<CR>
" Prevent arrow keys.
nnoremap <Right> :echoe "Use l"<CR>
" Prevent arrow keys.
nnoremap <Up> :echoe "Use k"<CR>
" Prevent arrow keys.
nnoremap <Down> :echoe "Use j"<CR>
"-------------------------------------------------------------------------------
" Program settings
"-------------------------------------------------------------------------------
"In Windows, replace "clear;" with "cls &&" and "python3" with "python"

" Run Python code in Vim (edit and insert modes).
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>

" Run C/C++ code in Vim.
autocmd FileType c map <buffer> <F5> :w<CR>:exec '!clear; gcc "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>
autocmd FileType c imap <buffer> <F5> <esc>:w<CR>:exec '!clear; gcc "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>
autocmd FileType cpp map <buffer> <F5> :w<CR>:exec '!clear; g++ "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>
autocmd FileType cpp imap <buffer> <F5> <esc>:w<CR>:exec '!clear; g++ "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>

" Run C# code in Vim (using Mono C# compiler or regular C# compiler).	
" autocmd FileType cs map <buffer> <F5> :w<CR>:exec '!clear; mcs "%" && ./"%<.exe"' shellescape(@%, 1)<CR>
" autocmd FileType cs imap <buffer> <F5> <esc>:w<CR>:exec '!clear; mcs "%" && ./"%<.exe"' shellescape(@%, 1)<CR>
autocmd FileType cs map <buffer> <F5> :w<CR>:exec '!clear; csc.exe "%" && ./"%<.exe"' shellescape(@%, 1)<CR>
autocmd FileType cs imap <buffer> <F5> <esc>:w<CR>:exec '!clear; csc.exe "%" && ./"%<.exe"' shellescape(@%, 1)<CR>

" Run Java code in Vim.
autocmd FileType java map <buffer> <F5> :w<CR>:exec '!clear; javac "%" && java "%<"' shellescape(@%, 1)<CR>
autocmd FileType java imap <buffer> <F5> <esc>:w<CR>:exec '!clear; javac "%" && java "%<"' shellescape(@%, 1)<CR>

" Run Rust code in Vim.
autocmd FileType rust map <buffer> <F5> :w<CR>:exec '!clear; rustc "%" && ./"%<"' shellescape(@%, 1)<CR>
autocmd FileType rust imap <buffer> <F5> <esc>:w<CR>:exec '!clea:r; rustc "%" && ./"%<"' shellescape(@%, 1)<CR>

" Compile LaTeX code in Vim.
autocmd FileType tex map <buffer> <F5> :w<CR>:exec '!clear; pdflatex.exe "%"' shellescape(@%, 1)<CR>
autocmd FileType tex imap <buffer> <F5> <esc>:w<CR>:exec '!clear; pdflatex.exe "%"' shellescape(@%, 1)<CR> <CR>
autocmd FileType tex map <buffer> <F4> :w<CR>:exec '!sumatrapdf.exe "%"<.pdf &'<CR> <CR>
autocmd FileType tex imap <buffer> <F4> <esc>:w<CR>:exec '!sumatrapdf.exe "%"<.pdf &'<CR> <CR>

" Spell check and wrap commit messages.
autocmd Filetype gitcommit setlocal spell textwidth=72
"-------------------------------------------------------------------------------
" File finder
"-------------------------------------------------------------------------------
set path+=** 				" Looks into subfolders to find and open a file. 
							" :find filename - finds the file in subfolders
							" Press Tab for suggesting files
							" Use the * as a wild card for beginnings or endings
set wildmenu				" Display all matching files when tab is pressed
							" :b filename - goes to other buffers
							" Can use Tab or specify unique filename substring
"-------------------------------------------------------------------------------
" Snippets
"-------------------------------------------------------------------------------
" Paste the following code from the specified file into the buffer
nnoremap <Leader>cpp :-1read ~/Templates/code.cpp<CR> 
"-------------------------------------------------------------------------------
" Interface
"-------------------------------------------------------------------------------
set encoding=utf-8          " Set encoding to UTF-8 to recognize Greek/Cyrillic
set ruler 					" Set the ruler to see the line and column  
set cindent					" Add indentation when S or cc is pressed
set colorcolumn=81			" Reminder to keep lines at most 80 characters long
set clipboard=unnamedplus	" Share clipboard with operating system
set backspace=2				" Enable backspace when using gVim
set number          		" Enable line numbers
set tabstop=4				" Shorten the tab size to 4 spaces
set shiftwidth=4			" Set tab size to 4 spaces
set autoindent				" Automatic indentation when going to next line
set nocompatible			" Not compatible with Vi (embrace the future)
set autoread				" Auto reload changed files
set history=20 				" History file is at most 20 lines
set ignorecase smartcase	" Search queries intelligently set case
set incsearch				" Show search results as you type
set background=dark         " Tell Vim if the background is light or dark
"-------------------------------------------------------------------------------
" Colors & Formatting
"-------------------------------------------------------------------------------
syntax enable 				" Highlight texts
filetype indent plugin on	" Enable plugins
colorscheme desert 			" Set color scheme for terminal

" Show comments in gray italics
highlight Comment ctermfg=Gray gui=italic 

" Change gVim looks depending on operating system
if has("gui_running")
	if has("gui_gtk2")
		set guifont=Inconsolata\ 15
	elseif has("gui_win32")
		set guifont=Consolas:h15:cANSI
		colorscheme slate
	endif
endif

" Map Ctrl-Up and Ctrl-Down to change font size in gVim.
nnoremap <C-Up> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR><CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR><CR>
"-------------------------------------------------------------------------------
" Other
"-------------------------------------------------------------------------------
" autocmd Filetype scss if getfsize(@%) > 300 | setlocal syntax=OFF | endif
" set hlsearch							" Highlight search results
" set smartindent				" Indent text inside brackets
"-------------------------------------------------------------------------------
