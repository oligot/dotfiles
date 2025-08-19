return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    -- "SmiteshP/nvim-navic",
  },
  config = function()
    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "catppuccin-frappe",
        globalstatus = true,
      },
      sections = {
        lualine_c = {
          { "filename", path = 3 },
          -- { "navic" },
        },
      },
    }
  end,
}
