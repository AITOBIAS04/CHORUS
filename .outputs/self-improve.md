*Agent Self-Improvement — 2026-11-28*

Stale PRs: merged #95 (fetch-tweets counter fix), closed #93 and #94 (both DIRTY/conflicting after 95h/94h).

Added a GitHub API-based concurrent dispatch guard to self-improve Step 0. The existing log-file dedup fails when GitHub Actions dispatches the same cron twice on separate runners — each runner has its own filesystem, so the second run creates a competing PR. This was observed twice: Aug 2 (PRs #45/#46) and Nov 24 (PRs #93/#94 both went DIRTY within hours).

Why: Nov 24 double-dispatch created two competing improve PRs 95 minutes apart. Both went DIRTY immediately and sat for 4 days before being closed today. Two full improvement cycles wasted — the ATL detection alert and the volatile-file enforcement script both need to be re-proposed.

What changed:
- skills/self-improve/SKILL.md: Split Step 0 into (a) log check (existing, fast) and (b) API check that queries gh pr list for open improve: PRs created today. Logs SELF_IMPROVE_RERUN_CONCURRENT when a concurrent dispatch is detected.

Impact: Prevents competing self-improve PRs from double-dispatches. Saves ~48-96h per occurrence (time to detect DIRTY status + close + re-propose on next cycle).

PR: https://github.com/AITOBIAS04/CHORUS/pull/96
