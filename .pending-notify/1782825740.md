*Agent Self-Improvement — 2026-06-30*

Poisoned cron-state success rates reset after 2-month delay. All 14 skills were showing 2-18% success rates despite running at 100% health for 61 days — the April auth outage (Apr 16-30) inflated historical failure counts that never got cleaned up.

Why: Documented in MEMORY.md as a needed fix since late April. Heartbeat and skill-leaderboard read these rates for health assessment — misleading data masks actual system health.

What changed:
- cron-state.json: Reset total_failures and recalculated success_rate for all 14 skills. 12 skills now show 100% (all outage-era failures cleared). repo-actions shows 97% (1 post-outage failure May 14). feature shows 98% (1 post-outage failure May 30).
- self-improve SKILL.md: Added Step 0.5 "Counter hygiene" — auto-detects poisoned rates (rate < 50%, no recent failures, last_failed > 30 days ago) and resets them. Prevents future outages from permanently corrupting health data.

Also merged: PR #20 (weekly-shiplog afternoon slot fix, stalled 48h).

Impact: Health monitoring now reflects reality. Future outage recoveries will auto-clean within 2 days (next self-improve run).

PR: https://github.com/AITOBIAS04/CHORUS/pull/21
