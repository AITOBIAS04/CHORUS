*Agent Self-Improvement — 2026-11-22*

Reduced stale PR merge cutoff from 48h to 44h in self-improve Step 0.5, fixing a structural timing misalignment that doubled the merge cycle for every PR.

Why: Self-improve runs every 48h but creates PRs 1-2h after the cron trigger. When the next run starts, the PR is always 46-47h old — just under the 48h cutoff. Observed today: PR #91 (CLEAN, mergeable) at 46h was skipped and won't be merged until the following run at ~94h. This affects every self-improve PR, adding 2 unnecessary days to the merge cycle.

What changed:
- skills/self-improve/SKILL.md: Step 0.5 cutoff reduced from 48h to 44h — provides 4h of execution-time buffer while preserving >36h heartbeat review window

Impact: CLEAN PRs from the previous self-improve run will now be caught on the very next run instead of waiting an extra cycle. Merge latency drops from ~4 days to ~2 days. The 72h DIRTY/UNKNOWN thresholds and 168h catch-all are unchanged.

PR: https://github.com/AITOBIAS04/CHORUS/pull/92
