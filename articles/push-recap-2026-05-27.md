# Push Recap — 2026-05-27

## Overview
7 commits by 3 authors across aaronjmars/MiroShark, plus ~34 automation commits in miroshark-aeon. Today's main thrust: a new per-agent belief sparklines surface (#115), a comprehensive 8-pass code-quality cleanup (#116), three targeted bug fixes (#110–#112), a UX improvement to the report view (#113), and a community ECOSYSTEM.md update (#114). The aeon repo pruned 5 scheduled skills and continued its daily content cycle.

**Stats:** ~70 unique files changed, +2,916/-547 lines across 41 commits by 4 authors (@aaronjmars, shak, aeonframework, Aeon)

---

## aaronjmars/MiroShark

### New Feature: Per-Agent Belief Sparklines (#115)
**Summary:** Added the 23rd share surface — per-agent belief sparklines that expose the layer underneath chart.svg's aggregate curve and peak-round's inflection points. Each individual agent's belief position is tracked round-by-round and rendered as a compact inline SVG polyline colored by final stance (bullish/neutral/bearish), answering swarm-convergence questions like "which agent anchored the consensus?" without parsing the transcript.

**Commits:**
- `697b2b0` — feat: per-agent belief sparklines surface (#115)
  - New file `backend/app/services/agent_sparklines_service.py` (+279 lines): Pure-stdlib service reads trajectory.json, computes per-agent scalar belief position via `_avg_position` mean (same ±0.2 stance threshold every other surface uses), sorts agents most-bullish-first, returns structured payload with `has_per_agent_data` flag (false for single-round sims)
  - Changed `backend/app/api/simulation.py` (+77): New `GET /api/simulation/<id>/agents/sparklines` endpoint with publish gate, 5-minute cache, bilingual error messages (English/Chinese), surface-stat increment
  - Changed `backend/app/services/surface_stats.py` (+3/-1): Registered `agent_sparklines` key in SURFACE_KEYS
  - Changed `frontend/src/components/EmbedDialog.vue` (+244): Scrollable agent-trajectory section with inline SVG sparklines — each row shows agent name, 60×16px polyline (belief position mapped to y-axis, round index to x-axis), and final stance label. Max-height 240px with overflow scroll for large swarms. Stance colors match chart.svg (green/gray/red)
  - Changed `frontend/src/api/simulation.js` (+48): `getAgentSparklinesUrl()` and `getAgentSparklines()` API helpers
  - Changed `backend/openapi.yaml` (+154): AgentSparklinesResponse schema definition
  - New file `backend/tests/test_unit_agent_sparklines.py` (+239): 18 offline unit tests + surface-keys parity assertion
  - Changed `docs/API.md` (+1), `docs/FEATURES.md` (+42): Documentation

**Impact:** Researchers and integrators can now query per-agent belief trajectories programmatically. The sparklines complete the analytical stack: aggregate curve (chart.svg) → inflection points (peak-round) → individual agent paths (sparklines). Zero new dependencies.

### Bug Fixes & Hardening (#110, #111, #112)
**Summary:** Three targeted fixes for production crashes: the reranker hanging indefinitely on Apple Silicon Macs, and two separate null-response paths in the report generation pipeline that caused section generation errors.

**Commits:**
- `ec657cb` — Fix reranker hang on Apple Silicon by steering off the MPS backend (#110)
  - Changed `backend/app/storage/reranker_service.py` (+24/-2): New `_select_device()` static method — honors `RERANKER_DEVICE` env override, otherwise prefers CUDA, falls back to CPU. MPS (Metal Performance Shaders) is intentionally skipped in auto mode because torch hangs indefinitely compiling Metal shader pipelines for the BAAI/bge-reranker-v2-m3 cross-encoder, pegging a CPU core at 100%
  - Changed `backend/app/config.py` (+5): New `RERANKER_DEVICE` config field
  - Changed `.env.example` (+5): Documented `RERANKER_DEVICE` with explanation of why MPS is avoided

- `484a571` — Fix report section crash on intermittent null LLM content (#112)
  - Changed `backend/app/utils/llm_client.py` (+11): Guard `None` content in `chat()` before the `<think>` tag regex — reasoning-capable models (notably Gemini 3 Flash) intermittently return `message.content = None`. Now returns `None` cleanly so callers' retry logic engages. Added explicit `ValueError` in `chat_json()` on `None` instead of crashing on `None.strip()`
  - Changed `backend/app/services/report_agent.py` (+4/-4): Coerced `chat()` results with `or ""` before regex in the interactive chat path (no retry loop)

- `23c3430` — Fix report section crash on null agent interview response (#111)
  - Changed `backend/app/services/graph_tools.py` (+5/-1): Coerced `None`/empty to `""` inside `_clean_tool_call_response` — the running-simulation API can return explicit `"response": null`, and `dict.get(key, "")` does NOT coerce `None` to `""`. The `re.sub` regex then crashed on `NoneType`

**Impact:** Apple Silicon users can now run simulations with the reranker enabled out-of-the-box (CPU fallback). Report generation no longer fails entire sections when an LLM returns a null response on a turn or when the simulation API returns null interview data.

### UX Improvement: Regenerate Report Button (#113)
**Summary:** Surfaced the existing `force_regenerate` backend path in the report UI, giving users a one-click way to re-run a report from scratch.

**Commits:**
- `45106c2` — Add "Regenerate Report" button to the report view (#113)
  - Changed `frontend/src/components/Step4Report.vue` (+96/-1): New orange regenerate button shown after report completion, alongside existing export buttons. Calls `generateReport(force_regenerate)`, routes to the fresh `report_id` (which triggers the existing `reportId` watcher to reset state and restart polling). Includes spinning SVG icon during regeneration, bilingual labels, disabled state handling

**Impact:** Users no longer need to manually trigger a new report via API when a report produces unsatisfactory results — the UI now exposes the capability directly.

### Code Quality: 8-Pass Cleanup (#116)
**Summary:** A systematic 8-pass code-quality sweep touching 61 files: removed dead code, deduplicated shared logic, tightened types, cleaned up error handling, and documented the full audit trail. Net reduction of ~238 lines from the deleted `retry.py` module alone.

**Commits:**
- `a9eab1e` — chore: 8-pass code-quality cleanup (DRY, types, dead code, error-handling) (#116)
  - **Dead code removal:** Deleted `backend/app/utils/retry.py` (-238 lines, zero references repo-wide). Removed 27 unused imports and 4 dead local variables across the codebase (verified via ruff F401/F841)
  - **DRY extraction:** `badge_service.py` (+37/-109): Extracted shared `_build_badge_document()` from duplicate SVG-badge builders; output stays bytewise-deterministic for caching/ETags. `event_logger.py` (+52/-24): Extracted shared `_build_event()` from `write_simulation_event`/`EventLogger.emit`; JSONL key order unchanged
  - **Type deduplication:** 3 run scripts (`run_twitter_simulation.py`, `run_reddit_simulation.py`, `run_parallel_simulation.py`) each redefined identical `CommandType` class — replaced with imports of canonical `CommandType(str, Enum)` from `simulation_ipc.py`
  - **Type strengthening:** `webhook_service.py` (+43/-6): Added `WebhookPayload` TypedDict + typed webhook state param as `Optional[SimulationRunState]`. Tightened weak annotations across storage, services, models, and sim engine (Literal/Optional/concrete generics/callback shapes)
  - **Error handling:** Narrowed 5 hot-path `except Exception: pass` to specific exception types (OSError, JSONDecodeError, UnicodeDecodeError) + debug logging. Fixed latent F821 forward-ref bugs in `simulation_manager.py` and `simulation_runner.py`
  - **Comment cleanup:** Dropped stale TODOs, rewrite change-history comments as durable WHY comments. Removed dangling CSS tombstone in `Step4Report.vue`
  - **Documentation:** 8 cleanup docs in `docs/cleanup/` (00-SUMMARY through 08-slop) documenting the full audit, deferred items, and rationale for intentionally-kept patterns
  - Tests: 971 passed / 2 pre-existing failures (unchanged). Ruff: 158 → 156 warnings

**Impact:** Cleaner codebase with fewer import warnings, no dead utility code, stronger type annotations, and narrower exception handling. The cleanup documentation provides a roadmap for future deferred items.

### Community Contribution (#114)
**Summary:** A community member added a new ecosystem partner.

**Commits:**
- `9bf47ec` — Update ECOSYSTEM.md (#114) by shak
  - Changed `ECOSYSTEM.md` (+1/-1): Added ZER0 to the ecosystem partners list — the 5th external contributor to the project

**Impact:** Growing ecosystem visibility; ZER0 joins as a named integrator alongside existing partners.

---

## aaronjmars/miroshark-aeon

### Skill Pruning (#47)
**Summary:** Disabled 5 scheduled skills to reduce CI noise and focus compute on the most impactful daily workflows.

**Commits:**
- `c19e47a` — chore(skills): disable 5 scheduled skills in aeon.yml (#47)
  - Changed `aeon.yml` (+5/-5): Disabled `hyperstitions-ideas`, `skill-leaderboard`, `ai-framework-watch`, `tweet-allocator`, and `fetch-tweets`

**Impact:** Leaner daily skill schedule — removes tweet-related workflows and lower-priority weekly tasks. Core daily cycle (token-report, repo-pulse, push-recap, repo-article, project-lens, feature, heartbeat) continues.

### Daily Skill Cycle
**Summary:** Normal Tuesday skill execution — all scheduled skills ran successfully.

- token-report (06:42 UTC): $0.00001328, +5.28% 24h
- fetch-tweets (06:42 UTC): Completed before disable took effect
- tweet-allocator (08:13 UTC): Completed before disable took effect
- repo-pulse (10:54 UTC): 1,205 stars, 255 forks
- star-momentum-alert (10:55 UTC): Ran, no alert triggered
- star-milestone (16:10 UTC): 1,205 stars — next milestone 1,500
- feature (12:21 UTC): Completed
- push-recap (16:13 UTC): Completed (this run)
- project-lens (16:13 UTC): Ecosystem-map article (+42 lines)
- repo-article (16:14 UTC): Completed

---

## Developer Notes
- **New dependencies:** None. Per-agent sparklines service is pure stdlib (json + os), continuing the zero-dependency streak since Nemotron-Personas (6 PRs ago)
- **Breaking changes:** None. All new endpoints are additive; the reranker device change defaults to the same behavior on Linux/CUDA hosts
- **Architecture shifts:** The sparklines surface transposes the trajectory.json data (agents × rounds instead of rounds × agents), establishing a pattern for future per-agent analytics surfaces
- **Tech debt:** Cleanup PR (#116) documents deferred items in `docs/cleanup/` — notify-channel cluster, sim runner scripts, belief-math helpers, publisher HTTP helpers, share-image font helpers, Vue view CSS/JS, stance-colour constants, base-url resolvers, and test fixtures are intentionally deferred with specific semantic obstacles documented for each

## What's Next
- The sparklines surface (#115) is the 23rd share surface — the analytical instrumentation layer (signal → calibration → confidence → peak-round → sparklines) is now complete from aggregate to per-agent granularity
- The cleanup PR (#116) documents a set of deferred DRY candidates and type improvements that could be picked up as follow-on work
- ZER0 ecosystem addition (#114) continues the community contributor trend — now 5 external contributors, tracking toward the 10-merged-PR-by-August-1 hyperstition target (currently 3/10)
- The 5 disabled skills in aeon (#47) suggest a strategy shift toward focusing CI compute on higher-impact workflows
