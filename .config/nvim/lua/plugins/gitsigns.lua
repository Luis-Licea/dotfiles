-- Add git decorations for modified lines, +, -, ~, etc.
return {
    'lewis6991/gitsigns.nvim',
    config = function()
        --------------------------------------------------------------------------------
        -- Gitsigns.
        --------------------------------------------------------------------------------
        local set = vim.keymap.set
        require('gitsigns').setup({
            -- signs                        = {
            --     add          = { text = '│' },
            --     change       = { text = '│' },
            --     delete       = { text = '_' },
            --     topdelete    = { text = '‾' },
            --     changedelete = { text = '~' },
            --     untracked    = { text = '┆' },
            -- },
            -- signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
            -- numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
            -- linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            -- word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            -- watch_gitdir                 = {
            --     follow_files = true
            -- },
            -- attach_to_untracked          = true,
            -- current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            -- current_line_blame_opts      = {
            --     virt_text = true,
            --     virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            --     delay = 1000,
            --     ignore_whitespace = false,
            -- },
            -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            -- sign_priority                = 6,
            -- update_debounce              = 100,
            -- status_formatter             = nil, -- Use default
            -- max_file_length              = 40000, -- Disable if file is longer than this (in lines)
            -- preview_config               = {
            --     -- Options passed to nvim_open_win
            --     border = 'single',
            --     style = 'minimal',
            --     relative = 'cursor',
            --     row = 0,
            --     col = 1
            -- },
            -- yadm                         = {
            --     enable = false
            -- },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function mapb(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    set(mode, l, r, opts)
                end

                -- Navigation
                mapb('n', ']c', function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true })

                mapb('n', '[c', function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true })

                -- Actions
                -- git log --reverse -p '%'
                mapb({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
                mapb({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
                mapb('n', '<leader>hS', gs.stage_buffer)
                mapb('n', '<leader>hu', gs.undo_stage_hunk)
                mapb('n', '<leader>hR', gs.reset_buffer)
                mapb('n', '<leader>hp', gs.preview_hunk)
                mapb('n', '<leader>hb', function()
                    gs.blame_line({ full = true })
                end)
                mapb('n', '<leader>tb', gs.toggle_current_line_blame)
                mapb('n', '<leader>hd', gs.diffthis)
                mapb('n', '<leader>hD', function()
                    gs.diffthis('~')
                end)
                mapb('n', '<leader>td', gs.toggle_deleted)
                -- Text object
                mapb({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end,
        })
    end,
}
