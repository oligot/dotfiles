local status_ok, gitlab = pcall(require, "gitlab")
if not status_ok then
	return
end

gitlab.setup()
