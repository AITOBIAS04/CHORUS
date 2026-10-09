# Push Recap — 2026-10-09

## Overview
3 substantive commits by Aaron Elijah Mars (9 automation commits filtered). Today was a bug-fix sprint — three user-filed issues (#321, #322, #323) all got fixes with thorough test coverage. The changes harden the report lookup system, fix a silent NER failure in claude-code mode, and make simulation resume safe on existing databases.

**Stats:** 36 files changed, +537/-47 lines across 3 substantive commits

---

## aaronjmars/MiroShark

### Bug Fix: Report Lookup Now Returns the Newest Report (#323, #325)
**Summary:** `get_report_by_simulation` returned the first match from `os.listdir` order — which is arbitrary. When `force_regenerate` kept the old report folder alongside the new one, the old report could shadow the new one. The lookup was rewritten to collect all matching reports and return the newest by `created_at`.

**Commits:**
- `f335814` — fix(report): return the newest report for a simulation (#325)
  - Changed `backend/app/services/report_agent.py`: Rewrote `get_report_by_simulation` from a first-match return to a collect-all-then-sort approach. Iterates all items in REPORTS_DIR (folders and legacy JSON), loads each with exception handling (corrupt/half-written meta.json is logged and skipped), then returns `max()` by `(created_at, report_id)`. New `prefer_completed` parameter filters to COMPLETED status when available, falling back to newest of any status. New static `_created_at_sort_key` handles missing/null created_at gracefully (+50/-11 lines)
  - Changed `backend/app/api/report.py`: The generate endpoint's "already exists?" check now passes `prefer_completed=True` so a newer failed/in-progress report doesn't falsely skip regeneration (+5/-2 lines)
  - New file `backend/tests/test_unit_report_lookup.py`: 148-line test suite — 8 tests covering: newer report wins regardless of listdir order, prefer_completed skips unfinished reports, legacy JSON files rank alongside folders, missing created_at sorts oldest, unreadable reports are skipped, empty directory returns None (+148 lines)

**Impact:** Users who hit "Regenerate" no longer risk seeing the old report. Report chat also benefits — it now always gets the newest completed report for context. The exception handling means a concurrent regeneration can't crash the lookup.

### Bug Fix: ClaudeCodeClient Now Accepts repair_truncated (#321, #324)
**Summary:** `ClaudeCodeClient.chat_json` didn't accept the `repair_truncated` keyword that NER callers pass. In `LLM_PROVIDER=claude-code` mode, every NER chunk raised a `TypeError`, the graph build silently continued with 0 nodes, and reported success. A 0-node graph would then stall downstream report generation.

**Commits:**
- `0e9bcba` — fix(llm): accept repair_truncated in ClaudeCodeClient.chat_json, fail 0-node graph builds (#324)
  - Changed `backend/app/utils/claude_code_client.py`: Added `repair_truncated: bool = False` parameter to `chat_json`. When enabled, a failed `json.loads` attempts `repair_json` before raising. Matches LLMClient's signature exactly (+11/-1 lines)
  - Changed `backend/app/api/graph.py`: After graph build completes, checks `node_count == 0` and explicitly fails the task and project with a clear error message ("0 entities extracted — check LLM/NER config and logs") instead of reporting success (+22/-4 lines)
  - New file `backend/tests/test_unit_llm_client_parity.py`: 51-line test suite — signature parity test (compares `inspect.signature` of both clients' `chat` and `chat_json`), repair_truncated integration test with a synthetically truncated JSON string, and strict-mode-by-default test (+51 lines)

**Impact:** claude-code mode NER now actually works — truncated LLM responses are repaired instead of crashing silently. The 0-node guard catches any future total-extraction-failure scenario regardless of cause.

### Bug Fix: Simulation Resume Made Safe on Existing Databases (#322, #326)
**Summary:** Resuming a simulation crashed with "table user already exists" because 26 SQL schema files used `CREATE TABLE` without `IF NOT EXISTS`. Additionally, a resumed run that died before completing its first round would save `current_round=0`, corrupting the resume state so the next start would silently wipe the platform databases. A new 409 response prevents resuming when there's nothing to resume from.

**Commits:**
- `e259fb2` — fix(simulation): make resume work on existing DBs and keep progress on failure (#326)
  - Changed 26 schema `.sql` files (13 in `wonderwall/simulations/social_media/schema/` + 13 in `wonderwall/social_platform/schema/`): Added `IF NOT EXISTS` to every `CREATE TABLE` statement — user, post, comment, like, dislike, follow, mute, comment_like, comment_dislike, product, rec, report, trace (+26/-26 lines, one per file)
  - Changed `backend/app/services/simulation_runner.py`: New `_seed_resumed_progress` static method that copies `current_round`, `simulated_hours`, and per-platform progress (twitter/reddit/polymarket `current_round`, `simulated_hours`, `actions_count`) from the prior run state into the new state. Called when `start_round > 0` (+23/-1 lines)
  - Changed `backend/app/api/simulation.py`: When `resume=true` but no completed rounds exist (`current_round` is 0 or state is None), returns 409 with bilingual error message instead of silently falling back to a fresh start that would delete the platform DBs (+11 lines)
  - Changed `backend/openapi.yaml`: Updated resume parameter description and added 409 response schema (+6/-1 lines)
  - New file `backend/tests/test_unit_resume_idempotent.py`: 184-line test suite — schema idempotency (applies schemas twice on same DB, verifies tables and data survive), IF NOT EXISTS regex check on all .sql files, PolymarketPlatform double-init test, _seed_resumed_progress unit tests, and 409-on-empty-resume API test (+184 lines)

**Impact:** Simulation resume now works reliably. The 26-file schema fix eliminates the crash on re-init. The progress seeding ensures a failed resume doesn't corrupt state. The 409 guard prevents the dangerous edge case where a "resume" with no progress would silently start fresh and wipe existing platform data.

---

## aaronjmars/miroshark-aeon

9 automation commits filtered (3 cron state, 3 scheduler updates, 2 auto-commits, 1 heartbeat).

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** `POST /api/simulation/start` with `resume=true` now returns 409 when no completed rounds exist (previously returned 200 and silently started fresh). Callers should handle this.
- **Architecture shifts:** `ReportManager.get_report_by_simulation` gained a new `prefer_completed` parameter — existing callers that don't pass it get the same default behavior (newest of any status). Two callers (generate skip-check and report chat) now use it.
- **Tech debt:** None introduced. The 26 schema files are now idempotent, which is a debt reduction. The signature parity test prevents future LLMClient/ClaudeCodeClient divergence.

## What's Next
- All three fixes address the user-filed issues from Oct 8 (#321, #322, #323) — the issue backlog should now be clear
- The `repair_truncated` fix unblocks claude-code mode for NER; anyone running `LLM_PROVIDER=claude-code` should see graphs actually populate now
- The resume fix is foundational — simulations that crash mid-run can now be resumed without data loss, which was previously a silent corruption vector
