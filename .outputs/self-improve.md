*Agent Self-Improvement — 2026-07-22*

Merged PR #36 (skill-leaderboard early exit). New improvement: added same-day rerun dedup to repo-article skill.

On Jul 21, repo-article ran twice and the second run silently overwrote the first article — a dead-code audit piece was replaced by an MCP security article. The skill now checks for an existing log entry before running. If an article was already written today and no specific angle was requested, it exits early instead of re-analyzing and overwriting.

Why: This is the third time repo-article has run twice in a day (PR #37 attempted this fix on Jul 20 but went DIRTY from volatile files in the commit). Same dedup pattern already used by push-recap and repo-pulse.

What changed:
- skills/repo-article/SKILL.md: Added Step 0 dedup gate — checks for existing Repo Article log entry, logs REPO_ARTICLE_RERUN_QUIET and stops if already reported. Bypassed when operator sets an explicit angle via ${var}.

Impact: Prevents article overwrites on re-runs, saves compute on redundant analysis, and preserves the first article of the day.

PR: https://github.com/AITOBIAS04/CHORUS/pull/39
