---@module Miscellaneous table functions.
---@author Luis David Licea Torres
---@license MIT

local tables = {}

---Join two dictionaries.
---@param table1 table The table that will be modified.
---@param table2 table The table to append.
function tables.append(table1, table2)
    if table1 and table2 then
        for key, value in pairs(table2) do
            table1[key] = value
        end
    end
end

---Return whether two arrays are the same.
---```lua
---local array = { { 'This', 'is' }, { 'an' }, 'example' }
---compare(array, { { 'This', 'is' }, { 'an' }, 'example' }, 'The arrays are the same.'))
---```
---
---
---@param array1 Array The first array to compare.
---@param array2 Array The second array to compare.
---@return boolean
function tables.compare(array1, array2)
    for i, v in pairs(array1) do
        if type(v) == 'table' then
            if tables.compare(array2[i], v) == false then
                return false
            end
        else
            if v ~= array2[i] then
                return false
            end
        end
    end
    return true
end

---Join two or more arrays or strings and return the new array.
---```lua
---local array = tables.merge({"This", "is"}, {"an"}, "example")
-- assert(tables.compare(array, { 'This', 'is', 'an', 'example' }), 'The arrays are the same.')
---```
---
---
---@vararg Array|number|string the arrays or strings to merge.
---@return Array the new array formed from all the passed arrays.
function tables.merge(...)
    local result = {}
    for _, t in ipairs({ ... }) do
        if type(t) == "table" then
            for _, v in pairs(t) do
                table.insert(result, v)
            end
        else
            table.insert(result, t)
        end
    end
    return result
end


return tables

