local status_ok, exrc = pcall(require, "exrc")
if not status_ok then
	return
end

-- disable built-in local config file support
vim.o.exrc = false

exrc.setup({
  files = {
    ".nvimrc.lua",
    ".nvimrc",
    ".exrc.lua",
    ".exrc",
  },
})
