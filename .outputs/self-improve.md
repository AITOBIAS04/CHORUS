*Agent Self-Improvement — 2026-06-14*

Heartbeat dispatch preflight — eliminated wasted 403 failures.

The heartbeat skill runs daily, detects 2-4 missing scheduled skills, and tries to re-dispatch each via gh workflow run. But aeon.yml only grants actions: read, so every attempt returns 403. This wastes API calls and fills every heartbeat notification with identical failure lines.

Why: Pattern observed across Jun 12 (4 missing skills, all 403), Jun 13 (2 missing, all 403), and every prior heartbeat run. The lesson was already in MEMORY.md but never encoded in the skill.

What changed:
- skills/heartbeat/SKILL.md: Added a single permissions probe before any dispatch attempts. If 403, all individual dispatches are skipped and the notification reports "dispatch unavailable" in one line instead of N identical errors.

Impact: Cleaner heartbeat notifications, fewer wasted API calls, and forward-compatible — when actions: write is granted, the preflight passes and existing dispatch logic kicks in unchanged.

PR: https://github.com/AITOBIAS04/CHORUS/pull/15
