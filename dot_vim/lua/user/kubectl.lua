local status_ok, kubectl = pcall(require, "kubectl")
if not status_ok then
	return
end

kubectl.setup({})

vim.keymap.set("n", "<leader>k", '<cmd>lua require("kubectl").toggle()<cr>', { noremap = true, silent = true })
