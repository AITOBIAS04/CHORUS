# Push Recap — 2026-08-23

## Overview
1 substantive commit by aaronjmars across miroshark-aeon (9 automation commits filtered). Today's work extracted deterministic bookkeeping out of the memory-flush skill's LLM context and into a standalone Python script, making the scan-window and log-rotation logic testable, reliable, and cheaper to run.

**Stats:** 4 files changed, +489/-29 lines across 1 substantive commit

---

## aaronjmars/miroshark-aeon

### Reliability: Memory-Flush Deterministic Prep
**Summary:** The memory-flush skill previously had the LLM compute its own scan window (parsing a prose watermark from MEMORY.md), list in-window logs, and rotate old log files — all pure-code work done inside the model context 7 times a week. This was costly and fragile: the window silently fell back to 3 days whenever the prose watermark was edited away, losing un-promoted entries. This commit extracts all that mechanical work into `scripts/memory_prep.py`, leaving the model with only judgment calls (what to promote, dedup, and prune).

**Commits:**
- `97cc07f` — improve(memory-flush): deterministic prep + structured watermark
  - New file `scripts/memory_prep.py` (+278 lines): Two subcommands — `window` (pre-pass: resolves the last-consolidated watermark from a new structured JSON file `memory/memory-flush-state.json`, falling back to the MEMORY.md prose line for first-run migration; computes the scan window with a 14-day clamp for long gaps; rotates whole old calendar months into `memory/logs/archive/YYYY-MM.md` once `memory/logs/` exceeds ~45 files; prints exactly which log files the model should read) and `stamp` (post-pass: writes today's date to the structured watermark file and mirrors it into the MEMORY.md `*Last consolidated:*` line). All date planners are pure functions with no clock or I/O dependency, making them unit-testable.
  - New file `scripts/tests/test_memory_prep.py` (+179 lines): 16 unit tests covering watermark parsing (from state file, from MEMORY.md prose, fallback chain), window computation (no watermark → 3-day default, normal gap, >14-day clamp, boundary at exactly 14 days), log selection and filtering, month rotation logic (threshold check, only rotates whole months outside the scan window, never touches current month), MEMORY.md stamp text manipulation (update existing line, insert under title when missing, idempotent re-stamp), and full I/O integration tests (stamp writes state + mirrors, window rotates + selects in a real git repo).
  - Changed `.github/workflows/ci-tests.yml` (+2 lines): Added `memory-flush prep tests` step running `python3 scripts/tests/test_memory_prep.py` to the CI pipeline.
  - Changed `skills/memory-flush/SKILL.md` (+30/-29 lines): Restructured skill steps to use the new script — step 0 now runs `memory_prep.py window` and reads its output instead of hand-parsing the watermark; step 7 is now documented as automated (handled by step 0); step 8 runs `memory_prep.py stamp` as the final action. Removed all manual watermark and rotation instructions. Clarified that the model must not hand-edit the consolidation date.

**Impact:** Memory-flush now has a deterministic, tested pre/post pipeline. The scan-window calculation can never silently regress to a 3-day default, log rotation is automatic and content-preserving, and the watermark is a structured JSON file rather than a fragile prose line. This reduces LLM token cost per run (no more context spent on bookkeeping) and eliminates a class of silent data-loss bugs where un-promoted log entries fell outside a miscalculated window.

---

## Developer Notes
- **New dependencies:** None — pure stdlib Python
- **Breaking changes:** Memory-flush skill now depends on `scripts/memory_prep.py` existing. The watermark source of truth has moved from the MEMORY.md prose line to `memory/memory-flush-state.json` (with automatic migration fallback)
- **Architecture shifts:** Pattern of extracting deterministic bookkeeping from LLM context into testable scripts continues (following `state_reduce.py`, `health_triage.py`). The structured watermark file is a new convention for skill-owned state that doesn't fit the cron-state schema.
- **Tech debt:** None introduced. This commit resolves existing tech debt (unreliable prose-based watermark, untested rotation logic).

## What's Next
- First run of memory-flush with the new script will migrate the watermark from the MEMORY.md prose line to `memory/memory-flush-state.json` automatically
- The pattern established here (extract pure bookkeeping into a script, test it, wire into CI) could apply to other skills with similar mechanical pre/post steps
- PR #57 (broaden push-recap automation filter) and PR #56 (fetch-tweets query backoff) are still open for merge
