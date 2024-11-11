local status_ok, sqlua = pcall(require, "sqlua")
if not status_ok then
	return
end

sqlua.setup({})
