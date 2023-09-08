-- Doge - Documentation Generator
return {
    'kkoomen/vim-doge',
    build = ':call doge#install()',
    config = function()
        vim.g.doge_python_settings = {
            omit_redundant_param_types = 0,
            single_quotes = 0,
        }
        vim.g.doge_doc_standard_python = 'google'

        -- Use a POSIX-compliant shell when executing Doge commands to avoid errors.
        vim.api.nvim_create_user_command('Doge', 'DogeGenerate', {})
    end,
}
