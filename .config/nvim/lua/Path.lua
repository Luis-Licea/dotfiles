---@module Path functions.
---@author Luis David Licea Torres
---@license MIT

local Path = {}

---Return whether the file is executable.
---```lua
---local Path = require("Path")
---
---local is_executable1 = Path.is_executable("/usr/bin/nvim")
---assert(is_executable1 == true, "Expected executable file.")
---
---local is_executable2 = Path.is_executable({"", "usr", "bin", "nvim"})
---assert(is_executable2 == true, "Expected executable file.")
--
---local is_executable3 = Path.is_executable("/usr/bin")
---assert(is_executable3 == false, "Expected non-executable file.")
---```
---
---
---@param path string[]|string The path to the file.
---@return boolean is_executable Whether the file executable.
function Path.is_executable(path)
    if type(path) == 'table' then
        path = table.concat(path, '/')
    end
    return vim.fn.executable(path) == 1
end

---Return whether the given file or folder path is executable.
---```lua
---local Path = require("Path")
---
---local is_executable1 = Path.executable("/usr/bin/nvim")
---assert(is_executable1 == true, "Expected executable file.")
---
---local is_executable2 = Path.executable("/usr/bin")
---assert(is_executable2 == true, "Expected executable folder.")
---```
---
---
---@param path string? An optional path to the file or folder to check. Defaults to
---current file path.
---@return boolean is_executable Whether the path is executable by all users.
function Path.executable(path)
    -- If the path is not defined, use the path to the current file.
    if not path then
        path = vim.fn.expand('%')
    end
    -- Get permissions string including parenthesis, e.g. "drwxrwxrwx".
    local permissions = vim.fn.system({ 'stat', '--printf="%A"', path })
    -- The eleventh character in the permissions "drwxrwxrwx" represents
    -- whether the file is executable by all users.
    return string.sub(permissions, 11, 11) == 'x'
end

--- Return the path to the first table element that is executable.
---```lua
---local Path = require("Path")
---
---local shell = Path.first_execuable({"/usr/bin/", "/usr/bin/bash"})
---assert(shell == "/usr/bin/bash", "Expected shell to match.")
---```
---
---
---@param executables string[]|table[]> The executable file paths.
---@return string|table? executable The path to the executable.
function Path.first_execuable(executables)
    for _, execuatble in ipairs(executables) do
        if Path.is_executable(execuatble) then
            return execuatble
        end
    end
    return nil
end

---Returns true if the file is readable. Returns false for directories.
---```lua
---local Path = require("Path")
---
---local exists1 = Path.exists("/usr/bin/nvim")
---local exists2 = Path.exists("/usr/bin/")
---assert(exists1 == true, "Expected file to exist.")
---assert(exists2 == true, "Expected folder to exist.")
---```
---
---
---@param path string The path to the file to test.
---@return boolean exists Whether the file exists.
function Path.exists(path)
    local file = io.open(path, 'r')
    if file ~= nil then
        io.close(file)
        return true
    end
    return false
end

---Return the file lines as a table.
---@param path string The path to the file to convert into a table.
---@return table lines The file lines.
function Path.to_lines(path)
    local lines = {}
    if Path.exists(path) then
        for line in io.lines(path, '*l') do
            table.insert(lines, line)
        end
    end
    return lines
end

---Write text to the given file.
---@param path string The path to the file.
---@param text string|string[] The text to write to the file.
---@return boolean? success Whether writing to the file was successful.
function Path.write_text(path, text)
    local file = io.open(path, 'w')
    if file then
        io.output(file)
        if type(text) == 'table' then
            io.write(table.concat(text, '\n'))
        else
            io.write(text)
        end
        return io.close(file)
    end
    return false
end

---@alias ReadMode string
---| "*n" # Reads a numeral and returns it as number.
---|>"*a" # Reads the whole file.
---| "*l" # Reads the next line skipping the end of line.
---| "*L" # Reads the next line keeping the end of line.

---Return text the file contents.
---@param path string The path to the text file.
---@param mode ReadMode? The read mode.
---@return string? text The text file contents.
function Path.read_text(path, mode)
    mode = mode or '*a'
    local file = io.open(path, 'r')
    if file then
        io.input(file)
        local lines = io.read(mode)
        io.close(file)
        return lines
    end
    return nil
end

---Expand environment variables and escape spaces and quotes in a string.
---```lua
---local Path = require("Path")
---assert(Path.escape("$HOME/a space") == os.getenv("HOME") .. "/a\\ space")
---```
---
---
---@param str string The string whose environment variables will be expanded
---and whose paces and quotes will be escaped.
---@return string string The resolved and escaped string.
function Path.escape(str)
    return vim.fn.fnameescape(vim.fn.expandcmd(str))
end

return Path
