---@module Functions for setting keybindings.
---@author Luis David Licea Torres
---@license MIT

local Key = {}

local set = vim.keymap.set

function Key.map(shortcut, command, options)
    set('', shortcut, command, options)
end

function Key.nnoremap(shortcut, command, options)
    options = options or {}
    options.noremap = true
    set('n', shortcut, command, options)
end

function Key.cnoremap(shortcut, command)
    set('c', shortcut, command, { noremap = true })
end

function Key.inoremap(shortcut, command)
    set('i', shortcut, command, { noremap = true })
end

function Key.tnoremap(shortcut, command)
    set('t', shortcut, command, { noremap = true })
end

return Key
