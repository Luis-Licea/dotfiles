-- Related: ./nvim-dap.lua
return {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.0',
    dependencies = {
        -- NOTE: Nvim-web-devicons requires a patched font such as MesloLGS NF.
        'kyazdani42/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',

        -- File browser with Telescope previews.
        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        'nvim-telescope/telescope-dap.nvim',

        -- NOTE: Install fd and ripgrep. Rich fuzzy finder.
        -- NOTE: Install fd and glow. Git repo searcher and opener.
        -- 'cljoly/telescope-repo.nvim',
    },
    config = function()
        local set = vim.keymap.set
        local noremap = { noremap = true }
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
        local fb_actions = require('telescope').extensions.file_browser.actions
        local action_state = require('telescope.actions.state')
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
        local actions = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-h>'] = actions.preview_scrolling_up,
                        ['<C-l>'] = actions.preview_scrolling_down,
                    },
                    n = {
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-h>'] = actions.preview_scrolling_up,
                        ['<C-l>'] = actions.preview_scrolling_down,
                    },
                },
            },
            pickers = {
                find_files = {
                    -- Use the current file's folder as cwd.
                    cwd = vim.fn.expand('%:h'),
                    -- Show hidden?
                    hidden = true,
                    -- Show files in gitignore?
                    no_ignore = true,
                    -- Show files in parent folder gitignore?
                    no_ignore_parent = true,
                },
                git_files = {
                    -- Show files that are not tracked?
                    show_untracked = true,
                },
            },
            extensions = {
                file_browser = {
                    -- Show file_browser instead of netrw.
                    hijack_netrw = true,
                    -- Use the current file's folder as cwd.
                    cwd = vim.fn.expand('%:h'),
                    mappings = {
                        -- Show hidden files? <C-h>/h
                        -- Show files in .gitignore? <C-u>/u
                        ['n'] = {
                            ['<u>'] = fb_actions.toggle_gitignore,
                        },
                        ['i'] = {
                            ['<C-u>'] = fb_actions.toggle_gitignore,
                        },
                    },
                },
                ['ui-select'] = {
                    -- Improves the looks of `lua vim.lsp.buf.code_action()`.
                    require('telescope.themes').get_dropdown({
                        -- even more opts
                    }),
                },
            },
        })

        --------------------------------------------------------------------------------
        -- Telescope UI-select.
        --------------------------------------------------------------------------------
        require('telescope').load_extension('ui-select')

        --------------------------------------------------------------------------------
        -- Telescope DAP.
        --------------------------------------------------------------------------------
        require('telescope').load_extension('dap')

        --------------------------------------------------------------------------------
        -- Telescope file browser.
        --------------------------------------------------------------------------------
        require('telescope').load_extension('file_browser')
        set('n', '<space>tf', require('telescope').extensions.file_browser.file_browser, noremap)

        -- Find files in git repo if possible, else find files like normal.
        local project_files = function()
            local opts = {}
            local ok = pcall(require('telescope.builtin').git_files, opts)
            if not ok then
                require('telescope.builtin').find_files(opts)
            end
        end

        --------------------------------------------------------------------------------
        -- Telescope.
        --------------------------------------------------------------------------------
        set('n', '<leader>te', project_files, noremap)

        -- --------------------------------------------------------------------------------
        -- -- Telescope repo. Find git repositories.
        -- --------------------------------------------------------------------------------
        -- -- Using nvimpager as the pager does not work, use less or most.
        -- if vim.fn.executable('less') == 1 then
        --     vim.fn.setenv('PAGER', 'less -r')
        -- end
        -- require('telescope').load_extension('repo')
        -- set('n', '<leader>tp', require('telescope').extensions.repo.list, noremap)
    end,
}
