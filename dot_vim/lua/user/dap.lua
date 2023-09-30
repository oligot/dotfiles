local dap = require("dap")

local dapui = require('dapui')
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local dapvt = require("nvim-dap-virtual-text")
dapvt.setup()

local status_ok, dapgo = pcall(require, 'dap-go')
if status_ok then
  dapgo.setup()
end

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<F4>", "<Cmd>lua require'dap'.terminate()<CR>", opts)
keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<Leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<Leader>B", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<Leader>lp", "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
keymap("n", "<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
keymap("n", "<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)
keymap("n", "<leader>E", "<Cmd>lua require('dapui').eval()<CR>", opts)
keymap("n", "<leader>td", "<Cmd>lua require('dap-go').debug_test()<CR>", opts)
