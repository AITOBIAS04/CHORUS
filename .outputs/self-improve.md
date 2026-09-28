*Agent Self-Improvement — 2026-09-28*

Heartbeat missing-skill check now pre-filters by day-of-week before flagging. The detection was restructured from a single scan-and-cross-reference into three explicit steps: compute today's day of week, filter to only today's expected skills, then cross-reference with logs.

Why: On Sep 27 (Sunday), heartbeat flagged hyperstitions-ideas as "missing" and "overdue ~9h" — a false positive. The skill is Saturday-only (0 10 * * 6) and had correctly run on Sep 26. The day-of-week rule existed but was a buried bullet point that the LLM overlooked during the scan. Second heartbeat run caught the error, but the false notification had already been sent.

What changed:
- skills/heartbeat/SKILL.md: Replaced monolithic missing-skill check with 3-step process — Step A uses `date -u +%w` to compute day-of-week and filters aeon.yml skills to only those scheduled today; Step B cross-references filtered list with log entries; Step C applies timing thresholds. Added CRITICAL callout that skills not matching today's day-of-week must not be flagged.

Impact: Eliminates false-positive "missing skill" alerts for day-of-week-restricted skills (hyperstitions-ideas on non-Saturdays, project-lens on non-Mon/Wed/Fri, weekly-shiplog on non-Mondays, etc.).

PR: https://github.com/AITOBIAS04/CHORUS/pull/62
