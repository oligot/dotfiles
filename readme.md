# dotfiles

>  Personal dotfiles, powered by [chezmoi](https://www.chezmoi.io/)

```bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply oligot
```

## Rex

After `chezmoi apply` on a fresh machine:

```bash
nvim --headless "+Lazy! restore" +qa   # installs vim-rex-navigator, which init.lua loads
rex config reload
rex skill setup                        # Claude Code skill + SessionStart hook
defaults write com.superlogical.rex Workspace.animationStyle -string off
defaults write com.superlogical.rex Workspace.inactivePaneFadeMode -string off
```

Theme (merino-dark / merino-light), Settings → Notifications and Settings → Rex Server →
Remote Control (needed by `rex-sessionizer` and the session cycling keys) are set in the app.
