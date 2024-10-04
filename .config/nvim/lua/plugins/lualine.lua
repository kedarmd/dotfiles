local os_logo = function()
	local os_name = vim.loop.os_uname().sysname
	if os_name == "Linux" then
		return "" -- Linux icon
	elseif os_name == "Darwin" then
		return "" -- macOS icon
	elseif os_name == "Windows" then
		return "" -- Windows icon
	else
		return "" -- Fallback icon
	end
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			sections = {
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = {},
				lualine_y = { "filetype" },
				lualine_z = { os_logo },
			},
		})
	end,
}
