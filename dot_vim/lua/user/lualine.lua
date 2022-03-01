local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local status_gps_ok, gps = pcall(require, "nvim-gps")
if not status_gps_ok then
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
			'filename',
			{ gps.get_location, cond = gps.is_available },
		},
	},
})

gps.setup()
