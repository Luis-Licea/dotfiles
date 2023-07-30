---@module Path functions.
---@author Luis David Licea Torres
---@license MIT

local Path = {}

---Return whether the path exists.
---```lua
---local Path = require("Path")
---
---local exists1 = Path.is_executable("/usr/bin/nvim")
---assert(exists1 == true, "Executable should exist.")
---
---local exists2 = Path.is_executable({"", "usr", "bin", "nvim"})
---assert(exists2 == true, "Executable should exist.")
---```
---
---
---@param path string[]|string The path to the file.
---@return boolean is_executable Whether the path executable.
function Path.is_executable(path)
    if type(path) == 'table' then
        path = table.concat(path, "/")
    end
    return vim.fn.executable(path) == 1
end

---Return whether the given path is executable.
---@param path string? An optional path to the file to check. Defaults to
---current file.
---@return boolean is_executable Whether the path is executable by all users.
function Path.executable(path)
    -- If the path is not defined, use the path to the current file.
    if not path then path = vim.fn.expand("%") end
    -- Get permissions string including parenthesis, e.g. "drwxrwxrwx".
    local permissions = vim.fn.system({'stat', '--printf="%A"', path})
    -- The eleventh character in the permissions "drwxrwxrwx" represents
    -- whether the file is executable by all users.
    return string.sub(permissions, 11, 11) == "x"
end

--- Return the path to the first array element that is executable.
---```lua
---local Path = require("Path")
---
---local shell = Path.first_execuable({"/usr/bin/", "/usr/bin/bash"})
---assert(shell == "/usr/bin/bash", "Shell does not match.")
---```
---
---
---@param executables string[]|table[]> The executable paths.
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
---@param path string The path to the file to test.
---@return boolean exists Whether the file exists.
function Path.exists(path)
   local file = io.open(path, "r")
   if file ~= nil then
       io.close(file)
       return true
   end
   return false
end

---Return the file lines a table.
---@param path string The path to the file to convert into a table.
---@return table lines The file lines.
function Path.to_lines(path)
    local lines = {}
    if Path.exists(path) then
        for line in io.lines(path, "*l") do
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
    local file = io.open(path, "w")
    if file then
        io.output(file)
        if type(text) == 'table' then
            io.write(table.concat(text, "\n"))
        else
            io.write(text)
        end
        return io.close(file)
    end
    return false
end

---Return text the file contents.
---@param path string The path to the text file.
---@return string? text The text file contents.
function Path.read_text(path)
    local file = io.open(path, "r")
    if file then
        io.input(file)
        local lines = io.read("*a")
        io.close(file)
        return lines
    end
    return nil
end

return Path
