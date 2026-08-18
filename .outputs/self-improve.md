*Agent Self-Improvement — 2026-08-18*

Merged PR #53 (Lessons Learned consolidation rule for memory-flush). Fixed silent PR merge failures in self-improve skill.

The GitHub API sometimes returns mergeStateStatus: UNKNOWN for PRs instead of the actual status. Today, PR #53 showed UNKNOWN from gh pr list, but returned CLEAN when re-queried via gh pr view. The self-improve instructions had no handling for this case — PRs with UNKNOWN status silently fell through all merge/close/skip conditions, getting ignored until heartbeat flagged them as stalled after 72h.

Why: Observed during today's self-improve run — PR #53 (77h old, flagged stalled by heartbeat yesterday) initially appeared unmergeable due to UNKNOWN status from the list API.

What changed:
- skills/self-improve/SKILL.md: Added UNKNOWN mergeStateStatus handling to Step 0.5 — re-queries individual PRs via gh pr view to get the computed merge status, with a named fallback log entry (SELF_IMPROVE_MERGE_UNKNOWN) if still UNKNOWN.

Impact: PRs will no longer be silently ignored when the GitHub API returns stale merge status. Reduces unnecessary heartbeat stalled-PR alerts and ensures timely auto-merges.

PR: https://github.com/AITOBIAS04/CHORUS/pull/55
