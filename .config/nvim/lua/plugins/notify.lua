return {
    'rcarriga/nvim-notify',
    config = function()
        -- Allow other modules to use "notify" by over-writing it.
        vim.notify = require("notify")
    end
}
