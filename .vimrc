"-------------------------------------------------------------------------------
" Ungrouped Mappings. Note: Do not place comments in the same line as mappings.
"-------------------------------------------------------------------------------
" Leader Mapping.
let mapleader="\<Space>"
" LocalLeader Mapping.
let maplocalleader="\\"
" Map LocalLeader to CTRL-W.
map <LocalLeader> <C-W>
" Save file.
nnoremap <Leader>w :write<CR>
" Quit vim.
nnoremap <Leader>q :quit<CR>
" Add indentation when S or cc is pressed.
nnoremap <Leader>c :set cindent<CR>
" Load .vimrc.
nnoremap <Leader>so :source ~/.vimrc<CR>
" Fix syntax highlighting.
nnoremap <Leader>fs :syntax sync fromstart<CR>
" Check script to make it POSIX compliant.
nnoremap <Leader>sc :!clear && shellcheck "%"<CR>
" Remove trailing white space.
nnoremap <Leader>rw :%s/\s\+$//e<CR>
" Remove swap file. Make the command long in purpose. 
nnoremap <Leader>rswap :!rm '.%.swp'<CR>
"-------------------------------------------------------------------------------
" Arrow key mappings.
"-------------------------------------------------------------------------------
" Resize Window.
map <Up> <c-w>+
map <Down> <c-w>-
map <Left> <c-w><
map <Right> <c-w>>
"-------------------------------------------------------------------------------
" File mappings. Prefix f means "file".
"-------------------------------------------------------------------------------
" Print file name.
nnoremap <Leader>fn :echo expand('%')<CR>
" Print file path (full).
nnoremap <Leader>fp :echo expand("%:p")<CR>
" Print file directory.
nnoremap <Leader>fd :echo expand("%:p:h")<CR>
"-------------------------------------------------------------------------------
" Switch mappings. Prefix s means "switch".
"-------------------------------------------------------------------------------
" Switch relative numbers.
nnoremap <Leader>sr :set relativenumber!<CR>
" Switch numbered lines.
nnoremap <Leader>sn :set number!<CR>
" Switch paste.
nnoremap <Leader>sp :set paste!<CR>
" Switch autoindent.
nnoremap <Leader>sa :set autoindent!<CR>
" Switch wrap.
nnoremap <Leader>sw :set wrap!<CR>
" Switch highlight search.
nnoremap <Leader>sh :set hlsearch!<CR>
"-------------------------------------------------------------------------------
" Spellcheck mappings. Prefix s means "spell".
"-------------------------------------------------------------------------------
" Switch spellcheck for English.
nnoremap <Leader>sse :setlocal spell spelllang=en<CR>
" Switch spellcheck for Spanish.
nnoremap <Leader>sss :setlocal spell spelllang=es<CR>
" Switch spellcheck for Russian.
nnoremap <Leader>ssr :setlocal spell spelllang=ru<CR>
" Switch spellcheck off.
nnoremap <Leader>sso :setlocal nospell<CR>
"-------------------------------------------------------------------------------
" Buffer mappings. Prefix b means "buffer".
"-------------------------------------------------------------------------------
" Go to the next buffer.
nnoremap <Leader>bn :bn<CR>
" Go to the previous buffer.
nnoremap <Leader>bp :bp<CR>
" Go back (to last) buffer.
nnoremap <Leader>bb :b#<CR>
" Show open buffers.
nnoremap <Leader>bs :buffers<CR>
" Delete (close) buffer from buffers list.
nnoremap <Leader>bd :bd<CR>
"-------------------------------------------------------------------------------
" Window mappings.
"-------------------------------------------------------------------------------
" <LocalLeader>s - split window (added for responsiveness).
nnoremap <LocalLeader>s :sp<CR>
" <LocalLeader>v - split window vertically (added for responsiveness).
nnoremap <LocalLeader>v :vsp<CR>
" Remaping LocalLeader to CTRL-W enabled the following mappings.
" <LocalLeader>w - switch windows
" <LocalLeader>q - quit a window
" <LocalLeader>x - exchange current window with next one
" <LocalLeader>= - make all windows equal height & width
" <LocalLeader>h - move cursor to the left window (vertical split)
" <LocalLeader>l - move cursor to the right window (vertical split)
" <LocalLeader>j - move cursor to the window below (horizontal split)
" <LocalLeader>k - move cursor to the window above (horizontal split)
"-------------------------------------------------------------------------------
" Dirvish mappings. Prefix t means "tree".
"-------------------------------------------------------------------------------
" Execute selected arguments.
nnoremap <Leader>tx :argdo !clear && '%'<CR>
" Open/close Dirvish tree.
nnoremap <Leader>tt :Dirvish<CR>
"-------------------------------------------------------------------------------
" Vim-plug settings.
"-------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'rust-lang/rust.vim'
    Plug 'justinmk/vim-dirvish'
    Plug 'dbeniamine/cheat.sh-vim' 
call plug#end()
"-------------------------------------------------------------------------------
" Program settings.
"-------------------------------------------------------------------------------
" In Windows, replace "clear;" with "cls &&" and "python3" with "python"

" Run Python code in Vim (edit and insert modes).
autocmd FileType python map <buffer> <F5> :w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F5> <esc>:w<CR>:exec '!clear; python3' shellescape(@%, 1)<CR>

" Run C code in Vim.
autocmd FileType c map <buffer> <F5> :w<CR>:exec '!clear; gcc -Wall -Wextra "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>
autocmd FileType c imap <buffer> <F5> <esc>:w<CR>:exec '!clear; gcc -Wall -Wextra "%" -o "%<" && "./%<"' shellescape(@%, 1)<CR>

" Run C++ code in Vim.
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
autocmd FileType rust imap <buffer> <F5> <esc>:w<CR>:exec '!clear; rustc "%" && ./"%<"' shellescape(@%, 1)<CR>

" Compile LaTeX code in Vim.
autocmd FileType tex map <buffer> <F5> :w<CR>:exec '!clear; pdflatex.exe "%"' shellescape(@%, 1)<CR>
autocmd FileType tex imap <buffer> <F5> <esc>:w<CR>:exec '!clear; pdflatex.exe "%"' shellescape(@%, 1)<CR> <CR>
autocmd FileType tex map <buffer> <F4> :w<CR>:exec '!sumatrapdf.exe "%"<.pdf &'<CR> <CR>
autocmd FileType tex imap <buffer> <F4> <esc>:w<CR>:exec '!sumatrapdf.exe "%"<.pdf &'<CR> <CR>

" Spell check and wrap commit messages.
autocmd Filetype gitcommit setlocal spell textwidth=72
"-------------------------------------------------------------------------------
" File finder.
"-------------------------------------------------------------------------------
set path+=** 				" Looks into subfolders to find and open a file. 
							" :find filename - finds the file in subfolders.
							" Press Tab for suggesting files.
							" Use * as a wild card for beginnings or endings.
set wildmenu				" Display all matching files when tab is pressed.
							" :b filename - goes to other buffers.
							" Can use Tab or specify unique filename substring.
"-------------------------------------------------------------------------------
" Snippets.
"-------------------------------------------------------------------------------
" Paste C++ template.
nnoremap <Leader>tcpp :-1read ~/Templates/Template.cpp<CR>
" Paste Python unit test.
nnoremap <Leader>tupy :-1read ~/Templates/UnitTest.py<CR>
" Paste Rust template.
nnoremap <Leader>trs :-1read ~/Templates/Template.rs<CR>
"-------------------------------------------------------------------------------
" Interface.
"-------------------------------------------------------------------------------
set encoding=utf-8			" Set encoding to UTF-8 to recognize Greek/Cyrillic.
set ruler 					" Set the ruler to see the line and column.
set cindent					" Add indentation when S or cc is pressed.
set colorcolumn=81			" Reminder to keep lines at most 80 characters long.
set clipboard=unnamedplus	" Share clipboard with operating system.
set backspace=2				" Enable backspace when using gVim.
set number					" Enable line numbers.
set tabstop=4				" Shorten the tab size to 4 spaces.
set shiftwidth=4			" Set tab size to 4 spaces.
set autoindent				" Automatic indentation when going to next line.
set nocompatible			" Not compatible with Vi (embrace the future).
set autoread				" Auto reload changed files.
set history=20 				" History file is at most 20 lines.
set ignorecase smartcase	" Search queries intelligently set case.
set incsearch				" Show search results as you type.
set background=dark			" Tell Vim if the background is light or dark.
set showcmd                 " Show commands as they are typed on the banner.
"-------------------------------------------------------------------------------
" Colors & Formatting.
"-------------------------------------------------------------------------------
" Enable code syntax highlighting.
syntax enable
" Enable plugins.
filetype indent plugin on
" Set color scheme for terminal.
colorscheme desert
" Show comments in gray italics.
highlight Comment ctermfg=Gray gui=italic
" Show comments in gray italics.
highlight Comment ctermfg=Gray gui=italic

" Support true color in vim. 
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Change gVim looks depending on operating system.
if has("gui_running")
	if has("gui_gtk2")
		set guifont=Inconsolata\ 15
	elseif has("gui_win32")
		set guifont=Consolas:h15:cANSI
		colorscheme slate
	endif
endif

" Enable gVim terminal to use wsl when using Windows 10.
if has("win32")
    set shell=C:\Windows\Sysnative\wsl.exe
    set shellpipe=|
    set shellredir=>
    set shellcmdflag=
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
" Other.
"-------------------------------------------------------------------------------
" autocmd Filetype scss if getfsize(@%) > 300 | setlocal syntax=OFF | endif
" set smartindent				" Indent text inside brackets
"-------------------------------------------------------------------------------
