---@module Functions for setting keybindings.
---@author Luis David Licea Torres
---@license MIT

local append = require('Table').append
local set = vim.keymap.set

local function map(shortcut, command, options)
    set('', shortcut, command, options)
end

local function nnoremap(shortcut, command, options)
    local default_options = { noremap = true }
    append(default_options, options)
    set('n', shortcut, command, default_options)
end
local function cnoremap(shortcut, command)
    set('c', shortcut, command, { noremap = true })
end
local function inoremap(shortcut, command)
    set('i', shortcut, command, { noremap = true })
end
local function tnoremap(shortcut, command)
    set('t', shortcut, command, { noremap = true })
end

return {
    map = map,
    nnoremap = nnoremap,
    cnoremap = cnoremap,
    inoremap = inoremap,
    tnoremap = tnoremap,
}
