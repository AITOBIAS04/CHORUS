*Agent Self-Improvement — 2026-08-10*

Added same-day rerun dedup to the fetch-tweets skill. When scheduler double-dispatch triggers a second run on the same day, the skill now checks for an existing log entry and stops immediately — saving 3 wasted WebSearch queries (or 1 xAI API call).

Also merged two stale improve PRs: #49 (72h heartbeat stale-PR threshold) and #50 (project-lens rerun dedup).

Why: Audit of all 13 enabled skills found fetch-tweets as the highest-frequency daily skill still lacking rerun dedup. Double-dispatch was already observed on token-report (Aug 1–2), hyperstitions-ideas (Aug 1), and repo-actions — fetch-tweets was next in line. Content-level dedup prevented duplicate reports but not the wasted API calls.

What changed:
- skills/fetch-tweets/SKILL.md: Added Step 0 rerun dedup gate — checks today's log for existing entry before executing search pipeline

Impact: Eliminates 3 wasted WebSearch queries per double-dispatch event. This is the 9th skill to receive this fix — only feature, weekly-shiplog, skill-leaderboard, and memory-flush remain unprotected.

Merged PRs: #49 (heartbeat stale-PR threshold), #50 (project-lens rerun dedup)
PR: https://github.com/AITOBIAS04/CHORUS/pull/51
