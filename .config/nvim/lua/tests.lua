#!/usr/bin/env nvim -l

---Test documentation code blocks by executing them.
---@author Luis David Licea Torres
---@license MIT

---Execute the Lua code blocks in the given files.
---@param files string[] The file paths to check.
---@return boolean success Whether all the tests passed.
local function testLuaCodeBlocks(files)
    local Path = require('Path')
    local String = require('String')
    local success = true
    local tests = {}

    local codeblock_start = '---```lua'
    local codeblock_end = '---```'
    local file_name_comment = function(file_path)
        return '--- ' .. file_path
    end

    local test_function = function(index)
        return 'Line' .. index .. '()'
    end
    local test_function_start = function(name)
        return 'local function ' .. name
    end
    local indented_line = function(line)
        return '    ' .. line:sub(4)
    end
    local test_function_end = 'end'
    local function_name = nil

    -- Loop over all the files, storing each code block as test.
    for _, file_path in ipairs(files) do
        local lines = Path.to_lines(file_path)
        local is_codeblock_line = false
        local test_lines = {}

        for index, line in ipairs(lines) do
            if String.ends_with(line, codeblock_end) then
                is_codeblock_line = false
                table.insert(test_lines, test_function_end)
                table.insert(test_lines, function_name)
                table.insert(tests, test_lines)
                test_lines = {}
            end
            if is_codeblock_line then
                table.insert(test_lines, indented_line(line))
            end
            if String.ends_with(line, codeblock_start) then
                is_codeblock_line = true
                table.insert(test_lines, file_name_comment(file_path))
                function_name = test_function(index)
                table.insert(test_lines, test_function_start(function_name))
            end
        end
    end

    -- Don't use default "print" because it truncates long lines.
    local print = function(text)
        io.stdout:write(text)
    end

    -- Execute each code block test and report any failures.
    for _, test in ipairs(tests) do
        local path = os.tmpname()
        Path.write_text(path, test)
        local stdout = vim.fn.system({ 'nvim', '-l', path })
        if stdout ~= '' then
            print('\n' .. stdout .. '\n')
        end
        if vim.v.shell_error ~= 0 then
            print(Path.read_text(path))
            success = false
        end
        os.remove(path)
    end
    return success
end

-- Run tests by executing: nvim -l tests.lua
local success = testLuaCodeBlocks({ './Path.lua', './Table.lua', './String.lua' })

os.exit(success)
