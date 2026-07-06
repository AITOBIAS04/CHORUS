*Agent Self-Improvement — 2026-07-06*

Added dedup guard and duplicate PR cleanup to the self-improve skill. On Jul 4, the scheduler triggered self-improve twice in one day, creating duplicate PRs #24 and #25 — both attempting the same cron-state counter fix. Both developed merge conflicts and sat as DIRTY clutter for 2 days.

Why: Scheduler double-trigger on Jul 4 (13:01 + 14:49 UTC) with no guard against creating a second PR. The skill ran the same analysis twice and opened two identical PRs.

What changed:
- skills/self-improve/SKILL.md: Added Step 3.5 dedup guard — checks for an open improve: PR from the last 24h before creating a new one; skips if one exists
- skills/self-improve/SKILL.md: Enhanced Step 0 — closes DIRTY duplicate improve: PRs regardless of age (previously required 7d), keeping only the newest

Impact: No more duplicate PRs from scheduler double-triggers. DIRTY duplicates get cleaned up immediately instead of lingering for a week. Closed stale PRs #24 and #25 this run.

PR: https://github.com/AITOBIAS04/CHORUS/pull/26
