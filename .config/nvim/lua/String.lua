---@module String functions.
---@author Luis David Licea Torres
---@license MIT

local String = {}

function String.starts_with(string, start)
   return string:sub(1, #start) == start
end

function String.ends_with(string, ending)
   return ending == "" or string:sub(-#ending) == ending
end

--- Splits a string into a table using the given character.
---@param separator string The character to use as a seperator.
---@return table
function String.split(str, separator)
    local fields = {}
    local pattern = string.format('([^%s]+)', separator)
    for match in string.gmatch(str, pattern) do
        fields[#fields + 1] = match
    end
    return fields
end

---Returns a character separator that does not appear in the given string.
---@param string string The string for which to choose an element separator.
---@return string? separator The character to use as element separator.
function String.chooseSeparator(string)
    for _, separator in ipairs({ '|', '@', '#', ':', '+', '-' }) do
        if not string:find(separator) then
            return separator
        end
    end
    return nil
end

---Split a string of command-line arguments into a list.
---@param str string The string with one or more arguments.
---@return table list The list of command-line arguments.
function String.to_list(str)
  local t = {}
  -- Balanced quotes.
  for quoted, non_quoted in ('""'..str):gmatch'(%b"")([^"]*)' do
    table.insert(t, quoted ~= '""' and quoted:sub(2,-2) or nil)
    for word in non_quoted:gmatch'%S+' do
      table.insert(t, word)
    end
  end
  return t
end

---Remove trailing and leading whitespace from string.
---@param string string The string whose white-space will be removed.
---@return string string The string with the white-space removed.
function String.trim(string)
  return (string:gsub("^%s*(.-)%s*$", "%1"))
end

---Remove leading whitespace from string.
---@param string string The string whose leading white-spaces will be removed.
---@return string string The string with the leading white-spaces removed.
function String.ltrim(string)
  return (string:gsub("^%s*", ""))
end

---Remove trailing whitespace from string.
---@param string string The string whose trailing spaces will be removed.
---@return string string The string with the trailing spaces removed.
function String.rtrim(string)
  local n = #string
  while n > 0 and string:find("^%s", n) do n = n - 1 end
  return string:sub(1, n)
end

---Format string with the given variables.
---```lua
---local String = require("String")
---local result = String.format("a=$(a),b=$(b)", {a=1, b=2})
---assert(result == "a=1,b=2")
---```
---
---
---@param string string The string to format.
---@param table table The table with the variables.
---@return string string The string with the substituted variables.
function String.format(string, table)
  -- note: handle {a=false} substitution
  string = string:gsub("%$%(([%w_]+)%)", function(name)
    local val = table[name]
    return val ~= nil and tostring(val)
  end)
  return string
end

---Convert a string into a dictionary and return the dictionary.
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
        oneOrMoreWordChars .. equalsSignWithZeroOrMoreSurroundingSpaces .. stringWithNoSpaces,
        oneOrMoreWordChars .. equalsSignWithZeroOrMoreSurroundingSpaces .. shortestStringInDoubleQuotes,
        oneOrMoreWordChars .. equalsSignWithZeroOrMoreSurroundingSpaces .. shortestStringInSingleQuotes,
    }

    for _, pattern in ipairs(dict_entry_patterns) do
        for key, value in string:gmatch(pattern) do
            dict[key] = value
        end
    end
    return dict
end

return String
