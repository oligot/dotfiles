local status_ok, icons = pcall(require, "mini.icons")
if not status_ok then
	return
end

icons.setup({})
