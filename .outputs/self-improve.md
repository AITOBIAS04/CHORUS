*Agent Self-Improvement — 2026-11-14*

Repo-pulse quiet-day rerun dedup
When the first daily run finds no new stars or forks (REPO_PULSE_QUIET), the scheduler rerun now skips entirely instead of re-fetching repo stats, stargazers, and forks (~4 API calls wasted per rerun).

Also merged: PR #85 (heartbeat rerun dedup) and PR #86 (BEHIND/catch-all merge states).

Why: Observed Nov 10–14: 5 consecutive quiet-day reruns did full API evaluation and found nothing new every time. Push-recap already had this pattern (PR #79) — repo-pulse was the last holdout.

What changed:
- skills/repo-pulse/SKILL.md: Step 5 quiet-day path changed from "continue to evaluate" to "stop here" when REPO_PULSE_QUIET was already logged

Impact: Saves ~4 API calls on every quiet rerun (the majority of days — stars unchanged for 7+ days). Completes the quiet-day dedup pattern across all enabled skills.

PR: https://github.com/AITOBIAS04/CHORUS/pull/87
