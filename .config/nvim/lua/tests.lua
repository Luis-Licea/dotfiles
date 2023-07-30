#!/usr/bin/env nvim -l

---@module Test documentation code blocks by executing them.
---@author Luis David Licea Torres
---@license MIT


local compare = require("Table").compare

local function testPathModule()
    local Path = require("Path")

    local exists1 = Path.is_executable("/usr/bin/nvim")
    assert(exists1 == true, "Executable should exist.")

    local exists2 = Path.is_executable({"", "usr", "bin", "nvim"})
    assert(exists2 == true, "Executable should exist.")

    local shell = Path.first_execuable({"/usr/bin/", "/usr/bin/bash"})
    assert(shell == "/usr/bin/bash", "Shell does not match.")
end

local function testStringModule()
    local String = require("String")

    local x = String.split("wow|cool", "|")
    assert(compare(x, {"wow", "cool"}))

    local y = String.to_list('a -b --c "test quotes"')
    assert(compare(y, {"a", "-b", "--c", "test quotes"}))

    local d = String.to_dict('a=b c="a test"')
    assert(compare(d, {a="b", c='"a test"'}))
end

---Execute the Lua code blocks in the given files.
---@param files string[] The file paths to check.
---@return boolean success Whether all the tests passed.
local function testLuaCodeBlocks(files)
    local Path = require("Path")
    local String = require("String")
    local success = true
    local tests = {}
    for _, file_path in ipairs(files) do
        local lines = Path.to_lines(file_path)
        local is_codeblock_line = false
        local test_lines = {}

        local codeblock_start = "---```lua"
        local codeblock_end = "---```"
        local file_name_comment = "--- "..file_path

        local test_function = function(index) return "Line"..index.."()" end
        local test_function_start = function(name) return "local function "..name end
        local indented_line = function(line) return "    "..line:sub(4) end
        local test_function_end = "end"
        local function_name = nil

        for index, line in ipairs(lines) do
            if String.ends_with(line, codeblock_end) then
                is_codeblock_line = false
                table.insert(test_lines, test_function_end)
                table.insert(test_lines, function_name)
                table.insert(test_lines, "")
                table.insert(tests, test_lines)
                test_lines = {}
            end
            if is_codeblock_line then
                table.insert(test_lines, indented_line(line))
            end
            if String.ends_with(line, codeblock_start) then
                is_codeblock_line = true
                table.insert(test_lines, file_name_comment)
                function_name = test_function(index)
                table.insert(test_lines, test_function_start(function_name))
            end
        end
    end


    for _, test in ipairs(tests) do
        local path = os.tmpname()
        Path.write_text(path, test)
        local stdout = vim.fn.system({"nvim", "-l", path})
        if stdout ~= "" then
            io.stdout:write("\n"..stdout.."\n")
        end
        if vim.v.shell_error ~= 0 then
            io.stdout:write(Path.read_text(path))
            success = false
        end
        os.remove(path)
    end
    return success
end

testPathModule()
testStringModule()
local success = testLuaCodeBlocks({"./Path.lua", "./Table.lua", "./Table.lua"})

os.exit(success)
