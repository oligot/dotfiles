local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

trouble.setup {}

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
