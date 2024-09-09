-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
    },
    opts = {
        filesystem = {
            window = {
                mappings = {
                    ['\\'] = 'close_window',
                },
                position = 'right'
            },
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            }
        },
    },
}
--
-- return {
--     "nvim-tree/nvim-tree.lua",
--     dependencies = "nvim-tree/nvim-web-devicons",
--     config = function()
--         local nvimtree = require("nvim-tree")
--
--         vim.g.loaded_netrw = 1
--         vim.g.loaded_netrwPlugin = 1
--
--         nvimtree.setup({
--             view = {
--                 width = 35,
--             },
--             renderer = {
--                 -- indent_markers = {
--                 --     enable = true,
--                 -- },
--                 icons = {
--                     glyphs = {
--                         folder = {
--                             arrow_closed = "→",
--                             arrow_open = "↓",
--                         },
--                     },
--                 },
--             },
--             -- actions = {
--             --     open_file = {
--             --         window_picker = {
--             --             enable = false,
--             --         },
--             --     },
--             -- },
--             -- filters = {
--             --     custom = { ".DS_Store" },
--             -- },
--             -- git = {
--             --     enable = false,
--             -- },
--         })
--
--         vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
--         vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
--         vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
--     end,
-- }
