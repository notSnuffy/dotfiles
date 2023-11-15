return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim"
    },
    config = function()

        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "clangd", -- C/C++
                "omnisharp", -- C#
                "cmake", -- CMake
                "dockerls", -- Docker
                "docker_compose_language_service", -- Docker Compose
                "emmet_ls", -- Emmet
                "html", -- HTML
                "jsonls", -- JSON
                "tsserver", -- JavaScript
                "lua_ls", -- Lua
                "intelephense", -- PHP
                "pyright", -- Python
                "yamlls", -- YAML
            },
            automatic_installation = true,
        })
    end,
}
