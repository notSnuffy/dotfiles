 return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                indent = { enable = true },
                ensure_installed = {
                    "bash",
                    "c",
                    "c_sharp",
                    "cmake",
                    "cpp",
                    "css",
                    "dockerfile",
                    "html",
                    "javascript",
                    "json",
                    "make",
                    "php",
                    "python",
                    "typescript",
                    "yaml"
                },
                auto_install = true,
            })
        end
    }
}
