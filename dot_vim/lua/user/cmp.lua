local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local lspkind_ok, lspkind = pcall(require, "lspkind")
if not lspkind_ok then
  return
end

lspkind.init()

require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
	mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),

    ["<c-space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },

    ["<tab>"] = cmp.config.disable,

    -- Testing
    ["<c-q>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    --  First you have to just promise to read `:help ins-completion`.
  },
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 5 },
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	formatting = {
		-- fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        luasnip = "[Snip]",
      },
    },
	},
	-- confirm_opts = {
	-- 	behavior = cmp.ConfirmBehavior.Replace,
	-- 	select = false,
	-- },
	-- window = {
	-- 	documentation = {
	-- 		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	-- 	},
	-- },
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

-- Add vim-dadbod-completion in sql files
_ = vim.cmd [[
  augroup DadbodSql
    au!
    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
  augroup END
]]
