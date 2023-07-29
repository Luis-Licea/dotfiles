local key = require("key_bindings")
local tables = require("tables")

local expand = key.expand
local map = key.map
local nnoremap = key.nnoremap
local cnoremap = key.cnoremap
local inoremap = key.inoremap
local tnoremap = key.tnoremap

table.merge = tables.merge
local set = vim.keymap.set

--------------------------------------------------------------------------------
-- Ungrouped Mappings.
--------------------------------------------------------------------------------
-- Leader Mapping.
vim.g.mapleader = ' '
-- Local Leader Mapping.
vim.g.maplocalleader = ';'
-- Map localleader to CTRL-W.
map('<localleader>', '<c-w>')
-- Save file.
nnoremap('<leader>w', ':write<cr>')
-- nnoremap('<leader>w', ':update<cr>')
local console = nil
if vim.fn.executable('alacritty') == 1 then
    console = {"alacritty", "--working-directory"}
elseif vim.fn.executable('konsole') == 1 then
    console = {"konsole", "--workdir"}
end

if console then
    function NewTerminal()
        local path = vim.fn.expand("%:p:h")
        vim.fn.system(table.merge('setsid', '--fork', console, path))
    end
    function NewRanger()
        local path = vim.fn.expand("%:p:h")
        vim.fn.system(table.merge('setsid', '--fork', console, path, '-e', 'ranger'))
    end

    -- Spawn a new terminal in the folder of the current file.
    nnoremap('<leader>nt', NewTerminal)
    -- Spawn a new ranger terminal in the folder of the current file.
    nnoremap('<leader>nr', NewRanger)

    vim.api.nvim_create_user_command('Nt', NewTerminal,
        { nargs = 0, desc = "Launch a new terminal." })
    vim.api.nvim_create_user_command('Nr', NewRanger,
        { nargs = 0, desc = "Launch a new ranger terminal." })
end

local function OpenTagBar()
    local tagbarLanguages = { cmake = true, tex = true}
    if tagbarLanguages[vim.bo.filetype] then
        vim.cmd("call tagbar#OpenWindow('fcj')")
    else
        require'symbols-outline'.toggle_outline()
    end
end

-- Open tag bar and close it after selecting a tag.
nnoremap('<leader>ta', OpenTagBar)
-- Quit vim.
nnoremap('<leader>q', ':quit<cr>')
-- Load .vimrc.
nnoremap('<leader>so', ':source ~/.config/nvim/init.vim<cr>')
-- Fix syntax highlighting.
nnoremap('<leader>fs', ':syntax sync fromstart<cr>')
-- Remove trailing white space.
nnoremap('<leader>rw', ':%s/\\s\\+$//e<cr>')
-- Remove swap file. Make the command long in purpose.
nnoremap('<leader>rswap', ':!rm "%.swp"<cr>')
-- Unset the last search pattern register.
nnoremap('<esc>', ':nohl<cr>', { silent = true })
-- Paste last thing yanked, not deleted.
nnoremap('<leader>p', '"0p')
nnoremap('<leader>P', '"0P')

--------------------------------------------------------------------------------
-- Tab, window, and buffer navigation.
--------------------------------------------------------------------------------
-- Open the current buffer in a new tab.
nnoremap('<leader>tn', ':tabnew %<cr>')
-- Close the tab.
nnoremap('<leader>tc', ':tabclose<cr>')

-- Go to tab by number.
nnoremap('<localleader>1', '1gt')
nnoremap('<localleader>2', '2gt')
nnoremap('<localleader>3', '3gt')
nnoremap('<localleader>4', '4gt')
nnoremap('<localleader>5', '5gt')
nnoremap('<localleader>6', '6gt')
nnoremap('<localleader>7', '7gt')
nnoremap('<localleader>8', '8gt')
nnoremap('<localleader>9', '9gt')
nnoremap('<localleader>0', ':tablast<cr>')

-- Go to window by number.
nnoremap('g1', ':call win_gotoid(win_getid(1))<cr>')
nnoremap('g2', ':call win_gotoid(win_getid(2))<cr>')
nnoremap('g3', ':call win_gotoid(win_getid(3))<cr>')
nnoremap('g4', ':call win_gotoid(win_getid(4))<cr>')
nnoremap('g5', ':call win_gotoid(win_getid(5))<cr>')
nnoremap('g6', ':call win_gotoid(win_getid(6))<cr>')
nnoremap('g7', ':call win_gotoid(win_getid(7))<cr>')
nnoremap('g8', ':call win_gotoid(win_getid(8))<cr>')
nnoremap('g9', ':call win_gotoid(win_getid(9))<cr>')
nnoremap('g0', ':call win_gotoid(win_getid(10))<cr>')

-- Go to buffer by number.
nnoremap('<leader>1', ':lua require("bufferline").go_to_buffer(1, true)<cr>')
nnoremap('<leader>2', ':lua require("bufferline").go_to_buffer(2, true)<cr>')
nnoremap('<leader>3', ':lua require("bufferline").go_to_buffer(3, true)<cr>')
nnoremap('<leader>4', ':lua require("bufferline").go_to_buffer(4, true)<cr>')
nnoremap('<leader>5', ':lua require("bufferline").go_to_buffer(5, true)<cr>')
nnoremap('<leader>6', ':lua require("bufferline").go_to_buffer(6, true)<cr>')
nnoremap('<leader>7', ':lua require("bufferline").go_to_buffer(7, true)<cr>')
nnoremap('<leader>8', ':lua require("bufferline").go_to_buffer(8, true)<cr>')
nnoremap('<leader>9', ':lua require("bufferline").go_to_buffer(9, true)<cr>')
nnoremap('<leader>0', ':lua require("bufferline").go_to_buffer(10, true)<cr>')

--------------------------------------------------------------------------------
-- Command mode mappings.
--------------------------------------------------------------------------------
-- Move up autocomplete options in Command mode.
cnoremap('<c-k>', '<c-p>')
-- Move down autocomplete options in Command mode.
cnoremap('<c-j>', '<c-n>')
-- Leave command mode without executing command.
cnoremap('<esc>', '<c-c>')

--------------------------------------------------------------------------------
-- Insert mode mappings.
--------------------------------------------------------------------------------
-- Move up autocomplete options in insert mode.
inoremap('<c-k>', '<c-p>')
-- Move down autocomplete options in insert mode.
inoremap('<c-j>', '<c-n>')

--------------------------------------------------------------------------------
-- Normal mode mappings. Fast movement.
--------------------------------------------------------------------------------
-- Move a page up.
nnoremap('<s-k>', '<c-u><c-u>')
-- Move a page down.
nnoremap('<s-j>', '<c-d><c-d>')

--------------------------------------------------------------------------------
-- Resize Window mappings.
--------------------------------------------------------------------------------
-- Increase height by N lines.
nnoremap('<up>', '10<c-w>+')
-- Decrease height by N lines.
nnoremap('<down>', '10<c-w>-')
-- Increase width by N lines.
nnoremap('<right>', '10<c-w>>')
-- Decrease width by N lines.
nnoremap('<left>', '10<c-w><')

--------------------------------------------------------------------------------
-- File mappings. Prefix f means "file".
--------------------------------------------------------------------------------
-- Print file name.
nnoremap('<leader>fn', ':echo expand("%:t")<cr>')
-- Print file path (full).
nnoremap('<leader>fp', ':echo expand("%:p")<cr>')
-- Print file directory.
nnoremap('<leader>fd', ':echo expand("%:p:h")<cr>')

--------------------------------------------------------------------------------
-- Yank mappings. Prefix y means "yank".
--------------------------------------------------------------------------------
-- Copy file name to clipboard.
nnoremap('yn', ':let @+=expand("%:t") | echo "Yanked file:" @+<cr>')
-- Copy file path to clipboard.
nnoremap('yp', ':let @+=expand("%:p") | echo "Yanked path:" @+<cr>')
-- Copy pwd to clipboard.
nnoremap('yd', ':let @+=expand("%:p:h") | echo "Yanked cwd:" @+<cr>')
-- Copy buffer contents to clipboard.
nnoremap('yb', ':%y<cr>')

--------------------------------------------------------------------------------
-- Switch mappings. Prefix s means "switch".
--------------------------------------------------------------------------------
-- Switch numbered lines.
nnoremap('<leader>sn', ':set number! number?<cr>')
-- Switch automatic indentation.
nnoremap('<leader>sa', ':set autoindent! autoindent?<cr>')
-- Switch wrap.
nnoremap('<leader>sw', ':set wrap! wrap?<cr>')
-- Switch highlight search.
nnoremap('<leader>sh', ':set hlsearch! hlsearch?<cr>')
-- Switch auto-changing directory.
nnoremap('<leader>sc', ':set autochdir! autochdir?<cr>')

--------------------------------------------------------------------------------
-- Spellcheck mappings. Prefix s means "spell".
--------------------------------------------------------------------------------
-- Switch spellcheck for English.
nnoremap('<leader>sse', ':setlocal spell! spelllang=en spell?<cr>')
-- Switch spellcheck for Spanish.
nnoremap('<leader>sss', ':setlocal spell! spelllang=es spell?<cr>')
-- Switch spellcheck for Russian.
nnoremap('<leader>ssr', ':setlocal spell! spelllang=ru spell?<cr>')

--------------------------------------------------------------------------------
-- Buffer mappings. Prefix b means "buffer".
--------------------------------------------------------------------------------
-- Go to the next buffer.
nnoremap('<Tab>', ':bn<cr>')
-- Go to the previous buffer.
nnoremap('<S-Tab>', ':bp<cr>')
-- Go to the next buffer.
nnoremap('<leader>bn', ':bn<cr>')
-- Go to the previous buffer.
nnoremap('<leader>bp', ':bp<cr>')
-- Go back (to last) buffer.
nnoremap('<leader>bb', ':b#<cr>')
-- Show open buffers.
nnoremap('<leader>bs', ':buffers<cr>')
-- Delete (close) buffer from buffers list.
nnoremap('<leader>bd', ':bd<cr>')

--------------------------------------------------------------------------------
-- Embedded terminal settings and mappings.
--------------------------------------------------------------------------------
-- Move cursor to the left window.
tnoremap('<localleader>h', '<c-\\><c-n><cr><c-w>h')
-- Move cursor to the window above.
tnoremap('<localleader>j', '<c-\\><c-n><cr><c-w>j')
-- Move cursor to the window below.
tnoremap('<localleader>k', '<c-\\><c-n><cr><c-w>k')
-- Move cursor to the right window.
tnoremap('<localleader>l', '<c-\\><c-n><cr><c-w>l')
-- Escape window.
tnoremap('<Esc><Esc>', '<c-\\><c-n><cr>')

local term_opnes_group = vim.api.nvim_create_augroup("Terminal Opens Group", {})

    -- Turn off spelling in terminal.
    vim.api.nvim_create_autocmd('TermOpen', {
        group = term_opnes_group,
        pattern = '*',
        command = 'setlocal nospell'
    })

    -- Disable line numbering in terminal.
    vim.api.nvim_create_autocmd('TermOpen', {
        group = term_opnes_group,
        pattern = '*',
        command = 'setlocal nonumber'
    })

    -- Press escape twice to exit. Add only to zsh because it conflicts with fzf.
    -- Press ctrl+q to scroll freely in terminal, as opposed to ctrl+\ ctrl+n.
    vim.api.nvim_create_autocmd('TermOpen', {
       group = term_opnes_group,
       pattern = '*',
       command = 'if expand("%:t") == "zsh" | tnoremap <c-q> <c-\\><c-n> | endif'
   })

local buffer_check_group = vim.api.nvim_create_augroup('Check Buffer Group', {})

    -- Resize windows equally when the window size changes.
    vim.api.nvim_create_autocmd('VimResized', {
        group = buffer_check_group,
        pattern = '*',
        command = 'wincmd ='
    })
    -- Reload config file on change.
    vim.api.nvim_create_autocmd('BufWritePost', {
        group    = buffer_check_group,
        pattern  = vim.env.MYVIMRC,
        command  = 'source %'})

    -- Highlight yanks.
    vim.api.nvim_create_autocmd('TextYankPost', {
        group    = buffer_check_group,
        pattern  = '*',
        callback = function() vim.highlight.on_yank{timeout=150} end})

    -- Start terminal in insert mode.
    vim.api.nvim_create_autocmd('TermOpen',     {
        group    = buffer_check_group,
        pattern  = '*',
        command  = 'startinsert | set winfixheight'})

    -- Start git messages in insert mode. Set color-column relative to
    -- text-width.
    vim.api.nvim_create_autocmd('FileType',     {
        group    = buffer_check_group,
        pattern  = { 'gitcommit', },
        command  = 'startinsert | 1 | setlocal colorcolumn=+1'})

    -- Remember file position.
    vim.api.nvim_create_autocmd('BufReadPost',  {
        group    = buffer_check_group,
        pattern  = '*',
        callback = function()
            if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
                vim.fn.setpos('.', vim.fn.getpos("'\""))
                -- exe "normal! g'\"" -- Difficult to escape qutoes.
                -- vim.cmd('normal zz') -- Find how to center buffer in a sane way.
                -- vim.cmd('silent! foldopen') -- Open folds. They are annoying.
            end
        end })

    -- Quit overly large files before loading them to avoid slowness.
    vim.api.nvim_create_autocmd('BufReadPre', {
        group = buffer_check_group,
        pattern = "*",
        callback = function()
            local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))
            local mega_byte = 1024 * 1024
            if fsize > 5 * mega_byte then
                 vim.ui.input({ prompt = 'File exceeds recommended file size. Continue [y/n]? ' },
                     function(input)
                            if input ~= 'y' then vim.cmd('quit') end
                     end
                 )
            end
        end
    })

    -- Turn off syntax highlighting that conflicts with treesitter.
    vim.api.nvim_create_autocmd('BufEnter', {
        group = buffer_check_group,
        pattern = "*",
        callback = function()
            local noSyntaxFor = {
                lua = true, markdown = true, sh = true, json = true,
                yaml = true, python = true, c = true, cpp = true, rust = true,
                tex = true
            }
            local noTreeSitterFor = { gitcommit = true }
            if noSyntaxFor[vim.bo.filetype] then
                vim.bo.syntax = false
            end
            if noTreeSitterFor[vim.bo.filetype] then
                vim.cmd('TSBufDisable highlight')
            end
        end
    })

local xresources_group = vim.api.nvim_create_augroup('Xresources Group', {})
    -- Apply .Xresources file after editing the file.
   vim.api.nvim_create_autocmd('BufWritePost',  {
        group    = xresources_group,
        pattern  = '.Xresources',
        callback = function()
            vim.fn.execute('!xrdb && xrdb -merge ~/.Xresources')
        end })

local cpp_group = vim.api.nvim_create_augroup('C++ Group', {})

    -- C++ code settings.
    vim.api.nvim_create_autocmd('FileType',  {
        group    = cpp_group,
        pattern  = 'cpp',
        callback = function()
            vim.cmd('set shiftwidth=2 | set softtabstop=2  | set tabstop=2')
        end })

--------------------------------------------------------------------------------
-- Load templates for newly created files.
--------------------------------------------------------------------------------
local template_group = vim.api.nvim_create_augroup('Template Group', {})

    --- Load a template in the current buffer. The template will be determined
    --- based on the file extension and the file name.
    ---@param name string path to the template to load.
    local function LoadTemplateFromType(name)
        -- The place where the templates are saved.
        local templateDir = vim.fn.expand('~/.config/nvim/templates/')

        -- The path to the template to with the same file extension.
        -- Examples: skeleton.c, skeleton.html, skeleton.awk, etc.
        local pathSameExt = templateDir .. "skeleton." .. vim.fn.expand("%:e")

        -- The path to the template to with the same file name.
        local pathSameName = templateDir .. vim.fn.expand("%:t")

        -- The path to the template to load.
        local template = nil

        -- Check if the template has the same file name or extension.
        for _, path in ipairs({pathSameExt, pathSameName}) do
            if vim.fn.filereadable(path) == 1 then template = path end
        end

        -- Override the template path if a template name is given.
        if name then template = name end

        if template then vim.fn.execute('0r ' .. template) end
    end

    vim.api.nvim_create_user_command('LoadTemplate',
        function(opts)
            LoadTemplateFromType(opts.args)
        end,
        {
            nargs = '*',
            complete = function()
                local regular_templates = vim.api.nvim_get_runtime_file("templates/*", true)
                local hidden_templates = vim.api.nvim_get_runtime_file("templates/.*", true)
                -- Remove the "." directory.
                table.remove(hidden_templates, 1)
                -- Remove the ".." directory.
                table.remove(hidden_templates, 1)
                return table.merge(regular_templates, hidden_templates)
            end,
            desc = 'Load the given template'
        }
     )

     local function ChooseTemplate()
        local regular_templates = vim.api.nvim_get_runtime_file("templates/**", true)
        local hidden_templates = vim.api.nvim_get_runtime_file("templates/**/.*", true)
        local templates = {}
        for _, path in ipairs(table.merge(hidden_templates, regular_templates)) do
            local tail = vim.fs.basename(path)
            -- Do not include special "." and ".." directories.
            if tail ~= "." and tail ~= ".." and vim.fn.isdirectory(path) == 0 then
                table.insert(templates, path)
            end
        end
        vim.ui.select(templates, { prompt = 'Select template to load into file:', },
            function(choice) LoadTemplateFromType(choice) end
         )
     end

    vim.api.nvim_create_user_command('ChooseTemplate', ChooseTemplate,
        { nargs = 0, desc = "Chose a template and load it into the buffer." })

    --- Return whether the file has a hash-bang.
    ---@return boolean True if the file has a hash-bang, false otherwise.
    function FileHasHashBang()
        return vim.fn.getline(0,1)[1]:sub(1, 2) == "#!"
    end

    --- Return the path to the executable specified by the hash-bang.
    ---@return string The path tho the executable.
    function GetHashBang() return vim.fn.getline(0,1)[1]:sub(3) end

    --- Return whether the given path is executable.
    ---@param path string An optional path to the file to check.
    ---@return boolean True if the path is executable by all users.
    function IsExecutable(path)
        -- If the path is not defined, use the path to the current file.
        if not path then path = vim.fn.expand("%") end
        -- Get permissions string including parenthesis, e.g. "drwxrwxrwx".
        local permissions = vim.fn.system({'stat', '--printf="%A"', path})
        -- The eleventh character in the permissions "drwxrwxrwx" represents
        -- whether the file is executable by all users.
        return string.sub(permissions, 11, 11) == "x"
    end

    -- Load a template if one is available when creating a file.
    vim.api.nvim_create_autocmd('BufNewFile',  {
        group    = template_group,
        pattern  = '*',
        callback = function() LoadTemplateFromType() end
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
vim.fn.setenv("TMPDIR", vim.fn.expandcmd("/tmp"))

-- Open a file, operate on it, and open it in a new tab. The function does not
-- remove the temporary file.
-- @param path string The path to the temporary file.
-- @param lines string The contents to write to the file.
local function openTemporaryTab(path, lines)
    local file = io.open(path, "w")
    if file then
        io.output(file)
        io.write(lines)
        io.close(file)
        vim.cmd("belowright split "..path)
        nnoremap('<leader>bd', ':bd<cr>')

        -- Close window entirely rather than leaving the buffer open.
        local opts = { noremap=true, silent=true, buffer=true }
        set('n', '<leader>q', ":bd<cr>", opts)
    end
end

-- Returns true if the file is readable. Returns false for directories.
-- @param path string The path to the file to test.
-- @return bool
local function fileExists(path)
   local file = io.open(path, "r")
   if file ~= nil then
       io.close(file)
       return true
   else
       return false
   end
end

-- Convert the file lines into a table and return it.
-- @param path string The path to the file to convert into a table.
-- @return table
local function fileLines2Table(path)
    local t = {}
    if fileExists(path) then
        for line in io.lines(path, "*l") do
            table.insert(t, line)
        end
    end
    return t
end

-- Edit a table property vim.b[value] by opening a buffer.
-- @param value The buffer property vim.b[value] to modify.
-- @param separator The argument separator character.
local function Edit(value, separator)
    if vim.b[value] == nil then
        error("The buffer property does not exist: " .. value)
    end
    local lines = table.concat(vim.b[value], separator)
    local path = os.tmpname()
    local buffer = vim.api.nvim_get_current_buf()

    pcall(openTemporaryTab, path, lines)

    -- Read the file and set the contents as the run command.
    vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = path,
        callback = function(event)
            local arguments = fileLines2Table(event.file)
            vim.api.nvim_buf_set_var(buffer, value, arguments)
        end
    })

    -- Remove the temporary file when done using it.
    vim.api.nvim_create_autocmd('BufDelete', {
        pattern = path,
        callback = function(event) os.remove(event.file) end
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
    print("Add Comp Flags:", vim.b.addCompFlags)
    vim.b.runCommand = {}
    vim.b.compilationCommand = {}
end
function ToggleAddDebugFlags()
    vim.b.addDebugFlags = not vim.b.addDebugFlags
    print("Add Debug Flags:", vim.b.addDebugFlags)
    vim.b.runCommand = {}
    vim.b.compilationCommand = {}
end
function ToggleFormatOnSave()
    vim.b.formatOnSave = not vim.b.formatOnSave
    print("Format On Save:", vim.b.formatOnSave)
end
function ToggleRunOnSave()
    vim.b.runOnSave = not vim.b.runOnSave
    print("Run On Save:", vim.b.runOnSave)
    vim.b.runCommand = {}
    vim.b.compilationCommand = {}
end

vim.api.nvim_create_user_command('EditRunCommand', EditRunCommand,
    { nargs = 0, desc = "Edit the run (or compilation) command." })
vim.api.nvim_create_user_command('EditCompilationCommand', EditCompilationCommand,
    { nargs = 0, desc = "Edit the run (or compilation) command." })
vim.api.nvim_create_user_command('ToggleAddCompFlags', ToggleAddCompFlags,
    { nargs = 0, desc = "Add compilation flags upon compilation." })
vim.api.nvim_create_user_command('ToggleAddDebugFlags', ToggleAddDebugFlags,
    { nargs = 0, desc = "Add debug flags upon compilation." })
vim.api.nvim_create_user_command('ToggleFormatOnSave', ToggleFormatOnSave,
    { nargs = 0, desc = "Format the file upon saving." })
vim.api.nvim_create_user_command('ToggleRunOnSave', ToggleRunOnSave,
    { nargs = 0, desc = "Run the file upon saving." })
nnoremap('<leader>ce', EditRunCommand)
nnoremap('<leader>cc', ToggleAddCompFlags)
nnoremap('<leader>cd', ToggleAddDebugFlags)
nnoremap('<leader>cf', ToggleFormatOnSave)
nnoremap('<leader>cr', ToggleRunOnSave)

local auto_run_group = vim.api.nvim_create_augroup('Auto Run Group', {
    clear = true
})

    -- Format document before saving.
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = auto_run_group,
        pattern = '*',
        callback = function() if vim.b.formatOnSave then vim.lsp.buf.format() end end
    })

    -- Run the document after saving it.
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = auto_run_group,
        pattern = '*',
        callback = function() if vim.b.runOnSave then Run() end end
    })

    -- Execute files named "scratchpad" each time they are saved.
    vim.api.nvim_create_autocmd({'BufNewFile','BufReadPost'}, {
        group = auto_run_group,
        pattern = 'scratchpad.*',
        callback = function()
            ToggleRunOnSave()
            ToggleFormatOnSave()
            ToggleAddCompFlags()
            ToggleAddDebugFlags()
        end
    })

    -- Always auto-format the following file types.
    vim.api.nvim_create_autocmd('FileType', {
        group = auto_run_group,
        pattern = {'rust', 'cpp', 'html'},
        callback = ToggleFormatOnSave
    })

    -- Always auto-format the following file types.
    vim.api.nvim_create_autocmd('FileType', {
        group = auto_run_group,
        pattern = 'c',
        callback = function()
            vim.api.nvim_create_user_command('CGenerateAssembly0',
                function() vim.fn.execute('!gcc -S -O0 -fverbose-asm "%"') end,
                { nargs = 0, desc = "Generate the assembly file" })
            vim.api.nvim_create_user_command('CGenerateAssembly1',
                function() vim.fn.execute('!gcc -S -O1 -fverbose-asm "%"') end,
                { nargs = 0, desc = "Generate the assembly file" })
            vim.api.nvim_create_user_command('CGenerateAssembly2',
                function() vim.fn.execute('!gcc -S -O2 -fverbose-asm "%"') end,
                { nargs = 0, desc = "Generate the assembly file" })
            vim.api.nvim_create_user_command('CDumpObject',
                function() vim.fn.execute('!objdump -drwC "$TMPDIR/%<"') end,
                { nargs = 0, desc = "Generate the assembly file" })
        end
    })

--------------------------------------------------------------------------------
-- Markdown.
--------------------------------------------------------------------------------
local markdown_group = vim.api.nvim_create_augroup('Markdown Group', {
    clear = true
})
    -- Auto compile markdown file after saving if auto compilation is enabled.
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = markdown_group,
        pattern = '*.md',
        callback = function()
            if vim.b.runOnSave then
                vim.fn.system({'setsid', '--fork', 'pandoc', vim.fn.expand("%"), '-o', vim.fn.expandcmd("$TMPDIR/%<.pdf")})
            end
        end
    })

    -- View pdf files.
    function LaunchViewer()
        local viewer = 'zathura'
        if vim.fn.executable('evince') == 1 then
            viewer = 'evince'
        end
        vim.fn.system({'setsid', '--fork', viewer, vim.fn.expandcmd("$TMPDIR/%<.pdf")})
    end

    -- Auto compile Typst upon changes.
    function LaunchWatcher()
        vim.b.runOnSave = false
        local path = vim.fn.expand("%:p:h")
        local input = vim.fn.expand('%')
        local output = vim.fn.expandcmd("$TMPDIR/%<.pdf")
        vim.fn.system(table.merge('setsid', '--fork', console, path, '-e', 'typst', 'watch', input, output))
    end

    vim.api.nvim_create_autocmd('FileType', {
        group = markdown_group,
        pattern = {'markdown', 'typst'},
        callback = function(event)
            -- View compiled markdown pdf.
            nnoremap('<leader>cv', LaunchViewer, {buffer = true})
            if event.match == "typst" then
                nnoremap('<leader>cw', LaunchWatcher, {buffer = true})
            end
        end
    })

--------------------------------------------------------------------------------
-- LaTeX auto commands.
--------------------------------------------------------------------------------
local latex_group = vim.api.nvim_create_augroup('LaTeX Group', {
    clear = true
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
            nnoremap('<leader>co', RunLaTeX, {buffer = true})
            -- Clean all files except the compiled pdf.
            nnoremap('<leader>cl', CleanLaTeX, {buffer = true})
            -- Open the compiled LaTeX pdf with the specified viewer.
            nnoremap('<leader>cv', ':lua OpenLaTeXPDF("zathura")<cr>', {buffer = true})
        end
    })

    -- Compile LaTeX document every time after saving.
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = latex_group,
        pattern = '*.tex',
        callback = function() if vim.b.runOnSave then RunLaTeX() end end
    })

    -- Clean the all files except the compiled pdf when exiting.
    vim.api.nvim_create_autocmd('VimLeavePre', {
        group = latex_group,
        pattern = '*.tex',
        callback = function() CleanLaTeX() end
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
vim.cmd[[set langmap=йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>?"]]
-- Open history file using :q.
vim.o.history = 200
-- Ignore case in search patterns.
vim.o.ignorecase = true
-- Search queries intelligently using case. Only used if ignorecase is on.
vim.o.smartcase = vim.o.ignorecase
-- Set spelling on.
vim.o.spell = true
-- Define tab and trailing space characters.
vim.opt.listchars = { tab = '◃―▹', trail = '●', extends = '◣', precedes = '◢', nbsp = '○' }
-- Show tabs and trailing spaces.
vim.o.list = true
-- Add indentation when S or cc is pressed.
vim.o.cindent = true
-- Change cwd to file's directory.
-- vim.o.autochdir = true

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
-- Function to auto-install packer if necessary.
local ensure_packer = function()
  local install_path = vim.fn.stdpath('data')
    ..'/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local use = require('packer').use
require('packer').startup(function()
    -- Packer plugin manager.
    use 'wbthomason/packer.nvim'
    -- Speed up loading Lua modules to improve startup time.
    use 'lewis6991/impatient.nvim'
    -- Syntax highlight Confluence wiki pages.
    use 'dix75/jira.vim'
    -- Context-aware comment plugin.
    use { 'numToStr/Comment.nvim',
        config = function() require'Comment'.setup{
            -- LHS of toggle mappings in NORMAL mode.
            toggler = {
                line = '<C-_>', -- Line-comment toggle keymap.
                block = 'gbc', -- Block-comment toggle keymap.
            },
            -- LHS of operator-pending mappings in NORMAL and VISUAL mode.
            opleader = {
                line = '<C-_>', -- Line-comment keymap.
                block = 'gb', -- Block-comment keymap.
            },
            -- Enable keybindings: `false` to not create mappings
            mappings = { basic = true, extra = false }
        } end
    }
    -- Tokyo night color scheme.
    use {'folke/tokyonight.nvim',
        config = function()
            require("tokyonight").setup({
                style = "moon",
                -- Enable this to disable setting the background color.
                transparent = true,
                styles = {
                    -- Background styles. Can be "dark", "transparent" or "normal".
                    sidebars = "transparent", -- Style for sidebars.
                    floats = "transparent", -- Style for floating windows
                }
            })
            require("tokyonight").colorscheme()
        end
    }
    -- Code snippet auto completion.
    use {'saadparwaiz1/cmp_luasnip',
        -- Code snippets. Needed by cmp-vim.
        requires = 'L3MON4D3/LuaSnip'}
    -- Easily align tables, or text by symbols like , ; = & etc.
    use 'junegunn/vim-easy-align'
    -- Tagbar for class and function outlines.
    use 'simrat39/symbols-outline.nvim'
    -- Show indentation lines.
    use 'lukas-reineke/indent-blankline.nvim'
    -- Add JSDoc, Doxygen, etc support.
    use { "danymat/neogen",
        config = function() require('neogen').setup { snippet_engine = "luasnip" } end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        tag = "*"
    }
    use { 'kkoomen/vim-doge', run = ':call doge#install()' }
    use 'gpanders/editorconfig.nvim'
    -- use 'nvim-treesitter/playground'
    -- use '~/Code/treesitter-markdown'
    -- NOTE: Nvim-web-devicons requires a patched font such as MesloLGS NF.
    -- use 'kyazdani42/nvim-web-devicons'
    -- Fancy debug adapter UI provider and Debug Adapter Protocol.
    use { "rcarriga/nvim-dap-ui", requires = 'mfussenegger/nvim-dap' }
    -- Adapter for vscode-js-debug.
    use { "mxsdev/nvim-dap-vscode-js", requires = "mfussenegger/nvim-dap" }
    -- Provide richer syntax highlighting and only spell-check comments.
    use { 'nvim-treesitter/nvim-treesitter',
        -- Show context in first line. Know what class or function you are in.
        requires = 'nvim-treesitter/nvim-treesitter-context' }
    -- Session manager for recently opened files.
    use 'Shatur/neovim-session-manager'
    -- Supporting functionality.
    use 'nvim-lua/plenary.nvim'
    -- NOTE: Install fd and ripgrep. Rich fuzzy finder.
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = {
            'kyazdani42/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            local set = vim.keymap.set
            local noremap = {noremap = true}
            local builtin = require('telescope.builtin')
            set('n', '<leader>tl', builtin.live_grep, noremap)
            set('n', '<leader>tb', builtin.buffers, noremap)
            set('n', '<leader>th', builtin.help_tags, noremap)
            set('n', '<leader>tg', builtin.git_status, noremap)
            set('n', '<leader>tr', builtin.resume, noremap)
            set('n', 'z=', builtin.spell_suggest, noremap)
            set('n', '<localleader><localleader>', ':Telescope<cr>', noremap)

            --------------------------------------------------------------------------------
            -- Telescope ui-select.
            --------------------------------------------------------------------------------
            -- Custom function for telescope file browser.
            local fb_actions = require "telescope".extensions.file_browser.actions
            local action_state = require "telescope.actions.state"
            --- Toggle files and folders in `.gitignore` for |telescope-file-browser.picker.file_browser|.
            ---@param prompt_bufnr number: The prompt bufnr
            fb_actions.toggle_gitignore = function(prompt_bufnr)
            -- local toggle_gitignore = function(prompt_bufnr)
            -- local function toggle_gitignore(prompt_bufnr)
              local current_picker = action_state.get_current_picker(prompt_bufnr)
              local finder = current_picker.finder
              finder.respect_gitignore = not finder.respect_gitignore
              current_picker:refresh(finder, { reset_prompt = true, multi = current_picker._multi })
            end

            -- Set vim.ui.select to telescope. This affects SessionManager.
            local actions = require "telescope.actions"
            require("telescope").setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-h>"] = actions.preview_scrolling_up,
                            ["<C-l>"] = actions.preview_scrolling_down,
                        },
                        n = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-h>"] = actions.preview_scrolling_up,
                            ["<C-l>"] = actions.preview_scrolling_down,
                        }
                    },
                },
                pickers = {
                    find_files = {
                        -- Use the current file's folder as cwd.
                        cwd = vim.fn.expand("%:h"),
                        -- Show hidden?
                        hidden = true,
                        -- Show files in gitignore?
                        no_ignore = true,
                        -- Show files in parent folder gitignore?
                        no_ignore_parent = true,
                    },
                    git_files = {
                        -- Show files that are not tracked?
                        show_untracked=true,
                    }
                },
                extensions = {
                    file_browser = {
                        -- Show file_browser instead of netrw.
                        hijack_netrw = true,
                        -- Use the current file's folder as cwd.
                        cwd=vim.fn.expand('%:h'),
                        mappings = {
                            -- Show hidden files? <C-h>/h
                            -- Show files in .gitignore? <C-u>/u
                            ["n"] = {
                                ["<u>"] = fb_actions.toggle_gitignore,
                            },
                            ["i"] = {
                                ["<C-u>"] = fb_actions.toggle_gitignore,
                            }
                        }
                    },
                    ["ui-select"] = {
                        -- Improves the looks of `lua vim.lsp.buf.code_action()`.
                        require("telescope.themes").get_dropdown {
                          -- even more opts
                        }
                    }
                }
            }

            --------------------------------------------------------------------------------
            -- Telescope UI-select.
            --------------------------------------------------------------------------------
            require("telescope").load_extension("ui-select")

            --------------------------------------------------------------------------------
            -- Telescope file browser.
            --------------------------------------------------------------------------------
            require("telescope").load_extension("file_browser")
            set("n", "<space>tf", require('telescope').extensions.file_browser.file_browser, noremap)

            -- Find files in git repo if possible, else find files like normal.
            local project_files = function()
                local opts = {}
                local ok = pcall(require"telescope.builtin".git_files, opts)
                if not ok then require"telescope.builtin".find_files(opts) end
            end

            --------------------------------------------------------------------------------
            -- Telescope.
            --------------------------------------------------------------------------------
            set('n', '<leader>te', project_files, noremap)

            --------------------------------------------------------------------------------
            -- Telescope repo. Find git repositories.
            --------------------------------------------------------------------------------
            -- Using nvimpager as the pager does not work, use less or most.
            if vim.fn.executable('less') then vim.fn.setenv("PAGER", "less -r") end
            require('telescope').load_extension('repo')
            set('n', '<leader>tp', require'telescope'.extensions.repo.list, noremap)
        end
    }
    use 'nvim-telescope/telescope-ui-select.nvim'
    -- NOTE: Install fd and glow. Git repo searcher and opener.
    use { 'cljoly/telescope-repo.nvim',
        requires = 'nvim-telescope/telescope.nvim' }
    -- File browser with Telescope previews.
    use "nvim-telescope/telescope-file-browser.nvim"
    -- Add Nu shell syntax highlighting.
    use 'LhKipp/nvim-nu'
    -- Add OpenGL Shader Language support.
    use 'tikhomirov/vim-glsl'
    -- Prettify status line.
    use {'feline-nvim/feline.nvim',
        -- Show trailing spaces and mixed indents in Feline.
        requires = 'stumash/snowball.nvim' }
    -- Highlight colors such as #315fff or #f8f.
    use {'norcalli/nvim-colorizer.lua',
        config = function() require('colorizer').setup() end}
    -- View open buffers and tabs in the top row.
    use { 'akinsho/bufferline.nvim', tag = "v2.*",
        config = function()
            require('bufferline').setup {
                options = {
                    numbers = "ordinal",
                    diagnostics = "nvim_lsp",
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                }
            }
        end,
        requires = 'kyazdani42/nvim-web-devicons'
    }
    -- Git stager and commiter.
    use { 'TimUntersberger/neogit',
        -- Fix compatibility with Bufferline plugin.
        commit = '4cc4476acbbc772f29fd6c1ccee43f58a29a1b13',
        cmd = "Neogit",
        requires = 'nvim-lua/plenary.nvim' }
    -- Auto close open brackets, parenthesis, quotes, etc.
    use { "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end }
    -- Install language servers, formatters, linters, and debug adapters.
    use { "williamboman/mason.nvim",
        config = function() require("mason").setup {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
        end
    }
    -- Configurations for Nvim LSP.
    use "williamboman/mason-lspconfig.nvim"
    -- Ensure lspconfig servers are installed.
    use {"neovim/nvim-lspconfig",
        config = function() require("mason-lspconfig").setup({
            -- Install servers set up via lspconfig.
            automatic_installation = true,
        }) end
    }
    use { 'jose-elias-alvarez/null-ls.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require("null-ls").setup {
                sources = {
                    ------------------------------------------------------------
                    -- Problematic.
                    ------------------------------------------------------------
                    -- Is not very useful.
                    -- require("null-ls").builtins.hover.printenv,
                    -- Refactoring for JavaScript and TypeScript, but doesn't work.
                    -- require("null-ls").builtins.code_actions.refactoring,
                    -- Useful but may leak information.
                    -- require("null-ls").builtins.hover.dictionary,
                    -- No visible changes.
                    -- require("null-ls").builtins.code_actions.cspell,
                    -- For Markdown and LaTeX: Not very useful.
                    -- require("null-ls").builtins.diagnostics.proselint,
                    -- require("null-ls").builtins.code_actions.proselint,
                    -- This functionality is provided by the "snowball" plugin.
                    -- require("null-ls").builtins.diagnostics.trail_space,
                    -- I don't even know what this does.
                    -- require("null-ls").builtins.code_actions.ltrs,
                    -- Not mature. Use StyLua.
                    -- require("null-ls").builtins.diagnostics.selene,
                    -- Tags need to be manually created with ctags -R.
                    -- require("null-ls").builtins.completion.tags,
                    -- Already provided by cmp_luasnip and luasnip plugins.
                    -- require("null-ls").builtins.completion.luasnip,
                    -- Does not have as many options as shfmt.
                    -- require("null-ls").builtins.formatting.beautysh,
                    -- Provide text auto completion.
                    -- require("null-ls").builtins.completion.spell,

                    ------------------------------------------------------------
                    -- Useful.
                    ------------------------------------------------------------
                    -- Add action to preview, reset, select, and stage hunks.
                    require("null-ls").builtins.code_actions.gitsigns,
                    -- Auto-complete CMake commands and keywords.
                    require("null-ls").builtins.diagnostics.cmake_lint,
                    -- Show Python lint errors.
                    require("null-ls").builtins.diagnostics.pylint,
                    -- Show messages when bad indentation occurs.
                    require("null-ls").builtins.formatting.cmake_format,
                    -- Add code actions since they aren't provided by the LSP.
                    require("null-ls").builtins.code_actions.shellcheck,
                    -- Format Lua files based on .stylua.toml file.
                    require("null-ls").builtins.formatting.stylua.with({
                        extra_args = {'--column-width', '100', '--quote-style', 'AutoPreferSingle'}
                    }),
                    -- Format Python code and comments consistently.
                    require("null-ls").builtins.formatting.black.with({
                        extra_args = {'--line-length', '100'}
                    }),
                    -- Formats Bash scripts and ensures consistent indentation.
                    require("null-ls").builtins.formatting.shfmt,
                    -- Formats Markdown tables.
                    require("null-ls").builtins.formatting.prettier
                },
                -- Set correct encoding to avoid gitsigns warning: multiple
                -- different client offset_encodings detected for buffer, this
                -- is not supported yet.
                on_init = function(new_client, _)
                    if vim.bo.filetype == 'cpp' then
                        new_client.offset_encoding = 'utf-8'
                    end
                end,
            }

            local lintersAndFormatters = {
                'cmakelang', -- CMake linter
                'shfmt', -- Bash formatter
                'stylua', -- Lua formatter
                'prettier', -- Markdown formatter.
            }

            vim.api.nvim_create_user_command(
                'MasonInstallLintersAndFormatters',
                function() MasonInstall(lintersAndFormatters) end,
                { nargs = 0, desc = 'Install linters/formatters for CMake, Lua, Bash' }
            )
        end
    }
    -- Window picker for using with Dap UI because it opens many windows.
    use 'https://gitlab.com/yorickpeterse/nvim-window'
    --  NOTE: Requires universal ctags. Tagbar: a class outline viewer for Vim.
    use 'preservim/tagbar'
    -- Add git decorations for modified lines, +, -, ~, etc.
    use 'lewis6991/gitsigns.nvim'
    -- Completion plugin.
    use { 'hrsh7th/nvim-cmp',
        requires =  {
            -- Completion sources.
            'f3fora/cmp-spell',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-path',
            'octaltree/cmp-look',
            -- Icons before source names.
            'onsails/lspkind.nvim'
        }
    }
    -- Auto-install packer if necessary.
    if packer_bootstrap then require('packer').sync() end
end)

--------------------------------------------------------------------------------
-- Impatient.
--------------------------------------------------------------------------------
-- Does not need to be at top of file.
require('impatient')

--------------------------------------------------------------------------------
-- Nvim-Window.
--------------------------------------------------------------------------------
require('nvim-window').setup({
    -- The characters available for hinting windows.
    chars = {
        '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'k', 'l','m',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    },
    -- The border style to use for the floating window.
    border = 'rounded'
})
nnoremap('<leader><leader>', require("nvim-window").pick)


--------------------------------------------------------------------------------
-- Doge - Documentation Generator
--------------------------------------------------------------------------------
vim.g.doge_python_settings = { omit_redundant_param_types = 0 }
vim.g.doge_doc_standard_python = 'google'

-- Use a POSIX-compliant shell when executing Doge commands to avoid errors.
vim.api.nvim_create_user_command('Doge', function()
    local shell = os.getenv("SHELL") or "/usr/bin/sh"
    vim.o.shell = "/usr/bin/sh"
    vim.cmd("DogeGenerate")
    vim.o.shell = shell
end, {})

vim.fn.sign_define('DapBreakpoint',{ text ='⏺️', texthl ='Error', linehl ='Error', numhl ='Error'})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='Search', linehl ='Search', numhl ='Search'})

nnoremap('dC', require 'dap'.continue) -- [C]ontinue
nnoremap('dO', require 'dap'.step_over) -- [O]ver
nnoremap('<enter>', require 'dap'.step_over)
nnoremap('dI', require 'dap'.step_into) -- [I]nto
nnoremap('dU', require 'dap'.step_out) -- [U]p
nnoremap('dE', require 'dap'.terminate) -- T[e]rminate, [E]nd
nnoremap('dT', require 'dap'.toggle_breakpoint) -- [T]oggle
nnoremap('dB', function()
    require('dap').set_breakpoint(vim.fn.input("Condition: "), vim.fn.input("Hit Condition: "), vim.fn.input('Log Message: '))
end)
nnoremap('dR', require('dap').repl.open) -- [R]epl
nnoremap('dL', require('dap').run_last) -- [L]ast
set({'n', 'v'}, 'dH', require('dap.ui.widgets').hover) -- [H]over
set({'n', 'v'}, 'dP', require('dap.ui.widgets').preview) -- [P]review
nnoremap('dF', function() -- [F]rames
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
nnoremap('dS', function() -- [S]copes
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

--------------------------------------------------------------------------------
-- Gitsigns.
--------------------------------------------------------------------------------
require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function mapb(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      set(mode, l, r, opts)
    end

    -- Navigation
    mapb('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    mapb('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    mapb({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    mapb({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    mapb('n', '<leader>hS', gs.stage_buffer)
    mapb('n', '<leader>hu', gs.undo_stage_hunk)
    mapb('n', '<leader>hR', gs.reset_buffer)
    mapb('n', '<leader>hp', gs.preview_hunk)
    mapb('n', '<leader>hb', function() gs.blame_line{full=true} end)
    mapb('n', '<leader>tb', gs.toggle_current_line_blame)
    mapb('n', '<leader>hd', gs.diffthis)
    mapb('n', '<leader>hD', function() gs.diffthis('~') end)
    mapb('n', '<leader>td', gs.toggle_deleted)
    -- Text object
    mapb({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

--------------------------------------------------------------------------------
-- DAP and DAPUI.
--------------------------------------------------------------------------------
local debuggers = {
    'debugpy', -- Python.
    'cpptools', -- C++/C/Rust
    'js-debug-adapter', -- JavaScript, TypeScript.
}

vim.api.nvim_create_user_command(
    'MasonInstallDebuggers',
    function() MasonInstall(debuggers) end,
    { nargs = 0, desc = 'Install debuggers for C, C++, Rs, Py, JS, TS.' }
)

require("dapui").setup({
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
        }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    force_buffers = true,
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 0.25 }
            },
            position = "left",
            size = 40
        },
        {
            elements = {
                { id = "repl", size = 0.95 },
                -- { id = "console", size = 0.5 }
            },
            position = "bottom",
            size = 10
        }
    },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    render = {
        indent = 1,
        max_value_lines = 100
    }
})

local dap, dapui = require("dap"), require("dapui")

dap.adapters.python = {
  type = 'executable';
  command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/debugpy-adapter'
}
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function() return 'python3' end;
  },
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/OpenDebugAD7'
}

local function GetDebugExecutable()
    local compilationPath = vim.fn.expandcmd('$TMPDIR/%:t:r')
    local sourcePath = vim.fn.expand('%:p:r')
    local cargoPath = function()
        if vim.fn.execute('cargo') then
            local metadata = vim.fn.system({'cargo', 'metadata', '--format-version', '1'})
            local name = metadata:gmatch('"name":"(.-)"')()
            local directory = metadata:gmatch('"target_directory":"(.-)"')()
            if directory and name then return directory .. '/' .. name end
        end
        return ""
    end

    for _, path in ipairs({sourcePath, compilationPath, cargoPath}) do
        if vim.fn.executable(path) == 1 then return path end
    end

    -- Manually enter executable name:
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
end
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = GetDebugExecutable,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = GetDebugExecutable,
  },
}
-- Reuse configuration for C and Rust.
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("dap-vscode-js").setup({
    -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    debugger_cmd = { os.getenv('HOME') .. "/.local/share/nvim/mason/bin/js-debug-adapter" },
    -- Which adapters to register in nvim-dap.
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

dap.configurations.javascript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
    },
    {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require 'dap.utils'.pick_process,
        cwd = "${workspaceFolder}",
    },
    {
        type = "pwa-node",
        request = "launch",
        name = "Debug Mocha Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
            "./node_modules/mocha/bin/mocha.js",
        },
        program = "${file}",
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
    }
}
dap.configurations.typescript = dap.configurations.javascript

-- Open windows automatically when debug session starts.
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

--------------------------------------------------------------------------------
-- Nvim-treesitter.
--------------------------------------------------------------------------------
--{{ For work.
require 'nvim-treesitter.install'.compilers = { "clang", "tcc", "gcc", "zig", "cc" }
require'nvim-treesitter.install'.prefer_git = true
--}}
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    -- ensure_installed = { "c", "lua", "rust" },
    ensure_installed = "all",

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "haskell" },
    ignore_install = {},

    -- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers",
    -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- True to only apply spellcheck to comments and false otherwise.
        -- Setting this to true will run `:h syntax` and tree-sitter at the same
        -- time. Set this to `true` if you depend on 'syntax' being enabled (like
        -- for indentation). Using this option may slow down your editor, and you
        -- may see some duplicate highlights. Instead of true it can also be a list
        -- of languages
        additional_vim_regex_highlighting = true,
    },
}
--------------------------------------------------------------------------------
-- Session Manager.
--------------------------------------------------------------------------------
nnoremap('<leader>sl', ':SessionManager load_session<cr>')
nnoremap('<leader>sd', ':SessionManager delete_session<cr>')
nnoremap('<leader>ss', ':SessionManager save_session<cr>')
nnoremap('<leader>sp', ':SessionManager load_last_session<cr>')
require('session_manager').setup({
    -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
    -- autoload_mode = require('session_manager.config').AutoloadMode.LastSession,
    autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
    autosave_last_session = true, -- Automatically save last session on exit and on session switch.
    autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
        'gitcommit',
    },
    autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
    max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})

--------------------------------------------------------------------------------
-- Feline.
--------------------------------------------------------------------------------
local snowball = require('snowball')
snowball.setup({ labels = snowball.labels_alternate })
require('feline').setup {
   custom_providers = { [snowball.provider_name] = snowball.provider },
   components = snowball.reverse_scroll_bar(snowball.add_whitespace_component(
       require('feline.default_components').statusline.icons
   )),
}

local opts = {
  -- highlight_hovered_item = true,
  -- show_guides = true,
  -- auto_preview = false,
  -- position = 'right',
  -- relative_width = true,
  -- width = 25,
  auto_close = true,
  -- show_numbers = false,
  -- show_relative_numbers = false,
  -- show_symbol_details = true,
  -- preview_bg_highlight = 'Pmenu',
  -- autofold_depth = nil,
  -- auto_unfold_hover = true,
  -- wrap = false,
  -- keymaps = { -- These keymaps can be a string or a table for multiple keys
    -- close = {"<Esc>", "q"},
    -- goto_location = "<Cr>",
    -- focus_location = "o",
    -- hover_symbol = "<C-space>",
    -- toggle_preview = "K",
    -- rename_symbol = "r",
    -- code_actions = "a",
    -- fold = "h",
    -- unfold = "l",
    -- fold_all = "W",
    -- unfold_all = "E",
    -- fold_reset = "R",
  -- },
  -- lsp_blacklist = {},
  symbol_blacklist = {
      -- 'File',
      -- 'Module',
      -- 'Namespace',
      -- 'Package',
      -- 'Class',
      -- 'Method',

      -- 'Property',
      -- 'Field',
      -- 'Constructor',

      'Enum',
      -- 'Interface',
      -- 'Function',

      'Variable',
      'Constant',
      -- 'String',
      'Number',
      'Boolean',
      -- 'Array',
      'Object',
      -- 'Key',
      -- 'Null',
      'EnumMember',
      -- 'Struct',
      -- 'Event',
      -- 'Operator',
      -- 'TypeParameter',
      -- 'Component',
      -- 'Fragment',
  },
  -- symbols = {
    -- File = {icon = "", hl = "TSURI"},
    -- Module = {icon = "", hl = "TSNamespace"},
    -- Namespace = {icon = "", hl = "TSNamespace"},
    -- Package = {icon = "", hl = "TSNamespace"},
    -- Class = {icon = "𝓒", hl = "TSType"},
    -- Method = {icon = "ƒ", hl = "TSMethod"},
    -- Property = {icon = "", hl = "TSMethod"},
    -- Field = {icon = "", hl = "TSField"},
    -- Constructor = {icon = "", hl = "TSConstructor"},
    -- Enum = {icon = "ℰ", hl = "TSType"},
    -- Interface = {icon = "ﰮ", hl = "TSType"},
    -- Function = {icon = "", hl = "TSFunction"},
    -- Variable = {icon = "", hl = "TSConstant"},
    -- Constant = {icon = "", hl = "TSConstant"},
    -- String = {icon = "𝓐", hl = "TSString"},
    -- Number = {icon = "#", hl = "TSNumber"},
    -- Boolean = {icon = "⊨", hl = "TSBoolean"},
    -- Array = {icon = "", hl = "TSConstant"},
    -- Object = {icon = "⦿", hl = "TSType"},
    -- Key = {icon = "🔐", hl = "TSType"},
    -- Null = {icon = "NULL", hl = "TSType"},
    -- EnumMember = {icon = "", hl = "TSField"},
    -- Struct = {icon = "𝓢", hl = "TSType"},
    -- Event = {icon = "🗲", hl = "TSType"},
    -- Operator = {icon = "+", hl = "TSOperator"},
    -- TypeParameter = {icon = "𝙏", hl = "TSParameter"}
  -- }
}

require("symbols-outline").setup(
    opts
)

--------------------------------------------------------------------------------
-- Nvim LspConfig.
--------------------------------------------------------------------------------
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
set('n', '<leader>e', vim.diagnostic.open_float, opts)
set('n', '[d', vim.diagnostic.goto_prev, opts)
set('n', ']d', vim.diagnostic.goto_next, opts)
-- nmap <buffer> [g <plug>(lsp-previous-diagnostic)
-- nmap <buffer> ]g <plug>(lsp-next-diagnostic)
set('n', '<leader>d', vim.diagnostic.setloclist, opts)
set('n', '<leader>D', vim.diagnostic.setqflist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- set('n', 'K', vim.lsp.buf.hover, bufopts)
    set('n', '<space>K', vim.lsp.buf.hover, bufopts)

    set('n', '<space>gi', vim.lsp.buf.implementation, bufopts)
    -- set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    set('n', 'gs', vim.lsp.buf.document_symbol, bufopts)
    set('n', 'gS', vim.lsp.buf.workspace_symbol, bufopts)
    set('n', '<leader><s-s>', vim.lsp.buf.signature_help, bufopts)
    -- set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- set('n', '<leader>wl', function()
        -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    set('x', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    set('n', '<C-.>', vim.lsp.buf.code_action, bufopts)
    set('n', 'gr', vim.lsp.buf.references, bufopts)
    set('n', '<c-a>', vim.lsp.buf.code_action, bufopts)
    -- Use gq for LPS formatting and gw for regular formatting.
    set('x', '<leader>f', vim.lsp.buf.format, bufopts)
    vim.api.nvim_create_user_command('FormatDocument', function() vim.lsp.buf.format() end,
        { nargs = 0, desc = "Format the document to fix indentation and spacing issues" })
end

--------------------------------------------------------------------------------
-- Language servers.
--------------------------------------------------------------------------------
local servers = {
    'awk_ls', -- AWK
    'bashls', -- Bash
    'clangd', -- C/C++
    'cmake', -- CMake
    'cssls', -- CSS
    -- 'dockerls', -- Docker
    'eslint',   -- JavaScript, TypeScript; Linter needs .eslintrc.yml.
    'groovyls', -- Groovy
    'html', -- HTML
    -- 'jdtls', -- Java
    'jsonls', -- JSON
    'ltex',
    'marksman', -- Markdown
    -- 'phpactor', -- PHP
    'pyright',
    'rust_analyzer', -- Rust
    -- 'sqls', -- SQL
    'taplo', -- TOML
    -- 'texlab', -- LaTeX
    'tsserver', -- JavaScript, TypeScript; LSP functionality.
    'typst_lsp', -- Typst
}

-- Enable (broadcasting) snippet capability for completion.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

for _, server in ipairs(servers) do
    require('lspconfig')[server].setup{
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

require('lspconfig').yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                -- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
                -- ["../path/relative/to/file.yml"] = "/.github/workflows/*"
                -- ["/path/from/root/of/project"] = "/.github/workflows/*"
            },
        },
    }
}

require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- Don't ask to configure workspace for luassert, luv, etc.
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique
            -- identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

--------------------------------------------------------------------------------
-- Completion.
--------------------------------------------------------------------------------
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end


require('cmp').setup {
    snippet = {
      -- NOTE: You must specify a snippet engine.
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    formatting = {
        format = function(entry, vim_item)

            -- Fancy icons and a name of kind.
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
                                " " .. vim_item.kind

            -- Set a name for each source.
            vim_item.menu = ({
                calc = "[Calc]",
                emoji = "[Emoji]",
                look = "[Look]",
                luasnip = "[Snip]",
                nvim_lsp = "[LSP]",
                nvim_lsp_signature_help = "[Signature]",
                nvim_lua = "[Lua]",
                path = "[Path]",
                spell = "[Spell]",
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = {
        ['<C-k>'] = require('cmp').mapping.select_prev_item(),
        ['<C-j>'] = require('cmp').mapping.select_next_item(),
        ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
        ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
        ['<C-Space>'] = require('cmp').mapping.complete(),
        ['<C-e>'] = require('cmp').mapping.close(),
        -- ['<Esc>'] = require('cmp').mapping.close(),

        ["<Esc>"] = require('cmp').mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t("<Esc><Esc>"), "n")
            else
                fallback()
            end
        end, {"i"}), -- Only apply in insert mode, not "s".

        ['<CR>'] = require('cmp').mapping.confirm({
            behavior = require('cmp').ConfirmBehavior.Insert,
            select = true
        }),
    },
    sources = {
        { name = 'calc'},                          -- Source for math calculation.
        { name = 'emoji' },
        { name = 'look' },
        { name = 'luasnip' },                      -- Snippets.
        { name = 'nvim_lsp' },                     -- Language server.
        { name = 'nvim_lsp_signature_help'},       -- Display function signatures with current parameter emphasized.
        { name = 'nvim_lua', keyword_length = 2 }, -- Complete neovim's Lua runtime API such vim.lsp.*.
        { name = 'path' },                         -- File paths.
        { name = 'spell', keyword_length = 4 },
    },
    -- menuone: popup even when there's only one match
    -- noinsert: Do not insert text until a selection is made
    -- noselect: Do not select, force to select one from the menu
    completion = {completeopt = 'menu,menuone,noinsert,noselect'}
}

-- local entries = { entries = { name = 'wildmenu', separator = ' ' } }
-- local entries  = { name = 'custom', selection_order = 'near_cursor' }
local entries  = { name = 'custom' }
local mappings = {
    ['<C-j>'] = { c = require('cmp').mapping.select_next_item() },
    ['<C-k>'] = { c = require('cmp').mapping.select_prev_item() },
    ['<Tab>'] = { c = require('cmp').mapping.select_next_item() },
    ['<S-Tab>'] = { c = require('cmp').mapping.select_prev_item() },
    -- ['<CR>'] = { c = require('cmp').mapping.confirm({
        -- behavior = require('cmp').ConfirmBehavior.Insert,
        -- select = true
    -- })},
    ['<Esc>'] = { c = require('cmp').mapping.close(),}
    -- ['<Tab>'] = { c = require('cmp').mapping.confirm({
        -- behavior = require('cmp').ConfirmBehavior.Insert,
        -- select = true
    -- })},
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
require('cmp').setup.cmdline({ '/', '?' }, {
    view = { entries = entries },
    mapping = require('cmp').mapping.preset.cmdline(mappings),
    sources = {
        { name = 'buffer' } -- Source text in current buffer.
    },
    completion = {completeopt = 'menu,menuone,noinsert,noselect'}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
require('cmp').setup.cmdline(':', {
    view = { entries = entries },
    mapping = require('cmp').mapping.preset.cmdline(mappings),
    sources = require('cmp').config.sources({
        { name = 'path' }
    }, {
        -- Remove cmp-cmdline from global sources because it will produce
        -- errors, so add cmp-cmdline for the cmdline setup function.
        { name = 'cmdline' }
    }),
    completion = {completeopt = 'menu,menuone,noinsert,noselect'}
})

--------------------------------------------------------------------------------
-- Auto compilation settings.
--------------------------------------------------------------------------------

--- Split a string of command-line arguments into a list.
---@param str string The string with one or more arguments.
---@return Array
local function str2list(str)
  local t = {}
  -- Balanced quotes.
  for quoted, non_quoted in ('""'..str):gmatch'(%b"")([^"]*)' do
    table.insert(t, quoted ~= '""' and quoted:sub(2,-2) or nil)
    for word in non_quoted:gmatch'%S+' do
      table.insert(t, word)
    end
  end
  return t
end

--- Splits a string into a table using the given character.
---@param separator string The character to use as a seperator.
---@return table
function string:split(separator)
    local fields = {}
    local pattern = string.format('([^%s]+)', separator)
    for match in self:gmatch(pattern) do
        fields[#fields + 1] = match
    end
    return fields
end

--- Returns a character separator that does not appear in the given string.
---@return string?
function string:chooseSeparator()
    for _, separator in ipairs({ '|', '@', '#', ':', '+', '-' }) do
        if not self:find(separator) then
            return separator
        end
    end
    return nil
end

--- Benchmark the execution time of compiled binary.
---@param times number How many times to execute the program.
---@param executable_path string path The path to the file or binary to execute.
---@param runner string The interpreter name.
function BenchmarkExecutionTime(times, executable_path, runner)
    if not times or not executable_path then return end

    times = times or 10 -- Execute the program this many times.
    -- Remove the parent directories and extension to get file name.
    executable_path = executable_path or expand("%:p:r")
    runner = runner or ''

    local program = string.format([[
        for ((i=1;i<=%s;i++)); do
            # Execute the program.
            %s %s > /dev/null
        done
    ]], times, runner, executable_path)

    print(program)

    --  Run the file.
    local stdout = vim.fn.system({'/usr/bin/time', '-p', 'bash', '-c', program})
    print(stdout)
end

--- Convert a string into a dictionary and return the dictionary.
---@param string string The string to convert to a dictionary.
---@return table
local function str2dict(string)
    local dict = {}

    -- Regex building blocks.
    local equalsSignWithZeroOrMoreSurroundingSpaces = '%s*=%s*'
    local oneOrMoreWordChars = '(%w+)'
    local stringWithNoSpaces = '(%S+)'
    local shortestStringInDoubleQuotes = '(".-")'
    local shortestStringInSingleQuotes = "('.-')"

    local dict_entry_patterns = {
        -- "(%w+)%s*=%s*(%S+)", -- Match strings with no spaces.
        -- '(%w+)%s*=%s*(".-")', -- Match shortest string inside double quotes.
        -- "(%w+)%s*=%s*('.-')", -- Match shortest string inside single quotes.
        oneOrMoreWordChars .. equalsSignWithZeroOrMoreSurroundingSpaces .. stringWithNoSpaces,
        oneOrMoreWordChars .. equalsSignWithZeroOrMoreSurroundingSpaces .. shortestStringInDoubleQuotes,
        oneOrMoreWordChars .. equalsSignWithZeroOrMoreSurroundingSpaces .. shortestStringInSingleQuotes,
    }

    for _, pattern in ipairs(dict_entry_patterns) do
        for key, value in string:gmatch(pattern) do
            dict[key] = value
        end
    end
    return dict
end

vim.api.nvim_create_user_command('Time',
    function(opts)
        local args = str2dict(opts.args)

        local times = args.times or 10
        local executable_path = args.path or vim.fn.expand("%:p:r")
        local runner = args.runner or ''

        BenchmarkExecutionTime(times, executable_path, runner)
    end,
    {
        nargs = '*',
        complete = function(ArgLead, CmdLine, CursorPos)
            -- Times to execute program.
            local times = 1000
            -- Define the path where the compiled executable will be placed, and
            -- where it should be executed. Remove the parent directories and
            -- extension to get file name.
            local executable_path = vim.fn.expandcmd("$TMPDIR/%:t:r")
            local completion_str_runner = 'times=%d runner=%s path="%s"'
            local completion_str = 'times=%d path="%s"'
            return {
                completion_str_runner:format(times, GetRunner(), executable_path),
                completion_str_runner:format(times, GetRunner(), vim.fn.expand("%:p")),
                completion_str:format(times, vim.fn.expand("%:p")),
                completion_str:format(times, executable_path),
            }
        end,
        desc = 'Execute the given file'
    }
 )

-- Another compiler for c is tcc.
local ft2compiler = {
    c    = 'gcc',
    cpp  = 'g++',
    rust = 'rustc',
    vala = 'valac',
}

-- Validate GLSL code for extensions: vert, tesc, tese, glsl, geom, frag, comp.
local ft2interpreter = {
    python     = "python3",
    java       = "java",
    groovy     = "groovy",
    lua        = "lua",
    sh         = "bash",
    javascript = "node",
    glsl       = "glslangValidator",
    typst      = {"typst", "compile"},
}
vim.filetype.add({ extension = {typ = "typst"}})

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
    c   = {unpack(cflags)},
    cpp = {'-std=c++17', unpack(cflags)},
}

local ft2debugflags = {
    c    = {unpack(debug_flags)},
    cpp  = {unpack(debug_flags)},
    rust = {'-g'}
}

--- Return the hash-bang, interpreter, or compiler for running the current file.
---@return string|nil
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
        local runCommand = str2list(GetHashBang())
        table.insert(runCommand, vim.fn.expand("%"))
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
        vim.b.runCommand = table.merge(interpreter, path)

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
        local executable_path = vim.fn.expandcmd("$TMPDIR/%:t:r")

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
            flags = table.merge(ft2debugflags[vim.bo.filetype], flags)
        end

        -- Compile and run the file.
        vim.b.compilationCommand = table.merge(compiler, flags, path, "-o", executable_path)
        vim.b.runCommand = {executable_path}
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
    RubberCompFlags = {'rubber', '--shell-escape', '--synctex', '--inplace'}

    -- grep: Look for first line that contains "% jobname:". Ignore whitespace.
    local jobname_line = vim.fn.system({'grep', '--max-count=1', '%*jobname:',
        vim.fn.expand('%')})
    -- Ignore surrounding whitespace. Match any characters such that the last
    -- one is not whitespace. The job name can be many words long.
    vim.b.latexJobName = jobname_line:gmatch('.*jobname:%s*(.*%S)%s*')()
end

function RunLaTeX()
    if vim.b.latexJobName then
        -- Compile using the jobname.
        local arguments = table.merge(RubberCompFlags, '--pdf', '--jobname', vim.b.latexJobName, vim.fn.expand('%'))
        local stdout = vim.fn.system(arguments)
        print(stdout)
    else
        -- If there is no jobname, compile using the default file name.
        local stdout = vim.fn.system(table.merge(RubberCompFlags, '--pdf', vim.fn.expand('%')))
        print(stdout)
    end
end

function CleanLaTeX()
    -- Clean files matching the current file's name by using the same flags
    -- used for compilation in addition to --clean flag. Do not include --pdf
    -- flag as not to remove the output pdf.
    local rubber_clean_flags = {'--clean', vim.fn.expand('%')}
    if vim.b.latexJobName then
        -- Clean files matching the job name.
        rubber_clean_flags = {'--clean', '--jobname', vim.b.latexJobName, vim.fn.expand('%')}
    end
    vim.fn.system(table.merge(RubberCompFlags, rubber_clean_flags))
end

function OpenLaTeXPDF(viewer)
    -- Get current file's root name (without extension) and add .pdf.
    local jobname = vim.fn.expand('%:p:r') .. '.pdf'
    if vim.b.latexJobName then
        -- Get current file's head (last path component removed) and add .pdf.
        jobname = vim.fn.expand('%:p:h') .. '/' .. vim.b.latexJobName .. '.pdf'
    end
    print("Viewing " .. jobname)
    vim.fn.system({'setsid', '--fork', viewer, jobname})
end

--------------------------------------------------------------------------------
-- Window settings.
--------------------------------------------------------------------------------
-- Next window. Move cursor clockwise to the next window
nnoremap('<c-j>', '<c-w>w')

-- Previous window. Move cursor counter-clockwise to the previous window.
nnoremap('<c-k>', '<c-w>W')

--------------------------------------------------------------------------------
-- Switch between files and headers: c -> h and cpp -> hpp.
--------------------------------------------------------------------------------
-- Attach when working with clangd.
vim.api.nvim_create_user_command('C', 'ClangdSwitchSourceHeader', { nargs = 0 })

--------------------------------------------------------------------------------
-- Vim Terminal.
--------------------------------------------------------------------------------
-- Close tab immediately after closing terminal.
-- au! TermClose * :q
--
-- nnoremap <silent> <leader>tt :terminal<CR>
-- nnoremap <silent> <leader>tv :vnew<CR>:terminal<CR>
-- nnoremap <silent> <leader>th :new<CR>:terminal<CR>
-- tnoremap <C-x> <C-\><C-n><C-w>q
