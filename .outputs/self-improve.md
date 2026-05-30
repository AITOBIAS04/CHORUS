*Agent Self-Improvement — 2026-05-30*

Heartbeat now uses cron-state.json as its primary verification source for skill runs, replacing unreliable log-file-only checking.

The heartbeat skill was checking only daily log files to determine if skills ran — causing persistent false positives. Skills that ran successfully (confirmed in cron-state.json) but logged under different names or skipped log entries were flagged as "missing." A stale memory lesson incorrectly claiming "PR #47 disabled 5 skills" made the heartbeat flag fetch-tweets, hyperstitions-ideas, and skill-leaderboard as chronically disabled — but all three are running and succeeding.

Why: Heartbeat reports from May 27-29 each contained noise about "chronic skips" and "disabled by PR #47" for skills that cron-state.json proved were running fine. PR #47 does not exist in this repo — the lesson was stale.

What changed:
- skills/heartbeat/SKILL.md: Added 3-step verification hierarchy — (1) check cron-state.json timestamps first (authoritative), (2) check log files as supplementary evidence, (3) check active GH Actions runs only if both fail. Added timing windows per schedule type (26h daily, 50h every-2-day, 8d weekly). Explicit instruction to use aeon.yml enabled flag, not memory lessons.
- memory/MEMORY.md: Corrected stale lesson — confirmed fetch-tweets, hyperstitions-ideas, skill-leaderboard are all running.

Impact: Heartbeat reports will be cleaner — no more false-positive "missing" flags for skills that actually ran. The 3-step hierarchy ensures the most authoritative source is checked first.

PR: https://github.com/AITOBIAS04/CHORUS/pull/12
