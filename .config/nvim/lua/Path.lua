---@module Path operation functions.
---@author Luis David Licea Torres
---@license MIT

local Path = {}

---Return whether the path exists.
---```lua
---local Path = require("path")
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

--- Return the path to the first array element that is executable.
---```lua
---local Path = require("path")
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

--- Splits a string into a table using the given character.
---@param separator string The character to use as a seperator.
---@return table
function string:split(separator)
    local fields = {}
    local pattern = string.format('([^%s]+)', separator)
    for match in self:gmatch(pattern) do
        fields[#fields + 1] = match
    end
    return fields
end

return Path
