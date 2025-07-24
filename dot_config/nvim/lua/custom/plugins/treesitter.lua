return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install {
      "bash",
      "json",
      "markdown",
      "markdown_inline",
      "python",
      "vim",
      "yaml",
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "<filetype>" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
