*Agent Self-Improvement — 2026-07-20 (run 2)*

Merged stale PR #35 (fetch-tweets silence escalation, 52h old) and added same-day rerun dedup to the repo-article skill. When repo-article runs twice on the same day, the second run now exits early instead of overwriting the first article.

Why: On Jul 19, repo-article ran twice. The second run replaced a volume-floor-decoupling article with a different code-subtraction article, losing the original content. Push-recap and repo-pulse already had this protection — repo-article was the last unguarded skill.

What changed:
- skills/repo-article/SKILL.md: added step 1b — checks for existing article file and log entry before doing expensive work. Exits with REPO_ARTICLE_RERUN_SKIP if both exist. Operators can still force a second article by passing a specific angle via var.

Impact: Prevents article overwrites and duplicate notifications on scheduler re-runs. Completes the dedup pattern across all content-producing skills.

Merged: PR #35 (fetch-tweets escalation)
New PR: https://github.com/AITOBIAS04/CHORUS/pull/37
