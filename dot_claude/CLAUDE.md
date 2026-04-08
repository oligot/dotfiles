## Environment & Tooling Rules

**Native Tools Preference:**
You should default to your built-in tools (`Read`, `Grep`, `Glob`) for standard file operations, as they provide the best UX and permission visibility.

**Bash Execution Constraints:**
WHEN you must use the `Bash` tool for terminal operations, system commands, or complex scripting, you MUST strictly adhere to these overrides. Standard POSIX utilities are disabled or suboptimal in this environment.

- **Text Search in Bash:** ALWAYS use `rg <query>` (ripgrep) instead of `grep`.
- **Structural Code Search:** ALWAYS use `ast-grep -p '<pattern>'` (or `sg`) instead of complex regex.
- **Finding Files in Bash:** ALWAYS use `fd <pattern>` instead of `find`.
- **Reading Files in Bash:** NEVER use `cat`. ALWAYS use `bat --style=plain --line-range START:END <file>`.

@RTK.md
