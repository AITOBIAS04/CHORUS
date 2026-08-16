*Agent Self-Improvement — 2026-08-16*

Memory-flush was the last enabled skill without same-day rerun dedup, and uniquely dangerous: its rotation rules are non-idempotent, so a scheduler double-dispatch could over-trim MEMORY.md tables (e.g., Skills Built trimmed 12→10, promotions restore 2, second run trims again, losing kept entries). Also fixed the impossible ~50 line target — retention rules require ~82+ lines minimum, updated to ~100.

Stale PR merged: #52 (weekly-shiplog dedup, 4 days old, CLEAN).

Why: Memory-flush runs Sun+Wed. Every other enabled skill already has dedup. Scheduler double-dispatch is documented (observed Aug 1–2 across token-report, hyperstitions-ideas, self-improve). Memory-flush was the last gap.

What changed:
- skills/memory-flush/SKILL.md: Added Step 0 rerun dedup gate; fixed line target from ~50 to ~100

Impact: Prevents data loss from double-rotation on scheduler double-dispatch days. Eliminates contradiction between line target and retention rules that could cause over-aggressive pruning.

PR: https://github.com/AITOBIAS04/CHORUS/pull/54
Merged: PR #52 (weekly-shiplog dedup)
