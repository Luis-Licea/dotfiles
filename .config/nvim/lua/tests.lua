#!/usr/bin/env nvim -l

local compare = require("Table").compare

local function testPathModule()
    local Path = require("Path")

    local exists1 = Path.is_executable("/usr/bin/nvim")
    assert(exists1 == true, "Executable should exist.")

    local exists2 = Path.is_executable({"", "usr", "bin", "nvim"})
    assert(exists2 == true, "Executable should exist.")

    local shell = Path.first_execuable({"/usr/bin/", "/usr/bin/bash"})
    assert(shell == "/usr/bin/bash", "Shell does not match.")
end

local function testStringModule()
    local String = require("String")

    local x = String.split("wow|cool", "|")
    assert(compare(x, {"wow", "cool"}))

    local y = String.to_list('a -b --c "test quotes"')
    assert(compare(y, {"a", "-b", "--c", "test quotes"}))

    local d = String.to_dict('a=b c="a test"')
    assert(compare(d, {a="b", c='"a test"'}))
end

testPathModule()
testStringModule()
