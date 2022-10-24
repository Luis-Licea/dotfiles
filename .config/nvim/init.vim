lua << EOF
    require'config'
EOF

"-------------------------------------------------------------------------------
" Vim Terminal.
"-------------------------------------------------------------------------------
" Close tab immediately after closing terminal.
" au! TermClose * :q

" Start terminal in insert mode
" au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" nnoremap <silent> <leader>tt :terminal<CR>
" nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
" nnoremap <silent> <leader>th :new<CR>:terminal<CR>
" tnoremap <C-x> <C-\><C-n><C-w>q

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

" Previous window. Move cursor counter-clockwise to the previous window.
nnoremap <c-k> <c-w>W

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
" Switch between files and headers: c -> h and cpp -> hpp.
"-------------------------------------------------------------------------------
command! A  ClangdSwitchSourceHeader

"-------------------------------------------------------------------------------
" Startify settings.
"-------------------------------------------------------------------------------
" Do not open blank windows when loading the session.
set sessionoptions=curdir,folds,help,tabpages,winpos,blank

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

