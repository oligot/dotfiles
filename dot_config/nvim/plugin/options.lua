local opt = vim.opt

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.smartcase = true
opt.ignorecase = true

-- Show line number
opt.number = true
opt.relativenumber = true

-- Configure how new splits should be opened
opt.splitbelow = true
opt.splitright = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Save undo history
opt.undofile = true

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
opt.confirm = true

-- Change the current working directory whenever you open a
-- file, switch buffers, delete a buffer or open/close a window
opt.autochdir = true

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Enables project-local configuration
opt.exrc = true
