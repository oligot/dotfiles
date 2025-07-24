return {
  "olimorris/codecompanion.nvim",
  -- "yetone/avante.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "codecompanion" },
    },
  },
}
