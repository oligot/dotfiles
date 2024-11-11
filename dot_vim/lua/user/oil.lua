local status_ok, oil = pcall(require, "oil")
if not status_ok then
	return
end

-- See https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/oil.lua
oil.setup({
	view_options = {
		show_hidden = true,
	},
})

-- Open parent directory in current window
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
