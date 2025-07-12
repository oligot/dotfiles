local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#code-actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		-- formatting.goimports,
		formatting.google_java_format,
		formatting.ktlint,
		formatting.nixpkgs_fmt,
		formatting.pg_format,
		formatting.prettier,
		formatting.shfmt,
		formatting.stylua,
		-- formatting.xmllint, TODO: Utiliser https://github.com/eclipse/lemminx à la place
		-- diagnostics
		diagnostics.golangci_lint.with({
			args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" },
		}),
		diagnostics.hadolint,
		diagnostics.ktlint,
		-- diagnostics.vale,
		diagnostics.yamllint,
		-- code actions
		code_actions.gitsigns,
	},
})
