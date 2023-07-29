local String = {}

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
---@return Array
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
