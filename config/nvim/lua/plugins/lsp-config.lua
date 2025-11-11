return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		-- The LspAttach Autocmd remains unchanged and is correctly set up.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				-- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				-- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				-- map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				-- map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				-- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				-- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local servers = {
			ts_ls = {
				root_dir = require("lspconfig").util.root_pattern("package.json"),
				capabilities = capabilities,
				single_file_support = false,
			},

			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		}

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = signs.Error,
					[vim.diagnostic.severity.WARN] = signs.Warn,
					[vim.diagnostic.severity.HINT] = signs.Hint,
					[vim.diagnostic.severity.INFO] = signs.Info,
				},
			},
			virtual_text = {
				prefix = "●", -- Could be '●', '▎', 'x'
				spacing = 4,
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			-- FIX 2: Change the handler function to use vim.lsp.config/enable
			handlers = {
				function(server_name)
					-- 1. Get custom config (if any)
					local server_config = servers[server_name] or {}

					-- 2. Force merge capabilities (this logic remains correct)
					server_config.capabilities =
						vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})

					-- 3. Use the new API: vim.lsp.config to define the settings
					vim.lsp.config(server_name, server_config)

					-- 4. Use the new API: vim.lsp.enable to start the server
					-- mason-lspconfig will handle starting the server via a default handler if none is provided.
					-- When providing a custom handler, the recommended action is to use the core API.
					vim.lsp.enable({ server_name })
				end,
			},
		})
	end,
}