vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
  end,
  desc = "Enable spell check for git commit messages",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en", "fr" }
  end,
})
