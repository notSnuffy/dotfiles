return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_dap = require("mason-nvim-dap")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
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
				"ts_ls", -- JavaScript
				"lua_ls", -- Lua
				"intelephense", -- PHP
				"pyright", -- Python
				"yamlls", -- Yaml
			},
			automatic_installation = true,
		})
		mason_dap.setup({
			ensure_installed = {
				"python",
				"coreclr",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"php-cs-fixer",
				"shfmt",
				"isort",
				"black",
				"clang-format",
				"csharpier",
				"pylint",
				"eslint_d",
				"checkstyle",
				"google-java-format",
			},
		})
	end,
}

