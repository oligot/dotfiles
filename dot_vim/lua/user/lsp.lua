local M = {}

local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local function lsp_keymaps(bufnr)
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local keymap = vim.api.nvim_set_keymap
	local bufkeymap = vim.api.nvim_buf_set_keymap
	local opts = { noremap = true, silent = true }
	keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	-- keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

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
	bufkeymap(
		bufnr,
		"n",
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
	bufkeymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	bufkeymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	bufkeymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- bufkeymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	bufkeymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
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
		["gopls"] = true,
		["jdt.ls"] = true,
		["jsonls"] = true,
		["sqls" ]= true,
		["volar"] = true,
	}

	if null_ls_formatting[client.name] then
		-- Use null-ls to format the code
		client.resolved_capabilities.document_formatting = false
	end

  if client.name == "jdt.ls" then
		-- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
		-- you make during a debug session immediately.
		-- Remove the option if you do not want that.
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
  end

	if client.name == "gopls" then
		vim.cmd([[
		          augroup LspFormatting
		              autocmd! * <buffer>
		              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
		          augroup END
		          ]])
	end

	if client.name == "sqls" then
		local ok, sqls = pcall(require, "sqls")
		if ok then
			sqls.on_attach(client, bufnr)
		end
	end

	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local enhance_server_opts = {
	-- Provide settings that should only apply to the "jsonls" server
	["jsonls"] = function(opts)
		opts.settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		}
	end,
	-- Provide settings that should only apply to the "sumneko_lua" server
	["sumneko_lua"] = function(opts)
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		}
	end,
	-- Provide settings that should only apply to the "jdtls" server
	["jdtls"] = function(opts)
		opts.autostart = false
	end,
}

lsp_installer.on_server_ready(function(server)
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if ok then
		capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
	end

	-- Specify the default options which we'll use to setup all servers
	local opts = {
		on_attach = M.on_attach,
		capabilities = capabilities,
	}

	if enhance_server_opts[server.name] then
		-- Enhance the default opts with the server-specific ones
		enhance_server_opts[server.name](opts)
	end

	server:setup(opts)
end)

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

	-- Automatically install LSP servers
	local servers = {
		"bashls",
		"gopls",
		-- "jdtls",
		"jsonls",
		"pylsp",
		"sqls",
		"sumneko_lua",
		"volar",
	}

	for _, name in pairs(servers) do
		local server_is_found, server = lsp_installer.get_server(name)
		if server_is_found and not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end

setup()

return M
