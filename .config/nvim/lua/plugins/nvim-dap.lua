-- DAP and DAPUI.
-- Related: ./telescope.lua
return {
    'mfussenegger/nvim-dap',
    -- event = 'BufAdd',
    config = function()
        require('nvim-dap-virtual-text').setup()

        local key = require('Key')
        local nnoremap = key.nnoremap
        local set = vim.keymap.set

        -- require('telescope').load_extension('dap')

        require('dapui').setup({
            controls = {
                element = 'repl',
                enabled = true,
                icons = {
                    disconnect = '',
                    pause = '',
                    play = '',
                    run_last = '',
                    step_back = '',
                    step_into = '',
                    step_out = '',
                    step_over = '',
                    terminate = '',
                },
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = 'single',
                mappings = {
                    close = { 'q', '<Esc>' },
                },
            },
            force_buffers = true,
            icons = {
                collapsed = '',
                current_frame = '',
                expanded = '',
            },
            layouts = {
                {
                    elements = {
                        { id = 'scopes', size = 0.25 },
                        { id = 'breakpoints', size = 0.25 },
                        { id = 'stacks', size = 0.25 },
                        { id = 'watches', size = 0.25 },
                    },
                    position = 'left',
                    size = 40,
                },
                {
                    elements = {
                        { id = 'repl', size = 0.95 },
                        -- { id = "console", size = 0.5 }
                    },
                    position = 'bottom',
                    size = 10,
                },
            },
            mappings = {
                edit = 'e',
                expand = { '<CR>', '<2-LeftMouse>' },
                open = 'o',
                remove = 'd',
                repl = 'r',
                toggle = 't',
            },
            render = {
                indent = 1,
                max_value_lines = 100,
            },
        })

        local dap, dapui = require('dap'), require('dapui')

        dap.adapters.python = {
            type = 'executable',
            command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/debugpy-adapter',
        }

        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = 'Launch file',
                program = '${file}',
                pythonPath = function()
                    return 'python3'
                end,
            },
        }

        dap.adapters.sh = {
            type = 'executable',
            command = vim.fn.exepath('bash-debug-adapter'),
        }

        local BASHDB_DIR = require('mason-registry')
            .get_package('bash-debug-adapter')
            :get_install_path() .. '/extension/bashdb_dir'
        dap.configurations.sh = {
            {
                name = 'Launch Bash debugger',
                type = 'sh',
                request = 'launch',
                program = '${file}',
                cwd = '${fileDirname}',
                pathBashdb = BASHDB_DIR .. '/bashdb',
                pathBashdbLib = BASHDB_DIR,
                pathBash = 'bash',
                pathCat = 'cat',
                pathMkfifo = 'mkfifo',
                pathPkill = 'pkill',
                env = {},
                args = {},
                -- showDebugOutput = true,
                -- trace = true,
            },
        }

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/OpenDebugAD7',
        }

        local function GetDebugExecutable()
            local compilationPath = vim.fn.expandcmd('$TMPDIR/%:t:r')
            local sourcePath = vim.fn.expand('%:p:r')
            local cargoPath = function()
                if vim.fn.execute('cargo') == 1 then
                    local metadata = vim.fn.system({ 'cargo', 'metadata', '--format-version', '1' })
                    local name = metadata:gmatch('"name":"(.-)"')()
                    local directory = metadata:gmatch('"target_directory":"(.-)"')()
                    if directory and name then
                        return directory .. '/' .. name
                    end
                end
                return ''
            end

            for _, path in ipairs({ sourcePath, compilationPath, cargoPath }) do
                if vim.fn.executable(path) == 1 then
                    return path
                end
            end

            -- Manually enter executable name:
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end
        dap.configurations.cpp = {
            {
                name = 'Launch file',
                type = 'cppdbg',
                request = 'launch',
                program = GetDebugExecutable,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
            },
            {
                name = 'Attach to gdbserver :1234',
                type = 'cppdbg',
                request = 'launch',
                MIMode = 'gdb',
                miDebuggerServerAddress = 'localhost:1234',
                miDebuggerPath = '/usr/bin/gdb',
                cwd = '${workspaceFolder}',
                program = GetDebugExecutable,
            },
        }
        -- Reuse configuration for C and Rust.
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp

        require('dap-vscode-js').setup({
            -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
            debugger_cmd = { os.getenv('HOME') .. '/.local/share/nvim/mason/bin/js-debug-adapter' },
            -- Which adapters to register in nvim-dap.
            adapters = {
                'pwa-node',
                'pwa-chrome',
                'pwa-msedge',
                'node-terminal',
                'pwa-extensionHost',
            },
        })

        dap.configurations.javascript = {
            {
                type = 'pwa-node',
                request = 'launch',
                name = 'Launch file',
                program = '${file}',
                cwd = '${workspaceFolder}',
            },
            {
                type = 'pwa-node',
                request = 'attach',
                name = 'Attach',
                processId = require('dap.utils').pick_process,
                cwd = '${workspaceFolder}',
            },
            {
                type = 'pwa-node',
                request = 'launch',
                name = 'Debug Mocha Tests',
                -- trace = true, -- include debugger info
                runtimeExecutable = 'node',
                runtimeArgs = {
                    './node_modules/mocha/bin/mocha.js',
                },
                program = '${file}',
                rootPath = '${workspaceFolder}',
                cwd = '${workspaceFolder}',
                console = 'integratedTerminal',
                internalConsoleOptions = 'neverOpen',
            },
        }
        dap.configurations.typescript = dap.configurations.javascript

        vim.fn.sign_define(
            'DapBreakpoint',
            { text = '⏺️', texthl = 'Error', linehl = 'Error', numhl = 'Error' }
        )
        vim.fn.sign_define(
            'DapStopped',
            { text = '▶️', texthl = 'Search', linehl = 'Search', numhl = 'Search' }
        )

        nnoremap('dC', dap.continue) -- [C]ontinue
        nnoremap('dO', dap.step_over) -- [O]ver
        set('n', '<enter>', function()
            if vim.bo.buftype == '' then
                dap.step_over()
            else
                -- Do not shadow quick-fix jump functionality when pressing "<enter>".
                return '<enter>'
            end
        end, { expr = true })
        nnoremap('dI', dap.step_into) -- [I]nto
        nnoremap('dU', dap.step_out) -- [U]p
        nnoremap('dE', dap.terminate) -- T[e]rminate, [E]nd
        nnoremap('dT', dap.toggle_breakpoint) -- [T]oggle
        nnoremap('dB', function()
            dap.set_breakpoint(
                vim.fn.input('Condition: '),
                vim.fn.input('Hit Condition: '),
                vim.fn.input('Log Message: ')
            )
        end)
        nnoremap('dR', dap.repl.open) -- [R]epl
        nnoremap('dL', dap.run_last) -- [L]ast
        set({ 'n', 'v' }, 'dH', require('dap.ui.widgets').hover) -- [H]over
        set({ 'n', 'v' }, 'dP', require('dap.ui.widgets').preview) -- [P]review
        nnoremap('dF', function() -- [F]rames
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.frames)
        end)
        nnoremap('dS', function() -- [S]copes
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.scopes)
        end)

        -- Open windows automatically when debug session starts.
        dap.listeners.after.event_initialized.dapui_config = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited.dapui_config =
            dap.listeners.before.event_terminated.dapui_config
    end,
    dependencies = {
        -- Fancy debug adapter UI provider and Debug Adapter Protocol.
        'rcarriga/nvim-dap-ui',
        'nvim-neotest/nvim-nio',
        -- Adapter for vscode-js-debug.
        'mxsdev/nvim-dap-vscode-js',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-telescope/telescope-dap.nvim',
    },
}
