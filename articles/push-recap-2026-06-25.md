# Push Recap — 2026-06-25

## Overview
8 substantive commits by 2 authors (Daniel Andersen and @aaronjmars) across 2 repos, with 38 automation commits filtered. The main thrust: a comprehensive interview-system hardening pass that eliminates silent hangs in batch interviews with slow thinking models, paired with local-LLM infrastructure tuning and a new CLI `stop` subcommand that completes the automation lifecycle.

**Stats:** 24 files changed, +583/-135 lines across 8 substantive commits

---

## aaronjmars/MiroShark

### Interview System Hardening
**Summary:** Batch interviews with slow thinking models (e.g. reasoning-heavy LLMs running on local hardware) could hang silently or fail with opaque error messages. This PR bundles engine, worker, API, and UI-level fixes to surface errors immediately and prevent infinite blocking at every layer of the interview pipeline. Also fixes the simulation stop lifecycle so intentional stops no longer trigger spurious failure notifications.

**Commits:**
- `8bbf206` — fix(interview): Persona-interviews hang prevention, error surfacing, and stop-lifecycle fixes (#214)
  - Changed `backend/app/api/simulation.py`: Raised IPC poll timeout from 60s/120s to 240s for slow thinking models; added stale RUNNING/STARTING state reset in `_ensure_env_alive()` before env-only restart; interview endpoints now return HTTP 400 with the real error message instead of silently succeeding with `success: false` in the body (+34/-8 lines)
  - Changed `backend/app/services/graph_tools.py`: Agent name matching now checks Reddit `name` and `profession` fields in addition to `realname`/`username`; strips parenthetical follower-count qualifiers like "(1.2M)" that the LLM appends to archetype labels (+15/-4 lines)
  - Changed `backend/app/services/simulation_ipc.py`: `check_env_alive()` now verifies PID liveness even when the status file says "alive" — catches crashed workers that left stale status files (+8/-1 lines)
  - Changed `backend/app/services/simulation_runner.py`: SIGTERM grace period increased 10s→30s so in-flight LLM calls can finish; monitor no longer overwrites STOPPED with FAILED on intentional -9 exit; failure notification fan-out moved inside the genuine-failure branch so intentional stops don't page operators (+34/-23 lines)
  - Changed `backend/scripts/run_parallel_simulation.py`: Wrapped `env.step()` calls in `asyncio.wait_for(220s)` so the worker always sends a timely IPC response; captured platform exceptions into the IPC "failed" error with combined error reporting across Twitter/Reddit platforms (+32/-10 lines)
  - Changed `backend/wonderwall/environment/env.py`: `_is_interview_action()` uses `getattr` to avoid `AttributeError`; skips `update_rec_table()` on interview-only steps since the synchronous PyTorch/twhin-bert call blocks the asyncio loop and defeats the worker timeout (+12/-3 lines)
  - Changed `backend/wonderwall/social_agent/agent.py`: Added logging around LLM interview calls; raises `RuntimeError` when LLM returns None/empty response with the agent ID for traceability (+7/-0 lines)
  - Changed `backend/wonderwall/social_platform/platform.py`: `running()` method now wraps action dispatch in try/except, sends None back on error instead of dying; unknown `ActionType` continues instead of raising, preventing a dead loop that blocked `perform_action` forever (+47/-26 lines)
  - Changed `frontend/src/api/simulation.js`: Dropped `requestWithRetry` wrapper on `interviewAgents` — retries just queue duplicate requests against a potentially stuck endpoint (+1/-1 lines)
  - Changed `frontend/src/components/Step5Interaction.vue`: Added visible error box (`survey-error` div) on survey submission failure so users see what went wrong (+19/-3 lines)

**Impact:** Eliminates the entire class of silent interview hangs. Operators running batch interviews with local thinking models will see clear error messages instead of indefinite waiting. The stop-lifecycle fix prevents false "failed" alerts when deliberately stopping a simulation.

---

### Local LLM Performance & Infrastructure Tuning
**Summary:** Operational tuning for self-hosters running MiroShark with local LLMs (Ollama) and Neo4j. Reduces JSON truncation from oversized batches, pre-warms the recommendation model during visible setup instead of Round 1, and hardens the Docker infrastructure with health checks and persistent caching.

**Commits:**
- `25e62b4` — chore: performance and robustness tuning for local LLMs and infra (#212)
  - Changed `backend/app/services/simulation_config_generator.py`: `AGENTS_PER_BATCH` reduced 15→7 to avoid JSON truncation with local LLMs; entity/agent summary lengths increased 300→500 chars for richer context; added name-based lookup in initial-post agent matching as a fallback before alias/influence matching (+13/-7 lines)
  - Changed `backend/app/storage/neo4j_storage.py`: `_ensure_schema()` now calls `.consume()` on schema DDL results to surface failures; added 5-attempt exponential-backoff retry for the Neo4j startup race condition common on fresh container start (+22/-7 lines)
  - Changed `backend/app/utils/logger.py`: Console handler now honors `MIROSHARK_LOG_LEVEL` env var so Docker Compose logs can show DEBUG output (+5/-3 lines)
  - Changed `backend/scripts/run_parallel_simulation.py`: Pre-warms twhin-bert-base recommendation model during setup phase so the ~3-5 min model load is visible instead of delaying Round 1 (+10/-0 lines)
  - Changed `backend/wonderwall/social_agent/agent.py`: Pops `num_tokens` kwarg before `super()._aget_model_response()` for CAMEL forward-compatibility (Docker py3.14 build dropped the kwarg) (+5/-0 lines)
  - Changed `docker-compose.yml`, `docker-compose.ollama.yml`, `docker-compose.traefik.yml`: Added Neo4j healthcheck with `service_healthy` gating so the app container waits for Neo4j; persistent `hf_cache` volume for HuggingFace models; `--add-modules jdk.incubator.vector` for SIMD-accelerated Neo4j vector operations (+37/-5 lines across 3 files)

**Impact:** Self-hosters on local hardware get faster simulation starts (no Round 1 model load delay), fewer JSON truncation errors with smaller LLMs, and more resilient container orchestration. The Neo4j retry loop alone eliminates a common first-run failure on fresh Docker deployments.

---

### i18n Locale Persistence Fix
**Summary:** Non-English simulations using reasoning/thinking models drifted back to English output over multiple rounds because the one-time system-prompt language instruction was diluted by accumulated English environment observations. Three fixes at the agent, report worker, and trace recorder levels.

**Commits:**
- `cf0b980` — fix(i18n): keep non-English locale in agent actions and report sections (#213)
  - Changed `backend/wonderwall/social_agent/agent.py`: Appends a locale-aware language directive to every per-round user message in `perform_action_by_llm()`, reinforcing the language instruction that gets diluted by English observations over many rounds. Supports EN, ZH, DE, FR (+12/-1 lines)
  - Changed `backend/app/services/report_agent.py`: Added `contextvars.copy_context().run()` for `ThreadPoolExecutor` workers so the active-locale `ContextVar` propagates into workers (not inherited on Python <3.12); each worker gets its own `ReasoningTraceRecorder` so concurrent `finalize_section()` calls no longer clobber a shared recorder's `current_section_uuid` state (+47/-17 lines)

**Impact:** Fixes a recurring regression where Chinese, German, and French simulations produced English-language agent responses and report sections. The `contextvars` fix is particularly important for Python <3.12 environments where `ThreadPoolExecutor` workers don't inherit context variables automatically.

---

### CLI Automation: `stop` Subcommand
**Summary:** The `wait` subcommand (shipped yesterday as PR #215) blocks until a simulation reaches a terminal state but had no escape hatch — a hung or timed-out run could not be cancelled from the CLI. `stop` completes the automation lifecycle.

**Commits:**
- `ed3cfd0` — feat(cli): add stop subcommand to cancel a running simulation (#216)
  - Changed `backend/cli.py`: New `cmd_stop()` function POSTs to `/api/simulation/stop` with the simulation ID; prints `<sim_id> stopped` on success; supports `--json` for raw payload output (+24/-0 lines)
  - Changed `backend/tests/test_unit_cli.py`: Added `test_stop_parses_positional` confirming the subparser registers correctly; updated subcommand set assertion to include `stop` (+9/-1 lines)
  - Changed `docs/CLI.md`: Added `stop` to command table, new `## Stop` section documenting the `wait || stop` recovery pattern (+16/-0 lines)
  - Changed `docs/CLI.zh-CN.md`: Chinese-language equivalent of the stop documentation (+15/-0 lines)

- `e0811ee` — docs(cli): clarify --json must precede the stop subcommand (#217)
  - Changed `docs/CLI.md`, `docs/CLI.zh-CN.md`: Fixed `--json` placement — it's a global flag on the parent parser, so `cli.py stop <id> --json` errors; docs now show the correct `cli.py --json stop <id>` form (+2/-2 lines)

**Impact:** Integrators can now write `python -m cli wait "$SIM" --timeout 600 || python -m cli stop "$SIM"` to bound a run and clean up on timeout. Previously, cancelling a stuck simulation required raw-curling the `/api/simulation/stop` endpoint.

---

## aaronjmars/miroshark-aeon

### Aeon Schedule Tuning — Lean Watch-and-Report Loop
**Summary:** Major schedule overhaul that pauses all build and content generation skills and stretches cadences for the remaining watch/report skills. Mirrors the same change applied to the aeon-agent repo.

**Commits:**
- `8ba4ea3` — chore(aeon): pause build/content skills, reschedule memory-flush + shiplog
  - Changed `aeon.yml`: Disabled 9 skills (feature, self-improve, repo-actions, thread-formatter, push-recap, repo-article, project-lens, star-milestone, star-momentum); rescheduled memory-flush from biweekly (Sun+Wed) to weekly (Sun); shiplog from weekly (Mon) to twice weekly (Mon+Thu) (+11/-11 lines)

- `64b6cad` — chore(aeon): stretch docs-sync to every 3 days, repo-pulse to every 2 days
  - Changed `aeon.yml`: docs-sync daily→every 3 days; repo-pulse daily→every 2 days (+2/-2 lines)

**Impact:** Shifts the aeon instance from full autonomous operation to a lean monitoring loop. Only repo-pulse (every 2 days), docs-sync (every 3 days), token-report, heartbeat, shiplog (Mon+Thu), and memory-flush (Sunday) remain active. This reduces CI minutes and API spend while maintaining observability.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None — all API changes are additive (new error responses on interview endpoints are in failure paths that previously returned ambiguous 200s)
- **Architecture shifts:** The interview pipeline now has timeout enforcement at every layer (worker→IPC→API→frontend), eliminating the class of silent hangs. Docker Compose files now use health-check-gated service dependencies instead of simple ordering.
- **Tech debt:** None introduced. The `num_tokens` kwarg pop in `agent.py` is a forward-compatibility shim for the CAMEL library version gap between py3.12 and py3.14 Docker builds.

## What's Next
- PRs #212, #213, #214 are all authored by Daniel Andersen and merged today — the interview hang fix, local LLM tuning, and i18n locale persistence are all live on main
- The aeon schedule tuning (PR #76) pauses push-recap and most content skills — this may be the last push-recap for a while unless the schedule is re-enabled
- The `stop` CLI subcommand (#216) paired with `wait` (#215) from yesterday completes the CLI automation story for simulation lifecycle management
- The `--json` docs fix (#217) is a fast-follow correcting a flag placement issue introduced in the stop docs
