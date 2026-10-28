-- Rex config.
package.path = os.getenv("HOME") .. "/.local/share/nvim/lazy/vim-rex-navigator/rex/?.lua;" .. package.path
local keys = { left = "cmd+shift+h", down = "cmd+shift+j", up = "cmd+shift+k", right = "cmd+shift+l" }
local ok, nav = pcall(require, "vim-rex-navigator")
if ok then
  nav.setup {
    focus_left = keys.left, focus_down = keys.down, focus_up = keys.up, focus_right = keys.right,
    focus_wrap = true,
    move = false, resize = false, close = false,
  }
  -- The plugin swallows the chord while a pane is zoomed. Rex's own focus
  -- unzooms and moves, so do that; otherwise fall through to the plugin.
  -- ponytail: a zoomed nvim loses split navigation, unzoom first if that bites.
  for dir, key in pairs(keys) do
    rex.bind(key, function()
      local view = rex.session.view({})
      for _, w in ipairs(view.windows) do
        if w.window_id == view.active_window_id and w.zoomed_block_id then
          rex.session.focus_direction({ direction = dir, wrap = true })
          return true
        end
      end
      return false
    end)
  end
else
  rex.log("warn", "vim-rex-navigator not installed, pane focus keys skipped")
end

-- Cycle sessions like tmux prefix+( / ). Needs Settings → Rex Server → Remote Control.
rex.bind("cmd+shift+p", "session.previous")
rex.bind("cmd+shift+n", "session.next")

-- Jump straight to the Nth session. Rex matches key names through the keyboard
-- layout and only on unshifted keys, so "cmd+2" can never fire on AZERTY (2 needs
-- shift). [DigitN] names the physical key of the digit row instead.
-- Asks the app through client.perform, which needs Remote Control on.
local function app_client()
  for _, c in ipairs(rex.call("client.list", {}).clients) do
    if c.info and c.info.kind == "app" then return c.client_id end
  end
end
local function goto_session(i)
  local s = rex.call("session.list", {}).sessions[i]
  local app = app_client()
  if s and app then
    rex.call("client.perform", { client_id = app, action = "session.select", args = { session_id = s.session_id } })
  end
  return true
end
for i = 1, 9 do
  rex.bind("cmd+[Digit" .. i .. "]", function() return goto_session(i) end)
end

-- Keyboard copy mode (tmux prefix+[) until Rex ships a native one:
-- opens the pane text in nvim, y copies to the clipboard and closes, q quits.
-- cmd+shift+y: unshifted key so it works on AZERTY (see the Digit note above).
require("copy_mode")
rex.bind("cmd+shift+y", "copy_mode")

-- Project picker (tmux-sessionizer) in a small centered float. cmd+shift+t:
-- unshifted key for AZERTY. fzf picks a ~/src project, rex-sessionizer opens
-- or switches to its session, the float closes when the script exits.
rex.action{
  name = "sessionizer",
  title = "Open Project",
  description = "Pick a project under ~/src and open or switch to its session.",
  run = function()
    return rex.session.new_layer{
      bounds = { 0.2, 0.25, 0.6, 0.5 },
      focus = true,
      layout = rex.layout.block{
        flavor = "com.superlogical.terminal.shell",
        -- Interactive zsh so .zshrc sets PATH (rex, fzf, jq via mise, zoxide).
        options = { command = { "/bin/zsh", "-ic", "rex-sessionizer" } },
      },
    }
  end,
}
rex.bind("cmd+shift+t", "sessionizer")
