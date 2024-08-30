return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        -- config = function()
        -- vim.cmd.colorscheme("tokyonight-night");
        -- end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin"
    },
    {
        "navarasu/onedark.nvim",
        config = function()
            -- require('onedark').setup {
            --     style = 'darker'
            -- }
            -- vim.cmd.colorscheme("onedark")
        end
    },
    {
        "AlexvZyl/nordic.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- local palette = require("nordic.colors")

            require("nordic").setup({
                transparent_bg = true,
                reduced_blue = false,
                bright_border = false,
                --     telescope = { style = "classic" },
                override = {
                    CursorLine = {
                        -- bg = "#191919",
                        bold = false,
                    },
                    --         Visual = {
                    --             bg = "#151515",
                    --         },
                },
            })
            --
            -- vim.cmd("colorscheme nordic")
            -- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#1e2022" })
        end,
    },
    {
        "arcticicestudio/nord-vim",
    }
}
