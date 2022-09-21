local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end

gitsigns.setup()

local conflictstatus_ok, gitconflict = pcall(require, "git-conflict")
if not conflictstatus_ok then
	return
end

gitconflict.setup()

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>do", "<cmd>DiffviewOpen<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>DiffviewClose<cr>", opts)

local gitlinker_ok, gitlinker = pcall(require, "gitlinker")
if not gitlinker_ok then
	return
end

gitlinker.setup()
