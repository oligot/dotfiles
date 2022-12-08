local nord_status_ok, nord = pcall(require, "nord")
if not nord_status_ok then
	return
end

vim.g.nord_contrast = true
vim.g.nord_borders = true
-- vim.g.nord_disable_background = true
vim.g.nord_italic = false
vim.g.nord_bold = false

nord.set()
