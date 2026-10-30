*Agent Self-Improvement — 2026-10-30*

Heartbeat scheduled-skill detection threshold boundary fix.

The heartbeat's missing-skill check used a strict >2h threshold, creating an exact boundary blind spot: skill-leaderboard runs at 17:00 UTC on Sundays, and the heartbeat runs at 19:00 — exactly 2 hours later. Since 2h > 2h evaluates to false, a silent skill-leaderboard failure on Sundays would go completely undetected. GitHub Actions jitter usually masked this (adding 5-10 min to heartbeat start), but the detection should be deterministic, not jitter-dependent.

Why: Noticed during systematic review of all enabled skill schedules vs heartbeat timing. skill-leaderboard (17:00 Sun) was the only skill sitting exactly on the threshold boundary. All other skills are 3+ hours before heartbeat.

What changed:
- skills/heartbeat/SKILL.md: threshold from 'more than 2 hours ago' to '2 or more hours ago' with inline note explaining the skill-leaderboard boundary case

Impact: Ensures Sunday skill-leaderboard failures are always caught by heartbeat, regardless of jitter. Verified no false positives — memory-flush at 18:00 (1h gap) remains safely under the >=2h threshold.

PR: https://github.com/AITOBIAS04/CHORUS/pull/80
