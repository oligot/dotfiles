local configs = require("nvim-treesitter.configs")

configs.setup({
	ensure_installed = {
		"bash",
		"css",
		"csv",
		"diff",
		-- "dockerfile",
		-- "editorconfig",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"go",
		"gomod",
		"gosum",
		-- "gotmpl",
		"gowork",
		"html",
		"hurl",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"sql",
		"typescript",
		"vhs",
		"vim",
		"vue",
		"yaml",
	},
	sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "yaml" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
})
