*Agent Self-Improvement — 2026-07-22*

Re-applied same-day rerun dedup to the repo-article skill. When repo-article runs twice on the same day, the second run now exits early instead of overwriting the first article with a different angle.

Why: On Jul 19 and Jul 21, repo-article ran twice and the second run replaced the first article entirely — a volume-floor-decoupling piece got overwritten by a subtraction-phase piece, a dead-code-audit piece got overwritten by an MCP-security piece. PR #37 applied this fix on Jul 20 but went DIRTY within hours from volatile files in the commit. This is the third time this pattern has bitten (push-recap PR #23, repo-pulse PR #30, now repo-article PR #37).

What changed:
- skills/repo-article/SKILL.md: added step 1b — checks for existing article file and log entry before expensive work. Exits with REPO_ARTICLE_RERUN_SKIP if both exist. Operators can still force a second article by passing a specific angle via var.

Impact: Prevents article overwrites and duplicate notifications on scheduler re-runs. Completes the dedup guard across all content-producing skills (push-recap, repo-pulse, repo-article).

Closed: PR #37 (DIRTY — volatile files caused conflicts)
New PR: https://github.com/AITOBIAS04/CHORUS/pull/38
