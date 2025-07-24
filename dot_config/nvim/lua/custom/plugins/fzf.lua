return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require "fzf-lua"
    fzf.setup { "telescope", winopts = { preview = { default = "bat" } } }

    local set = vim.keymap.set
    set("n", "<C-p>", fzf.git_files, {})
    set("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp" })
    set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
    set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
    set("n", "<leader>rg", fzf.live_grep_native, { desc = "[R]ip [G]rep" })
    set("n", "<leader>sd", fzf.diagnostics_document, { desc = "[S]earch [D]iagnostics" })
    set("n", "<leader>s.", fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    set("n", "<leader><leader>", fzf.buffers, { desc = "[ ] Find existing buffers" })
    set("n", "<leader>sn", function()
      fzf.files { cwd = vim.fn.stdpath "config" }
    end, { desc = "[S]earch [N]eovim files" })
  end,
}
