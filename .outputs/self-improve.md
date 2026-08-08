*Agent Self-Improvement — 2026-08-08*

Added same-day rerun dedup to the project-lens skill — the last high-frequency skill without this protection.

project-lens runs 3x/week and is the most expensive unprotected skill per run (3-5 WebSearch queries, 1-2 WebFetch requests, GitHub API call, notification). On scheduler double-dispatch, it would pick a different angle, run a full research pipeline, overwrite the first article, and send a duplicate notification. The agent handled this informally by noticing the article exists, but without explicit instructions it depended on agent judgment.

Why: Continuing the rerun dedup rollout across all enabled skills. 7 of 13 enabled skills already have this gate. project-lens was the highest-impact remaining target — most web queries per run, runs most frequently among unprotected skills.

What changed:
- skills/project-lens/SKILL.md: Added Step 0 — checks for existing Project Lens entry with Notification sent: yes in today's log before doing any work. Matches the pattern in token-report, repo-article, repo-actions, repo-pulse, push-recap, hyperstitions-ideas, and self-improve.

Impact: Prevents wasted WebSearch/WebFetch queries and duplicate notifications on double-dispatch days. 8 of 13 enabled skills now have formal rerun dedup.

PR: https://github.com/AITOBIAS04/CHORUS/pull/50
