-- Session manager for recently opened files.
return {
    'Shatur/neovim-session-manager',
    enabled = false,
    config = function()
        local nnoremap = require('Key').nnoremap
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
            max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
        })
    end,
}
