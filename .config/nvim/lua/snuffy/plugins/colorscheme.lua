return {
    { 
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000,
        config = function()
            local catppuccin = require("catppuccin")
            catppuccin.setup({
                flavour = "mocha",
                integrations = {
                    telescope = true,
                    nvimtree = true,
                    treesitter = true,
                },
            })
            vim.cmd.colorscheme "catppuccin"
        end,
    }
}
