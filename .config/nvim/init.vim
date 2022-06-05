"-------------------------------------------------------------------------------
" Ungrouped Mappings. NOTE: Do not place comments in the same line as mappings.
"-------------------------------------------------------------------------------
" Leader Mapping.
let mapleader="\<space>"
" localleader Mapping.
let maplocalleader=","
" Map localleader to CTRL-W.
map <localleader> <c-w>
" Save file.
nnoremap <leader>w :write<cr>
" Spawn a new terminal in the folder of the current file.
nnoremap <leader>t :let $VIM_DIR=expand('%:p:h')<CR>:!alacritty --working-directory $VIM_DIR &<CR>
" Quit vim.
nnoremap <leader>q :quit<cr>
" Add indentation when S or cc is pressed.
nnoremap <leader>c :set cindent<cr>
" Load .vimrc.
nnoremap <leader>so :source ~/.config/nvim/init.vim<cr>
" Fix syntax highlighting.
nnoremap <leader>fs :syntax sync fromstart<cr>
" Check script to make it POSIX compliant.
nnoremap <leader>sc :!clear && shellcheck "%"<cr>
" Remove trailing white space.
nnoremap <leader>rw :%s/\s\+$//e<cr>
" Remove tabs and convert them to spaces.
nnoremap <leader>rt :retab<cr>
" Remove swap file. Make the command long in purpose.
nnoremap <leader>rswap :!rm '%.swp'<cr>
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
" Insert mode mappings.
"-------------------------------------------------------------------------------
" Move up autocomplete options in insert mode.
inoremap <c-k> <c-p>
" Move down autocomplete options in insert mode.
inoremap <c-j> <c-n>

"-------------------------------------------------------------------------------
" Normal mode mappings.
"-------------------------------------------------------------------------------
" Remap fast movement.
nnoremap <c-k> <c-u>
nnoremap <c-j> <c-d>

"-------------------------------------------------------------------------------
" Resize Window mappings. Prefix is "ctrl".
"-------------------------------------------------------------------------------
" Increase height by N lines.
vnoremap <c-k> 4<c-w>+
" Decrease height by N lines.
vnoremap <c-j> 4<c-w>-
" Increase width by N lines.
vnoremap <c-l> 4<c-w>>
" Decrease width by N lines.
vnoremap <c-h> 4<c-w><

"-------------------------------------------------------------------------------
" Disable arrow keys.
"-------------------------------------------------------------------------------
noremap <up>    <nop>
noremap <down>  <nop>
noremap <left>  <nop>
noremap <right> <nop>

"-------------------------------------------------------------------------------
" File mappings. Prefix f means "file".
"-------------------------------------------------------------------------------
" Print file name.
nnoremap <leader>fn :echo expand('%:t')<cr>
" Print file path (full).
nnoremap <leader>fp :echo expand("%:p")<cr>
" Print file directory.
nnoremap <leader>fd :echo expand("%:p:h")<cr>

"-------------------------------------------------------------------------------
" Yank mappings. Prefix y means "yank".
"-------------------------------------------------------------------------------
" Copy file path to clipboard.
nnoremap <silent> yf :let @+=expand('%:p')<cr>
" Copy pwd to clipboard.
nnoremap <silent> yd :let @+=expand('%:p:h')<cr>
" Copy buffer contents to clipboard.
nnoremap <silent> yb :%y<cr>

"-------------------------------------------------------------------------------
" Switch mappings. Prefix s means "switch".
"-------------------------------------------------------------------------------
" Switch relative numbers.
nnoremap <leader>sr :set relativenumber!<cr>
" Switch numbered lines.
nnoremap <leader>sn :set number!<cr>
" Switch paste.
nnoremap <leader>sp :set paste!<cr>
" Switch automatic indentation.
nnoremap <leader>sa :set autoindent!<cr>
" Switch wrap.
nnoremap <leader>sw :set wrap!<cr>
" Switch highlight search.
nnoremap <leader>sh :set hlsearch!<cr>

"-------------------------------------------------------------------------------
" Spellcheck mappings. Prefix s means "spell".
"-------------------------------------------------------------------------------
" Switch spellcheck for English.
nnoremap <leader>sse :setlocal spell spelllang=en<cr>
" Switch spellcheck for Spanish.
nnoremap <leader>sss :setlocal spell spelllang=es<cr>
" Switch spellcheck for Russian.
nnoremap <leader>ssr :setlocal spell spelllang=ru<cr>
" Switch spellcheck.
nnoremap <leader>sso :setlocal spell!<cr>

"-------------------------------------------------------------------------------
" Buffer mappings. Prefix b means "buffer".
"-------------------------------------------------------------------------------
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
" Remaping localleader to CTRL-W enabled the following mappings.
" <localleader>= - make all windows equal height & width
" <localleader>h - move cursor to the left window
" <localleader>j - move cursor to the window below
" <localleader>k - move cursor to the window above
" <localleader>l - move cursor to the right window
" <localleader>q - quit a window
" <localleader>r - rotate windows upwards N times
" <localleader>w - switch windows
" <localleader>x - exchange current window with next one
" <localleader>s - split window
" <localleader>v - split window vertically
" Split window (add for responsiveness).
" nnoremap <localleader>s :sp<cr>
" Split window vertically (add for responsiveness).
" nnoremap <localleader>v :vsp<cr>

"-------------------------------------------------------------------------------
" Embedded terminal settings and mappings.
"-------------------------------------------------------------------------------
" Move cursor to the left window.
tnoremap <localleader>h <c-\><c-n><cr><c-w>h
" Move cursor to the window above.
tnoremap <localleader>j <c-\><c-n><cr><c-w>j
" Move cursor to the window below.
tnoremap <localleader>k <c-\><c-n><cr><c-w>k
" Move cursor to the right window.
tnoremap <localleader>l <c-\><c-n><cr><c-w>l
" Turn off spelling in terminal.
au TermOpen * setlocal nospell
" Disable line numbering in terminal.
au TermOpen * setlocal nonumber
" Press escape twice to exit. Add only to zsh because it conflicts with fzf.
au TermOpen * if expand('%:t') == "zsh" | tnoremap <c-q> <c-\><c-n> | endif

"-------------------------------------------------------------------------------
" Interface.
"-------------------------------------------------------------------------------
set background=dark         " Tell Vim if the background is light or dark.
set clipboard=unnamedplus   " Share clipboard with operating system.
set colorcolumn=81          " Reminder to keep lines at most 80 characters long.
set encoding=utf-8          " Set encoding to UTF-8 to recognize Greek/Cyrillic.
set incsearch               " Show search results as you type.
set mouse=a                 " Enable mouse wheel in all Vim modes.
set nocompatible            " Not compatible with Vi (embrace the future).
set number                  " Enable line numbers.
set ruler                   " Set the ruler to see the line and column.
set showcmd                 " Show commands as they are typed on the banner.
set termguicolors           " Support true color in vim.

"-------------------------------------------------------------------------------
" Tabs & spaces.
"-------------------------------------------------------------------------------
set backspace=2             " Enable backspace when using gVim.
set expandtab               " Tells vim to replace tabs with spaces.
set shiftwidth=4            " Control how text is indented when using << and >>.
set softtabstop=4           " Mixes tabs and spaces unless equal to tabstop.
set tabstop=4               " Tell vim how many columns a tab counts for.

"-------------------------------------------------------------------------------
" Indentation.
"-------------------------------------------------------------------------------
set autoindent              " Automatic indentation when going to next line.
set cindent                 " Add indentation when S or cc is pressed.

"-------------------------------------------------------------------------------
" Other.
"-------------------------------------------------------------------------------
set autoread                    " Auto reload changed files.
set history=100                 " History file is at most 20 lines.
set ignorecase smartcase        " Search queries intelligently set case.
set list                        " Show tabs and trailing spaces.
set listchars=tab:◃―▹,trail:●   " Define tab and trailing space characters.
set spell                       " Set spelling on.

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
" Colors and Formatting.
"-------------------------------------------------------------------------------
" Enable code syntax highlighting.
syntax enable
" Enable auto indentation and plugins based on file type.
filetype indent plugin on

"-------------------------------------------------------------------------------
" Remember file position.
"-------------------------------------------------------------------------------
" Jump to the last position when reopening a file.
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"-------------------------------------------------------------------------------
" Scratchpads.
"-------------------------------------------------------------------------------
" Execute the file "scratchpad.sh" each time it is saved.
au! BufWritePost scratchpad.sh exec '!bash "%"'

"-------------------------------------------------------------------------------
" Vim Terminal.
"-------------------------------------------------------------------------------
" Close tab immediately after closing terminal.
" au! TermClose * :q

"-------------------------------------------------------------------------------
" Auto-apply Xresources.
"-------------------------------------------------------------------------------
" Apply .Xresources file after editing the file.
au! BufWritePost .Xresources exec '!xrdb && xrdb -merge ~/.Xresources'

"-------------------------------------------------------------------------------
" Program settings.
"-------------------------------------------------------------------------------
" Run C code in Vim.
au FileType c map <buffer> <F5> :w<cr>:exec '!clear; gcc -Wall -Wextra "%" -o "%<" && "./%<"' shellescape(@%, 1)<cr>
au FileType c imap <buffer> <F5> <esc>:w<cr>:exec '!clear; gcc -Wall -Wextra "%" -o "%<" && "./%<"' shellescape(@%, 1)<cr>

" Run C++ code in Vim.
au FileType cpp map <buffer> <F5> :w<cr>:exec '!clear; g++ "%" -o "%<" && "./%<"' shellescape(@%, 1)<cr>
au FileType cpp imap <buffer> <F5> <esc>:w<cr>:exec '!clear; g++ "%" -o "%<" && "./%<"' shellescape(@%, 1)<cr>

" Run Python code in Vim (edit and insert modes).
au FileType python map <buffer> <F5> :w<cr>:exec '!clear; python3' shellescape(@%, 1)<cr>
au FileType python imap <buffer> <F5> <esc>:w<cr>:exec '!clear; python3' shellescape(@%, 1)<cr>

" Run Rust code in Vim.
au FileType rust map <buffer> <F5> :w<cr>:exec '!clear; rustc "%" && ./"%<"' shellescape(@%, 1)<cr>
au FileType rust imap <buffer> <F5> <esc>:w<cr>:exec '!clear; rustc "%" && ./"%<"' shellescape(@%, 1)<cr>

" Compile LaTeX code in Vim.
au FileType tex map <buffer> <F5> :w<cr>:exec '!clear; pdflatex.exe "%"' shellescape(@%, 1)<cr>
au FileType tex imap <buffer> <F5> <esc>:w<cr>:exec '!clear; pdflatex.exe "%"' shellescape(@%, 1)<cr> <cr>

" Spell check and wrap commit messages.
au Filetype gitcommit setlocal spell textwidth=72

"-------------------------------------------------------------------------------
" Vim-plug settings.
"-------------------------------------------------------------------------------
" Install Vim-plug by running :call InstallVimPlug.
function! InstallVimPlug()
    " Download plugin from junegunn/vim-plug/master/plug.vim.
    let $vim_plug_repo='https://raw.githubusercontent.com/
                \junegunn/vim-plug/master/plug.vim'
    " If using Neovim:
    if has('nvim')
        " Set installation path to the nvim directory.
        let $install_path='${XDG_DATA_HOME:-$HOME/.local/share}
            \/nvim/site/autoload/plug.vim'
    else
        " Else set installation path to the .vim directory.
        let install_path='~/.vim/autoload/plug.vim'
    endif

    " Download Vim Plug. The flags tell curl to fail on an empty download, to
    " follow redirects, and to output the download to a file rather than to
    " the terminal.
    !curl -fLo $install_path --create-dirs  $vim_plug_repo
endfunction

" Install plugins by running :PlugInstall.
call plug#begin()
    " Use dark color scheme for Vim.
    Plug 'dracula/vim'
    " Nerd tree system file operations. Access it using "m" key in nerd tree.
    Plug 'ivalkeen/nerdtree-execute'
    " Easily align tables, or text by symbols like , ; = & etc.
    Plug 'junegunn/vim-easy-align'
    " Install and update language servers using LspInstallServer.
    Plug 'mattn/vim-lsp-settings'
    " Nice start screen. NOTE: Put before vim-devicons, or icons won't load.
    Plug 'mhinz/vim-startify'
    " Search tool. NOTE: Install the ack grep utility first.
    Plug 'mileszs/ack.vim'
    " Provide asynchronous autocomplete using language servers.
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    " Provide asynchronous autocomplete.
    Plug 'prabirshrestha/asyncomplete.vim'
    " Automatically setup language servers.
    Plug 'prabirshrestha/vim-lsp'
    " Comment and uncomment code sections more easily witch cc, uc, and ci.
    Plug 'preservim/nerdcommenter'
    " Provide Cargo commands, and Rust syntax highlighting and formatting.
    Plug 'rust-lang/rust.vim'
    " File explorer sidebar.
    Plug 'scrooloose/nerdtree'
    " Provide syntax-highlight for nerd tree icons.
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " Use dark color scheme inspired on Visual Studio Code.
    Plug 'tomasiser/vim-code-dark'
    " Surround words in parenthesis, quotations, etc., more easily.
    Plug 'tpope/vim-surround'
    " Auto pair plugin.
    Plug 'jiangmiao/auto-pairs'
    " Jump to any location specified by two characters.
    Plug 'justinmk/vim-sneak'
    " Fuzzy finder for searching files.
    Plug 'junegunn/fzf.vim'
    " Prettify status line. Add icons to status line and nerd tree.
    " NOTE: Use a patched font such as nerd-fonts-source-code-pro.
    " NOTE: Icons will not display unless airline loads before dev icons.
    Plug 'vim-airline/vim-airline' | Plug 'ryanoasis/vim-devicons'
call plug#end()

"-------------------------------------------------------------------------------
" Startify settings.
"-------------------------------------------------------------------------------
" Automatically save session when leaving. Use :SSave to crate a session.
let g:startify_session_persistence = 1
" Do not show cowsay as part of the quote. It takes a lot of space.
let g:startify_custom_header = 'startify#pad(startify#fortune#quote())'
"-------------------------------------------------------------------------------
"  Ack settings.
"-------------------------------------------------------------------------------
" Open ack finder. The ! means not to jump to the first occurrence.
nnoremap <leader>a :tab split<cr>:Ack! ""<Left>
" Search word under cursor. The ! means not to jump to the first occurrence.
nnoremap <leader>A :tab split<cr>:Ack! <c-r><c-w><cr>

"-------------------------------------------------------------------------------
"  Fuzzy finder settings.
"-------------------------------------------------------------------------------
" Open fuzzy finder.
nnoremap <leader>ff :FZF<cr>

"-------------------------------------------------------------------------------
"  Sneak settings.
"-------------------------------------------------------------------------------
" Replace f with two-character Sneak. One-character Sneak is used when needed.
map f <Plug>Sneak_s
" Replace F with two-character Sneak. One-character Sneak is used when needed.
map F <Plug>Sneak_S
" Replace t with one-character Sneak. Works over multiple lines.
map t <Plug>Sneak_t
" Replace T with one-character Sneak. Works over multiple lines.
map T <Plug>Sneak_T
" Go to next or previous results using f or F.
let g:sneak#s_next = 1

"-------------------------------------------------------------------------------
" Nerd commenter settings.
"-------------------------------------------------------------------------------
" Add spaces after comment delimiters.
let g:NERDSpaceDelims = 1
" Map Ctrl+/ to toggle comment.
map <c-_> <plug>NERDCommenterToggle
" <leader>c$ " NERDCommenteToEOL Comment current line from cursor to line end.
" <leader>cA " NERDCommenterAppend Add comments to line end go to insert mode.
" <leader>ca " NERDCommenterAltDelims Switches to alternative set of delimiters.
" [N]<leader>cb " NERDCommenterAlignBoth Same as cc but aligned on both sides.
" [N]<leader>cl " NERDCommenterAlignLeft Same as cc but aligned to left side.
" [N]<leader>cm " NERDCommenterMinimal Only use one set of multipart delimiters.
" [N]<leader>cn " NERDCommenterNested Same as cc but forces nesting.
" [N]<leader>cs " NERDCommenterSexy Pretty block formatted layout.
" [N]<leader>cu " NERDCommenterUncomment Uncomment lines.
" [N]<leader>cy " NERDCommenterYank Yank lines and then comment cc them.

"-------------------------------------------------------------------------------
" Nerd tree mappings. Prefix n means "nerd".
"-------------------------------------------------------------------------------
" Go to sidebar tree.
nnoremap <leader>nf :NERDTreeFocus<cr>
" Go to project root.
nnoremap <leader>nn :NERDTree<cr>
" Switch sidebar tree.
nnoremap <leader>nt :NERDTreeToggle<cr>
" Find current file in tree.
nnoremap <leader>nf :NERDTreeFind<cr>
" Refresh files
nnoremap <leader>nr :NERDTreeFind<cr>
" Show hidden files by default.
let NERDTreeShowHidden=1

"-------------------------------------------------------------------------------
" Vim-Devicons settings.
"-------------------------------------------------------------------------------
" Integrate with powerline. Adds nice colors and decorative edges to sections.
let g:airline_powerline_fonts = 1

"-------------------------------------------------------------------------------
" Vim-code-dark settings.
"-------------------------------------------------------------------------------
" Set the color scheme. The schemes codedark and dracula are plugins.
" colorscheme codedark
colorscheme dracula
" Make the background transparent.
highlight normal guibg=none ctermbg=none

"-------------------------------------------------------------------------------
" Vim-airline settings.
"-------------------------------------------------------------------------------
" let g:airline_theme = 'codedark'
let g:airline_theme = 'dracula'
" Displays all buffers in upper tab line.
let g:airline#extensions#tabline#enabled = 1

"-------------------------------------------------------------------------------
" Rust-vim settings.
"-------------------------------------------------------------------------------
" Format Rust file using rustfmt each time the file is saved.
let g:rustfmt_autosave = 1
" TODO Provide RustRun and Crun mapping to run single files or cargo files.
" Also provide RustTest, RustEmitIr, RustEmitAsm, RustFmt, Ctest, Cbuild.

"-------------------------------------------------------------------------------
" Rusty-tags settings (Installed using `cargo install rusty-tags`).
"-------------------------------------------------------------------------------
" Looks for tags in current directory's rusty-tags.vi folder to the root.
au BufRead *.rs :setlocal tags=./rusty-tags.vi;/
au BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
" TODO Set shortcut to make tag, jump to tag, and split window and go to tag.

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
    au! BufWritePre *.py,*.cpp,*.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " Call s:on_lsp_buffer_enabled only for languages with registered servers.
    au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"-------------------------------------------------------------------------------
" Asyncomplete mappings.
"-------------------------------------------------------------------------------
" Next suggestion using Tab.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" Previous suggestion using Shift+Tab.
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Close pop-up using the Enter key.
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
