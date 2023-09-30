local M = {}

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	return
end
local masonlsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not masonlsp_status_ok then
	return
end
local fidget_status_ok, fidget = pcall(require, "fidget")
if not fidget_status_ok then
	return
end
local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
	return
end
local lsplines_status_ok, lsplines = pcall(require, "lsp_lines")
if not lsplines_status_ok then
	return
end

local function lsp_keymaps(bufnr)
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local keymap = vim.api.nvim_set_keymap
	local bufkeymap = vim.api.nvim_buf_set_keymap
	local opts = { noremap = true, silent = true }
	keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap("n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap("n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	-- keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.keymap.set("", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	bufkeymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- bufkeymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	bufkeymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- bufkeymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	-- bufkeymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	bufkeymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	bufkeymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	bufkeymap(bufnr, "n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	bufkeymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	bufkeymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	bufkeymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- bufkeymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	bufkeymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

M.on_attach = function(client, bufnr)
	local null_ls_formatting = {
		["bashls"] = true,
		["cssls"] = true,
		-- ["gopls"] = true,
		["jdt.ls"] = true,
		["jsonls"] = true,
		["lemminx"] = true,
		["pylsp"] = true,
		["sqlls"] = true,
		["lua_ls"] = true,
		["volar"] = true,
	}

	if null_ls_formatting[client.name] then
		-- Use null-ls to format the code
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "jdt.ls" then
		-- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
		-- you make during a debug session immediately.
		-- Remove the option if you do not want that.
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end

	if client.name == "gopls" then
		vim.cmd([[
		          augroup LspFormatting
		              autocmd! * <buffer>
		              autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = true })
		          augroup END
		          ]])
	end

	if client.name == "sqlls" then
		local ok, sqls = pcall(require, "sqls")
		if ok then
			sqls.on_attach(client, bufnr)
		end
	end
	if client.name ~= "bashls" and client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

M.get_capabilities = function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if ok then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end
	return capabilities
end

-- Ansible
lspconfig.ansiblels.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- Bash
lspconfig.bashls.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- CSS
lspconfig.cssls.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- Docker Compose
lspconfig.docker_compose_language_service.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- Docker
lspconfig.dockerls.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- Golang
lspconfig.gopls.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- Java
lspconfig.jdtls.setup({
	-- on_attach = M.on_attach,
	-- capabilities = M.get_capabilities(),
	autostart = false,
})

-- JSON
lspconfig.jsonls.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

-- Nix
lspconfig.nil_ls.setup{
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
}

-- Python
lspconfig.pylsp.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- SQL
lspconfig.sqlls.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- Lua
local neodev_ok, neodev = pcall(require, "neodev")
if not neodev_ok then
	return
end
neodev.setup()
lspconfig.lua_ls.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- Vue.js
lspconfig.volar.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

-- Yaml
lspconfig.yamlls.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
	settings = {
		yaml = {
			-- schemaStore = {
			-- 	-- You must disable built-in schemaStore support if you want to use
			-- 	-- this plugin and its advanced options like `ignore`.
			-- 	enable = false,
			-- },
			-- schemas = require('schemastore').yaml.schemas(),
		},
	},
})

-- XML
lspconfig.lemminx.setup({
	on_attach = M.on_attach,
	capabilities = M.get_capabilities(),
})

local function setup()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		virtual_lines = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	local ensure_installed = {
		"ansiblels",
		"bashls",
		"cssls",
		"docker_compose_language_service",
		"dockerls",
		"gopls",
		"jdtls",
		"jsonls",
		"lemminx",
		"pylsp",
		"sqlls",
		"lua_ls",
		"volar",
		"yamlls",
	}

	mason.setup()
	mason_lspconfig.setup({
		ensure_installed = ensure_installed,
	})

	fidget.setup()
	lsplines.setup()
end

setup()

return M
