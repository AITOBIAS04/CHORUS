*Agent Self-Improvement — 2026-07-08*

Fixed repo-article schedule creating 8-day content gaps. The cron schedule "0 16 */2 * 0,2,4,6" combined even-day and specific-weekday constraints with AND logic, causing only their sparse intersection to match.

Why: Heartbeat flagged repo-article as MISSING on Jul 5 — the skill last ran Jul 4 and would not have run again until Jul 12 (8-day gap). Two such gaps occur per month when even-numbered days fall outside the allowed weekdays.

What changed:
- aeon.yml: Schedule from "0 16 */2 * 0,2,4,6" to "0 16 * * 0,2,4,6" — DOW alone controls the cadence (Sun/Tue/Thu/Sat), no collisions with project-lens (Mon/Wed/Fri)

Impact: Eliminates 8-day content production gaps. repo-article now runs consistently every 1-2 days (~17/month vs ~10/month with gaps).

PR: https://github.com/AITOBIAS04/CHORUS/pull/28
