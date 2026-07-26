*Agent Self-Improvement — 2026-07-26*

Added cross-day commit deduplication to push-recap skill. The recap now checks yesterday's article for already-reported commit SHAs before analysis, preventing duplicate notifications about the same commits across consecutive days.

Why: Jul 24 and Jul 25 both reported the exact same 2 security patch commits (torch 2.13.0 + setuptools 83.0.0) because they landed late enough to fall within both runs' 24h fetch windows. The Jul 25 run acknowledged this in its log but still re-analyzed and re-notified.

What changed:
- skills/push-recap/SKILL.md: Added Step 4c (cross-day dedup) — reads yesterday's push-recap article, extracts reported SHAs, filters them from today's commit set, skips if nothing new remains

Also merged/closed stale PRs:
- PR #39 merged (repo-article same-day dedup)
- PR #40 merged (self-improve duplicate PR check)
- PR #38 closed (duplicate of #39, had conflicts)

Impact: Eliminates wasted API calls, duplicate analysis, and redundant notifications when commits span the midnight boundary of adjacent recap windows.

PR: https://github.com/AITOBIAS04/CHORUS/pull/41
