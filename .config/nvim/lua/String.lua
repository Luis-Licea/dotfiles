---@module String functions.
---@author Luis David Licea Torres
---@license MIT

local String = {}

---Return whether the string starts with the given start string.
---```lua
---local String = require("String")
---assert(String.starts_with("hello world", "hello"))
---```
---
---
---@param string string The string.
---@param start string The start substring.
---@return boolean does_start Whether the string starts with the start string.
function String.starts_with(string, start)
    return string:sub(1, #start) == start
end

---Return whether the string ends with the given end string.
---```lua
---local String = require("String")
---assert(String.ends_with("hello world", "world"))
---```
---
---@param string string The string.
---@param ending string The end substring.
---@return boolean does_end Whether the string ends with the end string.
function String.ends_with(string, ending)
    return ending == '' or string:sub(-#ending) == ending
end

---Split a string into a table using the given separator.
---```lua
---local String = require("String")
---local compare = require("Table").compare
---local list = String.split("hello world", " ")
---assert(compare(list, {"hello", "world"}), "Expected lists to equal.")
---```
---
---@param str string The string to split into a table.
---@param separator string The separator to use to split the string.
---@return string[] list The list of elements.
function String.split(str, separator)
    local fields = {}
    local pattern = string.format('([^%s]+)', separator)
    for match in string.gmatch(str, pattern) do
        fields[#fields + 1] = match
    end
    return fields
end

---Returns a character separator that does not appear in the given string.
---```lua
---local String = require("String")
---local separator = String.chooseSeparator("hello world")
---assert(separator == "|", "Expected lists to equal.")
---```
---
---@param string string The string for which to choose an element separator.
---@return string? separator A character that can be used as element separator.
function String.chooseSeparator(string)
    for _, separator in ipairs({ '|', '@', '#', ':', '+', '-' }) do
        if not string:find(separator) then
            return separator
        end
    end
    return nil
end

---Split a string of command-line arguments into a list.
---```lua
---local String = require("String")
---local compare = require("Table").compare
---local list = String.to_list('a -b --c "test quotes"')
---assert(compare(list, {"a", "-b", "--c", "test quotes"}))
---```
---
---@param str string The string with one or more arguments.
---@return table list The list of command-line arguments.
function String.to_list(str)
    local t = {}
    -- Balanced quotes.
    for quoted, non_quoted in ('""' .. str):gmatch('(%b"")([^"]*)') do
        table.insert(t, quoted ~= '""' and quoted:sub(2, -2) or nil)
        for word in non_quoted:gmatch('%S+') do
            table.insert(t, word)
        end
    end
    return t
end

---Remove trailing and leading whitespace from string.
---```lua
---local String = require("String")
---local string = String.trim("  hello  world  ")
---assert(string == "hello  world")
---```
---
---@param string string The string whose white-space will be removed.
---@return string string The string with the white-space removed.
function String.trim(string)
    return (string:gsub('^%s*(.-)%s*$', '%1'))
end

---Remove leading whitespace from string.
---```lua
---local String = require("String")
---local string = String.ltrim("\n  hello  world ")
---assert(string == "hello  world ")
---```
---
---@param string string The string whose leading white-spaces will be removed.
---@return string string The string with the leading white-spaces removed.
function String.ltrim(string)
    return (string:gsub('^%s*', ''))
end

---Remove trailing whitespace from string.
---```lua
---local String = require("String")
---local string = String.rtrim(" hello  world  \n")
---assert(string == " hello  world")
---```
---
---@param string string The string whose trailing spaces will be removed.
---@return string string The string with the trailing spaces removed.
function String.rtrim(string)
    local n = #string
    while n > 0 and string:find('^%s', n) do
        n = n - 1
    end
    return string:sub(1, n)
end

---Format string with the given variables.
---```lua
---local String = require("String")
---local string = String.format("a=$(a),b=$(b)", {a=1, b=2})
---assert(string == "a=1,b=2")
---```
---
---
---@param string string The string to format.
---@param table table The table with the variables.
---@return string string The string with the substituted variables.
function String.format(string, table)
    -- note: handle {a=false} substitution
    string = string:gsub('%$%(([%w_]+)%)', function(name)
        local val = table[name]
        return val ~= nil and tostring(val)
    end)
    return string
end

---Convert a string into a dictionary and return the dictionary.
---```lua
---local String = require("String")
---local compare = require("Table").compare
---local dictionary = String.to_dict('a=b c="a test"')
---assert(compare(dictionary, {a="b", c='"a test"'}))
---```
---
---
---@param string string The string to convert to a dictionary.
---@return table
function String.to_dict(string)
    local dict = {}

    -- Regex building blocks.
    local equalsSignWithZeroOrMoreSurroundingSpaces = '%s*=%s*'
    local oneOrMoreWordChars = '(%w+)'
    local stringWithNoSpaces = '(%S+)'
    local shortestStringInDoubleQuotes = '(".-")'
    local shortestStringInSingleQuotes = "('.-')"

    local dict_entry_patterns = {
        -- "(%w+)%s*=%s*(%S+)", -- Match strings with no spaces.
        -- '(%w+)%s*=%s*(".-")', -- Match shortest string inside double quotes.
        -- "(%w+)%s*=%s*('.-')", -- Match shortest string inside single quotes.
        oneOrMoreWordChars
            .. equalsSignWithZeroOrMoreSurroundingSpaces
            .. stringWithNoSpaces,
        oneOrMoreWordChars
            .. equalsSignWithZeroOrMoreSurroundingSpaces
            .. shortestStringInDoubleQuotes,
        oneOrMoreWordChars
            .. equalsSignWithZeroOrMoreSurroundingSpaces
            .. shortestStringInSingleQuotes,
    }

    for _, pattern in ipairs(dict_entry_patterns) do
        for key, value in string:gmatch(pattern) do
            dict[key] = value
        end
    end
    return dict
end

return String
