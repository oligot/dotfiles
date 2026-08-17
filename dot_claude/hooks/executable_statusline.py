#!/usr/bin/env python3
"""Claude Code status line — shows model, location, context usage, cost and rate limits.

Reads the session JSON from stdin (see `claude` statusLine docs) and prints a
single colorized line. Designed to fail soft: any missing field is skipped.
Uses only widely-supported unicode (no Nerd Font required).
"""

import json
import os
import sys
import time

# ── ANSI helpers ────────────────────────────────────────────────────────────
RESET = "\033[0m"
BOLD = "\033[1m"
DIM = "\033[2m"


def c(code):
    return f"\033[38;5;{code}m"


# 256-color palette
CYAN = c(80)
BLUE = c(75)
GREEN = c(78)
YELLOW = c(221)
ORANGE = c(215)
RED = c(203)
GREY = c(245)
PURPLE = c(176)
SEP = f"{DIM}{c(240)} │ {RESET}"


def color_for_pct(p):
    """Green → yellow → orange → red as a percentage climbs."""
    if p < 50:
        return GREEN
    if p < 75:
        return YELLOW
    if p < 90:
        return ORANGE
    return RED


def bar(pct, width=10):
    """A compact block-style progress bar."""
    filled = int(round(pct / 100 * width))
    filled = max(0, min(width, filled))
    col = color_for_pct(pct)
    return f"{col}{'█' * filled}{DIM}{'░' * (width - filled)}{RESET}"


def human_reset(epoch):
    """Time remaining until a unix epoch, as e.g. '3d8h', '3h12m' or '45m'."""
    if not epoch:
        return ""
    delta = int(epoch - time.time())
    if delta <= 0:
        return "now"
    if delta >= 86400:
        d, h = delta // 86400, (delta % 86400) // 3600
        return f"{d}d{h}h"
    h, m = delta // 3600, (delta % 3600) // 60
    return f"{h}h{m:02d}m" if h else f"{m}m"


def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        return

    segments = []

    # ── Model ────────────────────────────────────────────────────────────────
    model = (data.get("model") or {}).get("display_name")
    if model:
        eff = (data.get("effort") or {}).get("level")
        label = model
        if eff:
            label += f"{DIM}·{eff}{RESET}{BOLD}{PURPLE}"
        segments.append(f"{BOLD}{PURPLE}◆ {label}{RESET}")

    # ── Location (dir + git) ──────────────────────────────────────────────────
    ws = data.get("workspace") or {}
    cwd = ws.get("current_dir") or data.get("cwd") or ""
    dirname = os.path.basename(cwd.rstrip("/")) or cwd
    loc = f"{BLUE}{dirname}{RESET}"
    worktree = data.get("worktree") or {}
    branch = worktree.get("branch") or ws.get("git_worktree")
    if branch:
        loc += f" {GREEN}⎇ {branch}{RESET}"
    segments.append(loc)

    # ── Context window ─────────────────────────────────────────────────────────
    ctx = data.get("context_window") or {}
    used = ctx.get("used_percentage")
    if used is not None:
        tot_in = ctx.get("total_input_tokens", 0) or 0
        tot_out = ctx.get("total_output_tokens", 0) or 0
        ktok = (tot_in + tot_out) / 1000
        col = color_for_pct(used)
        segments.append(
            f"{GREY}ctx{RESET} {bar(used)} {col}{used:.0f}%{RESET} "
            f"{DIM}({ktok:.0f}k){RESET}"
        )

    # ── Line churn ─────────────────────────────────────────────────────────────
    cost = data.get("cost") or {}
    added = cost.get("total_lines_added") or 0
    removed = cost.get("total_lines_removed") or 0
    if added or removed:
        segments.append(f"{GREEN}+{added}{DIM}/{RED}-{removed}{RESET}")

    # ── Rate limits (Pro/Max plans only) ───────────────────────────────────────
    rl = data.get("rate_limits") or {}
    parts = []
    for key, label in (("five_hour", "5h"), ("seven_day", "7d")):
        win = rl.get(key)
        if not win:
            continue
        p = win.get("used_percentage")
        if p is None:
            continue
        col = color_for_pct(p)
        reset = human_reset(win.get("resets_at"))
        txt = f"{GREY}{label}{RESET} {col}{p:.0f}%{RESET}"
        if reset:
            txt += f"{DIM} ↻ {reset}{RESET}"
        parts.append(txt)
    if parts:
        segments.append(" ".join(parts))

    sys.stdout.write(SEP.join(segments))


if __name__ == "__main__":
    main()
