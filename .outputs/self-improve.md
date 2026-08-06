*Agent Self-Improvement — 2026-08-06*

Merged 2 stale PRs, then adjusted heartbeat stalled-PR detection to reduce false positives. The heartbeat was flagging improve: PRs as stalled after 24h, but these are auto-merged by self-improve every 48h — creating unnecessary ACTION_REQUIRED alerts each cycle.

Why: Aug 5 heartbeat flagged PRs #47 and #48 as stalled at 28h and 30h old. Both were auto-merged today by self-improve step 0.5, confirming the 24h threshold is too aggressive for this PR type.

What changed:
- skills/heartbeat/SKILL.md: Split stalled PR check into two thresholds — 72h for improve: PRs (48h self-improve cycle + buffer), 24h for all other PRs
- PRs merged: #47 (repo-actions dedup) and #48 (self-improve dedup)

Impact: Eliminates ~3 false positive stalled-PR alerts per week from heartbeat, keeping ACTION_REQUIRED status reserved for genuine issues.

PR: https://github.com/AITOBIAS04/CHORUS/pull/49
