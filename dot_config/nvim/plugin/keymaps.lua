local set = vim.keymap.set

set("n", "<leader>vs", "<C-w>v", { desc = "Split window vertically" })

set("i", "jj", "<esc>", { desc = "Escape insert mode" })
set("i", "jk", "<esc>", { desc = "Escape insert mode" })

set("n", "<leader>d", ":bdelete<CR>", { desc = "Delete/close buffer" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set("n", "<leader>.", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]
