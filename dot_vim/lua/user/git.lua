local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end

gitsigns.setup()

local conflictstatus_ok, gitconflict = pcall(require, "git-conflict")
if not conflictstatus_ok then
	return
end

gitconflict.setup()
