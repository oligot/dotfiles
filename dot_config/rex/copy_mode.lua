-- copy_mode.lua: a stand-in for tmux-style copy mode in Rex, until Rex ships
-- a native one. From https://gist.github.com/catsby/0fd3d65ae905ee645a5e7de89b17b5df
--
-- The action takes the focused pane's text (screen plus scrollback) and opens
-- it read-only in a full-window floating pane running a bare nvim (-u NONE, no
-- plugins or colorscheme), scrolled to the bottom so it matches the pane.
--
--   v / V    start a selection (normal vim motions and / search work)
--   y        any yank (y in visual mode, yy, yiw, ...) copies to the
--            clipboard and closes
--   q        close without copying
--
-- Requirements: nvim with a working clipboard provider (pbcopy on macOS) and
-- the `rex` CLI, both on the PATH of your login shell. Without `rex`,
-- everything still works except focus returning to the original pane.

rex.action{
  name = "copy_mode",
  title = "Copy Mode",
  description = "Open the focused pane's text in nvim to select and copy it.",
  run = function(ctx)
    if not ctx.block_id then error("copy_mode: no focused pane", 0) end

    local r, err = rex.block.call("com.superlogical.terminal", "format",
      { block_id = ctx.block_id, format = "text", trim = true })
    if not r then error(err, 0) end

    local text = r.content:gsub("%s+$", "") .. "\n"
    local path = os.tmpname()
    local f = assert(io.open(path, "w"))
    f:write(text)
    f:close()

    local vim_cmds = table.concat({
      "set clipboard=unnamedplus nomodifiable readonly",
      "nnoremap <silent> q :qa!<CR>",
      "execute 'normal! Gzb'",
      "autocmd TextYankPost * call timer_start(0, {-> execute('qa!')})",
    }, " | ")

    local layer, err2 = rex.session.new_layer{
      bounds = { 0, 0, 1, 1 },
      focus = true,
      layout = rex.layout.block{
        flavor = "com.superlogical.terminal.shell",
        options = {
          command = {
            "/bin/sh", "-c",
            -- Closing the layer doesn't return focus to the pane it came
            -- from, so focus that pane before the layer goes away.
            [[trap 'rm -f "$1"' EXIT; nvim -u NONE -i NONE -n -c "$2" "$1"; ]]
              .. [[rex focus -s "$4" "$3" >/dev/null 2>&1]],
            "copy_mode", path, vim_cmds, ctx.block_id, ctx.session_id,
          },
        },
      },
    }
    if not layer then
      os.remove(path)
      error(err2, 0)
    end
    return layer
  end,
}
