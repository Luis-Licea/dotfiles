---Table functions.
---@author Luis David Licea Torres
---@license GPL3

local Table = {}

---Join two dictionaries.
---```lua
---local Table = require("Table")
---local compare = Table.compare
---local table = { "a", "b" }
---Table.append({ "c", "d" })
---local the_same = compare(table, {"a", "b", "c", "d"})
---assert(the_same == true, 'The arrays must be the same.')
---```
---
---
---@param table1 table The table that will be modified.
---@param table2 table The table to append.
function Table.append(table1, table2)
    if table1 and table2 then
        for key, value in pairs(table2) do
            table1[key] = value
        end
    end
end

---Return whether two arrays are the same.
---```lua
---local Table = require("Table")
---local array = { { 'This', 'is' }, { 'an' }, 'example' }
---local the_same = Table.compare(array, { { 'This', 'is' }, { 'an' }, 'example' })
---assert(the_same == true, 'The arrays must be the same.')
---```
---
---
---@param table1 table The first array to compare.
---@param table2 table The second array to compare.
---@return boolean is_equal Whether the lists are the same.
function Table.compare(table1, table2)
    for i, v in pairs(table1) do
        if type(v) == 'table' then
            if Table.compare(table2[i], v) == false then
                return false
            end
        else
            if v ~= table2[i] then
                return false
            end
        end
    end
    return true
end

local Table = {}
---Join two or more arrays or strings and return the new array.
---```lua
---local Table = require("Table")
---local array = Table.merge({"This", "is"}, {"an"}, "example")
-- assert(Table.compare(array, { 'This', 'is', 'an', 'example' }), 'The arrays are the same.')
---```
---
---
---@vararg table|number|string the arrays, strings, or numbers to merge.
---@return table merged_table the new array formed from all the passed arrays.
function Table.merge(...)
    local result = {}
    for _, t in ipairs({ ... }) do
        if type(t) == 'table' then
            for _, v in pairs(t) do
                table.insert(result, v)
            end
        else
            table.insert(result, t)
        end
    end
    return result
end

return Table
