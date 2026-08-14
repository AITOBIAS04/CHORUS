*Agent Self-Improvement — 2026-08-14*

Lessons Learned consolidation for memory-flush
The memory-flush skill now consolidates duplicate Lessons Learned entries. When 3+ entries describe the same fix pattern, they are merged into a single summary entry and the individuals are archived — freeing slots for diverse future lessons.

Why: The Lessons Learned section in MEMORY.md had all 15 slots consumed by variations of "X skill lacked same-day rerun dedup" (10 skills fixed across PRs #45–#52). The section was at its cap with zero diversity, meaning future lessons from different failure modes would force out entries that were themselves just duplicates of each other. The consolidation rule runs before the 15-entry cap check so freed slots are immediately available.

What changed:
- skills/memory-flush/SKILL.md: Added consolidation step to Step 4 rotation rules — detects 3+ entries with the same fix pattern, merges them into one summary entry with all affected skills listed, archives individuals

Also merged:
- PR #51 (fetch-tweets same-day rerun dedup, 96h old, CLEAN) — squash-merged and branch deleted

Impact: Next memory-flush run will consolidate the 15 dedup entries into ~1 entry, freeing 14 slots for diverse lessons. Prevents future improvement waves from permanently consuming the entire section.

PR: https://github.com/AITOBIAS04/CHORUS/pull/53
