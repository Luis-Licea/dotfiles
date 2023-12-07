local Table = require('Table')
--------------------------------------------------------------------------------
-- Load templates for newly created files.
--------------------------------------------------------------------------------
local template_group = vim.api.nvim_create_augroup('Template Group', {})

---Load a template in the current buffer. The template will be determined
---based on the file extension and the file name.
---@param name string? The path to the template to load.
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

-- Load a template if one is available when creating a file.
vim.api.nvim_create_autocmd('BufNewFile', {
    group = template_group,
    pattern = '*',
    callback = function()
        LoadTemplateFromType(nil)
    end,
})
