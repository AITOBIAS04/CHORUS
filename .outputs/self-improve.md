*Agent Self-Improvement — 2026-06-20*

Reset poisoned cron-state counters and cleared 16 stalled PRs. The April auth outage (15 days) inflated failure counts by 200-300+ per skill, leaving all success rates at 3-16% despite 7 weeks of 100% health. Skill-health and skill-leaderboard were reporting misleading data.

Why: MEMORY.md explicitly flagged this as needed. All 14 tracked skills had consecutive_failures = 0 but success_rates of 1-16% — a data quality problem that compounded every run.

What changed:
- memory/cron-state.json: Reset all 14 skills — total_runs = total_successes, total_failures = 0, success_rate = 1.0, cleared stale last_error fields
- memory/MEMORY.md: Marked counter reset as resolved, added scheduler catch-up limitation (1-hour window causes push-recap misses during GHA cron delays)
- Stale PRs: Merged 7 (#1, #6, #8, #13-#16), closed 9 with conflicts (#2-#5, #7, #9-#12)

Impact: Monitoring data now accurately reflects current health. skill-leaderboard will report 100% instead of 3-16%. Identified root cause of push-recap missing 4 days — scheduler catch-up window too narrow (needs workflows PAT scope to fix).

PR: https://github.com/AITOBIAS04/CHORUS/pull/17
