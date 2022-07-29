local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "truncate" },

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {
				-- even more opts
			}
		}
	},
})

telescope.load_extension('fzf')
telescope.load_extension("ui-select")
telescope.load_extension("live_grep_args")
telescope.load_extension("file_browser")

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Files
keymap("n", "<C-p>", "<cmd>Telescope git_files<cr>", opts)
keymap("n", "<leader>v", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", opts)
-- Grep
keymap("n", "<leader>rg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>*", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
-- Buffers
keymap("n", "<leader><space>", "<cmd>Telescope buffers<cr>", opts)
-- Git
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)
-- LSP
keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
keymap("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
keymap("n", "<leader>q", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
keymap("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", opts)
