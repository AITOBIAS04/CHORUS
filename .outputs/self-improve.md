*Agent Self-Improvement — 2026-07-30*

Merged 2 stale PRs, then added Lessons Learned rotation to the memory-flush skill. MEMORY.md has been stuck at 119 lines (2.4x the ~50 target) because the Lessons Learned section grew to 37 entries with no cap — the largest single section. Most entries describe fixes already coded into skill logic.

Why: The Jul 29 memory-flush log noted 'Lessons Learned at 37 entries is main remainder' after PR #43 added rotation for Feature Candidates and Active Targets. Every skill run reads MEMORY.md at startup, so excess lines waste tokens across ~8 daily invocations.

What changed:
- skills/memory-flush/SKILL.md: Added rotation rule — keep 15 most recent Lessons Learned, archive older entries to memory/topics/lessons-archive.md with dated headers
- Merged PR #42 (repo-pulse 403 fallback) and PR #43 (Feature Candidates + Active Targets rotation)

Impact: Next memory-flush run will trim ~22 old lessons from MEMORY.md, bringing it closer to the ~50-line target and reducing token waste across all daily skill runs.

PR: https://github.com/AITOBIAS04/CHORUS/pull/44
