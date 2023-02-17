#!/usr/bin/env bash

# https://sharats.me/posts/shell-script-best-practices/
set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

base=$(basename "$1")
wtdir=$(echo "$base" | tr "[:upper:]" "[:lower:]")

echo "Adding worktree $wtdir"
git worktree add "$wtdir" "$1"
