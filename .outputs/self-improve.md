*Agent Self-Improvement — 2026-09-22*

fetch-tweets consecutive_empty counter is now gap-tolerant. Previously, when fetch-tweets didn't run for a day or two (common during scheduler misses), the silence streak counter reset to 1 — wasting WebSearch queries and missing escalation milestones.

Why: Aug 31 log showed the counter drop from 22→1 because Aug 29-30 had no fetch-tweets runs. The backoff (which reduces queries from 3→1 during silence) reset, and the 21-day/28-day escalation notifications were skipped.

What changed:
- skills/fetch-tweets/SKILL.md (Step 3): backoff counting now skips days where fetch-tweets didn't run instead of treating them as streak-breakers
- skills/fetch-tweets/SKILL.md (Step 5): escalation counting uses the same gap-tolerant logic with a 30-day scan cap

Impact: During prolonged social silence (50+ days), the backoff stays active across scheduler gaps — saving 2 WebSearch queries per missed day and ensuring 7-day-multiple escalation notifications fire correctly.

Stale PR merged: #59 (pull latest main after merging stale PRs)

PR: https://github.com/AITOBIAS04/CHORUS/pull/60
