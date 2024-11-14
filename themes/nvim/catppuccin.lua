return {
	"catppuccin/nvim",
	name = "catppuccin",
	-- opts = {
	-- 	transparent_background = true,
	-- }
	config = function()
		-- require('onedark').setup {
		--     style = 'darker'
		-- }
		vim.cmd.colorscheme("catppuccin")
	end,
}
