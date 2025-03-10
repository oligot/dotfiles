require("diffview") -- We require some global state from diffview
local status_ok, gitlab = pcall(require, "gitlab")
if not status_ok then
	return
end

gitlab.setup()

vim.keymap.set("n", "glb", gitlab.choose_merge_request)
vim.keymap.set("n", "glr", gitlab.review)
vim.keymap.set("n", "gls", gitlab.summary)
vim.keymap.set("n", "glA", gitlab.approve)
vim.keymap.set("n", "glR", gitlab.revoke)
vim.keymap.set("n", "glc", gitlab.create_comment)
vim.keymap.set("v", "glc", gitlab.create_multiline_comment)
vim.keymap.set("v", "glC", gitlab.create_comment_suggestion)
vim.keymap.set("n", "glO", gitlab.create_mr)
vim.keymap.set("n", "glm", gitlab.move_to_discussion_tree_from_diagnostic)
vim.keymap.set("n", "gln", gitlab.create_note)
vim.keymap.set("n", "gld", gitlab.toggle_discussions)
vim.keymap.set("n", "glaa", gitlab.add_assignee)
vim.keymap.set("n", "glad", gitlab.delete_assignee)
vim.keymap.set("n", "glla", gitlab.add_label)
vim.keymap.set("n", "glld", gitlab.delete_label)
vim.keymap.set("n", "glra", gitlab.add_reviewer)
vim.keymap.set("n", "glrd", gitlab.delete_reviewer)
vim.keymap.set("n", "glp", gitlab.pipeline)
vim.keymap.set("n", "glo", gitlab.open_in_browser)
vim.keymap.set("n", "glM", gitlab.merge)
vim.keymap.set("n", "glu", gitlab.copy_mr_url)
vim.keymap.set("n", "glP", gitlab.publish_all_drafts)
vim.keymap.set("n", "glD", gitlab.toggle_draft_mode)
