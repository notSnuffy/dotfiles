return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_virtual_text = require("nvim-dap-virtual-text")

        dap_virtual_text.setup({
            virtual_text = {
                enabled = true,
                prefix = "",
            },
            float = {
                enabled = false,
                max_height = nil,
                max_width = nil,
                mappings = {
                    close = {"q", "<Esc>"},
                },
            },
            sign = {
                enabled = true,
                priority = 20,
            },
            underline = {
                enabled = true,
                priority = 20,
            },
        })

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()

        end

        vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
        vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

        vim.keymap.set('n', '<F5>', function() dap.continue() end)
        vim.keymap.set('n', '<F10>', function() dap.step_over() end)
        vim.keymap.set('n', '<F11>', function() dap.step_into() end)
        vim.keymap.set('n', '<F12>', function() dap.step_out() end)
        vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)

        dapui.setup({
            icons = {expanded = "▾", collapsed = "▸"},
            mappings = {
                -- Use a table to apply multiple mappings
                expand = {"<CR>"},
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
            },
            sidebar = {
                open_on_start = true,
                elements = {
                    -- You can change the order of elements in the sidebar
                    "scopes",
                    "breakpoints",
                    "stacks",
                    "watches",
                },
                width = 40,
                position = "left", -- Can be "left" or "right"
            },
            tray = {
                open_on_start = true,
                elements = {"repl"},
                height = 10,
                position = "bottom", -- Can be "bottom" or "top"
            },
            floating = {
                max_height = nil, -- These can be integers or a float between 0 and 1.
                max_width = nil, -- Floats will be treated as percentage of your screen.
                mappings = {
                    close = {"q", "<Esc>"},
                },
            },
            windows = {indent = 1},
        })


        dap.adapters.node2 = {
            type = "executable",
            command = "node",
            args = {os.getenv("HOME") .. "/.local/share/nvim/dapinstall/jsnode_dbg/vscode-node-debug2/out/src/nodeDebug.js"},
        }
        dap.configurations.javascript = {
            {
                type = "node2",
                request = "launch",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                console = "integratedTerminal",
            },
        }
        dap.adapters.python = {
            type = "executable",
            command = "python",
            args = {"-m", "debugpy.adapter"},
        }
        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                        return cwd .. "/venv/bin/python"
                    elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                        return cwd .. "/.venv/bin/python"
                    else
                        return "/usr/bin/python"
                    end
                end,
            },
        }
    end,
}
