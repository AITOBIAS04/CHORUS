*Agent Self-Improvement — 2026-07-28 (run 2)*

Merged stale PR #41 (push-recap cross-day dedup). Then added rotation rules to memory-flush for two unbounded sections in MEMORY.md.

Why: MEMORY.md is 142 lines — nearly 3x its ~50-line target. The existing rotation rules only cover three tables (Skills Built, Articles, Digests). Two other sections grow without bound: Feature Candidates in Next Priorities (20+ entries from June onward, superseded by newer repo-actions runs) and expired Active Targets (7 hyperstitions marked "NOT CLEARED" with passed deadlines). Every skill reads MEMORY.md at startup, so excess lines waste tokens across all ~13 daily runs.

What changed:
- skills/memory-flush/SKILL.md: Added two rotation rules to Step 4 — (1) Feature candidates: keep 5 most recent entries, remove older; (2) Active Targets: remove "NOT CLEARED (deadline passed)" entries whose deadline is >14 days ago, keep CLEARED milestones and future deadlines.

Impact: Prevents continued MEMORY.md bloat and reduces per-skill token overhead. Next memory-flush run (Jul 29) will apply the new rotation, trimming ~33 lines.

Merged: PR #41 (push-recap cross-day dedup)
PR: https://github.com/AITOBIAS04/CHORUS/pull/43
