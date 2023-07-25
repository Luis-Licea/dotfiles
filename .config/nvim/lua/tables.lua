---@module Miscellaneous table functions.
---@author Luis David Licea Torres
---@license MIT

local tables = {}

--- Join two dictionaries.
---@param table1 table The table that will be modified.
---@param table2 table The table to append.
function tables.append(table1, table2)
    if table1 and table2 then
        for key, value in pairs(table2) do
            table1[key] = value
        end
    end
end


--- Join two or more arrays and return the new array.
---@vararg Array|number|string the arrays to merge.
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

