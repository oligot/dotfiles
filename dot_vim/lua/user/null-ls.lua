local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		-- formatting
		formatting.black,
		formatting.goimports,
		formatting.google_java_format,
		formatting.ktlint,
		formatting.pg_format,
		formatting.prettier,
		formatting.shfmt,
		formatting.stylua,
		formatting.xmllint,
		-- diagnostics
		diagnostics.golangci_lint.with({
			args = { "run", "--fix=false", "--out-format=json", "$DIRNAME", "--path-prefix", "$ROOT" },
		}),
		diagnostics.ktlint,
		diagnostics.vale,
		diagnostics.yamllint,
		-- code actions
		code_actions.gitsigns,
	},
})
