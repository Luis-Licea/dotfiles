lua << EOF
    require'config'
EOF

"" Auto start NERD tree when opening a directory
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif
"
"" Auto start NERD tree if no files are specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | exe 'NERDTree' | endif
"
"" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
"autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

"" improved keyboard support for navigation (especially terminal)
"" https://neovim.io/doc/user/nvim_terminal_emulator.html
"tnoremap <Esc> <C-\><C-n>
"tnoremap <A-h> <C-\><C-n><C-w>h
"tnoremap <A-j> <C-\><C-n><C-w>j
"tnoremap <A-k> <C-\><C-n><C-w>k
"tnoremap <A-l> <C-\><C-n><C-w>l
"nnoremap <A-h> <C-w>h
"nnoremap <A-j> <C-w>j
"nnoremap <A-k> <C-w>k
"nnoremap <A-l> <C-w>l

"" Start terminal in insert mode
"au BufEnter * if &buftype == 'terminal' | :startinsert | endif
"nnoremap <silent> <leader>tt :terminal<CR>
"nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
"nnoremap <silent> <leader>th :new<CR>:terminal<CR>
"tnoremap <C-x> <C-\><C-n><C-w>q

"-------------------------------------------------------------------------------
" Tab settings.
"-------------------------------------------------------------------------------
" Open the current buffer in a new tab.
nnoremap <leader>tn :tabnew %<cr>
" Close the tab.
nnoremap <leader>tc :tabclose<cr>

" Go to tab by number.
noremap <localleader>1 1gt
noremap <localleader>2 2gt
noremap <localleader>3 3gt
noremap <localleader>4 4gt
noremap <localleader>5 5gt
noremap <localleader>6 6gt
noremap <localleader>7 7gt
noremap <localleader>8 8gt
noremap <localleader>9 9gt
noremap <localleader>0 :tablast<cr>

nnoremap <leader>1 <cmd>lua require("bufferline").go_to_buffer(1, true)<cr>
nnoremap <leader>2 <cmd>lua require("bufferline").go_to_buffer(2, true)<cr>
nnoremap <leader>3 <cmd>lua require("bufferline").go_to_buffer(3, true)<cr>
nnoremap <leader>4 <cmd>lua require("bufferline").go_to_buffer(4, true)<cr>
nnoremap <leader>5 <cmd>lua require("bufferline").go_to_buffer(5, true)<cr>
nnoremap <leader>6 <cmd>lua require("bufferline").go_to_buffer(6, true)<cr>
nnoremap <leader>7 <cmd>lua require("bufferline").go_to_buffer(7, true)<cr>
nnoremap <leader>8 <cmd>lua require("bufferline").go_to_buffer(8, true)<cr>
nnoremap <leader>9 <cmd>lua require("bufferline").go_to_buffer(9, true)<cr>
nnoremap <leader>0 <cmd>lua require("bufferline").go_to_buffer(10, true)<cr>

""-------------------------------------------------------------------------------
"" Row and column movement settings.
""-------------------------------------------------------------------------------
"" Move the cursor to the column. E.g., 50% is the middle of the line.
"function! GoToBufferColumn(percent)
"    let l:visible_columns = virtcol('$')
"    let l:column = l:visible_columns*a:percent/100
"    call cursor(0, l:column)
"endfunction
"
"
"" Move the cursor to the row. E.g., 50% is the middle of the buffer.
"function! GoToBufferRow(percent)
"    let l:all_rows = line('$')
"    let l:row =  l:all_rows*a:percent/100
"    call cursor(l:row + 1, 0)
"endfunction
"
"" Move across line characters in increments.
"nnoremap ,1 :call GoToBufferColumn(0)<cr>
"nnoremap ,2 :call GoToBufferColumn(11)<cr>
"nnoremap ,3 :call GoToBufferColumn(22)<cr>
"nnoremap ,4 :call GoToBufferColumn(33)<cr>
"nnoremap ,5 :call GoToBufferColumn(44)<cr>
"nnoremap ,6 :call GoToBufferColumn(55)<cr>
"nnoremap ,7 :call GoToBufferColumn(66)<cr>
"nnoremap ,8 :call GoToBufferColumn(77)<cr>
"nnoremap ,9 :call GoToBufferColumn(88)<cr>
"nnoremap ,0 :call GoToBufferColumn(100)<cr>
"

"" Move across buffer rows in increments.
"nnoremap g1 :call GoToBufferRow(0)<cr>
"nnoremap g2 :call GoToBufferRow(11)<cr>
"nnoremap g3 :call GoToBufferRow(22)<cr>
"nnoremap g4 :call GoToBufferRow(33)<cr>
"nnoremap g5 :call GoToBufferRow(44)<cr>
"nnoremap g6 :call GoToBufferRow(55)<cr>
"nnoremap g7 :call GoToBufferRow(66)<cr>
"nnoremap g8 :call GoToBufferRow(77)<cr>
"nnoremap g9 :call GoToBufferRow(88)<cr>
"nnoremap g0 :call GoToBufferRow(100)<cr>

"-------------------------------------------------------------------------------
" Colors and Formatting.
"-------------------------------------------------------------------------------
" Enable code syntax highlighting.
syntax enable
" Enable auto indentation and plugins based on file type.
filetype indent plugin on

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
            \'groovy'       : "groovy",
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
    " At the end we get a jobname with no loading spaces; can be many words.
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
" DWM settings.
"-------------------------------------------------------------------------------
" Do not use default DWM key mappings.
let g:dwm_map_keys=0
let g:dwm_auto_arrange=0

" Open the current buffer in a new window.
nmap <silent> <c-n> :call DWM_New()<cr>
" Close window.
nmap <silent> <c-c> :exec DWM_Close()<cr>
" Focus the master window.
nmap <silent> <c-space> :exec DWM_Focus()<cr>

" Next window. Move cursor clockwise to the next window
nnoremap <c-j> <c-w>w
nnoremap <Tab> <c-w>w
" Previous window. Move cursor counter-clockwise to the previous window.
nnoremap <c-k> <c-w>W
nnoremap <S-Tab> <c-w>W

" Increase master window size the given number of columns.
nnoremap <silent> <c-l> :call DWM_GrowMaster(10)<CR>
" Decrease master window size the given number of columns.
nnoremap <silent> <c-h> :call DWM_ShrinkMaster(10)<CR>

function! ToggleAutoRearrange()
    if g:dwm_auto_arrange  == 0
        let g:dwm_auto_arrange = 1
    else
        let g:dwm_auto_arrange = 0
    endif
endfunction
nnoremap <leader>cr :call ToggleAutoArrange()<cr>
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
command! A  ClangdSwitchSourceHeader

"-------------------------------------------------------------------------------
" Startify settings.
"-------------------------------------------------------------------------------
" Automatically save session when leaving. Use :SSave to crate a session.
let g:startify_session_persistence = 1
" Do not open blank windows when loading the session.
set sessionoptions=curdir,folds,help,tabpages,winpos,blank
" Do not show cowsay as part of the quote. It takes a lot of space.
" let g:startify_custom_header = 'startify#pad(startify#fortune#quote())'
" Place sessions section first because that is what I access most often.
let g:startify_lists = [
    \ { 'header': ['   Sessions'],       'type': 'sessions' },
    \ { 'header': ['   MRU'],            'type': 'files' },
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
" Vim-code-dark settings.
"-------------------------------------------------------------------------------
" Set the color scheme. The schemes codedark and dracula are plugins.
" colorscheme codedark
" colorscheme dracula
" Make the background transparent.
" highlight normal guibg=none ctermbg=none

"-------------------------------------------------------------------------------
" Vim-airline settings.
"-------------------------------------------------------------------------------
" let g:airline_theme = 'codedark'
" let g:airline_theme = 'dracula'
"let g:airline_theme = 'codedark'
" Displays all buffers in upper tab line.
let g:airline#extensions#tabline#enabled = 1
" Whether to show "Buffers" and "Tabs" labels in tabline.
let g:airline#extensions#tabline#show_tab_type = 0
" Whether to show close button next to buffer when many tabs are open.
let g:airline#extensions#tabline#show_close_button = 0
" Whether to display the number of open tabs.
let g:airline#extensions#tabline#show_tab_count = 0

"-------------------------------------------------------------------------------
" Conflict Marker.
"-------------------------------------------------------------------------------
" Place after colorscheme or custom colors will be overriden.
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81

"-------------------------------------------------------------------------------
" Rust-vim settings.
"-------------------------------------------------------------------------------
" Format Rust file using rustfmt each time the file is saved.
let g:rustfmt_autosave = 1
" TODO Provide RustRun and Crun mapping to run single files or cargo files.
" Also provide RustTest, RustEmitIr, RustEmitAsm, RustFmt, Ctest, Cbuild.

"-------------------------------------------------------------------------------
" Vim-lsp mappings. Prefix g means "go".
"-------------------------------------------------------------------------------
"function! s:on_lsp_buffer_enabled() abort
"    setlocal omnifunc=lsp#complete
"    setlocal signcolumn=yes
"    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"    nmap <buffer> gd <plug>(lsp-definition)
"    nmap <buffer> gs <plug>(lsp-document-symbol-search)
"    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"    nmap <buffer> gr <plug>(lsp-references)
"    " nmap <buffer> gi <plug>(lsp-implementation)
"    nmap <buffer> <leader>gi <plug>(lsp-implementation)
"    nmap <buffer> gt <plug>(lsp-type-definition)
"    nmap <buffer> <leader>rn <plug>(lsp-rename)
"    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
"    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
"    " nmap <buffer> K <plug>(lsp-hover)
"    nmap <buffer> <leader>k <plug>(lsp-hover)
"
"    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
"    inoremap <buffer> <expr><c-d> lsp#scroll(-4)
"
"    let g:lsp_format_sync_timeout = 1000
"    " Start formatting server when the file is opened.
"    au! BufWritePre *.py,*.cpp,*.hpp,*.rs,*.c,*.h if s:auto_format == 1 | call execute('LspDocumentFormatSync') | endif
"
"    " refer to doc to add more commands
"endfunction
"
"aug lsp_install
"    " Clear previous group auto commands to avoid duplicate definitions.
"    au!
"    " Call s:on_lsp_buffer_enabled only for languages with registered servers.
"    au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"aug end

