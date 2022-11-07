-- TODO Replace callback with command in autocommands.
local function dict_append(dict1, dict2)
    if dict1 and dict2 then
        for key, value in pairs(dict2) do
            dict1[key] = value
        end
    end
end

local function keymap(mode, shortcut, command, options)
    vim.keymap.set(mode, shortcut, command, options)
end

local function map(shortcut, command, options)
    keymap('', shortcut, command, options)
end

local function nnoremap(shortcut, command, options)
    local default_options = {noremap = true}
    dict_append(default_options, options)
    keymap('n', shortcut, command, default_options)
end
local function cnoremap(shortcut, command)
    keymap('c', shortcut, command, {noremap = true})
end
local function inoremap(shortcut, command)
    keymap('i', shortcut, command, {noremap = true})
end
local function tnoremap(shortcut, command)
    keymap('t', shortcut, command, {noremap = true})
end

--------------------------------------------------------------------------------
-- Ungrouped Mappings.
--------------------------------------------------------------------------------
-- Leader Mapping.
vim.g.mapleader = " "
-- Local Leader Mapping.
vim.g.maplocalleader=";"
-- Map localleader to CTRL-W.
map('<localleader>', '<c-w>')
-- Save file.
nnoremap('<leader>w', ':write<cr>')
-- nnoremap('<leader>w', ':update<cr>')

local console = nil
if vim.fn.executable('alacritty') == 1 then
    console="alacritty --working-directory"
elseif vim.fn.executable('konsole') == 1 then
    console="konsole --workdir"
end

if console then
    local new_terminal=':let $VIM_DIR=expand("%:p:h")<cr>:sil !setsid --fork ' .. console .. ' "$VIM_DIR" &<cr>'
    local new_ranger=':let $VIM_DIR=expand("%:p:h")<cr>:sil !setsid --fork ' .. console .. ' "$VIM_DIR" -e ranger<cr>'
    -- Spawn a new terminal in the folder of the current file.
    nnoremap('<leader>tt', new_terminal)
    -- Spawn a new ranger terminal in the folder of the current file.
    nnoremap('<leader>rt', new_ranger)
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
vim.keymap.set('n', '<leader>ta', OpenTagBar, {noremap = true})
-- Quit vim.
nnoremap('<leader>q', ':quit<cr>')
-- Load .vimrc.
nnoremap('<leader>so', ':source ~/.config/nvim/init.vim<cr>')
-- Fix syntax highlighting.
nnoremap('<leader>fs', ':syntax sync fromstart<cr>')
-- Check script to make it POSIX compliant.
nnoremap('<leader>sc', ':term shellcheck "%" && beautysh -c "%"<cr>')
-- Remove trailing white space.
nnoremap('<leader>rw', ':%s/\\s\\+$//e<cr>')
-- Remove swap file. Make the command long in purpose.
nnoremap('<leader>rswap', ':!rm "%.swp"<cr>')
-- Unset the last search pattern register.
nnoremap('<esc>', ':nohl<cr>', { silent = true })
-- Paste last thing yanked, not deleted.
nnoremap(',p', '"0p')
nnoremap(',P', '"0P')

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

-- -----------------------------------------------------------------------------
-- Command mode mappings.
-- -----------------------------------------------------------------------------
-- Move up autocomplete options in Command mode.
cnoremap('<c-k>', '<c-p>')
-- Move down autocomplete options in Command mode.
cnoremap('<c-j>', '<c-n>')

-- -----------------------------------------------------------------------------
-- Insert mode mappings.
-- -----------------------------------------------------------------------------
-- Move up autocomplete options in insert mode.
inoremap('<c-k>', '<c-p>')
-- Move down autocomplete options in insert mode.
inoremap('<c-j>', '<c-n>')

-- -----------------------------------------------------------------------------
-- Normal mode mappings. Fast movement.
-- -----------------------------------------------------------------------------
-- Move a page up.
nnoremap('<s-k>', '<c-u><c-u>')
-- Move a page down.
nnoremap('<s-j>', '<c-d><c-d>')

-- -----------------------------------------------------------------------------
-- Resize Window mappings.
-- -----------------------------------------------------------------------------
-- Increase height by N lines.
nnoremap('<up>', '10<c-w>+')
-- Decrease height by N lines.
nnoremap('<down>', '10<c-w>-')
-- Increase width by N lines.
nnoremap('<right>', '10<c-w>>')
-- Decrease width by N lines.
nnoremap('<left>', '10<c-w><')

-- -----------------------------------------------------------------------------
-- File mappings. Prefix f means "file".
-- -----------------------------------------------------------------------------
-- Print file name.
nnoremap('<leader>fn', ':echo expand("%:t")<cr>')
-- Print file path (full).
nnoremap('<leader>fp', ':echo expand("%:p")<cr>')
-- Print file directory.
nnoremap('<leader>fd', ':echo expand("%:p:h")<cr>')

-- -----------------------------------------------------------------------------
-- Yank mappings. Prefix y means "yank".
-- -----------------------------------------------------------------------------
-- Copy file name to clipboard.
nnoremap('yn', ':let @+=expand("%:t")<cr>')
-- Copy file path to clipboard.
nnoremap('yp', ':let @+=expand("%:p")<cr>')
-- Copy pwd to clipboard.
nnoremap('yd', ':let @+=expand("%:p:h")<cr>')
-- Copy buffer contents to clipboard.
nnoremap('yb', ':%y<cr>')

-- -----------------------------------------------------------------------------
-- Switch mappings. Prefix s means "switch".
-- -----------------------------------------------------------------------------
-- Switch numbered lines.
nnoremap('<leader>sn', ':set number! number?<cr>')
-- Switch automatic indentation.
nnoremap('<leader>sa', ':set autoindent! autoindent?<cr>')
-- Switch wrap.
nnoremap('<leader>sw', ':set wrap! wrap?<cr>')
-- Switch highlight search.
nnoremap('<leader>sh', ':set hlsearch! hlsearch?<cr>')

-- -----------------------------------------------------------------------------
-- Spellcheck mappings. Prefix s means "spell".
-- -----------------------------------------------------------------------------
-- Switch spellcheck for English.
nnoremap('<leader>sse', ':setlocal spell! spelllang=en spell?<cr>')
-- Switch spellcheck for Spanish.
nnoremap('<leader>sss', ':setlocal spell! spelllang=es spell?<cr>')
-- Switch spellcheck for Russian.
nnoremap('<leader>ssr', ':setlocal spell! spelllang=ru spell?<cr>')

-- -----------------------------------------------------------------------------
-- Buffer mappings. Prefix b means "buffer".
-- -----------------------------------------------------------------------------
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

-- -----------------------------------------------------------------------------
-- Embedded terminal settings and mappings.
-- -----------------------------------------------------------------------------
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

    -- Start git messages in insert mode.
    -- Spell check and wrap commit messages.
    vim.api.nvim_create_autocmd('FileType',     {
        group    = buffer_check_group,
        pattern  = { 'gitcommit', },
        command  = 'startinsert | 1 | setlocal spell textwidth=72'})

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

    -- Turn off syntax highlighting that conflicts with treesitter.
    vim.api.nvim_create_autocmd('BufEnter', {
        group = buffer_check_group,
        pattern = "*",
        callback = function()
            local should_ignore = { lua = true, markdown = true, javascript = true,
                sh = true, json = true, yaml = true, python = true, c = true}
            if should_ignore[vim.bo.filetype] then
                vim.bo.syntax = false
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

    local function LoadTemplate(templateName)
        -- " The place where the templates are saved.
        local templateDir = vim.fn.expand('~/.config/nvim/templates/')
        -- " Get path to template file.
        local templatePath = templateDir .. vim.fn.fnameescape(templateName)
        -- " Load the template into the current file.
        vim.fn.execute('0r ' .. templatePath)
    end

    local function LoadTemplateFromType()
        local type2template = {
            c = "skeleton.c",
            cpp = "skeleton.cpp",
            html = "skeleton.html",
            sh = "skeleton.sh",
            py = "skeleton.py",
            mocha = "mocha.mjs",
            mjs = "skeleton.mjs",
            CMakeLists = "CMakeLists.txt",
            cmake_uninstall = "cmake_uninstall.cmake.in"
        }

        -- Get the file name root (one extension removed).
        local fileName = vim.fn.expand("%:r")
        -- Get the file extension only.
        local extension = vim.fn.expand("%:e")
        -- Try to find a valid template using the file name or the file type.
        local template = type2template[fileName] or type2template[extension]
        -- Load the template if it could be found.
        if template then LoadTemplate(template) end
    end

    --- Return whether the file has a hash-bang.
    ---@return boolean True if the file has a hash-bang, false otherwise.
    local function FileHasHashBang()
        -- If the first 2 characters are a hashbang, make file executable.
        return string.sub(vim.fn.getline(0,1)[1], 1, 2) == "#!"
    end

    --- Return whether the current file is executable.
    ---@return boolean True if the file is executable by all users.
    function FileIsExecutable()
        -- Get permissions string including parenthesis, e.g. "drwxrwxrwx".
        local permissions = vim.fn.system({'stat', '--printf="%A"',
            vim.fn.fnameescape(vim.fn.expand("%"))})
        -- The eleventh character in the permissions "drwxrwxrwx" represents
        -- whether the file is executable by all users.
        return string.sub(permissions, 11, 11) == "x"
    end

    -- C++ code settings.
    vim.api.nvim_create_autocmd('BufNewFile',  {
        group    = template_group,
        pattern  = '*',
        callback = function()
            LoadTemplateFromType()
            if FileHasHashBang() then
                vim.cmd("silent! write")
                vim.cmd("silent! !chmod +x '%'")
            end
        end
    })
--------------------------------------------------------------------------------
-- Auto compilation settings.
--------------------------------------------------------------------------------
-- Function for toggling auto compilation on save:
HasAutoRun = false;
function ToggleHasAutoRun()
    HasAutoRun = not HasAutoRun;
end
nnoremap('<leader>ct', ':lua ToggleHasAutoRun()<cr>')

-- Function for toggling code formatting on save:
HasAutoFormat = false;
function ToggleHasAutoFormat()
    HasAutoFormat = not HasAutoFormat;
end
nnoremap('<leader>cf', ':lua ToggleHasAutoFormat()<cr>')

local auto_run_group = vim.api.nvim_create_augroup('Auto Run Group', {
    clear = true
})

    -- For all programs.
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = auto_run_group,
        pattern = '*',
        callback = function()
            if HasAutoFormat then vim.lsp.buf.format() end
            if HasAutoRun then
                if FileHasHashBang() and FileIsExecutable() then
                    vim.cmd("!./" .. vim.fn.fnameescape(vim.fn.expand("%")))
                else
                    vim.cmd('call Run()')
                end
            end
        end
    })

    -- Execute files named "scratchpad" each time they are saved.
    vim.api.nvim_create_autocmd('BufEnter', {
        group = auto_run_group,
        pattern = 'scratchpad.*',
        callback = function()
            ToggleHasAutoFormat()
            ToggleHasAutoRun()
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
            if HasAutoRun then
                vim.fn.execute('!pandoc "%" -o "/tmp/%<.pdf"')
            end
        end
    })

    -- View pdf files.
    function LaunchViewer()
        vim.fn.execute('!zathura "/tmp/%<.pdf" &')
    end

    vim.api.nvim_create_autocmd('BufReadPost', {
        group = markdown_group,
        pattern = '*.md',
        callback = function()
            -- View compiled markdown pdf.
            nnoremap('<leader>cv', ':lua LaunchViewer()<cr>', {buffer = true})
            -- Create a binding for formatting tables.
            nnoremap('<leader>fo', ':TableFormat<cr>', {buffer = true})
        end
    })

--------------------------------------------------------------------------------
-- LaTeX auto commands.
--------------------------------------------------------------------------------
local latex_group = vim.api.nvim_create_augroup('LaTeX Group', {
    clear = true
})

    -- Define variables for compiling file into a PDF.
    vim.api.nvim_create_autocmd('FileType', {
        group = latex_group,
        pattern = 'tex',
        callback = function() vim.cmd('call SetLaTeXVariables()') end
    })

    -- Compile the file in the same directory and watch for changes ever 10 seconds.
    -- nnoremap <leader>co :sil exec
    -- '!watch -n 10 rubber --pdf --shell-escape --synctex --inplace "%"'<cr>
    vim.api.nvim_create_autocmd('FileType', {
        group = latex_group,
        pattern = 'tex',
        callback = function()
            nnoremap('<leader>co', ':call RunLaTeX()<cr>', {buffer = true})
        end
    })

    -- Clean all files except the compiled pdf.
    vim.api.nvim_create_autocmd('FileType', {
        group = latex_group,
        pattern = 'tex',
        callback = function()
            nnoremap('<leader>cr', ':call CleanLaTeX()<cr>', {buffer = true})
        end
    })

    -- Open the compiled LaTeX pdf with the specified viewer.
    vim.api.nvim_create_autocmd('FileType', {
        group = latex_group,
        pattern = 'tex',
        callback = function()
            nnoremap('<leader>cv', ':sil call OpenLaTeXPDF("zathura")<cr>', {buffer = true})
        end
    })

    -- Compile LaTeX document every time after saving.
    vim.api.nvim_create_autocmd('BufWritePost', {
        group = latex_group,
        pattern = '*.tex',
        callback = function() if HasAutoRun then vim.cmd('call RunLaTeX()') end end
    })

    -- Clean the all files except the compiled pdf when exiting.
    vim.api.nvim_create_autocmd('VimLeavePre', {
        group = latex_group,
        pattern = '*.tex',
        callback = function() vim.cmd('call CleanLaTeX()') end
    })

--------------------------------------------------------------------------------
-- Interface.
--------------------------------------------------------------------------------
-- Share clipboard with operating system.
vim.o.clipboard = 'unnamedplus'
-- Reminder to keep lines at most 80 characters long.
vim.o.colorcolumn = '81'
-- Enable mouse wheel in normal modes.
vim.o.mouse = 'a'
-- Support true color in vim.
vim.o.termguicolors = true

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
-- Indentation.
--------------------------------------------------------------------------------
-- Add indentation when S or cc is pressed.
vim.o.cindent = true

--------------------------------------------------------------------------------
-- Other.
--------------------------------------------------------------------------------
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
-- Change cwd to file's directory.
vim.o.autochdir = true

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
    -- Tokyo night color scheme.
    use {'folke/tokyonight.nvim',
        config = function()
            require("tokyonight").setup({ style = "moon" })
            require("tokyonight").colorscheme()
        end
    }
    -- Markdown syntax highlighting.
    use { 'preservim/vim-markdown',
        requires = {
            -- Vim-json for conceal.
            'elzr/vim-json',
            -- Tabular for auto-formatting tables.
            'godlygeek/tabular' } }
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
    -- Configurations for Nvim LSP.
    use 'neovim/nvim-lspconfig'
    -- Comment and uncomment code sections more easily witch cc, uc, and ci.
    use 'preservim/nerdcommenter'
    -- Add JSDoc, Doxygen, etc support.
    use { "danymat/neogen",
        config = function() require('neogen').setup { snippet_engine = "luasnip" } end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        tag = "*"
    }
    -- Provide Cargo commands, and Rust syntax highlighting and formatting.
    use 'rust-lang/rust.vim'
    -- NOTE: Nvim-web-devicons requires a patched font such as MesloLGS NF.
    -- use 'kyazdani42/nvim-web-devicons'
    -- Fancy debug adapter UI provider and Debug Adapter Protocol.
    use { "rcarriga/nvim-dap-ui", requires = 'mfussenegger/nvim-dap' }
    -- Window picker for using with Dap UI because it opens many windows.
    use {'https://gitlab.com/yorickpeterse/nvim-window',
        config = function() require('nvim-window').setup({
            -- The characters available for hinting windows.
            chars = {
                '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'k', 'l','m',
                'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
            },
            -- The border style to use for the floating window.
            border = 'rounded'
        })
        end,
        nnoremap('<leader><leader>', require("nvim-window").pick)
    }
    -- Intelligent search.
    use 'ggandor/lightspeed.nvim'
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
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>tl', builtin.live_grep, {noremap = true})
            vim.keymap.set('n', '<leader>tb', builtin.buffers, {noremap = true})
            vim.keymap.set('n', '<leader>th', builtin.help_tags, {noremap = true})
            vim.keymap.set('n', '<leader>tg', builtin.git_status, {noremap = true})

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
            vim.keymap.set("n", "<space>tf",
                require('telescope').extensions.file_browser.file_browser, {noremap = true})

            -- Find files in git repo if possible, else find files like normal.
            local project_files = function()
                local opts = {}
                local ok = pcall(require"telescope.builtin".git_files, opts)
                if not ok then require"telescope.builtin".find_files(opts) end
            end

            --------------------------------------------------------------------------------
            -- Telescope.
            --------------------------------------------------------------------------------
            vim.keymap.set('n', '<leader>te', project_files, {noremap = true})

            --------------------------------------------------------------------------------
            -- Telescope repo. Find git repositories.
            --------------------------------------------------------------------------------
            -- Using nvimpager as the pager does not work, use less or most.
            if vim.fn.executable('less') then vim.fn.setenv("PAGER", "less -r") end
            require('telescope').load_extension('repo')
            vim.keymap.set('n', '<leader>tr', ':Telescope repo list<cr>', {noremap = true})
        end
    }
    use 'nvim-telescope/telescope-ui-select.nvim'
    -- NOTE: Install fd and glow. Git repo searcher and opener.
    use { 'cljoly/telescope-repo.nvim',
        requires = 'nvim-telescope/telescope.nvim' }
    -- File browser with Telescope previews.
    use "nvim-telescope/telescope-file-browser.nvim"
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
        cmd = {"Mason", "MasonInstall", "MasonUninstall"},
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
    use { 'jose-elias-alvarez/null-ls.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require("null-ls").setup {
                sources = {
                    require("null-ls").builtins.formatting.black,
                    -- require("null-ls").builtins.formatting.stylua,
                    -- require("null-ls").builtins.diagnostics.eslint,
                    -- require("null-ls").builtins.diagnostics.selene,
                    -- require("null-ls").builtins.completion.spell,
                    -- require("null-ls").builtins.code_actions.gitsigns,
                    require("null-ls").builtins.code_actions.gitsigns,
                    require("null-ls").builtins.code_actions.shellcheck,
                },
            }
        end
    }
    --  NOTE: Requires universal ctags. Tagbar: a class outline viewer for Vim.
    use 'preservim/tagbar'
    -- Add git decorations for modified lines, +, -, ~, etc.
    use 'lewis6991/gitsigns.nvim'
    -- Completion plugin.
    use { 'hrsh7th/nvim-cmp',
        requires =  {
            -- Completion sources.
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'octaltree/cmp-look',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'f3fora/cmp-spell',
            'hrsh7th/cmp-emoji',

            -- Icons before source names.
            'onsails/lspkind.nvim'
        }
    }
    -- Auto-install packer if necessary.
    if packer_bootstrap then require('packer').sync() end
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
      vim.keymap.set(mode, l, r, opts)
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
require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.adapters.python = {
  type = 'executable';
  command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/debugpy-adapter'
}

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function() return 'python3' end;
  },
}
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
vim.keymap.set('n', '<leader>sl', ':SessionManager load_session<cr>', {})
vim.keymap.set('n', '<leader>sd', ':SessionManager delete_session<cr>', {})
vim.keymap.set('n', '<leader>ss', ':SessionManager save_session<cr>', {})
vim.keymap.set('n', '<leader>sp', ':SessionManager load_last_session<cr>', {})
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
  -- auto_close = false,
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
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<leader>D', vim.diagnostic.setqflist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>K', vim.lsp.buf.hover, bufopts)

    vim.keymap.set('n', '<space>gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader><s-s>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<leader>wl', function()
        -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('x', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<C-.>', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<c-a>', vim.lsp.buf.code_action, bufopts)
    -- Use gq for LPS formatting and gw for regular formatting.
    vim.keymap.set('x', '<leader>f', vim.lsp.buf.format, bufopts)
end

--------------------------------------------------------------------------------
-- Language servers.
--------------------------------------------------------------------------------
local servers = {
    'bashls',
    'clangd',
    'cssls',
    'dockerls',
    -- 'eslint',   -- Needs configuration.
    'tsserver', -- Works better for individual files.
    'groovyls',
    'html',
    'jdtls',
    'jsonls',
    'marksman', -- Markdown
    'phpactor',
    'pyright',
    'rust_analyzer',
    'sqls',
    'cmake',
    'taplo',
    'ltex',
    -- 'texlab',
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

require('lspconfig').sumneko_lua.setup {
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
                -- buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                nvim_lua = "[Lua]",
                look = "[Look]",
                path = "[Path]",
                calc = "[Calc]",
                -- cmdline = "[Cmdline]",
                -- spell = "[Spell]",
                emoji = "[Emoji]"
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
        -- {name = 'buffer'},
        {name = 'nvim_lsp'},
        {name = "nvim_lua"},
        {name = "look"},
        {name = "path"},
        {name = "calc"},
        -- {name = "cmdline"},
        -- {name = "spell"},
        {name = "luasnip"},
        {name = "emoji"}
    },
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
        { name = 'buffer' }
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
        { name = 'cmdline' }
    }),
    completion = {completeopt = 'menu,menuone,noinsert,noselect'}
})

vim.cmd[[
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
" Auto compilation settings.
"-------------------------------------------------------------------------------
" Function for toggling code formatting on save:
let s:auto_format = 0
function! ToggleAutoFormat()
    if s:auto_format  == 0
        let s:auto_format = 1
    else
        let s:auto_format = 0
    endif
endfunction
" nnoremap <leader>cf :call ToggleAutoFormat()<cr>

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

"-------------------------------------------------------------------------------
" Md-vim settings.
"-------------------------------------------------------------------------------
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

"-------------------------------------------------------------------------------
" DWM settings.
"-------------------------------------------------------------------------------
" Next window. Move cursor clockwise to the next window
nnoremap <c-j> <c-w>w

" Previous window. Move cursor counter-clockwise to the previous window.
nnoremap <c-k> <c-w>W

"-------------------------------------------------------------------------------
" Switch between files and headers: c -> h and cpp -> hpp.
"-------------------------------------------------------------------------------
command! A  ClangdSwitchSourceHeader

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
]]
