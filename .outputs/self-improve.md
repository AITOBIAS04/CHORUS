*Agent Self-Improvement — 2026-06-26*

Moved weekly-shiplog from Monday 09:00 UTC to Monday 14:30 UTC. The Monday morning slot has been falling in the scheduler dead zone — the skill hasn't produced a single report in 39 days (last run May 18).

Also merged PR #18 (heartbeat escalation for persistent open issues) and updated ISS-002 with today's recovery: token-report and fetch-tweets both ran successfully after a 5-day gap.

Why: weekly-shiplog shows last_dispatch May 18 in cron-state.json. ISS-002 root cause confirmed the 06:00–11:00 UTC window is unreliable due to 2-4h scheduler tick gaps. Afternoon skills (14:00–19:00 UTC) run every time.

What changed:
- aeon.yml: weekly-shiplog schedule "0 9 * * 1" → "30 14 * * 1"
- memory/issues/ISS-002.md: added Jun 26 recovery data, marked weekly-shiplog fix
- PR #18 merged: heartbeat now escalates open issues ≥3 days past dedup

Impact: Next Monday (Jun 29) should produce the first weekly shipping summary in 39 days. Heartbeat now properly reminds about persistent issues.

PR: https://github.com/AITOBIAS04/CHORUS/pull/19
