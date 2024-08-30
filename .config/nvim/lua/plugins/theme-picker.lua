return {
    "zaldih/themery.nvim",
    event = 'VimEnter',
    priority = 1000,
    config = function()
        local keymap = vim.keymap
        keymap.set("n", "<leader>kt", "<cmd>Themery<CR>", { desc = 'Open Theme selection buffer' })
        require("themery").setup({
            themes = {
                {
                    name = 'Catppuccin Frappe',
                    colorscheme = 'catppuccin-frappe',
                    after = [[
                        require('lualine').setup{ options = { theme = 'tokyonight' } }
                    ]]
                },
                {
                    name = 'Catppuccin Macchiato',
                    colorscheme = 'catppuccin-macchiato',
                    after = [[
                        require('lualine').setup{ options = { theme = 'tokyonight' } }
                    ]]
                },
                {
                    name = 'Catppuccin Mocha',
                    colorscheme = 'catppuccin-mocha',
                    after = [[
                        require('lualine').setup{ options = { theme = 'tokyonight' } }
                    ]]
                },
                {
                    name = 'Nord',
                    colorscheme = 'nord',
                    after = [[
                        require('lualine').setup{ options = { theme = 'auto' } }
                    ]]
                },
                {
                    name = 'Nordic',
                    colorscheme = 'nordic',
                    after = [[
                        require('lualine').setup{ options = { theme = 'nordic' } }
                    ]]
                },
                {
                    name = 'Onedark',
                    colorscheme = 'onedark',
                    before = [[
                        require('onedark').setup({
                            style = 'dark'
                        })
                    ]],
                    after = [[
                        require('lualine').setup{ options = { theme = 'onedark' } }
                    ]]
                },
                {
                    name = 'Onedark Darker',
                    colorscheme = 'onedark',
                    before = [[
                        require('onedark').setup({
                            style = 'darker'
                        })
                    ]],
                    after = [[
                        require('lualine').setup{ options = { theme = 'onedark' } }
                    ]]
                },
                {
                    name = 'Onedark Warm',
                    colorscheme = 'onedark',
                    before = [[
                        require('onedark').setup({
                            style = 'warm'
                        })
                    ]],
                    after = [[
                        require('lualine').setup{ options = { theme = 'onedark' } }
                    ]]
                },
                {
                    name = 'Onedark Warmer',
                    colorscheme = 'onedark',
                    before = [[
                        require('onedark').setup({
                            style = 'warmer'
                        })
                    ]],
                    after = [[
                        require('lualine').setup{ options = { theme = 'onedark' } }
                    ]]
                },
                {
                    name = 'Onedark Cool',
                    colorscheme = 'onedark',
                    before = [[
                        require('onedark').setup({
                            style = 'cool'
                        })
                    ]],
                    after = [[
                        require('lualine').setup{ options = { theme = 'onedark' } }
                    ]]
                },
                {
                    name = 'Onedark Deep',
                    colorscheme = 'onedark',
                    before = [[
                        require('onedark').setup({
                            style = 'deep'
                        })
                    ]],
                    after = [[
                        require('lualine').setup{ options = { theme = 'onedark' } }
                    ]]
                },
                {
                    name = 'Tokyonight',
                    colorscheme = 'tokyonight-night',
                    after = [[
                        require('lualine').setup{ options = { theme = 'tokyonight' } }
                    ]]
                },
                {
                    name = 'Tokyonight Storm',
                    colorscheme = 'tokyonight-storm',
                    after = [[
                        require('lualine').setup{ options = { theme = 'tokyonight' } }
                    ]]
                },
                {
                    name = 'Tokyonight Moon',
                    colorscheme = 'tokyonight-moon',
                    after = [[
                        require('lualine').setup{ options = { theme = 'tokyonight' } }
                    ]]
                },
            }
        })
    end
}
