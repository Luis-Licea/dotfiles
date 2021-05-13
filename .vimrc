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
" Remove tabs and convert them to spaces.
nnoremap <Leader>rt :retab<CR>
" Remove swap file. Make the command long in purpose.
nnoremap <Leader>rswap :!rm '%.swp'<CR>
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
" Auto-closing mappings.
"-------------------------------------------------------------------------------
" Create a shortcut for skipping quotes, parenthesis, etc.
inoremap zw <Esc>wa
" Create shortcuts for auto-closing on the same line.
inoremap z" ""<Esc>i
inoremap z' ''<Esc>i
inoremap z( ()<Esc>i
inoremap z[ []<Esc>i
inoremap z{ {}<Esc>i
" Create shortcuts for auto-closing on the next line.
inoremap z;( (<CR>);<Esc>O
inoremap z,( (<CR>),<Esc>O
inoremap zz(  (<CR>)<Esc>O
inoremap z;{ {<CR>};<Esc>O
inoremap z,{ {<CR>},<Esc>O
inoremap zz{ {<CR>}<Esc>O
inoremap z;[ [<CR>];<Esc>O
inoremap z,[ [<CR>],<Esc>O
inoremap zz[ [<CR>]<Esc>O
"-------------------------------------------------------------------------------
" Snippets. Paste the following code from the specified file into the buffer.
"-------------------------------------------------------------------------------
" Paste C++ template.
nnoremap <Leader>tcpp :-1read ~/Templates/Template.cpp<CR>
" Paste Python unit test.
nnoremap <Leader>tupy :-1read ~/Templates/UnitTest.py<CR>
" Paste Rust template.
nnoremap <Leader>trs :-1read ~/Templates/Template.rs<CR>
"-------------------------------------------------------------------------------
" Vim-plug settings.
"-------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    " Comment and uncomment code sections more easily witch cc and uc.
    Plug 'preservim/nerdcommenter'
    " Surround words in parenthesis, quotations, etc., more easily.
    Plug 'tpope/vim-surround'
    " Minimalist directory viewer.
    Plug 'justinmk/vim-dirvish'
    " Browse cheat sheets from cheat.sh.
    Plug 'dbeniamine/cheat.sh-vim'
    " Provide Cargo commands, and Rust syntax highlighting and formatting.
    Plug 'rust-lang/rust.vim'
    " Automatically setup language servers.
    Plug 'prabirshrestha/vim-lsp'
    " Install and update language servers using LspInstallServer.
    Plug 'mattn/vim-lsp-settings'
    " Provide asynchronous autocomplete.
    Plug 'prabirshrestha/asyncomplete.vim'
    " Provide asynchronous autocomplete using language servers.
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    " Use dark coloscheme inspired on Visual Studio Code.
    Plug 'tomasiser/vim-code-dark'
    " Improve the status line.
    Plug 'vim-airline/vim-airline'
    " Show open buffers. Integrates well with air-line plugin.
    Plug 'bling/vim-bufferline'
call plug#end()
"-------------------------------------------------------------------------------
" Dirvish mappings. Prefix t means "tree".
"-------------------------------------------------------------------------------
" Execute selected arguments.
nnoremap <Leader>tx :argdo !clear && '%'<CR>
" Open/close Dirvish tree.
nnoremap <Leader>tt :Dirvish<CR>
"-------------------------------------------------------------------------------
" Vim-code-dark settings.
"-------------------------------------------------------------------------------
" Set the color scheme. The codedark scheme requires vim-code-dark plugin.
colorscheme codedark
"-------------------------------------------------------------------------------
" Vim-airline settings.
"-------------------------------------------------------------------------------
" Use the codedark air-line. Needs air-line and code-dark plugins.
let g:airline_theme = 'codedark'
"-------------------------------------------------------------------------------
" Rust-vim settings.
"-------------------------------------------------------------------------------
" Format Rust file using rustfmt each time the file is saved.
let g:rustfmt_autosave = 1
" TODO
" Provide RustRun and Crun mapping to run single files or cargo files.
" Also provide RustTest, RustEmitIr, RustEmitAsm, RustFmt, Ctest, Cbuild.
"-------------------------------------------------------------------------------
" Rusty-tags settings (Installed using `cargo install rusty-tags`).
"-------------------------------------------------------------------------------
" Looks for tags in current directory's rusty-tags.vi folder to the root.
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
" TODO
" Set shortcut to make tag, jump to tag, and split window and go to tag. 
"-------------------------------------------------------------------------------
" Vim-lsp mappings. Prefix g means "go".
"-------------------------------------------------------------------------------
" Install Rust server.
" rustup component add rls rust-analysis rust-src
" Run :LspInstallServer inside a corresponding file.

" Install Python server.
" pip3 install python-language-server
" apt-get install python3-venv
" Run :LspInstallServer inside a corresponding file.

" Install C++ server.
" Run :LspInstallServer inside a corresponding file.Fix the errors as follows:
" sudo update-alternatives --install /lib/x86_64-linux-gnu/libz3.so.4.8 libz3.4.8 /lib/x86_64-linux-gnu/libz3.so.4 100
" I knew that libz3.so.4 already existed on my system because I found it using sudo find / -xdev -name 'libz3*'.
" Run :LspInstallServer inside a corresponding file.

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    " Start formatting server when the file is opened.
    autocmd! BufWritePre *.py,*.cpp,*.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
"-------------------------------------------------------------------------------
" Asyncomplete mappings.
"-------------------------------------------------------------------------------
" Next suggestion using Tab.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" Previous suggestion using Shift+Tab.
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Close popup using the Enter key.
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
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
" Interface.
"-------------------------------------------------------------------------------
set nocompatible            " Not compatible with Vi (embrace the future).
set background=dark         " Tell Vim if the background is light or dark.
set encoding=utf-8          " Set encoding to UTF-8 to recognize Greek/Cyrillic.
set ruler                   " Set the ruler to see the line and column.
set colorcolumn=81          " Reminder to keep lines at most 80 characters long.
set clipboard=unnamedplus   " Share clipboard with operating system.
set incsearch               " Show search results as you type.
set showcmd                 " Show commands as they are typed on the banner.
set number                  " Enable line numbers.
"-------------------------------------------------------------------------------
" Tabs & spaces.
"-------------------------------------------------------------------------------
set tabstop=4               " Tell vim how many columns a tab counts for.
set softtabstop=4           " Mixes tabs and spaces unless equal to tabstop.
set shiftwidth=4            " Control how text is indented when using << and >>.
set expandtab               " Tells vim to replace tabs with spaces.
set backspace=2             " Enable backspace when using gVim.
"-------------------------------------------------------------------------------
" Indentation.
"-------------------------------------------------------------------------------
set autoindent              " Automatic indentation when going to next line.
set cindent                 " Add indentation when S or cc is pressed.
"-------------------------------------------------------------------------------
" Other.
"-------------------------------------------------------------------------------
set spell                       " Set spelling on.
set autoread                    " Auto reload changed files.
set history=20                  " History file is at most 20 lines.
set ignorecase smartcase        " Search queries intelligently set case.
set listchars=tab:◃―▹,trail:●   " Define tab and trailing space characters.
set list                        " Show tabs and trailing spaces.
"-------------------------------------------------------------------------------
" File finder.
"-------------------------------------------------------------------------------
set path+=**                " Looks into subfolders to find and open a file.
                            " :find filename - finds the file in subfolders.
                            " Press Tab for suggesting files.
                            " Use * as a wild card for beginnings or endings.
set wildmenu                " Display all matching files when tab is pressed.
                            " :b filename - goes to other buffers.
                            " Can use Tab or specify unique filename substring.
"-------------------------------------------------------------------------------
" Colors & Formatting.
"-------------------------------------------------------------------------------
" Enable code syntax highlighting.
syntax enable
" Enable plugins.
filetype indent plugin on
" Show comments in italics.
highlight Comment cterm=italic gui=italic

" Underline, rather than highlight, errors.
highlight SpellBad   guisp=red    gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
highlight SpellCap   guisp=yellow gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
highlight SpellRare  guisp=blue   gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline
highlight SpellLocal guisp=orange gui=undercurl guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE term=underline cterm=underline

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

" Enable gVim terminal to use WSL when using Windows 10.
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
