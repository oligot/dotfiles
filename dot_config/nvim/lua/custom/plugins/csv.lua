return {
  "hat0uma/csvview.nvim",
  ft = { "csv", "tsv" },
  opts = {
    parser = {
      comments = { "#" },
    },
    view = {
      display_mode = "highlight",
    },
  },
  keys = {
    { "<leader>ct", "<cmd>CsvViewToggle<cr>", ft = { "csv", "tsv" }, desc = "Toggle CSV view" },
  },
}
