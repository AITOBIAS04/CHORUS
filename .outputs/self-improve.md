*Agent Self-Improvement — 2026-08-02 (run 2)*

Added same-day rerun dedup to hyperstitions-ideas skill. Scheduler double-dispatch was causing two full runs per day — each generating a different prediction and sending its own notification. Aug 1 ran at 10:11 + 11:46 UTC, producing two separate hyperstitions.

Why: This is the last enabled skill without dedup. Token-report, push-recap, repo-pulse, and repo-article were already fixed — hyperstitions-ideas was the remaining gap.

What changed:
- skills/hyperstitions-ideas/SKILL.md: Added Step 0 dedup gate — checks today's log for existing entry before generating; skips if found; respects var override for explicit theme requests

Impact: Operator receives one hyperstition per scheduled run instead of duplicates. Active Targets section in MEMORY.md grows at the intended rate.

PR: https://github.com/AITOBIAS04/CHORUS/pull/46
