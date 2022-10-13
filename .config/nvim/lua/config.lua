local function dict_append(dict1, dict2)
    if dict1 and dict2 then
        for key, value in pairs(dict2) do
            dict1[key] = value
        end
    end
end

local function keymap(mode, shortcut, command, options)
    local default_options = {}
    dict_append(default_options, options)
    vim.api.nvim_set_keymap(mode, shortcut, command, default_options)
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

-- Open tag bar and close it after selecting a tag.
nnoremap('<leader>ta', ':TagbarOpenAutoClose<cr>')
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
nnoremap('<s-k>', '<pageup>')
-- Move a page down.
nnoremap('<s-j>', '<pagedown>')

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
nnoremap('L', ':bn<cr>')
-- Go to the previous buffer.
nnoremap('H', ':bp<cr>')
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
-- Window mappings.
-- -----------------------------------------------------------------------------
-- Move cursor to the left window.
nnoremap('<leader>h', '<c-w>h')
-- Move cursor to the window below.
nnoremap('<leader>j', '<c-w>j')
-- Move cursor to the window above.
nnoremap('<leader>k', '<c-w>k')
-- Move cursor to the right window.
nnoremap('<leader>l', '<c-w>l')
-- Remaping localleader to CTRL-W enabled the following mappings.
-- <localleader>= - make all windows equal height & width
-- <localleader>h - move cursor to the left window
-- <localleader>j - move cursor to the window below
-- <localleader>k - move cursor to the window above
-- <localleader>l - move cursor to the right window
-- <localleader>q - quit a window
-- <localleader>r - rotate windows upwards N times
-- <localleader>w - switch windows
-- <localleader>x - exchange current window with next one
-- <localleader>s - split window
-- <localleader>v - split window vertically
-- Split window (add for responsiveness).
-- nnoremap <localleader>s :sp<cr>
-- Split window vertically (add for responsiveness).
-- nnoremap <localleader>v :vsp<cr>

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

local when_term_opens = vim.api.nvim_create_augroup("When Terminal Opens", {
    -- Clear previous group auto commands to avoid duplicate definitions.
    clear = true
})

    -- Turn off spelling in terminal.
    vim.api.nvim_create_autocmd('TermOpen', {
        group = when_term_opens,
        pattern = '*',
        command = 'setlocal nospell'
    })

    -- Disable line numbering in terminal.
    vim.api.nvim_create_autocmd('TermOpen', {
        group = when_term_opens,
        pattern = '*',
        command = 'setlocal nonumber'
    })

    -- Press escape twice to exit. Add only to zsh because it conflicts with fzf.
    -- Press ctrl+q to scroll freely in terminal, as opposed to ctrl+\ ctrl+n.
    vim.api.nvim_create_autocmd('TermOpen', {
       group = when_term_opens,
       pattern = '*',
       command = 'if expand("%:t") == "zsh" | tnoremap <c-q> <c-\\><c-n> | endif'
   })

local buffer_check = vim.api.nvim_create_augroup('Check Buffer', {
    clear = true
})

    -- Resize windows equally when the window size changes. Useful for DWM.
    vim.api.nvim_create_autocmd('VimResized', {
        group = buffer_check,
        pattern = '*',
        command = 'wincmd ='
    })
    -- Reload config file on change.
    vim.api.nvim_create_autocmd('BufWritePost', {
        group    = buffer_check,
        pattern  = vim.env.MYVIMRC,
        command  = 'source %'})

    -- Highlight yanks.
    vim.api.nvim_create_autocmd('TextYankPost', {
        group    = buffer_check,
        pattern  = '*',
        callback = function() vim.highlight.on_yank{timeout=150} end})

    -- -- sync clipboards because I'm easily confused
    -- vim.api.nvim_create_autocmd('TextYankPost', {
        -- group    = 'bufcheck',
        -- pattern  = '*',
        -- callback = function() fn.setreg('+', fn.getreg('*')) end })

    -- Start terminal in insert mode.
    vim.api.nvim_create_autocmd('TermOpen',     {
        group    = buffer_check,
        pattern  = '*',
        command  = 'startinsert | set winfixheight'})

    -- Start git messages in insert mode.
    vim.api.nvim_create_autocmd('FileType',     {
        group    = buffer_check,
        -- pattern  = { 'gitcommit', 'gitrebase', },
        pattern  = { 'gitcommit', },
        command  = 'startinsert | 1'})

   -- -- pager mappings for Manual
   -- vim.api.nvim_create_autocmd('FileType',     {
        -- group    = 'bufcheck',
        -- pattern  = 'man',
        -- callback = function()
          -- vim.keymap.set('n', '<enter>'    , 'K'    , {buffer=true})
          -- vim.keymap.set('n', '<backspace>', '<c-o>', {buffer=true})
          -- end })

    -- Remember file position.
   vim.api.nvim_create_autocmd('BufReadPost',  {
        group    = buffer_check,
        pattern  = '*',
        callback = function()
            if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
                vim.fn.setpos('.', vim.fn.getpos("'\""))
                -- exe "normal! g'\"" -- Difficult to escape qutoes.
                -- vim.cmd('normal zz') -- Find how to center buffer in a sane way.
                -- vim.cmd('silent! foldopen') -- Open folds. They are annoying.
            end
        end })
--------------------------------------------------------------------------------
-- Interface.
--------------------------------------------------------------------------------
-- Share clipboard with operating system.
vim.o.clipboard = 'unnamedplus'
-- Reminder to keep lines at most 80 characters long.
vim.o.colorcolumn = '81'
-- Enable mouse wheel in normal modes.
vim.o.mouse = 'a'
-- Enable line numbers.
vim.o.number = true
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
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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
    -- Use dark color scheme for Vim.
    use 'dracula/vim'
    use 'folke/tokyonight.nvim'
    -- Markdown syntax highlighting.
    use {
        'preservim/vim-markdown',
        requires = {
            -- Vim-json for conceal.
            'elzr/vim-json',
            -- Tabular for auto-formatting tables.
            'godlygeek/tabular'
        }
    }
    -- Easily align tables, or text by symbols like , ; = & etc.
    use 'junegunn/vim-easy-align'
    use 'simrat39/symbols-outline.nvim'
    -- Fuzzy finder for files, buffers, mru files, and tags.
    use 'kien/ctrlp.vim'
    -- Show indentation lines.
    use 'lukas-reineke/indent-blankline.nvim'
    -- Nice start screen.
    -- use 'mhinz/vim-startify'
    -- Search tool. NOTE: Install the ag (silver-searcher grep) utility first.
    use 'mileszs/ack.vim'
    -- Configurations for Nvim LSP.
    use 'neovim/nvim-lspconfig'
    -- Comment and uncomment code sections more easily witch cc, uc, and ci.
    use 'preservim/nerdcommenter'
    -- Provide Cargo commands, and Rust syntax highlighting and formatting.
    use 'rust-lang/rust.vim'
    use {
        'goolord/alpha-nvim',
        -- NOTE: Use a patched font such as MesloLGS NF.
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    }
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    -- use 'rhysd/conflict-marker.vim'
    use 'onsails/lspkind.nvim'
    use 'ggandor/lightspeed.nvim'
    -- Provide richer syntax highlighting and only spell-check comments.
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'
    use 'Shatur/neovim-session-manager'
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
      requires = { 'nvim-lua/plenary.nvim' }
    }
    use 'nvim-telescope/telescope-ui-select.nvim'

    use {
        'cljoly/telescope-repo.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope.nvim'},
        }
    }

    use { "nvim-telescope/telescope-file-browser.nvim" }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    -- Add OpenGL Shader Language support.
    use 'tikhomirov/vim-glsl'
    -- Use dark color scheme inspired on Visual Studio Code.
    use 'tomasiser/vim-code-dark'
    -- Surround words in parenthesis, quotations, etc., more easily.
    use 'tpope/vim-surround'
    -- Prettify status line.
    use 'feline-nvim/feline.nvim'
    use 'stumash/snowball.nvim'

    -- use {
      -- 'nvim-lualine/lualine.nvim',
      -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    -- }

    use 'norcalli/nvim-colorizer.lua'
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

    -- Add Doxygen support.
    use 'vim-scripts/DoxygenToolkit.vim'
    -- A powerful autopair plugin for Neovim that supports multiple characters.
    use {
        "windwp/nvim-autopairs",
        config = require("nvim-autopairs").setup()
    }
    -- Install language servers, formatters, linters, and debug adapters.
    use {
        "williamboman/mason.nvim",
        config = require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    -- Tagbar: a class outline viewer for Vim.
    use 'preservim/tagbar' -- Requires universal ctags.
    -- Add window-tiling manager functionality.
    use 'luis-licea/dwm.vim'
    -- Add git decorations for modified lines, +, -, ~, etc.
    use {
        'lewis6991/gitsigns.nvim',
        config = require('gitsigns').setup()
    }
    -- Completion plugin.
    use {
        'hrsh7th/nvim-cmp',
        requires =  {
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'octaltree/cmp-look',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'f3fora/cmp-spell',
            'hrsh7th/cmp-emoji'
        }
    }
    -- Auto-install packer if necessary.
    if packer_bootstrap then
        require('packer').sync()
    end
end)

local neogit = require('neogit')
neogit.setup {}

-- There are also colorschemes for the different styles:
-- tokyonight tokyonight-night tokyonight-storm tokyonight-day tokyonight-moon
vim.cmd[[colorscheme tokyonight-moon]]

-- Highlight colors such as #315fff or #f8f.
require('colorizer').setup()

vim.cmd([[
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
]])

-- local dap = require('dap')
-- dap.adapters.python = {
  -- type = 'executable';
  -- command = '/home/luis/.local/share/nvim/mason/bin/debugpy-adapter';
  -- args = { '-m', 'debugpy.adapter' };
-- }

require("dapui").setup()
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  -- command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
  -- command = '/usr/bin/python3';
  command = '/home/luis/.local/share/nvim/mason/bin/debugpy-adapter'
  -- args = { '-m', 'debugpy.adapter' };
}

-- local dap, dapui = require("dap"), require("dapui")
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

-- local dap = require('dap')
dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    -- program = "/home/luis/.local/share/nvim/mason/bin/debugpy";
    pythonPath = function()
      return '/usr/bin/python3'
    end;
  },
}

--------------------------------------------------------------------------------
-- Null-ls.
--------------------------------------------------------------------------------
-- require("null-ls").setup {
    -- sources = {
        -- require("null-ls").builtins.formatting.stylua,
        -- require("null-ls").builtins.diagnostics.eslint,
        -- require("null-ls").builtins.diagnostics.selene,
        -- require("null-ls").builtins.completion.spell,
    -- },
-- }

--------------------------------------------------------------------------------
-- Nvim-treesitter.
--------------------------------------------------------------------------------
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    -- ensure_installed = { "c", "lua", "rust" },
    ensure_installed = "all",

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

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
-- Telescope.
--------------------------------------------------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>te', builtin.find_files, {noremap = true})
vim.keymap.set('n', '<leader>tl', builtin.live_grep, {noremap = true})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {noremap = true})
vim.keymap.set('n', '<leader>th', builtin.help_tags, {noremap = true})
vim.keymap.set('n', '<leader>ts', builtin.git_status, {noremap = true})

--------------------------------------------------------------------------------
-- Telescope file browser.
--------------------------------------------------------------------------------
require("telescope").load_extension("file_browser")
vim.keymap.set('n', '<leader>tf', ':Telescope file_browser<cr>', {noremap = true})

--------------------------------------------------------------------------------
-- Telescope ui-select.
--------------------------------------------------------------------------------
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
            }
        },
    },
    extensions = {
        ["ui-select"] = {
            -- Impoves the looks of `lua vim.lsp.buf.code_action()`.
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
        }
    }
}

require("telescope").load_extension("ui-select")

--------------------------------------------------------------------------------
-- Telescope repo. Find git repositories.
--------------------------------------------------------------------------------
if vim.fn.executable('fd') == 1 and vim.fn.executable('glow') == 1 then
    require('telescope').load_extension('repo')
    vim.keymap.set('n', '<leader>tr', ':Telescope repo list<cr>', {noremap = true})
else
    print("Error: fd or glow is not installed.")
end

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
-- Vim-Startify.
--------------------------------------------------------------------------------
-- Define the following functions as a work-around to use nvim-web-devicons.
-- In Lua.
function _G.webDevIcons(path)
  local filename = vim.fn.fnamemodify(path, ':t')
  local extension = vim.fn.fnamemodify(path, ':e')
  return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
end

-- In VimScript.
vim.cmd([[
    function! StartifyEntryFormat() abort
        return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
    endfunction
]])

--------------------------------------------------------------------------------
-- Nvim tree mappings. Prefix n means "Nvim".
--------------------------------------------------------------------------------
-- Disable netrw at the very start of your init.lua (strongly advised).
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
-- Go to project root.
nnoremap('<leader>no', ':NvimTreeOpen<cr>')
-- Switch sidebar tree.
nnoremap('<leader>nt', ':NvimTreeToggle<cr>')
-- Find current file in tree.
nnoremap('<leader>nn', ':NvimTreeFindFile<cr>')
-- Close tree after opening a file.

require("nvim-tree").setup {
    actions = {
        open_file = {
            quit_on_open = true, -- Close tree after picking a file.
            resize_window = false, -- It messes up DWM window sizes.
            window_picker = {
                enable = false, -- Don't ask for window when opening new buffer.
            },
        }
    }
}

-- Open tree automatically when executing `nvim .`.
-- require("nvim-tree").open_replacing_current_buffer()

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

--------------------------------------------------------------------------------
-- Lualine.
--------------------------------------------------------------------------------
-- require('lualine').setup()

--------------------------------------------------------------------------------
-- Bufferline.
--------------------------------------------------------------------------------
require('bufferline').setup {
    options = {
        -- max_name_length = 18,
        -- max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        -- truncate_names = true -- whether or not tab names should be truncated
        -- tab_size = 18,
        -- diagnostics = false | "nvim_lsp" | "coc",
        diagnostics = "nvim_lsp",
        -- diagnostics_update_in_insert = false,
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
            -- return "("..count..")"
        -- end,
        show_buffer_close_icons = false,
        show_close_icon = false,
        -- show_tab_indicators = true | false,
        -- show_duplicate_prefix = true | false, -- whether to show duplicate buffer prefix
        -- persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
        separator_style = 'thin',
        -- enforce_regular_tabs = false | true,
        -- always_show_bufferline = true | false,
        always_show_bufferline = true,
    }
}

local opts = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { '', '' },
  wrap = false,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
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

      -- 'Enum',
      -- 'Interface',
      -- 'Function',

      -- 'Variable',
      -- 'Constant',
      -- 'String',
      -- 'Number',
      -- 'Boolean',
      -- 'Array',
      -- 'Object',
      -- 'Key',
      -- 'Null',
      -- 'EnumMember',
      -- 'Struct',
      -- 'Event',
      -- 'Operator',
      -- 'TypeParameter',
      -- 'Component',
      -- 'Fragment',
  },
  symbols = {
    File = {icon = "", hl = "TSURI"},
    Module = {icon = "", hl = "TSNamespace"},
    Namespace = {icon = "", hl = "TSNamespace"},
    Package = {icon = "", hl = "TSNamespace"},
    Class = {icon = "𝓒", hl = "TSType"},
    Method = {icon = "ƒ", hl = "TSMethod"},
    Property = {icon = "", hl = "TSMethod"},
    Field = {icon = "", hl = "TSField"},
    Constructor = {icon = "", hl = "TSConstructor"},
    Enum = {icon = "ℰ", hl = "TSType"},
    Interface = {icon = "ﰮ", hl = "TSType"},
    Function = {icon = "", hl = "TSFunction"},
    Variable = {icon = "", hl = "TSConstant"},
    Constant = {icon = "", hl = "TSConstant"},
    String = {icon = "𝓐", hl = "TSString"},
    Number = {icon = "#", hl = "TSNumber"},
    Boolean = {icon = "⊨", hl = "TSBoolean"},
    Array = {icon = "", hl = "TSConstant"},
    Object = {icon = "⦿", hl = "TSType"},
    Key = {icon = "🔐", hl = "TSType"},
    Null = {icon = "NULL", hl = "TSType"},
    EnumMember = {icon = "", hl = "TSField"},
    Struct = {icon = "𝓢", hl = "TSType"},
    Event = {icon = "🗲", hl = "TSType"},
    Operator = {icon = "+", hl = "TSOperator"},
    TypeParameter = {icon = "𝙏", hl = "TSParameter"}
  }
}

require("symbols-outline").setup(
-- opts
)

--------------------------------------------------------------------------------
-- Nvim LspConfig.
--------------------------------------------------------------------------------
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

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
    vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, bufopts)

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
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<c-a>', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.formatting{ async = true } end, bufopts)
    vim.keymap.set('v', '<leader>f', vim.lsp.buf.range_formatting, bufopts)
    vim.keymap.set('x', '<leader>c', function() vim.lsp.buf.range_code_action() end, bufopts)
    -- lua vim.lsp.buf.range_formatting()
end


--------------------------------------------------------------------------------
-- Language servers.
--------------------------------------------------------------------------------
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
}

require('lspconfig').rust_analyzer.setup {
    on_attach = on_attach,
}

require('lspconfig').clangd.setup{
    on_attach = on_attach
}

require('lspconfig').eslint.setup{
    on_attach = on_attach,
}

require('lspconfig').jdtls.setup{
    on_attach = on_attach,
}

require('lspconfig').phpactor.setup {
    on_attach = on_attach,
}

require('lspconfig').bashls.setup {
    on_attach = on_attach,
}

require('lspconfig').groovyls.setup{
    on_attach = on_attach,
}
require('lspconfig').sqls.setup {
    on_attach = on_attach,
    -- cmd = {"sqls", "-config", "~/.config/sqls/config.yml"}
}

require('lspconfig').marksman.setup{
    on_attach = on_attach,
}

require('lspconfig').taplo.setup{
    on_attach = on_attach,
}

require('lspconfig').yamlls.setup {
    on_attach = on_attach,
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

require 'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
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

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig').jsonls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').html.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspconfig').dockerls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

--------------------------------------------------------------------------------
-- Completion.
--------------------------------------------------------------------------------
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require('cmp')
if cmp then cmp.setup {
    formatting = {
        format = function(entry, vim_item)

            -- Fancy icons and a name of kind.
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
                                " " .. vim_item.kind

            -- Set a name for each source.
            vim_item.menu = ({
                -- buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                look = "[Look]",
                path = "[Path]",
                calc = "[Calc]",
                cmdline = "[Cmdline]",
                -- spell = "[Spell]",
                emoji = "[Emoji]"
            })[entry.source.name]
            return vim_item
        end

    },
    mapping = {

        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        -- ['<Esc>'] = cmp.mapping.close(),

        ["<Esc>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t("<Esc><Esc>"), "n")
            else
                fallback()
            end
        end, {"i"}), -- Only apply in insert mode, not "s".

        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
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
        {name = "cmdline"},
        -- {name = "spell"},
        {name = "emoji"}
    },
    completion = {completeopt = 'menu,menuone,noinsert'}
}
end

