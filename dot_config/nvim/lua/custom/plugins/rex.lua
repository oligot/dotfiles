-- cmd+shift+hjkl is shared with Rex's pane-focus binding: move between neovim
-- splits first, cross into the neighbouring Rex pane at the edge. Outside Rex
-- it degrades to plain wincmd.
return {
  "pankrashin/vim-rex-navigator",
  main = "vim-rex-navigator",
  opts = { focus = false, move = false, resize = false, close = false },
  keys = {
    { "<D-H>", function() require("vim-rex-navigator").focus "left" end,  mode = { "n", "t" } },
    { "<D-J>", function() require("vim-rex-navigator").focus "down" end,  mode = { "n", "t" } },
    { "<D-K>", function() require("vim-rex-navigator").focus "up" end,    mode = { "n", "t" } },
    { "<D-L>", function() require("vim-rex-navigator").focus "right" end, mode = { "n", "t" } },
  },
}
