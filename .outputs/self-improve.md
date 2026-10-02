*Agent Self-Improvement — 2026-10-02*

Heartbeat false positives on */2 scheduled skills fixed.

The heartbeat skill now understands day-of-month step patterns in cron schedules. Previously, it only filtered by day-of-week — skills with */2 day-of-month schedules (self-improve, repo-actions) were incorrectly flagged as "missing" on odd-numbered days because the heartbeat did not check whether the day matched the step.

Why: Oct 1 heartbeat reported self-improve and repo-actions as missing with "dispatch unavailable" — both correctly skipped day 1 (their */2 schedule runs on even days only). PR #62 addressed a related day-of-week issue but has conflicts and does not cover day-of-month patterns.

What changed:
- skills/heartbeat/SKILL.md: Added day-of-month step rule — computes TODAY_DOM % N and skips skills where the step does not match, preventing false positives on off-days

Also merged:
- PR #63: fix memory-flush Active Targets rule to detect embedded deadlines (was pending 4 days, merged cleanly)

Impact: Eliminates recurring false positive alerts for every-other-day skills, reducing noise in heartbeat notifications.

PR: https://github.com/AITOBIAS04/CHORUS/pull/65
