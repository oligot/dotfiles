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
