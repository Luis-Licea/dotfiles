lua << EOF
    require('config')
EOF

set mouse=n                 " Enable mouse wheel in normal modes.
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
function! ToggleAutoRun()
    if s:auto_run  == 0
        let s:auto_run = 1
    else
        let s:auto_run = 0
    endif
endfunction
nnoremap <leader>ct :call ToggleAutoRun()<cr>

" Function for toggling code formatting on save:
let s:auto_format = 0
function! ToggleAutoFormat()
    if s:auto_format  == 0
        let s:auto_format = 1
    else
        let s:auto_format = 0
    endif
endfunction
nnoremap <leader>cf :call ToggleAutoFormat()<cr>

" Whether to include debugging information.
let s:is_debug = 0
function! ToggleDebug()
    if s:is_debug  == 0
        let s:is_debug = 1
    else
        let s:is_debug = 0
    endif
endfunction
nnoremap <leader>cd :call ToggleDebug()<cr>

" Benchmark the execution time of compiled binary.
function! Time_cpp_c_rs()
    " Remove the parent directories and extension to get file name.
    let l:file=expand('%:t:r')

    " Define the path where the compiled executable will be placed, and where
    " it should be executed.
    let l:executable_path='/tmp/' . l:file

    " Run the file.
    exe printf('!/usr/bin/time -p bash -c "for ((i=1;i<=1000;i++)); do \"%s\" > /dev/null; done"', l:executable_path)
endfunction
" Call the function by simply typing :Time.
command! Time call Time_cpp_c_rs()

" Another compiler for c is tcc.
let s:ft2compiler = {
            \'c'            : 'gcc',
            \'cpp'          : 'g++',
            \'rust'         : 'rustc',
            \'vala'         : 'valac',
            \}

" Validate GLSL code: vert, tesc, tese, glsl, geom, frag, comp.
let s:ft2interpreter = {
            \'python'       : 'python3',
            \'java'         : "java",
            \'lua'          : "lua",
            \'sh'           : "bash",
            \'javascript'   : "node",
            \'glsl'         : "glslangValidator",
            \}

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
" Wpedantic: Demand strict ISO C and ISO C++; no forbidden extensions.
" Wconversion: Warn implicit conversions that may alter a value.
let s:cflags=' -Wall -Wextra -Wfloat-conversion -Wshadow
            \ -Wsign-conversion -Wconversion '

" g: Produce debugging info for GDB.
" fsanitize=address: Warns use after free.
" fsanitize=leak: Warns when pointers have not been freed.
" fsanitize=undefined: Detects undefined behavior.
" fsanitize-address-use-after-scope: Catches references to temporary
"   values. The value may be gone before the reference is accessed.
let s:debug_flags=' -g -fsanitize=address,leak,undefined
            \ -fsanitize-address-use-after-scope '

let s:ft2flags = {
            \'c'          : s:cflags,
            \'cpp'        : s:cflags . '-std=c++17',
            \}

let s:ft2debugflags = {
            \'c'          : s:debug_flags,
            \'cpp'        : s:debug_flags,
            \'rust'       :'-g'
            \}

function! SetupLanguageBindings(ft2compiler, ft2interpreter)
    " If the file type is supported:
    if has_key(a:ft2compiler, &ft) || has_key(a:ft2interpreter, &ft)
        " Set key bindings to run the program.
        map <buffer> <F5> :call Run()<cr>
        imap <buffer> <F5> <esc>:call Run()<cr>
        return
    endif
endfunction

call SetupLanguageBindings(s:ft2compiler, s:ft2compiler)

function! Run()
    " Compile and execute program in tmp folder.

    " If the interpreted language is supported:
    if has_key(s:ft2interpreter, &filetype)
        " Get the interpreter.
        let l:interpreter=s:ft2interpreter[&filetype]

        " Get the file path.
        let l:path=expand('%')

        " Run the file.
        exe printf("!%s %s", l:interpreter, l:path)
    endif

    " If the compiled language is supported:
    if has_key(s:ft2compiler, &filetype)
        " Compile the file based on its type.
        " Set the correct compiler for C, C++, Rust, etc.
        let l:compiler=s:ft2compiler[&filetype]

        " Get the absolute file to the file.
        let l:path=expand('%')

        " Remove the parent directories and extension to get file name.
        let l:file=expand('%:t:r')

        " Define the path where the compiled executable will be placed, and
        " where it should be executed.
        let l:executable_path="/tmp/" . l:file

        " By default do not pass additional compilation flags.
        let l:flags = ''

        " If the language has additional compilation flags:
        if has_key(s:ft2flags, &filetype)
            " Pass the additional compilation flags.
            let l:flags = s:ft2flags[&filetype]
        endif

        " If the language has debug flags, and debugging is enabled:
        if has_key(s:ft2debugflags, &filetype) && s:is_debug
            " Pass the additional compilation flags.
            let l:flags = s:ft2debugflags[&filetype] . ' ' . l:flags
        endif

        " Compile and run the file.
        exe printf('!%s %s %s -o "%s" && "%s"', l:compiler, l:flags, l:path,
                    \l:executable_path, l:executable_path)
    endif
endfunction

" For all programs.
    aug Program
        au!
        au BufWritePost * if s:auto_run == 1 | call Run() | endif
    aug end

" C++ code settings.
    aug CppGroup
        au!
        au FileType cpp set shiftwidth=2 | set softtabstop=2  | set tabstop=2
    aug end

" JavaScript code settings.
    aug JSGroup
        au!
        au BufEnter *.mjs set filetype=javascript
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
au! BufEnter scratchpad.* call ToggleAutoRun() | call ToggleAutoFormat()

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

" Install plugins by running :PlugInstall. Default path is
" ~/.local/share/nvim/plugged.
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
    " Fuzzy finder for files, buffers, mru files, and tags.
    Plug 'kien/ctrlp.vim'
    " Show indentation lines.
    Plug 'lukas-reineke/indent-blankline.nvim'
    " Install and update language servers using LspInstallServer.
    Plug 'mattn/vim-lsp-settings'
    " Nice start screen. NOTE: Put before vim-devicons, or icons won't load.
    Plug 'mhinz/vim-startify'
    " Search tool. NOTE: Install the ag (silver-searcher grep) utility first.
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
    " Add OpenGL Shader Language support.
    Plug 'tikhomirov/vim-glsl'
    " Use dark color scheme inspired on Visual Studio Code.
    Plug 'tomasiser/vim-code-dark'
    " Surround words in parenthesis, quotations, etc., more easily.
    Plug 'tpope/vim-surround'
    " Prettify status line. Add icons to status line and nerd tree.
    " NOTE: Use a patched font such as nerd-fonts-source-code-pro.
    " NOTE: Icons will not display unless airline loads before dev icons.
    Plug 'vim-airline/vim-airline' | Plug 'ryanoasis/vim-devicons'
    " Add Doxygen support.
    Plug 'vim-scripts/DoxygenToolkit.vim'
    " A powerful autopair plugin for Neovim that supports multiple characters.
    Plug 'windwp/nvim-autopairs'
    " Tagbar: a class outline viewer for Vim.
    Plug 'preservim/tagbar' " Requires universal ctags.
call plug#end()

lua << EOF
    -- Load autopair plugin.
    require("nvim-autopairs").setup {}
EOF
"-------------------------------------------------------------------------------
" CtrlP settings.
"-------------------------------------------------------------------------------
" Run :CtrlP or :CtrlP [starting-directory] to invoke CtrlP in find file mode.
" Run :CtrlPBuffer or :CtrlPMRU to invoke CtrlP in find buffer or find MRU file mode.
" Run :CtrlPMixed to search in Files, Buffers and MRU files at the same time.
"
" Check :help ctrlp-commands and :help ctrlp-extensions for other commands.
" Once CtrlP is open:
"
" Press <F5> to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.
" Press <c-f> and <c-b> to cycle between modes.
" Press <c-d> to switch to filename only search instead of full path.
" Press <c-r> to switch to regexp mode.
" Use <c-j>, <c-k> or the arrow keys to navigate the result list.
" Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
" Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
" Use <c-y> to create a new file and its parent directories.
" Use <c-z> to mark/unmark multiple files and <c-o> to open them.
"
 "Run :help ctrlp-mappings or submit ? in CtrlP for more mapping help.
"
" Submit two or more dots .. to go up the directory tree by one or multiple levels.
" End the input string with a colon : followed by a command to execute it on the opening file(s):
" Use :25 to jump to line 25.
" Use :diffthis when opening multiple files to run :diffthis on the first 4 files

" Set silver-searcher for faster searches if available.
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Show hidden files.
" let g:ctrlp_show_hidden = 1

" Ignore these files from searchers.
" set wildignore+=*.so,*/,*/.sass-cache/*,*/node_modules/*,*/.git/*

" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_custom_ignore = {
  " \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  " \ 'file': '\v\.(exe|so|dll)$|\v(node_modules)*',
  " \ }

" set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.yardoc/*,*.exe,*.so,*.dat
" let g:ctrlp_custom_ignore = {
    " \'dir': '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$',
    " \'file': '\v\.(dll|min.js|min.css|jpg|png|mp4)$'
" \}

"-------------------------------------------------------------------------------
" Switch between files and headers: c -> h and cpp -> hpp.
"-------------------------------------------------------------------------------
command! A LspDocumentSwitchSourceHeader

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
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
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
" Close Nerd tree after opening a file.
let g:NERDTreeQuitOnOpen = 1

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
    au! BufWritePre *.py,*.cpp,*.hpp,*.rs,*.c,*.h if s:auto_format == 1 | call execute('LspDocumentFormatSync') | endif

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
