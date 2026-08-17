return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- master is frozen and unsupported on Neovim 0.12+
  -- Pinned: main is a rolling, archived project. Unpinned, every :Lazy sync
  -- rebuilt some parsers and not others, drifting parsers out of lockstep with
  -- their queries ("Impossible pattern" crashes). Bump deliberately, then
  -- re-run :TSUpdate in the same step so parser + query stay a matched set.
  commit = "4916d6592ede8c07973490d9322f187e07dfefac",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- main branch has no configs.setup/opts; install parsers explicitly…
    require("nvim-treesitter").install({
      "bash",
      "diff",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "vim",
      "vimdoc",
    })

    -- …and start highlighting per buffer (no-op if the parser isn't ready).
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
      end,
    })
  end,
}
