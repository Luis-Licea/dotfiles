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
noremap <leader>t :let $VIM_DIR=expand('%:p:h')<CR>:sil !setsid --fork alacritty --working-directory $VIM_DIR &<CR>
" Spawn a new ranger terminal in the folder of the current file.
noremap <leader>rt :let $VIM_DIR=expand('%:p:h')<CR>:sil !setsid --fork alacritty --working-directory $VIM_DIR -e ranger<CR>
" Quit vim.
nnoremap <leader>q :quit<cr>
" Load .vimrc.
nnoremap <leader>so :source ~/.config/nvim/init.vim<cr>
" Fix syntax highlighting.
nnoremap <leader>fs :syntax sync fromstart<cr>
" Check script to make it POSIX compliant.
nnoremap <leader>sc :!shellcheck "%"<cr>
" Remove trailing white space.
nnoremap <leader>rw :%s/\s\+$//e<cr>
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
" Normal mode mappings. Fast movement.
"-------------------------------------------------------------------------------
" Move a page up.
nnoremap <c-k> <c-u>
" Move a page down.
nnoremap <c-j> <c-d>

"-------------------------------------------------------------------------------
" Resize Window mappings.
"-------------------------------------------------------------------------------
" Increase height by N lines.
noremap <up> 4<c-w>+
" Decrease height by N lines.
noremap <down> 4<c-w>-
" Increase width by N lines.
noremap <right> 4<c-w>>
" Decrease width by N lines.
noremap <left> 4<c-w><

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
" Copy file name to clipboard.
nnoremap <silent> yn :let @+=expand('%:t')<cr>
" Copy file path to clipboard.
nnoremap <silent> yp :let @+=expand('%:p')<cr>
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
aug TermOpenGroup
    " Clear previous group auto commands to avoid duplicate definitions.
    au!
    " Turn off spelling in terminal.
    au TermOpen * setlocal nospell
    " Disable line numbering in terminal.
    au TermOpen * setlocal nonumber
    " Press escape twice to exit. Add only to zsh because it conflicts with fzf.
    au TermOpen * if expand('%:t') == "zsh" | tnoremap <c-q> <c-\><c-n> | endif
aug end

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
aug RememberFilePositionGroup
    " Clear previous group auto commands to avoid duplicate definitions.
    au!
    " Jump to the last position when reopening a file.
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
aug end

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
" Auto compilation settings.
"-------------------------------------------------------------------------------
" Function for toggling auto compilation on save:
let s:auto_run = 0
function! AutoRunToggle()
    if s:auto_run  == 0
        let s:auto_run = 1
    else
        let s:auto_run = 0
    endif
endfunction
nnoremap <leader>ct :call AutoRunToggle()<CR>

" Function for toggling code formatting on save:
let s:auto_format = 0
function! AutoFormatToggle()
    if s:auto_format  == 0
        let s:auto_format = 1
    else
        let s:auto_format = 0
    endif
endfunction
nnoremap <leader>cf :call AutoFormatToggle()<CR>

function! SetCompiledLanguageVariables(language, flags)
    " Remove the parent directories and extension to get file name.
    let $file=expand('%:t:r')

    " Define the path where the compiled executable will be placed, and where
    " it should be executed.
    let $executable_path="/tmp/" . $file

    " Set the correct compiler for C, C++, Rust, etc.
    " let $compiler="tcc"
    if a:language == 'C'        | let $compiler='gcc'
    elseif a:language == 'C++'  | let $compiler='g++'
    elseif a:language == 'Rust' | let $compiler='rustc'
    elseif a:language == 'Vala' | let $compiler='valac'
    endif

    " Set different default compilation flags for C, C++, Rust, etc.
    if a:language == 'C' || a:language == 'C++'

        " Sample CMake flags.
        " set(CMAKE_CXX_FLAGS_DEBUG_INIT "-fsanitize=address,undefined -fsanitize-undefined-trap-on-error")
        " set(CMAKE_EXE_LINKER_FLAGS_INIT "-fsanitize=address,undefined -static-libasan")
        " set(CMAKE_CXX_FLAGS_INIT "-Werror -Wall -Wextra -Wpedantic")
        " # toolchain file for use with gcov
        " set(CMAKE_CXX_FLAGS_INIT "--coverage -fno-exceptions -g")

        " C++ and C compilation flags:
        " Wall: Warn questionable or easy to avoid constructions.
        " Wextra: Some extra warnings not enabled by -Wall.
        " Wfloat-conversion: Warns when doubles implicitly converted to floats.
        " Wsign-conversion: Warn implicit conversion that change integer sign.
        " Wshadow: Find errors particularly regarding unique_lock<mutex>(my_mutex);
        " fsanitize=address: Warns use after free.
        " fsanitize=leak: Warns when pointers have not been freed.
        " fsanitize=undefined: Detects undefined behavior.
        " fsanitize-address-use-after-scope: Catches references to temporary
        "   values. The value may be gone before the reference is accessed.
        " Wpedantic: Demand strict ISO C and ISO C++; no forbidden extensions.
        " Wconversion: Warn implicit conversions that may alter a value.
        let $flags=a:flags . ' -Wall -Wextra -Wfloat-conversion -Wshadow
                    \ -Wsign-conversion -Wconversion
                    \ -fsanitize=address,leak,undefined
                    \ -fsanitize-address-use-after-scope'
    elseif a:language == 'Rust'
        let $flags=a:flags
    endif
endfunction

" Benchmark the execution time of compiled binary.
function! Time_cpp_c_rs()
    !/usr/bin/time -p bash -c "for ((i=1;i<=1000;i++)); do \"$executable_path\" > /dev/null; done"
endfunction
" Call the function by simply typing :Time.
command Time call Time_cpp_c_rs()

" -g: Include debugging information.
let $debug_flag = ''
function! DebugToggle()
    if $debug_flag == ''
        let $debug_flag = '-g'
    else
        let $debug_flag = ''
    endif
endfunction
nnoremap <leader>cd :call DebugToggle()<CR>

function! Run()
    " Save file.
    w!
    " Compile and execute program in tmp folder.
    !eval $compiler $debug_flag $flags "%" -o "$executable_path" && "$executable_path"
endfunction

function! Interpret(language)
    " Save file.
    w!
    " Use the correct interpreter for each language.
    if a:language == 'Python'   | !python3 "%"
    elseif a:language == 'Java' | !java "%"
    elseif a:language == 'Bash' | !bash "%"
    endif
endfunction

" Run C code in Vim.
    aug CGroup
        " Clear previous group auto commands to avoid duplicate definitions.
        au!
        au FileType c map <buffer> <F5> :call Run()<cr>
        au FileType c imap <buffer> <F5> <esc>:call Run()<cr>
        au FileType c call SetCompiledLanguageVariables('C', '')
        au BufWritePost *.c if s:auto_run == 1 | call Run() | endif
    aug end

" Run C++ code in Vim.
    aug CppGroup
        au!
        au FileType cpp map <buffer> <F5> :call Run()<cr>
        au FileType cpp imap <buffer> <F5> <esc>:call Run()<cr>
        au FileType cpp set shiftwidth=2 | set softtabstop=2  | set tabstop=2
        au BufWritePost *.cpp if s:auto_run == 1 | call Run() | endif
        au FileType cpp call SetCompiledLanguageVariables('C++', '-std=c++17')
    aug end

" Run Python code in Vim (edit and insert modes).
    aug PyGroup
        au!
        au FileType python map <buffer> <F5> :call Interpret('Python')<cr>
        au FileType python imap <buffer> <F5> <esc>:call Interpret('Python')<cr>
        au BufWritePost *.py if s:auto_run == 1 | call Interpret('Python') | endif
    aug end

" Run Java code in Vim.
    aug JavaGroup
        au!
        au FileType java map <buffer> <F5> :call Interpret('Java')<cr>
        au FileType java imap <buffer> <F5> <esc>:call Interpret('Java')<cr>
        au BufWritePost *.java if s:auto_run == 1 | call Interpret('Java') | endif
    aug end

" Run Rust code in Vim.
    aug RsGroup
        au!
        au FileType rust map <buffer> <F5> :call Run()<cr>
        au FileType rust imap <buffer> <F5> <esc>:call Run()<cr>
        au FileType rust call SetCompiledLanguageVariables('Rust', '')
        au BufWritePost *.rs if s:auto_run == 1 | call Run() | endif
    aug end

" Run bash code in Vim.
    aug ShGroup
        au!
        au FileType sh map <buffer> <F5> :call Interpret('Bash')<cr>
        au FileType sh imap <buffer> <F5> <esc>:call Interpret('Bash')<cr>
        au BufWritePost *.sh if s:auto_run == 1 | call Interpret('Bash') | endif
    aug end

" Run Rust code in Vim.
    aug ValaGroup
        au!
        au FileType vala map <buffer> <F5> :call Run()<cr>
        au FileType vala imap <buffer> <F5> <esc>:call Run()<cr>
        au FileType vala call SetCompiledLanguageVariables('Vala', '')
        au BufWritePost *.vala if s:auto_run == 1 | call Run() | endif
    aug end

" Spell check and wrap commit messages.
au! Filetype gitcommit setlocal spell textwidth=72

"-------------------------------------------------------------------------------
" Latex auto compilation.
"-------------------------------------------------------------------------------
function! SetLaTeXVariables()
    let $rubber_flags='--shell-escape --synctex --inplace'
    " grep: Look for first line that contains "% jobname:". Ignore whitespace.
    " cut: Split the line using the ":" character, and get the second field.
    " xargs: Remove leading whitespace.
    " tr: Remove newline character by using tr.
    " At the end we get a jobname with no loeading spaces; can be many words.
    let $jobname=system('cat ' . expand('%') . ' | grep --max-count=1 "%*jobname:" | cut -d: -f2 | xargs | tr -d "\n"')
endfunction

function! RunLaTeX()
    if $jobname == ""
        " If there is no jobname, compile using the default file name.
        !eval rubber --pdf $rubber_flags "%"
    else
        " Else compile using the jobname.
        !eval rubber --pdf $rubber_flags --jobname \"$jobname\" '%'
    endif
endfunction

function! CleanLaTeX()
    " Use the same flags used for compilation in addition to --clean flag.
    " Do not include --pdf flag as not to remove the output pdf.
    if $jobname == ""
        " Clean files matching the current file's name.
        !eval rubber $rubber_flags --clean '%'
    else
        " Clean files matching the job name.
        !eval rubber $rubber_flags --clean --jobname \"$jobname\" '%'
    endif
endfunction

function! OpenLaTeXPDF(viewer)
    " Assign viewer to a shell variable.
    let $viewer=a:viewer
    if $jobname == ""
        " Get current file's root name (without extension) and add .pdf.
        !$viewr "%:p:r.pdf" &
    else
        " Get current file's head (last path component removed) and add .pdf.
        !$viewer "%:p:h/$jobname.pdf" &
    endif
endfunction

aug LaTeXGroup
    " Clear previous group auto commands to avoid duplicate definitions.
    au!
    " Define variables for compiling file into a PDF.
    au FileType tex call SetLaTeXVariables()
    " Compile the file in the same directory and watch for changes ever 10 seconds.
    au FileType tex nnoremap <buffer> <leader>co :call RunLaTeX()<cr>
    " Clean all files except the compiled pdf.
    au FileType tex nnoremap <buffer> <leader>cr :call CleanLaTeX()<cr>
    " Open the compiled LaTeX pdf with the specified viewer.
    au FileType tex nnoremap <buffer> <leader>cv :sil call OpenLaTeXPDF("zathura")<cr>
    " Compile LaTeX document every time after saving.
    au BufWritePost *.tex if s:auto_run == 1 | call RunLaTeX() | endif
    " Clean the all files except the compiled pdf when exiting.
    au VimLeavePre *.tex :call CleanLaTeX()
aug end

" Compile the file in the same directory and watch for changes ever 10 seconds.
" nnoremap <leader>co :sil exec '!watch -n 10 rubber --pdf --shell-escape --synctex --inplace "%"'<cr>

"-------------------------------------------------------------------------------
" Scratchpads.
"-------------------------------------------------------------------------------
" Execute files named "scratchpad" each time they are saved.
au! BufEnter scratchpad.* call AutoRunToggle() | call AutoFormatToggle()

"-------------------------------------------------------------------------------
" Templates for new files that do not exist.
"-------------------------------------------------------------------------------
function! LoadTemplate(name)
    " The place where the templates are saved.
    let s:template_dir=expand('~/.config/nvim/templates/')
    " Get path to template file.
    let s:templae_path=s:template_dir . fnameescape(a:name)
    " Load the template into the current file.
    exe "0r " . s:templae_path
endfunction

aug TemplateGroup
    au!
    au BufNewFile *.c            call LoadTemplate('skeleton.c')
    au BufNewFile *.cpp          call LoadTemplate('skeleton.cpp')
    au BufNewFile *.html         call LoadTemplate('skeleton.html')
    au BufNewFile *.py           call LoadTemplate('skeleton.py')
    au BufNewFile *.sh           call LoadTemplate('skeleton.sh')
    au BufNewFile CMakeLists.txt call LoadTemplate('CMakeLists.txt')
    au BufNewFile cmake_uninstall.cmake.in call
                \ LoadTemplate('cmake_uninstall.cmake.in')
aug end

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
    " Tabular for tables. Vim-json for conceal. Both needed by vim-markdown.
    Plug 'godlygeek/tabular' | Plug 'elzr/vim-json' | Plug 'preservim/vim-markdown'
    " Nerd tree system file operations. Access it using "m" key in nerd tree.
    Plug 'ivalkeen/nerdtree-execute'
    " Fuzzy finder for searching files.
    Plug 'junegunn/fzf.vim'
    " Easily align tables, or text by symbols like , ; = & etc.
    Plug 'junegunn/vim-easy-align'
    " Show indentation lines.
    Plug 'lukas-reineke/indent-blankline.nvim'
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
    " Prettify status line. Add icons to status line and nerd tree.
    " NOTE: Use a patched font such as nerd-fonts-source-code-pro.
    " NOTE: Icons will not display unless airline loads before dev icons.
    Plug 'vim-airline/vim-airline' | Plug 'ryanoasis/vim-devicons'
    " A powerful autopair plugin for Neovim that supports multiple characters.
    Plug 'windwp/nvim-autopairs'
    " Tagbar: a class outline viewer for Vim.
    Plug 'preservim/tagbar' " Requires universal ctags.
call plug#end()

" Load autopair plugin.
lua << EOF
require("nvim-autopairs").setup {}
EOF

"-------------------------------------------------------------------------------
" Md-vim settings.
"-------------------------------------------------------------------------------
aug MdGroup
    au!
    " Create a binding for formatting tables.
    au BufReadPost *.md nnoremap <buffer><leader>fo :TableFormat()<cr>
    " au FileType cpp set shiftwidth=2 | set softtabstop=2  | set tabstop=2
    " Create a binding for formatting (renumbering) ordered lists.
    au BufReadPost *.md nnoremap <buffer><leader>fl :call MdFixOrderedList()<cr>
    " View compiled markdown pdf.
    au BufReadPost *.md nnoremap <buffer><leader>cv :silent !zathura "/tmp/%<.pdf" &<cr>
    " Auto compile the markdown file after saving if auto compilation is enabled.
    au BufWritePost *.md if s:auto_run == 1 | sil exec '!pandoc "%" -o "/tmp/%<.pdf"' | endif
aug end

" Disable header folding.
let g:vim_markdown_folding_disabled = 1

" Conceal ~~this~~ and *this* and `this` and more.
let g:vim_markdown_conceal = 1

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" Stop adding annoying indentation.
let g:vim_markdown_new_list_item_indent = 0

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format
"-------------------------------------------------------------------------------
" Startify settings.
"-------------------------------------------------------------------------------
" Automatically save session when leaving. Use :SSave to crate a session.
let g:startify_session_persistence = 1
" Do not open blank windows when loading the session.
set sessionoptions=curdir,folds,help,tabpages,winpos ",blank
" Do not show cowsay as part of the quote. It takes a lot of space.
let g:startify_custom_header = 'startify#pad(startify#fortune#quote())'
" Place sessions section first because that is what I access most often.
let g:startify_lists = [
    \ { 'header': ['   Sessions'],       'type': 'sessions' },
    \ { 'header': ['   MRU'],            'type': 'files' },
    \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
    \ ]
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
" Go to project root.
nnoremap <leader>nt :NERDTree<cr>
" Switch sidebar tree.
nnoremap <leader>nn :NERDTreeToggle<cr>
" Find current file in tree.
nnoremap <leader>nf :NERDTreeFind<cr>
" Refresh files
nnoremap <leader>nr :NERDTreeRefreshRoot<cr>
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
" highlight normal guibg=none ctermbg=none

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
" au BufRead *.rs :setlocal tags=./rusty-tags.vi;/
" au BufWritePost *.rs :sil! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
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
    " nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> <leader>gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)

    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    " Start formatting server when the file is opened.
    au! BufWritePre *.py,*.cpp,*.rs,*.c if s:auto_format == 1 | call execute('LspDocumentFormatSync') | endif

    " refer to doc to add more commands
endfunction

aug lsp_install
    " Clear previous group auto commands to avoid duplicate definitions.
    au!
    " Call s:on_lsp_buffer_enabled only for languages with registered servers.
    au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
aug end

"-------------------------------------------------------------------------------
" Asyncomplete mappings.
"-------------------------------------------------------------------------------
" Next suggestion using Tab.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" Previous suggestion using Shift+Tab.
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Close pop-up using the Enter key.
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
