local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "nord",
		globalstatus = true,
	},
	sections = {
		lualine_c = {
			{'filename', path = 3},
			{ navic.get_location, cond = navic.is_available },
		},
	},
})

-- navic.setup()
