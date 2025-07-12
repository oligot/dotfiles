local status_ok, codecompanion = pcall(require, "codecompanion")
if not status_ok then
	return
end

codecompanion.setup({
  strategies = {
    chat = {
      adapter = "gemini", -- anthropic
    },
    inline = {
      adapter = "gemini", -- anthropic
    },
  },
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
