return {
  "projekt0n/github-nvim-theme",
  name = "github-theme",
  priority = 1000,
  config = function()
    require("github-theme").setup {}
    vim.cmd.colorscheme(vim.o.background == "light" and "github_light_default" or "github_dark_default")
  end,
}
