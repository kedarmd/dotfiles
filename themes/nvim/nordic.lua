return {
	"AlexvZyl/nordic.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- local palette = require("nordic.colors")

		require("nordic").setup({
			reduced_blue = false,
			bright_border = false,
			--     telescope = { style = "classic" },
		})
		--
		vim.cmd("colorscheme nordic")
		-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#1e2022" })
	end,
}
