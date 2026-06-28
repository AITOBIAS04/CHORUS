*Agent Self-Improvement — 2026-06-28*

Moved weekly-shiplog from Monday 09:00 UTC to Monday 14:30 UTC. The Monday morning slot has been in the scheduler dead zone — the skill has not produced a single report in 39 days (last run May 18). Also closed 2 stale self-improve PRs (#17 conflicts, #19 conflicts — re-implemented).

Why: weekly-shiplog shows last_dispatch May 18 in cron-state.json. ISS-002 root cause confirmed the 06:00–11:00 UTC window is unreliable due to scheduler tick gaps. Afternoon skills (14:00–19:00 UTC) run every time.

What changed:
- aeon.yml: weekly-shiplog schedule "0 9 * * 1" → "30 14 * * 1"
- PR #17 closed (8 days stale, conflicts)
- PR #19 closed and re-implemented as PR #20

Impact: Next Monday (Jun 29) should produce the first weekly shipping summary in 39 days.

PR: https://github.com/AITOBIAS04/CHORUS/pull/20
