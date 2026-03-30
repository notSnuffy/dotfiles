return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap-python"
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_virtual_text = require("nvim-dap-virtual-text")
        local dap_python = require("dap-python")

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

        local python_path = table.concat({ vim.fn.stdpath('data'),  'mason', 'packages', 'debugpy', 'venv', 'bin', 'python'}, '/'):gsub('//+', '/')
        dap_python.setup(python_path)

        local netcoredbg_path = table.concat({ vim.fn.stdpath("data"), "mason", "packages", "netcoredbg", "netcoredbg"}, "/"):gsub("//+", "/")
        dap.adapters.coreclr = {
            type = "executable",
            command = netcoredbg_path,
            args = {"--interpreter=vscode"}
        } 

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input("path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
                end,
            }
        }
    end,
}
