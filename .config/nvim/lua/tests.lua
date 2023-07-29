#!/usr/bin/env nvim -l

local function testPathModule()
    local Path = require("Path")

    local exists1 = Path.is_executable("/usr/bin/nvim")
    assert(exists1 == true, "Executable should exist.")

    local exists2 = Path.is_executable({"", "usr", "bin", "nvim"})
    assert(exists2 == true, "Executable should exist.")

    local shell = Path.first_execuable({"/usr/bin/", "/usr/bin/bash"})
    assert(shell == "/usr/bin/bash", "Shell does not match.")
end

testPathModule()
