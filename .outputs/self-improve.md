*Agent Self-Improvement — 2026-07-16*

Stale PR cleanup: merged PR #31 (fetch-tweets freshness gate), closed PRs #27 and #28 (both had merge conflicts, superseded).

Fixed the repo-article scheduling bug — the cron expression used AND semantics between day-of-month (*/2) and day-of-week (0,2,4,6), which halved article output from ~4 runs/week to ~2. Removed the day-of-month constraint so only the day-of-week field controls scheduling.

Why: PR #28 identified this exact bug on Jul 8 but went stale from merge conflicts (cron-generated files were included in the diff). The fix never landed. Re-applied with targeted staging.

What changed:
- aeon.yml: repo-article schedule from '0 16 */2 * 0,2,4,6' to '0 16 * * 0,2,4,6'

Impact: repo-article now fires on all 4 intended days (Sun/Tue/Thu/Sat) instead of only the subset that also falls on even-numbered days of the month. Doubles content output frequency.

PR: https://github.com/AITOBIAS04/CHORUS/pull/32
