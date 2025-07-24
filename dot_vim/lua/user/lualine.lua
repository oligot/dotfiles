local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "nord",
    globalstatus = true,
  },
  sections = {
    lualine_c = {
      { "filename", path = 3 },
      -- { "navic" },
    },
  },
}
