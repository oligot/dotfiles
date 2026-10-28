return {
  {
    "selimacerbas/mdkite.nvim",
    dependencies = { "selimacerbas/kitehost.nvim" },
    cmd = "MdKite",
    ft = { "markdown", "mermaid", "mmd" },
    config = function()
      require("mdkite").setup {
        instance_mode = "multi",
        port = 0,
        open_browser = true,
        default_theme = "dark",
        debounce_ms = 300,
        mermaid_renderer = "rust", -- requires mmdr (brew: 1jehuang/mmdr/mmdr)
      }
    end,
    keys = {
      { "<leader>mp", "<cmd>MdKite start<cr>", ft = "markdown", desc = "Markdown Preview" },
      { "<leader>ms", "<cmd>MdKite stop<cr>", ft = "markdown", desc = "Markdown Preview Stop" },
    },
  },
  {
    "bngarren/checkmate.nvim",
    ft = "markdown",
    opts = { files = { "*.md" } },
  },
}
