local keymap = vim.keymap -- for conciseness
local function nvim_wez_nae(key)
	local map = {
		l = "Right",
		h = "Left",
		j = "Down",
		k = "Up",
	}
	local command = string.format("wincmd %s", key)
	local current_win = vim.api.nvim_get_current_win()
	vim.cmd(command)
	if vim.api.nvim_get_current_win() == current_win then
		local current_termial = vim.fn.getenv("TERM_PROGRAM")
		if current_termial == "WezTerm" then
			local wez_command = string.format("wezterm cli activate-pane-direction %s", map[key])
			vim.fn.system(wez_command)
		else
			vim.notify("Not Running in WezTerm")
		end
	end
end

keymap.set("n", "<C-l>", function()
	nvim_wez_nae("l")
end, { desc = "Move to Rigth Window" })
keymap.set("n", "<C-h>", function()
	nvim_wez_nae("h")
end, { desc = "Mover to Left Window" })
keymap.set("n", "<C-k>", function()
	nvim_wez_nae("k")
end, { desc = "Move to Up Window" })
keymap.set("n", "<C-j>", function()
	nvim_wez_nae("j")
end, { desc = "Move to Down Window" })
