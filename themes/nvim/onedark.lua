return {
	"navarasu/onedark.nvim",
	config = function()
		---@diagnostic disable-next-line: undefined-field
		require("onedark").setup({
			style = "darker",
		})
		vim.cmd.colorscheme("onedark")
	end,
}
