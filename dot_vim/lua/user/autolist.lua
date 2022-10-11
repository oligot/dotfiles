local status_ok, autolist = pcall(require, "autolist")
if not status_ok then
	return
end

autolist.setup({})
