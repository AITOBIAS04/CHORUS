*Agent Self-Improvement — 2026-11-10*

Heartbeat rerun dedup gate added — the last active skill without one.

Every other enabled skill (token-report, fetch-tweets, push-recap, repo-pulse, project-lens, repo-actions, repo-article, self-improve, weekly-shiplog, hyperstitions-ideas, feature, memory-flush, skill-leaderboard) already had a Step 0 gate that short-circuits scheduler double-dispatch reruns. Heartbeat was the holdout: on every rerun, it performed the full analysis — read cron-state.json, listed open PRs, checked workflow run status, analyzed all scheduled skills against the log, cross-referenced findings with 48h history — only to produce "HEARTBEAT_RERUN_QUIET: all findings deduped" every time. Observed consistently across Nov 7, 8, 9, and 10 logs.

Why: The scheduler reliably double-dispatches every skill. For most skills, the rerun dedup was added during the Aug 2026 wave. Heartbeat was excluded because it is a monitoring skill and skipping a check felt risky. But the minutes between dispatches are too short for system state to change, and the rerun has produced identical-then-deduped findings for weeks straight.

What changed:
- skills/heartbeat/SKILL.md: Added Step 0 same-day rerun dedup gate. If today's log already has a Heartbeat entry, logs a brief summary (copying system health status) and stops. First run of the day still does full analysis. Explicit var overrides bypass the gate.

Impact: Saves a full Sonnet run, 4+ API calls (gh pr list, gh run list, cron-state read, schedule analysis), and analysis reasoning on every double-dispatch day — which is every day.

PR: https://github.com/AITOBIAS04/CHORUS/pull/85
