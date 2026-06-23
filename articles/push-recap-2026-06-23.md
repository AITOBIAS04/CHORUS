# Push Recap — 2026-06-23

## Overview
6 substantive commits by 2 authors (aaronjmars, aeonframework) across 2 repos, with 28 automation commits filtered. The main thrust was a model migration (Mimo V2 Flash delisted, replaced by V2.5), a branding refresh to the new "$1" tagline, a major code-quality cleanup that removed 680 lines of dead code, and a new CLI cost subcommand that makes per-run pricing verifiable from scripts.

**Stats:** ~81 file changes, +735/-1,226 lines across 6 substantive commits

---

## aaronjmars/MiroShark

### Model Migration: Mimo V2 Flash Delisted, V2.5 Takes Over
**Summary:** Xiaomi's mimo-v2-flash was delisted from OpenRouter, forcing a comprehensive swap to mimo-v2.5 across the entire stack. A follow-up fix ensures blank env vars fall back to the new default instead of sending an empty model name that 400s.

**Commits:**
- `ec707cd` — chore(models): switch default model from mimo-v2-flash to mimo-v2.5 (#207)
  - Changed `backend/app/config.py`: Updated default model name from `xiaomi/mimo-v2-flash` to `xiaomi/mimo-v2.5` in both the Default and Wonderwall slot comments (+3, -3 lines)
  - Changed `backend/app/api/settings.py`: Updated the Cloud preset label and model fields — "Cloud — ~$1/run (Mimo V2.5 + Gemini 3 Flash)" (+3, -3 lines)
  - Changed `backend/app/utils/run_summary.py`: Updated MODEL_PRICING table — mimo-v2.5 rates at $0.14/M in, $0.28/M out (was $0.10/$0.40) (+1, -1 line)
  - Changed `.env.example`: Swapped model names in LLM_MODEL_NAME, WONDERWALL_MODEL_NAME, and CoT disable comment (+4, -4 lines)
  - Changed `cloudrun.env.yaml.example`, `railway.env.example`: Updated deploy template model references (+1, -1 each)
  - Changed `frontend/src/components/SettingsPanel.vue`: Updated Wonderwall input placeholder (+1, -1 line)
  - Changed `docs/MODELS.md`, `docs/MODELS.zh-CN.md`: Updated Cloud mode tables and prose in EN and ZH (+4, -4 each)
  - Changed `docs/CONFIGURATION.md`, `docs/CONFIGURATION.zh-CN.md`, `docs/INSTALL.md`, `docs/INSTALL.zh-CN.md`: Model references updated across all install/config docs (+2-3, -2-3 each)
  - Changed all four READMEs (EN, ZH, JA, FR): Updated quickstart comment to say "Mimo V2.5" (+1, -1 each)
  - Added `backend/events.jsonl` to `.gitignore` (runtime EventLogger artifact) (+1 line)

- `35206d5` — fix(config): fall back to default when LLM_MODEL_NAME is blank (#210)
  - Changed `backend/app/config.py`: `os.environ.get('LLM_MODEL_NAME', 'xiaomi/mimo-v2.5')` → `os.environ.get('LLM_MODEL_NAME') or 'xiaomi/mimo-v2.5'` — `get()` with a default returns the empty string when the var is set-but-blank, so the previous code sent an empty model name that 400'd with "no model provided". The `or` pattern correctly falls through. Spotted by @tomer-liran in #204. (+1, -1 line)

**Impact:** All new installs and Cloud preset runs now use mimo-v2.5 by default. Existing deployments with `LLM_MODEL_NAME=` (blank) no longer break on startup. Pricing accuracy improved — run cost estimates now reflect the real mimo-v2.5 rates.

---

### Branding Refresh: New Tagline & Production Domain
**Summary:** The "Universal Swarm Intelligence Engine" branding is retired in favor of "Simulate anything, for $1 & less than 10 min." across all user-facing surfaces. OpenRouter attribution headers now point at the production domain (miroshark.xyz) instead of the GitHub repo.

**Commits:**
- `fc69fb4` — chore(branding): adopt new tagline and point OpenRouter attribution at miroshark.xyz (#206)
  - Changed `README.md`, `README.zh-CN.md`, `README.ja.md`, `README.fr.md`: Removed "— Universal Swarm Intelligence Engine" suffix from the hero tagline in all four languages (+1, -1 each)
  - Changed `CLAUDE.md`: Updated project description to lead with the new tagline (+1, -1 line)
  - Changed `backend/pyproject.toml`: Project description now reads "Simulate anything, for $1 & less than 10 min." (+1, -1 line)
  - Changed `backend/openapi.yaml`: OpenAPI summary updated (+1, -1 line)
  - Changed `backend/app/utils/llm_client.py`: HTTP-Referer → `https://www.miroshark.xyz/`, X-OpenRouter-Title → new tagline (+2, -2 lines)
  - Changed `backend/app/storage/embedding_service.py`: Same OpenRouter header update (+2, -2 lines)
  - Changed `backend/scripts/run_parallel_simulation.py`, `run_reddit_simulation.py`, `run_twitter_simulation.py`: OpenRouter attribution headers updated in all three simulation runners (+2, -2 each)
  - Changed `frontend/src/views/Home.vue`: Hero chip changed from "Universal Swarm Intelligence Engine" to "Your first result in under 10 minutes" (+1, -1 line)

**Impact:** Consistent messaging across all surfaces — the value prop ("$1, <10 min") is now front-and-center instead of the abstract "swarm intelligence engine" label. OpenRouter analytics will track usage under the production domain.

---

### New CLI Feature: Cost Subcommand
**Summary:** A new `miroshark cost <sim_id>` command surfaces the per-run USD estimate at the command line, making the "$1 to simulate anything" claim verifiable from scripts and CI.

**Commits:**
- `cef787b` — feat(cli): add cost subcommand surfacing per-run USD estimate (#208)
  - Changed `backend/cli.py`: New `cmd_cost()` function (+34 lines) — calls `/api/simulation/<id>/cost.json`, formats output as `~$0.9213  (1,284,902 tokens, 871 LLM calls)` with per-phase breakdown (graph_build, simulation, report). The `~` prefix mirrors the EmbedView cost pill, marking it as a lower-bound estimate. Exit code 2 when cost isn't available yet.
  - Changed `backend/tests/test_unit_cli.py`: Added `cost` to expected subcommands set and a new `test_cost_parses_positional` test verifying argument parsing (+9 lines)
  - Changed `docs/CLI.md`: New "Cost" section with usage example and exit code documentation (+20 lines)
  - Changed `docs/CLI.zh-CN.md`: Chinese translation of the Cost section (+18 lines)

**Impact:** Operators and CI pipelines can now programmatically verify run costs. Combined with the branding refresh, the "$1" claim is no longer just marketing — it's a `--json`-parseable assertion.

---

### Major Code-Quality Cleanup (680 Lines Removed)
**Summary:** An 8-agent audit produced a surgical cleanup across 36 files — removing dead code, extracting shared patterns, narrowing error handling, and adding proper type annotations. Net result: 680 fewer lines of logic with no behavior change, gated on pytest (1,424 pass), ruff, and the Vite build.

**Commits:**
- `6cf32a8` — refactor: code-quality cleanup across backend and frontend (#205)
  - **Dead code removed (verified zero callers):**
    - `backend/app/services/simulation_ipc.py`: Gutted `SimulationIPCServer` (-106 lines)
    - `backend/app/services/graph_builder.py`: Removed `build_graph_async` and `_build_graph_worker` (-165 lines)
    - `backend/app/services/dkg_publisher.py`: Removed health_check + probe constants (-34 lines)
    - `backend/app/services/waybackclaw_publisher.py`: Same cleanup (-34 lines)
    - `backend/app/services/graph_memory_updater.py`: Removed `get_all_stats` (-8 lines)
    - Frontend: 6 unused axios wrappers removed from `simulation.js` (-61), `observability.js` (-16), `report.js` (-8); legacy `toggleLocale` from `i18n.js` (-9); orphaned entity-card CSS from `Step4Report.vue` (-41)
  - **DRY extractions:**
    - New `backend/app/services/simulation_run_state.py` (+184 lines): Leaf module with `RunnerStatus`, `AgentAction`, `RoundSummary`, `SimulationRunState` — eliminates 5 `TYPE_CHECKING` import shims that existed only to break circular deps
    - New `backend/app/services/_notify_base.py` (+82 lines): Shared per-channel `Dedup` class + parameterized `post_json` — telegram, discord, slack, email notifiers each dropped 20-40 lines of duplicated HTTP/dedup logic
    - `simulation_runner.py`: `_fan_out_notifications` collapses the 3x notification dispatch (-359, +69 lines — largest single-file change)
    - `backend/app/utils/belief.py`: New `bucket_snapshots` function (+49 lines) centralizes the belief stance-bucketing that was inlined in 5 services (outcome_distribution, platform_stats, project_stats, activity_feed, batch_status — each dropped ~23 lines)
  - **Error handling (no error hiding):**
    - `backend/app/api/observability.py`: Three `except Exception: pass` blocks narrowed to `except OSError` (+3, -3)
    - `backend/app/api/simulation.py`: Narrowed dead `except (X, Exception)` tuples (+4, -4)
    - `backend/app/services/graph_tools.py`: Similar narrowing (+6, -2)
    - `backend/wonderwall/social_platform/recsys.py`: Removed two `pdb.set_trace()` debugger breakpoints (+3, -11)
  - **Type annotations:**
    - `backend/app/api/mcp.py`: Added `ResolvedPaths` TypedDict replacing `Dict[str, str]` (+11, -3)
    - `backend/app/models/project.py`: Added `RunInstructions` and `SavedFileInfo` TypedDicts (+10, -2)
    - `backend/app/services/wonderwall_profile_generator.py`: `Optional[callable]` → `Optional[Callable[...]]` (+2, -2)
  - Total: 36 files, +484/-1,164 lines

**Impact:** The codebase is measurably cleaner — 680 fewer lines, 5 fewer circular-import shims, zero dead async code paths, no stray debugger breakpoints. The notification pipeline went from 3 copy-pasted dispatch blocks to one shared helper. Two pre-existing bugs (Project.chunk_size 3-way default mismatch, repro_export director-events filename) were documented but left for maintainer decision.

---

## aaronjmars/miroshark-aeon

### Aeon Self-Improvement: Token Report X Sentiment Prefetch
**Summary:** The token-report skill's Social Pulse section was silently degrading to `xai=skip` on every run because the GitHub Actions sandbox blocks env-var-in-header curl calls to api.x.ai. This fix adds a prefetch case so X sentiment is cached before the sandbox starts.

**Commits:**
- `b74f038` — fix(token-report): prefetch X sentiment so Social Pulse stops silently skipping (#74)
  - Changed `scripts/prefetch-xai.sh`: Added `token-report)` case (+21 lines) — derives tracked token symbol and contract from `memory/MEMORY.md`, builds an X search query like `$MIROSHARK or 0xd7bc...`, and caches the response to `.xai-cache/token-report-social.json` before Claude starts. Mirrors the tweet-digest prefetch pattern (PR #67).
  - Changed `skills/token-report/SKILL.md`: Updated step 6 to read the cache file first, with live curl as a non-sandbox fallback. Added a "Sandbox note" section documenting the pre-fetch pattern. (+15, -2 lines)
  - Changed `.outputs/self-improve.md`: Updated latest output to reflect this fix (+1, -1)
  - New file `apps/dashboard/outputs/self-improve-2026-06-22T14-40-30Z.json`: Dashboard card for this improvement (+61 lines)
  - Changed `memory/logs/2026-06-22.md`: Logged fix details and evidence (+8 lines)
  - Changed `memory/skill-health/self-improve.json`: Score 4, avg 4.4 (+7, -3)
  - Changed `memory/token-usage.csv`: Added self-improve token usage entry (+1 line)

**Impact:** Token reports will now include actual X/Twitter sentiment data instead of silently skipping it every run. The 3-day streak of `xai=skip` (Jun 20-22) should end with the next token-report run. This was the last X.AI consumer without a prefetch case.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** `xiaomi/mimo-v2-flash` is delisted from OpenRouter — any deployment still referencing it will fail. Must update to `xiaomi/mimo-v2.5` (or override with another model). The blank `LLM_MODEL_NAME=` edge case is now handled gracefully.
- **Architecture shifts:** New `simulation_run_state.py` leaf module decouples runner state types from the runner itself — eliminates 5 circular-import shims. New `_notify_base.py` standardizes notification channel HTTP/dedup logic.
- **Tech debt:** Two pre-existing bugs documented but unresolved: `Project.chunk_size` 3-way default mismatch, `repro_export` director-events filename. Left for maintainer decision.

## What's Next
- The mimo-v2.5 migration is complete but deployments need to pull the latest `.env.example` — existing installs with `mimo-v2-flash` hardcoded will start failing.
- With the cost CLI subcommand landed, CI pipelines could now gate on cost thresholds (e.g., fail if a simulation exceeds $2).
- The token-report prefetch fix should produce the first `xai=ok` Social Pulse section on the next run — worth monitoring.
- The branding refresh is code-complete; any remaining "Universal Swarm Intelligence Engine" references in external docs or marketing materials need manual cleanup.
- The 680-line code cleanup leaves the codebase significantly leaner for the next feature cycle — the notification DRY extraction in particular unblocks adding new channels with minimal code.
