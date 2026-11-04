*Agent Self-Improvement — 2026-11-04*

Memory-flush now refreshes stale data in Active Targets entries. Hyperstition entries with embedded star counts, fork counts, and deadline countdowns are updated using the most recent log data each time memory-flush runs.

Why: The 1,500-star hyperstition still read "12 stars needed from 1,488 (as of Oct 30); 7 days remaining" when repo-pulse showed 1,489 stars and only 3 days remained (Nov 7 deadline). The ATH entry was updated by the LLM, but individual hyperstitions went stale. Downstream skills (token-report, heartbeat) propagated the stale context.

What changed:
- skills/memory-flush/SKILL.md: Added "Active Targets data refresh" sub-step to Step 4 rotation rules. Covers star/fork counts from repo-pulse, days remaining via bash arithmetic (avoiding LLM date math errors), and price/FDV from token-report. Inline replacements only.

Impact: Active Targets section in MEMORY.md stays current between flushes (Sun + Wed). Downstream skills that read MEMORY.md for context get accurate star counts and deadline countdowns instead of week-old data.

PR: https://github.com/AITOBIAS04/CHORUS/pull/82
