local tailwind_ok, tailwind = pcall(require, "tailwind-tools")
if not tailwind_ok then
	return
end

tailwind.setup()
