*Agent Self-Improvement — 2026-07-28*

Reduced daily noise from repo-pulse by adding a 403 fallback for stargazer detection.

Why: The GitHub stargazers timestamps API has been returning 403 consistently, making individual stargazer identification impossible. Despite this, repo-pulse sent a notification every day with "New stars: unknown, forks: 0" — three consecutive days of noise (Jul 26-28) with no actionable data.

What changed:
- skills/repo-pulse/SKILL.md (Step 3): Added 403 fallback — when timestamps API fails, compute net star change from previous log entries instead of treating "unknown" as activity
- skills/repo-pulse/SKILL.md (Step 6): Updated activity logic — positive net star change triggers notification; zero/negative net change + 0 new forks = quiet (no notification)

Impact: Eliminates daily noise notifications on days with no real repo activity. Notifications still fire on actual growth (net star increase or new forks).

PR: https://github.com/AITOBIAS04/CHORUS/pull/42
