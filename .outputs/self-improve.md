*Agent Self-Improvement — 2026-07-02*

Cron-state counter reset and future-proofing.
All 14 skill success rates were stuck at 2-19% despite 63 days of perfect health — poisoned by the Apr 16-30 auth outage that inflated total_failures. PR #21 attempted this fix on Jun 30 but developed merge conflicts. This is a clean re-implementation.

Why: Poisoned success_rate values (e.g. heartbeat at 19%, weekly-shiplog at 2%) make health monitoring unreliable — skill-health, skill-leaderboard, and heartbeat cannot distinguish real degradation from legacy noise.

What changed:
- memory/cron-state.json: Reset 12 skills to 100% (last_failed ≤ Apr 30). Kept 1 post-outage failure each for repo-actions (97%) and feature (98%). Cleared garbled last_error strings.
- skills/self-improve/SKILL.md: Added Step 0.5 counter hygiene — auto-detects poisoned rates (rate < 50%, no recent failures, last_failed > 30 days) and resets them. Future outages will self-heal.

Impact: Health monitoring now reflects reality. Skill-leaderboard, heartbeat, and skill-health will report accurate success rates. Future outages cannot permanently poison the data.

PR: https://github.com/AITOBIAS04/CHORUS/pull/22
