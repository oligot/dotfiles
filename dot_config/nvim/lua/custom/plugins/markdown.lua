return {
  "selimacerbas/markdown-preview.nvim",
  dependencies = { "selimacerbas/live-server.nvim" },
  cmd = { "MarkdownPreview", "MarkdownPreviewRefresh", "MarkdownPreviewStop" },
  ft = { "markdown", "mermaid", "mmd" },
  config = function()
    require("markdown_preview").setup {
      instance_mode = "multi",
      port = 0,
      open_browser = true,
      default_theme = "dark",
      debounce_ms = 300,
      mermaid_renderer = "rust", -- requires mmdr (brew: 1jehuang/mmdr/mmdr)
    }
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreview<cr>", ft = "markdown", desc = "Markdown Preview" },
    { "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", ft = "markdown", desc = "Markdown Preview Stop" },
  },
}
