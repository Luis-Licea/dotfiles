-- Import custom modules.
local Path = require('Path')
local String = require('String')
local Table = require('Table')
local key = require('Key')

local map = key.map
local nnoremap = key.nnoremap

local set = vim.keymap.set

--------------------------------------------------------------------------------
-- Ungrouped Mappings.
--------------------------------------------------------------------------------
-- Leader Mapping.
vim.g.mapleader = ' '
-- Local Leader Mapping.
vim.g.maplocalleader = ';'

local console = require('console')
require('mappings')

local term_opnes_group = vim.api.nvim_create_augroup('Terminal Opens Group', {})

-- Turn off spelling in terminal.
vim.api.nvim_create_autocmd('TermOpen', {
    group = term_opnes_group,
    pattern = '*',
    command = 'setlocal nospell',
})

-- Disable line numbering in terminal.
vim.api.nvim_create_autocmd('TermOpen', {
    group = term_opnes_group,
    pattern = '*',
    command = 'setlocal nonumber',
})

-- Press escape twice to exit. Add only to zsh because it conflicts with fzf.
-- Press ctrl+q to scroll freely in terminal, as opposed to ctrl+\ ctrl+n.
vim.api.nvim_create_autocmd('TermOpen', {
    group = term_opnes_group,
    pattern = '*',
    command = 'if expand("%:t") == "zsh" | tnoremap <c-q> <c-\\><c-n> | endif',
})

local buffer_check_group = vim.api.nvim_create_augroup('Check Buffer Group', {})

-- Resize windows equally when the window size changes.
vim.api.nvim_create_autocmd('VimResized', {
    group = buffer_check_group,
    pattern = '*',
    command = 'wincmd =',
})
-- Reload config file on change.
vim.api.nvim_create_autocmd('BufWritePost', {
    group = buffer_check_group,
    pattern = vim.env.MYVIMRC,
    command = 'source %',
})

-- Highlight yanks.
vim.api.nvim_create_autocmd('TextYankPost', {
    group = buffer_check_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})

-- Start terminal in insert mode.
vim.api.nvim_create_autocmd('TermOpen', {
    group = buffer_check_group,
    pattern = '*',
    command = 'startinsert | set winfixheight',
})

-- Start git messages in insert mode. Set color-column relative to
-- text-width.
vim.api.nvim_create_autocmd('FileType', {
    group = buffer_check_group,
    pattern = { 'gitcommit' },
    command = 'startinsert | 1 | setlocal colorcolumn=+1',
})

-- Remember file position.
vim.api.nvim_create_autocmd('BufReadPost', {
    group = buffer_check_group,
    pattern = '*',
    callback = function()
        if vim.fn.line('\'"') > 0 and vim.fn.line('\'"') <= vim.fn.line('$') then
            vim.fn.setpos('.', vim.fn.getpos('\'"'))
        end
    end,
})

-- Quit overly large files before loading them to avoid slowness.
vim.api.nvim_create_autocmd('BufReadPre', {
    group = buffer_check_group,
    pattern = '*',
    callback = function()
        local fsize = vim.fn.getfsize(vim.fn.expand('%:p:f'))
        local mega_byte = 1024 * 1024
        if fsize > 5 * mega_byte then
            vim.ui.input(
                { prompt = 'File exceeds recommended file size. Continue [y/n]? ' },
                function(input)
                    if input ~= 'y' then
                        vim.cmd('quit')
                    end
                end
            )
        end
    end,
})

-- Turn off syntax highlighting that conflicts with treesitter.
-- vim.api.nvim_create_autocmd('BufEnter', {
--     group = buffer_check_group,
--     pattern = '*',
--     callback = function()
--         local noSyntaxFor = {
--             lua = true,
--             markdown = true,
--             sh = true,
--             json = true,
--             -- yaml = true,
--             python = true,
--             c = true,
--             cpp = true,
--             rust = true,
--             tex = true,
--         }
--         local noTreeSitterFor = { gitcommit = true }
--         if noSyntaxFor[vim.bo.filetype] then
--             vim.bo.syntax = false
--         end
--         if noTreeSitterFor[vim.bo.filetype] then
--             vim.cmd('TSBufDisable highlight')
--         end
--     end,
-- })

local xresources_group = vim.api.nvim_create_augroup('Xresources Group', {})
-- Apply .Xresources file after editing the file.
vim.api.nvim_create_autocmd('BufWritePost', {
    group = xresources_group,
    pattern = '.Xresources',
    callback = function()
        vim.fn.execute('!xrdb && xrdb -merge ~/.Xresources')
    end,
})

local cpp_group = vim.api.nvim_create_augroup('C++ Group', {})

-- C++ and Nix code settings.
vim.api.nvim_create_autocmd('FileType', {
    group = cpp_group,
    pattern = { 'nix', 'cpp', 'toml' },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.tabstop = 2
    end,
})

--------------------------------------------------------------------------------
-- Load templates for newly created files.
--------------------------------------------------------------------------------
local template_group = vim.api.nvim_create_augroup('Template Group', {})

---Load a template in the current buffer. The template will be determined
---based on the file extension and the file name.
---@param name string path to the template to load.
local function LoadTemplateFromType(name)
    -- The place where the templates are saved.
    local templateDir = vim.fn.expand('~/.config/nvim/templates/')

    -- The path to the template to with the same file extension.
    -- Examples: skeleton.c, skeleton.html, skeleton.awk, etc.
    local pathSameExt = templateDir .. 'skeleton.' .. vim.fn.expand('%:e')

    -- The path to the template to with the same file name.
    local pathSameName = templateDir .. vim.fn.expand('%:t')

    -- The path to the template to load.
    local template = nil

    -- Check if the template has the same file name or extension.
    for _, path in ipairs({ pathSameExt, pathSameName }) do
        if vim.fn.filereadable(path) == 1 then
            template = path
        end
    end

    -- Override the template path if a template name is given.
    if name then
        template = name
    end

    if template then
        vim.fn.execute('0r ' .. template)
    end
end

vim.api.nvim_create_user_command('LoadTemplate', function(opts)
    LoadTemplateFromType(opts.args)
end, {
    nargs = '*',
    complete = function()
        local regular_templates = vim.api.nvim_get_runtime_file('templates/*', true)
        local hidden_templates = vim.api.nvim_get_runtime_file('templates/.*', true)
        -- Remove the "." directory.
        table.remove(hidden_templates, 1)
        -- Remove the ".." directory.
        table.remove(hidden_templates, 1)
        return Table.merge(regular_templates, hidden_templates)
    end,
    desc = 'Load the given template',
})

local function ChooseTemplate()
    local regular_templates = vim.api.nvim_get_runtime_file('templates/**', true)
    local hidden_templates = vim.api.nvim_get_runtime_file('templates/**/.*', true)
    local templates = {}
    for _, path in ipairs(Table.merge(hidden_templates, regular_templates)) do
        local tail = vim.fs.basename(path)
        -- Do not include special "." and ".." directories.
        if tail ~= '.' and tail ~= '..' and vim.fn.isdirectory(path) == 0 then
            table.insert(templates, path)
        end
    end
    vim.ui.select(templates, { prompt = 'Select template to load into file:' }, function(choice)
        LoadTemplateFromType(choice)
    end)
end

vim.api.nvim_create_user_command(
    'ChooseTemplate',
    ChooseTemplate,
    { nargs = 0, desc = 'Chose a template and load it into the buffer.' }
)

--- Return whether the file has a hash-bang.
---@return boolean True if the file has a hash-bang, false otherwise.
function FileHasHashBang()
    return vim.fn.getline(0, 1)[1]:sub(1, 2) == '#!'
end

--- Return the path to the executable specified by the hash-bang.
---@return string The path tho the executable.
function GetHashBang()
    return vim.fn.getline(0, 1)[1]:sub(3)
end

-- Load a template if one is available when creating a file.
vim.api.nvim_create_autocmd('BufNewFile', {
    group = template_group,
    pattern = '*',
    callback = function()
        LoadTemplateFromType(nil)
    end,
})
--------------------------------------------------------------------------------
-- Auto compilation settings.
--------------------------------------------------------------------------------
-- Default compilation and execution settings.
vim.b.addCompFlags = false
vim.b.addDebugFlags = false
vim.b.formatOnSave = false
vim.b.runCommand = {}
vim.b.compilationCommand = {}
vim.b.runOnSave = false
-- Output folder for compiled binaries, pdfs, etc.
vim.fn.setenv('TMPDIR', vim.fn.expandcmd('/tmp'))

-- Open a file, operate on it, and open it in a new tab. The function does not
-- remove the temporary file.
-- @param path string The path to the temporary file.
-- @param lines string The contents to write to the file.
local function openTemporaryTab(path, lines)
    local file = io.open(path, 'w')
    if file then
        io.output(file)
        io.write(lines)
        io.close(file)
        vim.cmd('belowright split ' .. path)
        nnoremap('<leader>bd', ':bd<cr>')

        -- Close window entirely rather than leaving the buffer open.
        local opts = { noremap = true, silent = true, buffer = true }
        set('n', '<leader>q', ':bd<cr>', opts)
    end
end

-- Edit a table property vim.b[value] by opening a buffer.
-- @param value The buffer property vim.b[value] to modify.
-- @param separator The argument separator character.
local function Edit(value, separator)
    if vim.b[value] == nil then
        error('The buffer property does not exist: ' .. value)
    end
    local lines = table.concat(vim.b[value], separator)
    local path = os.tmpname()
    local buffer = vim.api.nvim_get_current_buf()

    pcall(openTemporaryTab, path, lines)

    -- Read the file and set the contents as the run command.
    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = path,
        callback = function(event)
            local arguments = Path.to_lines(event.file)
            vim.api.nvim_buf_set_var(buffer, value, arguments)
        end,
    })

    -- Remove the temporary file when done using it.
    vim.api.nvim_create_autocmd('BufDelete', {
        pattern = path,
        callback = function(event)
            os.remove(event.file)
        end,
    })
end

-- Edit the auto run command.
local function EditRunCommand()
    Edit('runCommand', '\n')
end

-- Edit the auto compilation command.
local function EditCompilationCommand()
    Edit('compilationCommand', '\n')
end

function ToggleAddCompFlags()
    vim.b.addCompFlags = not vim.b.addCompFlags
    print('Add Comp Flags:', vim.b.addCompFlags)
    vim.b.runCommand = {}
    vim.b.compilationCommand = {}
end

function ToggleAddDebugFlags()
    vim.b.addDebugFlags = not vim.b.addDebugFlags
    print('Add Debug Flags:', vim.b.addDebugFlags)
    vim.b.runCommand = {}
    vim.b.compilationCommand = {}
end

function ToggleFormatOnSave()
    vim.b.formatOnSave = not vim.b.formatOnSave
    print('Format On Save:', vim.b.formatOnSave)
end

function ToggleRunOnSave()
    vim.b.runOnSave = not vim.b.runOnSave
    print('Run On Save:', vim.b.runOnSave)
    vim.b.runCommand = {}
    vim.b.compilationCommand = {}
end

vim.api.nvim_create_user_command(
    'EditRunCommand',
    EditRunCommand,
    { nargs = 0, desc = 'Edit the run (or compilation) command.' }
)
vim.api.nvim_create_user_command(
    'EditCompilationCommand',
    EditCompilationCommand,
    { nargs = 0, desc = 'Edit the run (or compilation) command.' }
)
vim.api.nvim_create_user_command(
    'ToggleAddCompFlags',
    ToggleAddCompFlags,
    { nargs = 0, desc = 'Add compilation flags upon compilation.' }
)
vim.api.nvim_create_user_command(
    'ToggleAddDebugFlags',
    ToggleAddDebugFlags,
    { nargs = 0, desc = 'Add debug flags upon compilation.' }
)
vim.api.nvim_create_user_command(
    'ToggleFormatOnSave',
    ToggleFormatOnSave,
    { nargs = 0, desc = 'Format the file upon saving.' }
)
vim.api.nvim_create_user_command(
    'ToggleRunOnSave',
    ToggleRunOnSave,
    { nargs = 0, desc = 'Run the file upon saving.' }
)
nnoremap('<leader>ce', EditRunCommand)
nnoremap('<leader>cc', ToggleAddCompFlags)
nnoremap('<leader>cd', ToggleAddDebugFlags)
nnoremap('<leader>cf', ToggleFormatOnSave)
nnoremap('<leader>cr', ToggleRunOnSave)

local auto_run_group = vim.api.nvim_create_augroup('Auto Run Group', {
    clear = true,
})

-- Format document before saving.
vim.api.nvim_create_autocmd('BufWritePre', {
    group = auto_run_group,
    pattern = '*',
    callback = function()
        if vim.b.formatOnSave then
            vim.lsp.buf.format()
        end
    end,
})

-- Run the document after saving it.
vim.api.nvim_create_autocmd('BufWritePost', {
    group = auto_run_group,
    pattern = '*',
    callback = function()
        if vim.b.runOnSave then
            Run()
        end
    end,
})

-- Execute files named "scratchpad" each time they are saved.
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
    group = auto_run_group,
    pattern = 'scratchpad.*',
    callback = function()
        ToggleRunOnSave()
        ToggleFormatOnSave()
        ToggleAddCompFlags()
        ToggleAddDebugFlags()
    end,
})

-- Always auto-format the following file types.
vim.api.nvim_create_autocmd('FileType', {
    group = auto_run_group,
    pattern = { 'rust', 'cpp', 'html', 'lua' },
    callback = ToggleFormatOnSave,
})

-- Always auto-format the following file types.
vim.api.nvim_create_autocmd('FileType', {
    group = auto_run_group,
    pattern = 'c',
    callback = function()
        vim.api.nvim_create_user_command('CGenerateAssembly0', function()
            vim.fn.execute('!gcc -S -O0 -fverbose-asm "%"')
        end, { nargs = 0, desc = 'Generate the assembly file' })
        vim.api.nvim_create_user_command('CGenerateAssembly1', function()
            vim.fn.execute('!gcc -S -O1 -fverbose-asm "%"')
        end, { nargs = 0, desc = 'Generate the assembly file' })
        vim.api.nvim_create_user_command('CGenerateAssembly2', function()
            vim.fn.execute('!gcc -S -O2 -fverbose-asm "%"')
        end, { nargs = 0, desc = 'Generate the assembly file' })
        vim.api.nvim_create_user_command('CDumpObject', function()
            vim.fn.execute('!objdump -drwC "$TMPDIR/%<"')
        end, { nargs = 0, desc = 'Generate the assembly file' })
    end,
})

--------------------------------------------------------------------------------
-- Markdown.
--------------------------------------------------------------------------------
local markdown_group = vim.api.nvim_create_augroup('Markdown Group', {
    clear = true,
})
-- Auto compile markdown file after saving if auto compilation is enabled.
vim.api.nvim_create_autocmd('BufWritePost', {
    group = markdown_group,
    pattern = '*.md',
    callback = function()
        if vim.b.runOnSave then
            vim.fn.system({
                'setsid',
                '--fork',
                'pandoc',
                vim.fn.expand('%'),
                '-o',
                vim.fn.expandcmd('$TMPDIR/%<.pdf'),
            })
        end
    end,
})

-- View pdf files.
function LaunchViewer()
    local viewer = 'zathura'
    if vim.fn.executable('evince') == 1 then
        viewer = 'evince'
    end
    vim.fn.system({ 'setsid', '--fork', viewer, vim.fn.expandcmd('$TMPDIR/%<.pdf') })
end

-- Auto compile Typst upon changes.
function LaunchWatcher()
    vim.b.runOnSave = false
    local path = vim.fn.expand('%:p:h')
    local input = vim.fn.expand('%')
    local output = vim.fn.expandcmd('$TMPDIR/%<.pdf')
    vim.fn.system(
        Table.merge('setsid', '--fork', console, path, '-e', 'typst', 'watch', input, output)
    )
end

vim.api.nvim_create_autocmd('FileType', {
    group = markdown_group,
    pattern = { 'markdown', 'typst' },
    callback = function(event)
        -- View compiled markdown pdf.
        nnoremap('<leader>cv', LaunchViewer, { buffer = true })
        if event.match == 'typst' then
            nnoremap('<leader>cw', LaunchWatcher, { buffer = true })
        end
    end,
})

--------------------------------------------------------------------------------
-- LaTeX auto commands.
--------------------------------------------------------------------------------
local latex_group = vim.api.nvim_create_augroup('LaTeX Group', {
    clear = true,
})

-- Compile the file in the same directory and watch for changes ever 10 seconds.
-- nnoremap <leader>co :sil exec \
-- '!watch -n 10 rubber --pdf --shell-escape --synctex --inplace "%"'<cr>
vim.api.nvim_create_autocmd('FileType', {
    group = latex_group,
    pattern = 'tex',
    callback = function()
        -- Define variables for compiling file into a PDF.
        SetLaTeXVariables()
        -- Compile the file in the same directory.
        nnoremap('<leader>co', RunLaTeX, { buffer = true })
        -- Clean all files except the compiled pdf.
        nnoremap('<leader>cl', CleanLaTeX, { buffer = true })
        -- Open the compiled LaTeX pdf with the specified viewer.
        nnoremap('<leader>cv', ':lua OpenLaTeXPDF("zathura")<cr>', { buffer = true })
    end,
})

-- Compile LaTeX document every time after saving.
vim.api.nvim_create_autocmd('BufWritePost', {
    group = latex_group,
    pattern = '*.tex',
    callback = function()
        if vim.b.runOnSave then
            RunLaTeX()
        end
    end,
})

-- Clean the all files except the compiled pdf when exiting.
vim.api.nvim_create_autocmd('VimLeavePre', {
    group = latex_group,
    pattern = '*.tex',
    callback = function()
        CleanLaTeX()
    end,
})

--------------------------------------------------------------------------------
-- Interface.
--------------------------------------------------------------------------------
-- Share clipboard with operating system.
vim.o.clipboard = 'unnamedplus'
-- Reminder to keep lines at most 80, 120 characters long.
vim.o.colorcolumn = '81,101,121'
-- Enable mouse wheel in normal modes.
vim.o.mouse = 'a'
-- Support true color in vim.
vim.o.termguicolors = true
-- Hide quotes in JSON files.
vim.o.conceallevel = 1
-- When using gq, wrap the line at this many characters.
vim.o.textwidth = 80

--------------------------------------------------------------------------------
-- Tabs & spaces.
--------------------------------------------------------------------------------
-- Tells vim to replace tabs with spaces.
vim.o.expandtab = true
-- Control how text is indented when using << and >>.
vim.o.shiftwidth = 4
-- Mixes tabs and spaces unless equal to tabstop.
vim.o.softtabstop = 4
-- Tell vim how many columns a tab counts for.
vim.o.tabstop = 4

--------------------------------------------------------------------------------
-- Other.
--------------------------------------------------------------------------------
-- Treat keybindings the same when using a different keyboard layout.
vim.o.langmap =
    'йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:\'"zZxXcCvVbBnNmM\\,<.>?'
-- Open history file using :q.
vim.o.history = 200
-- Ignore case in search patterns.
vim.o.ignorecase = true
-- Search queries intelligently using case. Only used if ignorecase is on.
vim.o.smartcase = vim.o.ignorecase
-- Set spelling on.
vim.o.spell = true
-- Define tab and trailing space characters.
vim.opt.listchars = {
    tab = '◃―▹',
    trail = '●',
    extends = '◣',
    precedes = '◢',
    nbsp = '○',
    -- eol = '↴',
    -- space = '⋅',
}
-- Show tabs and trailing spaces.
vim.o.list = true
-- Add indentation when S or cc is pressed.
vim.o.cindent = true
-- Change cwd to file's directory.
-- vim.o.autochdir = true
vim.o.shell = Path.first_execuable({ '/usr/bin/zsh', '/usr/bin/bash', '/usr/bin/nu' })
vim.opt.undodir = '/tmp/'
vim.opt.shada = ''
vim.opt.shadafile = 'NONE'

--------------------------------------------------------------------------------
-- File finder.
--------------------------------------------------------------------------------
-- Looks into subfolders to find and open a file. :find filename - finds the
-- file in subfolders. Press Tab for suggesting files. Use * as a wild card for
-- beginnings or endings.
vim.o.path = vim.o.path .. '**'

--------------------------------------------------------------------------------
-- Plugins.
--------------------------------------------------------------------------------

-- Bootsrap lazy.nvim.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
    print('Installed lazy.nvim. Reopen Neovim.')
else
    vim.opt.rtp:prepend(lazypath)
    -- Load plugins from files that match the pattern "lua/plugins/*.lua".
    require('lazy').setup('plugins', {
        change_detection = {
            -- Automatically check for configuration changes and reload the UI.
            enabled = true,
            notify = false,
        },
    })
end

--------------------------------------------------------------------------------
-- Auto compilation settings.
--------------------------------------------------------------------------------

---Benchmark the execution time of compiled binary.
---@param times number How many times to execute the program.
---@param executable_path string path The path to the file or binary to execute.
---@param runner string The interpreter name.
function BenchmarkExecutionTime(times, executable_path, runner)
    if not times or not executable_path then
        return
    end

    times = times or 10 -- Execute the program this many times.
    -- Remove the parent directories and extension to get file name.
    executable_path = executable_path or vim.fn.fnameescape('%:p:r')
    runner = runner or ''

    local program = string.format(
        [[
        for ((i=1;i<=%s;i++)); do
            # Execute the program.
            %s %s > /dev/null
        done
    ]],
        times,
        runner,
        executable_path
    )

    print(program)

    --  Run the file.
    local stdout = vim.fn.system({ '/usr/bin/time', '-p', 'bash', '-c', program })
    print(stdout)
end

vim.api.nvim_create_user_command('Time', function(opts)
    local args = String.to_dict(opts.args)

    local times = args.times or 10
    local executable_path = args.path or vim.fn.expand('%:p:r')
    local runner = args.runner or ''

    BenchmarkExecutionTime(times, executable_path, runner)
end, {
    nargs = '*',
    complete = function(ArgLead, CmdLine, CursorPos)
        -- Times to execute program.
        local times = 1000
        -- Define the path where the compiled executable will be placed, and
        -- where it should be executed. Remove the parent directories and
        -- extension to get file name.
        local executable_path = vim.fn.expandcmd('$TMPDIR/%:t:r')
        local completion_str_runner = 'times=%d runner=%s path="%s"'
        local completion_str = 'times=%d path="%s"'
        return {
            completion_str_runner:format(times, GetRunner(), executable_path),
            completion_str_runner:format(times, GetRunner(), vim.fn.expand('%:p')),
            completion_str:format(times, vim.fn.expand('%:p')),
            completion_str:format(times, executable_path),
        }
    end,
    desc = 'Execute the given file',
})

-- Another compiler for c is tcc.
local ft2compiler = {
    c = 'gcc',
    cpp = 'g++',
    rust = 'rustc',
    vala = 'valac',
}

-- Validate GLSL code for extensions: vert, tesc, tese, glsl, geom, frag, comp.
local ft2interpreter = {
    python = 'python3',
    java = 'java',
    groovy = 'groovy',
    lua = 'lua',
    sh = 'bash',
    javascript = 'node',
    glsl = 'glslangValidator',
    typst = { 'typst', 'compile' },
}
vim.filetype.add({ extension = { typ = 'typst' } })

-- Sample CMake flags.
-- set(CMAKE_CXX_FLAGS_DEBUG_INIT "-fsanitize=address,undefined -fsanitize-undefined-trap-on-error")
-- set(CMAKE_EXE_LINKER_FLAGS_INIT "-fsanitize=address,undefined -static-libasan")
-- set(CMAKE_CXX_FLAGS_INIT "-Werror -Wall -Wextra -Wpedantic")
-- # toolchain file for use with gcov
-- set(CMAKE_CXX_FLAGS_INIT "--coverage -fno-exceptions -g")
--
-- C++ and C compilation flags:
-- O3: Enable IEEE-and-ISO-compliant optimizations.
-- Ofast: Enable fast math optimizations; The results may be inaccurate.
-- Wall: Warn questionable or easy to avoid constructions.
-- Wextra: Some extra warnings not enabled by -Wall.
-- Wfloat-conversion: Warns when doubles implicitly converted to floats.
-- Wsign-conversion: Warn implicit conversion that change integer sign.
-- Wshadow: Find errors particularly regarding unique_lock<mutex>(my_mutex);
-- Wpedantic: Demand strict ISO C and ISO C++; no forbidden extensions.
-- Wconversion: Warn implicit conversions that may alter a value.
local cflags = {
    '-O3',
    '-Ofast',
    '-Wall',
    '-Wconversion',
    '-Wextra',
    '-Wfloat-conversion',
    '-Wshadow',
    '-Wsign-conversion',
}

-- g: Produce debugging info for GDB.
-- fsanitize=address: Warns use after free.
-- fsanitize=leak: Warns when pointers have not been freed.
-- fsanitize=undefined: Detects undefined behavior.
-- fsanitize-address-use-after-scope: Catches references to temporary
--   values. The value may be gone before the reference is accessed.
local debug_flags = {
    '-g',
    '-fsanitize=address,leak,undefined',
    '-fsanitize-address-use-after-scope',
}

local ft2flags = {
    c = { unpack(cflags) },
    cpp = { '-std=c++17', unpack(cflags) },
}

local ft2debugflags = {
    c = { unpack(debug_flags) },
    cpp = { unpack(debug_flags) },
    rust = { '-g' },
}

---Return the hash-bang, interpreter, or compiler for running the current file.
---@return string|table? runner The compiler, interpreter, or hash-bash.
function GetRunner()
    if FileHasHashBang() and GetHashBang() then
        -- Get the hash-bang.
        return GetHashBang()
    elseif ft2interpreter[vim.bo.filetype] then
        -- Get the interpreter.
        return ft2interpreter[vim.bo.filetype]
    elseif ft2compiler[vim.bo.filetype] then
        -- Get the interpreter.
        return ft2compiler[vim.bo.filetype]
    end
end

-- TODO: Add entr command: ag -g "%" | entr "./%"
-- Example: ag -g "/tmp/mocha.mjs" | entr npx mocha mocha.mjs

function Run()
    -- Run the compilation command if it is not empty.
    if #vim.b.compilationCommand ~= 0 then
        print(vim.inspect(vim.b.compilationCommand))
        -- Compile the program.
        print(vim.fn.system(vim.b.compilationCommand))
    end

    -- Run the program if the command is not empty.
    if #vim.b.runCommand ~= 0 then
        print(vim.inspect(vim.b.runCommand))
        -- Run the program.
        print(vim.fn.system(vim.b.runCommand))
        -- Program ran.
        return true
    end

    -- Handle files with hash-bangs.
    if FileHasHashBang() and GetHashBang() then
        -- Run file using hash-bang.
        local runCommand = String.to_list(GetHashBang())
        table.insert(runCommand, vim.fn.expand('%'))
        vim.b.runCommand = runCommand

        return Run()
    end

    -- Handle interpreted languages.
    if ft2interpreter[vim.bo.filetype] then
        -- Get the interpreter.
        local interpreter = ft2interpreter[vim.bo.filetype]

        -- Get the file path.
        local path = vim.fn.expand('%:p')

        -- Run the file.
        vim.b.runCommand = Table.merge(interpreter, path)

        return Run()
    end

    -- Handle compiled languages.
    if ft2compiler[vim.bo.filetype] then
        -- Get the interpreter.
        local compiler = ft2compiler[vim.bo.filetype]

        -- Get the file path.
        local path = vim.fn.expand('%:p')

        -- Define the path where the compiled executable will be placed, and
        -- where it should be executed. Remove the parent directories and
        -- extension to get file name.
        local executable_path = vim.fn.expandcmd('$TMPDIR/%:t:r')

        -- By default do not pass additional compilation flags.
        local flags = {}

        -- If the language has additional compilation flags:
        if ft2flags[vim.bo.filetype] and vim.b.addCompFlags then
            -- Pass the additional compilation flags.
            flags = ft2flags[vim.bo.filetype]
        end

        -- If the language has debug flags, and debugging is enabled:
        if ft2debugflags[vim.bo.filetype] and vim.b.addDebugFlags then
            -- Pass the additional compilation flags.
            flags = Table.merge(ft2debugflags[vim.bo.filetype], flags)
        end

        -- Compile and run the file.
        vim.b.compilationCommand = Table.merge(compiler, flags, path, '-o', executable_path)
        vim.b.runCommand = { executable_path }
        return Run()
    end
    -- Program did not run.
    return false
end

--------------------------------------------------------------------------------
-- Latex auto compilation.
--------------------------------------------------------------------------------
function SetLaTeXVariables()
    -- Flags used by all rubber commands.
    RubberCompFlags = { 'rubber', '--shell-escape', '--synctex', '--inplace' }

    -- grep: Look for first line that contains "% jobname:". Ignore whitespace.
    local jobname_line =
        vim.fn.system({ 'grep', '--max-count=1', '%*jobname:', vim.fn.expand('%') })
    -- Ignore surrounding whitespace. Match any characters such that the last
    -- one is not whitespace. The job name can be many words long.
    vim.b.latexJobName = jobname_line:gmatch('.*jobname:%s*(.*%S)%s*')()
end

function RunLaTeX()
    if vim.b.latexJobName then
        -- Compile using the jobname.
        local arguments = Table.merge(
            RubberCompFlags,
            '--pdf',
            '--jobname',
            vim.b.latexJobName,
            vim.fn.expand('%')
        )
        local stdout = vim.fn.system(arguments)
        print(stdout)
    else
        -- If there is no jobname, compile using the default file name.
        local stdout = vim.fn.system(Table.merge(RubberCompFlags, '--pdf', vim.fn.expand('%')))
        print(stdout)
    end
end

function CleanLaTeX()
    -- Clean files matching the current file's name by using the same flags
    -- used for compilation in addition to --clean flag. Do not include --pdf
    -- flag as not to remove the output pdf.
    local rubber_clean_flags = { '--clean', vim.fn.expand('%') }
    if vim.b.latexJobName then
        -- Clean files matching the job name.
        rubber_clean_flags = { '--clean', '--jobname', vim.b.latexJobName, vim.fn.expand('%') }
    end
    vim.fn.system(Table.merge(RubberCompFlags, rubber_clean_flags))
end

function OpenLaTeXPDF(viewer)
    -- Get current file's root name (without extension) and add .pdf.
    local jobname = vim.fn.expand('%:p:r') .. '.pdf'
    if vim.b.latexJobName then
        -- Get current file's head (last path component removed) and add .pdf.
        jobname = vim.fn.expand('%:p:h') .. '/' .. vim.b.latexJobName .. '.pdf'
    end
    print('Viewing ' .. jobname)
    vim.fn.system({ 'setsid', '--fork', viewer, jobname })
end

--------------------------------------------------------------------------------
-- Switch between files and headers: c -> h and cpp -> hpp.
--------------------------------------------------------------------------------
-- Attach when working with clangd.
vim.api.nvim_create_user_command('C', 'ClangdSwitchSourceHeader', { nargs = 0 })
