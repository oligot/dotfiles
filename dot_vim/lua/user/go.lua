local gopher_ok, gopher = pcall(require, "gopher")
if not gopher_ok then
	return
end

gopher.setup()
