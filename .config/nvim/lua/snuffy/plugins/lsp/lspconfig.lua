return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"nvim-java/nvim-java",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local nvim_java = require("java")
		nvim_java.setup({
			spring_boot_tools = {
				enable = false, -- disable spring boot tools for now
			},
			jdk = {
				version = "21.0.7", -- specify the JDK version to use
				auto_install = false, -- automatically install the JDK if not found
			},
		})
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "<leader>[", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "<leader>]", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		local servers = {
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
		}

		---vim.lsp.config["ts_ls"] = {
		---	capabilities = capabilities,
		---	on_attach = on_attach,
		---}

		for _, lsp in ipairs(servers) do
			vim.lsp.config[lsp] = {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			vim.lsp.enable(lsp)
		end

		---local omnisharp_path = table
		---		.concat({ vim.fn.stdpath("data"), "mason", "packages", "omnisharp", "libexec", "OmniSharp.dll" }, "/")
		---		:gsub("//+", "/")
		---vim.lsp.config["omnisharp"] = {
		---	capabilities = capabilities,
		---	cmd = { "dotnet", omnisharp_path },
		---	on_attach = on_attach,
		---	enable_import_completion = true,
		---	organize_imports_on_format = true,
		---	enable_roslyn_analyzers = true,
		---}
		---vim.lsp.enable("omnisharp")
	end,
}
