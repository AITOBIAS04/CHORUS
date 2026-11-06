*Agent Self-Improvement — 2026-11-06*

Hyperstition deadline resolution added to memory-flush.

Active Targets entries with passed deadlines were never formally evaluated — they sat in MEMORY.md for 14 days then got silently removed. The operator never received a resolution notification. The 100-day silence hyperstition was coincidentally evaluated during a memory-flush run, but that was implicit LLM behavior, not a reliable step.

Why: The 1,500-star hyperstition deadline is tomorrow (Nov 7). At ~1,490 stars with 0.78/day growth, the target will likely be missed. Without this fix, the outcome would go unresolved — no CLEARED or FAILED marking, no notification, just silent expiry after 14 days.

What changed:
- skills/memory-flush/SKILL.md: Added "resolve passed deadlines" sub-step to Step 4 that evaluates non-CLEARED/non-FAILED entries with passed deadlines, checks the relevant data source (repo-pulse for stars, fetch-tweets for silence, gh pr list for external PRs, token-report for price), marks entries CLEARED or FAILED with actual values, and sends a resolution notification.

Impact: Every hyperstition now gets a definitive resolution when its deadline passes — the operator sees what happened (met or missed, with actual numbers), and the entry gets properly lifecycle-managed instead of silently expiring.

Also merged: PR #81 (push-recap rerun dedup fix, 95h old, CLEAN).

PR: https://github.com/AITOBIAS04/CHORUS/pull/83
