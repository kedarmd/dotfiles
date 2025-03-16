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
██╔═██╗ ██╔══╝  ██║  ██║██╔══██║██╔═██╝   
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
		indent = { enabled = true },
		input = { enabled = false },
		picker = { enabled = true },
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

	-- Picker
	keymap(
		"n",
		"<leader>sf",
		"<cmd>lua Snacks.picker.files()<CR>",
		{ desc = "[S]earch [F]iles", noremap = true, silent = true }
	),
	keymap(
		"n",
		"<leader><leader>",
		"<cmd>lua Snacks.picker.buffers()<CR>",
		{ desc = "[Search] [Buffers] existing", noremap = true, silent = true }
	),
	keymap(
		"n",
		"<leader>sw",
		"<cmd>lua Snacks.picker.grep_word()<CR>",
		{ desc = "[Search] current [W]ord", noremap = true, silent = true }
	),
	keymap(
		"n",
		"<leader>sg",
		"<cmd>lua Snacks.picker.grep()<CR>",
		{ desc = "[Search] by [G]rep", noremap = true, silent = true }
	),
	keymap(
		"n",
		"<leader>sd",
		"<cmd>lua Snacks.picker.diagnostics()<CR>",
		{ desc = "[Search] [D]iagnostics", noremap = true, silent = true }
	),
	keymap(
		"n",
		"<leader>sr",
		"<cmd>lua Snacks.picker.resume()<CR>",
		{ desc = "[Search] [R]esume", noremap = true, silent = true }
	),
	keymap(
		"n",
		"<leader>sb",
		"<cmd>lua Snacks.picker.git_branches()<CR>",
		{ desc = "[Search] [B]ranches", noremap = true, silent = true }
	),
}
