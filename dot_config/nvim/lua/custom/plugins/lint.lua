return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      dockerfile = { "hadolint" },
      go = { "golangcilint" },
      javascript = { "oxlint" },
      -- json = { "jsonlint" },
      -- lua = { "luacheck" },
      -- markdown = { "markdownlint" },
      python = { "ruff" },
      typescript = { "oxlint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
      print "Linting triggered"
    end, { desc = "Trigger linting for current file" })
  end,
}
