# Push Recap — 2026-06-24

## Overview
5 substantive commits by 2 authors (37 automation commits filtered). The main thrust today was hardening MiroShark's LLM pipeline for thinking/reasoning models — a multi-file robustness sweep from community contributor Daniel Andersen, complemented by follow-up fixes from @aaronjmars. On the feature side, a new CLI `wait` subcommand enables scripted automation to block on running simulations without hand-rolling polling loops.

**Stats:** 19 file changes, +332/-35 lines across 5 substantive commits

---

## aaronjmars/MiroShark

### New Feature: CLI `wait` Subcommand
**Summary:** A new `wait` command joins the CLI toolkit, letting scripts block until a simulation run reaches a terminal state. This is the missing link for scripted automation pipelines — previously you'd need to build your own polling loop against `status`.

**Commits:**
- `959aef8` — feat(cli): add wait subcommand to block until a simulation finishes (#215)
  - New `cmd_wait()` in `backend/cli.py`: polls `/api/simulation/<id>/run-status` with configurable `--interval` (default 5s) and `--timeout` (default 600s). Exit codes: `0` completed, `1` failed/stopped, `2` timeout (+69 lines)
  - Progress lines (`[running] round 12/144`) print to stderr so stdout stays clean for `--json` piping
  - Transient poll errors (5xx, dropped connections) are treated as retryable with a warning, not as terminal failures — a network blip won't be mistaken for a genuinely failed simulation
  - Added `build_parser()` registration with `--interval`, `--timeout`, `--json` flags (+14 lines)
  - `backend/tests/test_unit_cli.py`: new `test_wait_defaults_and_overrides()` verifying default values and float parsing (+15 lines)
  - `docs/CLI.md`: full documentation with usage example (`wait "$SIM" && report "$SIM"`), exit code table, stderr behavior (+19 lines)
  - `docs/CLI.zh-CN.md`: Chinese translation of the same docs (+18 lines)

**Impact:** Scripts and CI pipelines can now chain `wait` → `report` (or any post-run action) without building polling infrastructure. The transient-error resilience means long-running simulations won't falsely fail on a brief network hiccup.

---

### Thinking Model Robustness
**Summary:** A comprehensive hardening pass across 8 backend files makes MiroShark's LLM pipeline resilient to reasoning/thinking models (deepseek-v4-flash, Qwen3, etc.) that emit `<think>` blocks, sometimes return empty responses after thinking, and occasionally produce malformed JSON. This is critical as the project migrated to mimo-v2.5 and supports community-contributed model configurations.

**Commits:**
- `7a9dffa` — fix(llm): thinking model robustness — budget, JSON repair, None guards (#209) — by **Daniel Andersen**
  - `backend/app/config.py`: new `THINKING_BUDGET_TOKENS` env var (default 0) with `validate()` warning when it conflicts with `LLM_DISABLE_REASONING=true` (+16 lines)
  - `backend/app/utils/llm_client.py`: pads `max_tokens` with thinking budget so the model has headroom for both `<think>` blocks and actual response; strips unclosed `<think>` blocks (previously only matched `<think>...</think>` pairs); returns `None` on empty content after stripping so callers' retry logic engages instead of hitting cryptic JSON parse errors (+18/-2 lines)
  - `backend/app/utils/json_repair.py`: strips control characters and fixes invalid backslash escapes (Windows paths like `\U`, LaTeX-style `\f`, `\p`) by converting non-standard escapes to double-backslash (+6 lines)
  - `backend/app/services/graph_tools.py`: added `repair_truncated=True` to `chat_json()` calls; new plain-text fallback for sub-queries — when the model returns a numbered/bulleted list instead of JSON, regex-extracts question lines (+33/-17 lines)
  - `backend/app/services/simulation_config_generator.py`: `None` guard before `json.loads` on LLM response (+5 lines)
  - `backend/app/services/wonderwall_profile_generator.py`: same `None` guard before `json.loads` (+5 lines)
  - `backend/app/storage/ner_extractor.py`: `repair_truncated=True` on `chat_json()` call (+1 line)
  - `backend/app/storage/contradiction_detector.py`: `repair_truncated=True` on `chat_json()` call (+1 line)
  - `backend/scripts/run_parallel_simulation.py`: passes `max_tokens = 4096 + thinking_budget` to CAMEL `ModelFactory.create()` so thinking models don't exhaust their token pool on `<think>` blocks before emitting tool-call JSON (+12/-2 lines)

- `9097055` — fix(graph): restore semantic default fan-out in sub-query fallback (#211)
  - `backend/app/services/graph_tools.py`: PR #209's total-failure fallback had narrowed PanoramaSearch to a single bare `[query]`, losing the 4-way semantic fan-out (participants / causes & impacts / development process). Restored the richer default so breadth search still explores those facets when the LLM fails to produce sub-questions (+8/-1 lines)

- `35206d5` — fix(config): fall back to default when LLM_MODEL_NAME is blank (#210)
  - `backend/app/config.py`: changed from `os.environ.get('LLM_MODEL_NAME', 'xiaomi/mimo-v2.5')` to `os.environ.get('LLM_MODEL_NAME') or 'xiaomi/mimo-v2.5'` — a present-but-empty `LLM_MODEL_NAME=` now resolves to the default instead of sending an empty model name that 400s with "no model provided". Spotted by @tomer-liran in #204 (+1/-1 lines)

**Impact:** Thinking models (deepseek-v4-flash, Qwen3, MiniMax M2.5) now work reliably in the full simulation pipeline — from config generation to NER extraction to graph reasoning to parallel simulation. Previously, `<think>` blocks could cause empty responses, truncated JSON, and exhausted token budgets. The JSON repair improvements also benefit non-thinking models that occasionally produce malformed output.

---

## aaronjmars/miroshark-aeon

### Observability: Token Report Prefetch Health
**Summary:** The `xai=skip` footer flag in token reports was overloaded — it meant both "prefetch worked but market chatter is quiet" and "no data was fetched at all." After the Jun 22 self-improve fix (PR #74) added a prefetch case for token-report, 5 consecutive days still showed `xai=skip` with no way to tell if the fix took effect. This commit makes the distinction observable.

**Commits:**
- `df3bb56` — fix(token-report): split xai=skip into quiet vs skip so prefetch health is observable (#75)
  - `skills/token-report/SKILL.md`: rewrote step 6 logic with four distinct states: `xai=ok` (≥2 tweets clearing engagement bar), `xai=quiet` (cache present, <2 qualifying tweets — prefetch is working, market is just quiet), `xai=skip` (cache missing / key unset — no data fetched), `xai=fail` (API error payload). Updated both footer legends (+24/-7 lines)
  - Added caveat: `prefetch-xai.sh` only writes cache on HTTP 200, so an API error surfaces as `xai=skip` not `xai=fail` — check daily log for `## XAI Prefetch Error` block to distinguish
  - `.outputs/self-improve.md`: updated output summary (+1/-1)
  - `apps/dashboard/outputs/self-improve-2026-06-24T13-07-55Z.json`: dashboard card for the improvement (+64 lines, new file)
  - `memory/logs/2026-06-24.md`: detailed problem/fix/evidence log entry (+8 lines)
  - `memory/skill-health/self-improve.json`: scored this run at 4/5, updated avg to 4.33 (+7/-3 lines)

**Impact:** Operators can now distinguish a broken prefetch from a quiet market at a glance in the daily token report footer. A run of `xai=skip` unambiguously flags a prefetch problem; `xai=quiet` confirms it's working.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None — `wait` is additive; the `xai=quiet` state is a new value in the footer legend (existing parsers looking for `xai=skip` still match cache-missing runs)
- **Architecture shifts:** The `THINKING_BUDGET_TOKENS` pattern is a clean opt-in for thinking models — zero by default, no behavior change for existing deployments. The plain-text fallback in `_generate_sub_queries` establishes a precedent for gracefully degrading when LLM JSON output fails
- **Tech debt:** The `xai=skip` vs `xai=fail` distinction for API errors during prefetch relies on checking a separate log block — could be improved by having `prefetch-xai.sh` write a status file alongside the cache

## What's Next
- The `wait` command enables more sophisticated CLI automation — expect scripted simulation pipelines (run → wait → report → notify) to appear in CI or user workflows
- The thinking model robustness work (#209) is a foundation — if mimo-v2.5 or another thinking model becomes the default, the pipeline is ready
- The `xai=quiet` vs `xai=skip` split will reveal whether the X-sentiment prefetch (PR #74, merged Jun 23) is actually producing cache files in the next token-report run
- @tomer-liran's #204 issue suggests community members are actively testing different model configurations — more config-edge-case fixes may follow
