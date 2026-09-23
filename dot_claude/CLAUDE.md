@RTK.md

# ast-grep

**Usage**: Use `ast-grep` (aka `sg`) for structural code search and rewriting based on AST patterns instead of regex. Prefer it over grep/ripgrep when searching for specific code structures (function calls, imports, class definitions, etc.) where regex would be fragile.

## When to use ast-grep vs Grep

- **Use ast-grep** for: finding specific function calls, matching code patterns with wildcards (`$$$`), refactoring structural patterns, language-aware searches
- **Use Grep** for: simple string/keyword searches, searching across all file types, non-code files

## Common patterns

```bash
# Find function calls
sg -p 'console.log($$$)' -l js

# Find imports
sg -p 'import $_ from "$_"' -l js

# Find React component usage
sg -p '<Button $$$>$$$</Button>' -l tsx

# Find Python function definitions
sg -p 'def $FUNC($$$):' -l python

# Structural replace (--rewrite)
sg -p 'console.log($$$)' -r 'logger.debug($$$)' -l js

# Interactive review of replacements
sg -p 'OLD_PATTERN' -r 'NEW_PATTERN' -l LANG --interactive
```

## Key flags

- `-p` pattern, `-r` rewrite replacement, `-l` language
- `$_` matches single AST node, `$$$` matches zero or more nodes
- `$NAME` captures a named metavariable (reusable in `-r`)
- `--json` for structured output

# Git worktrees

For creating a git worktree, always use the `user-skills:create-worktree` skill. Never use `superpowers:using-git-worktrees` (it is disabled via `skillOverrides` in settings.json).

# Implementation plans

Every plan written to `docs/superpowers/plans/` includes an `## Execution Model`
section right after the header, before the tasks. It has:

- a legend: 🤖 Subagent (file edits, local validation, commits, no live-system
  access) · 👤 Human · 🚧 Manual gate (hard stop, next task waits until it clears)
- a `**Progress: N / M tasks done (P%).**` line
- a table `| Task | Status | What | Executor |` with one row per task, Status
  ⬜/✅, Executor 🤖, 👤, 👤 🚧, or "Mixed — Steps a–b 🤖 · Step c 👤 🚧"
- the branch and worktree the work happens on
- a "How to run this plan" paragraph: Pass 1 lists the 🤖 work, Pass 2 the
  human steps in order, plus hard orderings between them

Update the Status column and the Progress line as tasks complete. Never commit
spec or plan files.
