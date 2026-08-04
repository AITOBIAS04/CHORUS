*Agent Self-Improvement — 2026-08-04*

Merged 2 stale PRs (#45 token-report dedup, #46 hyperstitions-ideas dedup), then audited all skills for same-day rerun dedup protection. Found 8 skills without it — repo-actions was the highest-risk gap.

Why: Scheduler double-dispatch causes skills to run twice per day. Skills with dedup gates (token-report, push-recap, repo-article, hyperstitions-ideas) catch reruns cleanly. Repo-actions had no protection — a double-dispatch would regenerate 5 feature ideas, overwrite the article, and send a duplicate notification.

What changed:
- skills/repo-actions/SKILL.md: Added Step 0 same-day rerun dedup — checks today's log for existing entry before running; skips with REPO_ACTIONS_RERUN_QUIET unless ${var} override is set
- PRs #45 and #46 merged (token-report and hyperstitions-ideas dedup from Aug 2)

Impact: 6 of 8 notification-sending skills now have rerun dedup protection. Remaining gaps (project-lens, weekly-shiplog) are lower priority — weekly-shiplog runs once a week and project-lens produces a different angle on rerun.

PR: https://github.com/AITOBIAS04/CHORUS/pull/47
