-- Rex port of vim-tmux-runner, with its <leader> maps.
return {
  "oligot/rex-runner.nvim",
  cond = vim.env.REX_BLOCK ~= nil,
  opts = { default_maps = true },
}
