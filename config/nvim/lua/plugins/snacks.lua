local keymap = vim.api.nvim_set_keymap
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = false },
		dashboard = {
			preset = {
				header = [[
██╗  ██╗███████╗██████╗  █████╗ ██████╗  
██║ ██╔╝██╔════╝██╔══██╗██╔══██╗██╔══██╗ 
█████╔╝ █████╗  ██║  ██║███████║██████╔╝ 
██╔═██╗ ██╔══╝  ██║  ██║██╔══██║██╔═██╗  
██║  ██╗███████╗██████╔╝██║  ██║██║  ██╗ 
╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝]],
			},
		},
		terminal = {
			win = {
				style = "terminal",
			},
		},
		lazygit = { enabled = true },
		explorer = { enabled = true },
		indent = { enabled = false },
		input = { enabled = false },
		picker = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},

	-- keybings here...
	keymap("n", "\\", ":lua Snacks.picker.explorer()<CR>", { noremap = true, silent = true }),
	keymap("n", "<leader>lg", "<cmd>lua Snacks.lazygit()<CR>", { desc = "Lazygit", noremap = true, silent = true }),
	keymap(
		"n",
		"<C-`>",
		"<cmd>lua Snacks.terminal.toggle()<CR>",
		{ desc = "Toggle Terminal", noremap = true, silent = true }
	),
	keymap(
		"t",
		"<C-`>",
		"<cmd>lua Snacks.terminal.toggle()<CR>",
		{ desc = "Toggle Terminal", noremap = true, silent = true }
	),
}
