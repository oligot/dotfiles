return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },

  version = "1.*",
  opts = {
    keymap = { preset = "default" },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = { documentation = { auto_show = true } },

    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
