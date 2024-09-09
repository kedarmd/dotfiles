return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { 'lua_ls', 'eslint', 'ts_ls', 'cssls', 'tailwindcss' }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }
                    opts.desc = "Show line diagnostics"
                    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
                end
            })

            -- Custom function to toggle inline diagnostics
            local inline_diagnostics_active = false
            vim.diagnostic.config({
                virtual_text = inline_diagnostics_active,
            })

            function _G.toggle_inline_diagnostics()
                inline_diagnostics_active = not inline_diagnostics_active
                if inline_diagnostics_active then
                    vim.diagnostic.config({
                        virtual_text = true,
                    })
                else
                    vim.diagnostic.config({
                        virtual_text = false,
                    })
                end
            end

            vim.api.nvim_set_keymap('n', '<leader>td', ':lua toggle_inline_diagnostics()<CR>',
                { noremap = true, silent = true, desc = 'Toggle inline diagnostic' })

            -- Custom Icons for displaying diagnostic signs
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- Setup LSP servers
            lspconfig.lua_ls.setup({})
            lspconfig.ts_ls.setup({})
        end
    }
}
