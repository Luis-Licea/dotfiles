return {
    'b0o/incline.nvim',
    config = function()
        vim.o.laststatus = 3
        local function get_git_diff(props)
            local icons = { removed = '', changed = '', added = '' }
            local labels = {}

            local ok, signs = pcall(vim.api.nvim_buf_get_var, props.buf, 'gitsigns_status_dict')
            if not ok then
                return labels
            end
            for name, icon in pairs(icons) do
                if tonumber(signs[name]) and signs[name] > 0 then
                    table.insert(
                        labels,
                        { icon .. ' ' .. signs[name] .. ' ', group = 'Diff' .. name }
                    )
                end
            end
            -- if #labels > 0 then
            --   table.insert(labels, { "| " })
            -- end
            return labels
        end
        local function get_diagnostic_label(props)
            local icons = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
            local label = {}
            for severity, icon in pairs(icons) do
                local n = #vim.diagnostic.get(
                    props.buf,
                    { severity = vim.diagnostic.severity[string.upper(severity)] }
                )
                if n > 0 then
                    table.insert(
                        label,
                        { icon .. '' .. n .. ' ', group = 'DiagnosticSign' .. severity }
                    )
                end
            end
            -- if #label > 0 then
            --   table.insert(label, { "| " })
            -- end
            return label
        end
        require('incline').setup({
            window = {
                winhighlight = {
                    Normal = 'Search',
                },
            },
            -- #51a0cf
            render = function(props)
                -- print(props.buf) -- The buffer number.
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                local ft_icon, ft_color = require('nvim-web-devicons').get_icon_color(filename)
                local modified = vim.api.nvim_buf_get_option(props.buf, 'modified')
                        and 'bold,italic'
                    or 'bold'

                local buffer = {
                    { get_git_diff(props) },
                    { get_diagnostic_label(props) },
                    { ft_icon, guifg = ft_color },
                    { ' ' },
                    { filename, gui = modified },
                }
                return buffer
            end,
        })
    end,
}
