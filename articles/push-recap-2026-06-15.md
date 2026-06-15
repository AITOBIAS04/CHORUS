# Push Recap — 2026-06-15

## Overview
5 commits by 3 authors (Daniel Andersen, @aaronjmars, Claude Opus 4.8 co-authoring) across both watched repos. Today was a code-quality day — the main MiroShark repo got an aggressive round-2 cleanup that consolidated 12 duplicate helper functions into 3 shared utilities, narrowed exception handling across dozens of modules, and removed dead imports and AI-generated comment noise. A community contributor's same-origin API patch also landed, making MiroShark work behind LAN hostnames and custom domains for the first time.

**Stats:** 77 files changed, +1,580/-571 lines across 5 commits

---

## aaronjmars/MiroShark

### Code Quality: Round-2 Cleanup & Helper Consolidation
**Summary:** Two back-to-back PRs (#163 and #164) systematically paid down technical debt across the backend. The first ran an 8-pass sweep — DRY/dedup, type consolidation, dead code, circular deps, weak types, defensive exception narrowing, legacy/fallback audit, and AI slop removal. The second extracted the newly-exposed duplicate helpers into proper shared modules.

**Commits:**
- `1a35ba2` — chore: round-2 code-quality cleanup (DRY, types, weak-types, dead-imports, error-handling) (#163)
  - New file `backend/app/utils/json_io.py`: Shared `safe_load_json` helper extracted from 11 service modules that had byte-identical copy-pasted implementations (+37 lines). Net -192 lines across activity_feed, agent_export, agent_sparklines, batch_status, outcome_distribution, platform_stats, platform_status, project_stats, thread_formatter, trajectory_export, transcript
  - Changed `backend/app/services/webhook_service.py`: Added shared `build_test_payload()` factory consolidating 13-key test-event dicts that were duplicated across 4 notify channel modules (discord, email, slack, telegram) (+32 lines)
  - Changed `backend/app/api/simulation.py`: Narrowed bare `except` to specific `(OSError, ValueError, TypeError, json.JSONDecodeError)` on gallery card config parsing; strengthened return type of `_get_report_id_for_simulation` to `str | None` (+7/-7)
  - Changed `backend/app/storage/neo4j_storage.py`: Narrowed exception types, improved error context (+8/-4)
  - Changed `backend/app/utils/claude_code_client.py`: Narrowed exception handling (+9/-2)
  - Changed `backend/app/utils/llm_client.py`: Strengthened weak types (+12/-1)
  - Changed `backend/app/utils/event_logger.py`: Type cleanup (+8/-8)
  - Changed `backend/app/utils/trace_context.py`: Tightened types (+9/-7)
  - Changed `backend/app/utils/logger.py`: Cleaned up dead imports, streamlined (+9/-11)
  - Removed dead `# Get logger` / `# Set up logging` comments from `__init__.py`, `graph.py`
  - Removed dead imports from `project.py`, `task.py`, `report_agent.py`, `action_logger.py`, `HistoryDatabase.vue`
  - Cleaned up 7 test files: removed unused imports after service modules stopped re-exporting helpers
  - New docs `docs/cleanup/round2-00-SUMMARY.md` through `round2-08-slop.md`: 8 detailed cleanup audit documents (+1,098 lines of documentation across the cleanup sub-passes)
  - 47 files changed, +1,368/-317 lines

- `20aa674` — refactor: dedup utc-iso8601, avg_position, public-base-url helpers + drop dead settings import (#164)
  - New file `backend/app/utils/timeutils.py` (+13 lines): Shared `utc_iso8601()` — consolidated from 7 duplicate implementations across archive_service, dkg_publisher, notebook_export, outcome_distribution, repro_export, signal_service, signed_result, waybackclaw_publisher
  - New file `backend/app/utils/belief.py` (+24 lines): Shared `avg_position()` — consolidated from 4 duplicate implementations across agent_sparklines, thread_formatter, trajectory_export, transcript
  - New file `backend/app/utils/base_url.py` (+32 lines): Shared `resolve_public_base_url()` — consolidated from 3 duplicate implementations across feed, share, sitemap (note: watch.py and webhook_service.py intentionally keep their own resolvers)
  - Deleted 7 `_utc_iso8601`/`_now_iso` copies, 4 `_avg_position` copies, 3 `_resolve_base_url` copies, 1 dead `webhook_service` import from settings.py
  - 19 files changed, +90/-209 lines (net -119)

**Impact:** Any future fix to timestamp formatting, base-URL resolution, or belief averaging now happens in one place instead of 7–11. The narrowed exception types mean real bugs surface as actual tracebacks instead of being silently swallowed. The cleanup documentation serves as a living audit trail for code health decisions.

### Community Infrastructure: Same-Origin API & Neo4j 5.26
**Summary:** Daniel Andersen's PR (#159) removes the hardcoded `http://localhost:5001` API base from the frontend, replacing it with same-origin `/api` that works through Vite's dev proxy and any reverse-proxy deployment. Neo4j bumps from 5.15 to 5.26 for indexing reliability improvements.

**Commits:**
- `e01e495` — chore: same-origin API calls + neo4j 5.26 bump (#159)
  - Changed `frontend/src/api/index.js`: Default `baseURL` changed from `'http://localhost:5001'` to `''` (same-origin); added structured error extraction from API response bodies (+16/-5)
  - Changed `frontend/src/api/observability.js`: SSE EventSource path now works with same-origin or explicit API base (+3/-2)
  - Changed `frontend/vite.config.js`: Full rewrite — dynamic env loading via `loadEnv()`, auto-parses Traefik DNS vars (`DOMAIN_NAME`, `SUBDOMAIN`, `API_SUBDOMAIN`) for `allowedHosts`, configurable `VITE_DEV_API_PROXY` target, `host: true` for network access (+66/-27)
  - Changed `.env.example`: Added `VITE_API_BASE_URL`, `VITE_DEV_ALLOWED_HOSTS`, `VITE_DEV_API_PROXY` documentation (+7)
  - Changed `docker-compose.yml`: neo4j image 5.15-community → 5.26-community (+1/-1)
  - Changed `backend/requirements.txt`: neo4j>=5.26.0 (+1/-1)
  - Changed `docs/INSTALL.md` + `docs/INSTALL.zh-CN.md`: Updated prereq to Neo4j 5.26+ (+2/-2)
  - Changed `.github/workflows/tests.yml`: neo4j>=5.26.0 in CI (+1/-1)
  - 9 files changed, +97/-39 lines

**Impact:** MiroShark now works out of the box behind LAN hostnames (`gpu.local`, custom domains via Traefik) without env overrides. This is the first community code contribution from Daniel Andersen (dan-and) — previously contributed the infra-side PR.

### Test Suite Hardening
**Summary:** Two demographic-grounding generator tests crashed in any CI environment without `LLM_API_KEY` because `WonderwallProfileGenerator.__init__` eagerly constructs an LLM client. The tests don't need an actual client, so patching the constructor fixes the false failure.

**Commits:**
- `6c5f0e7` — test: mock LLM client in demographic-grounding generator tests (#165)
  - Changed `backend/tests/test_unit_demographic_grounding.py`: Wrapped both `WonderwallProfileGenerator()` instantiations in `patch("...create_llm_client")` context managers (+6/-2)
  - Suite: 1,372 tests passing

**Impact:** CI no longer requires a real LLM API key to pass the full test suite. Removes a contributor friction point — anyone can fork and run tests immediately.

---

## aaronjmars/miroshark-aeon

### CI Fix: Upstream Sync Workflow
**Summary:** The `sync-upstream.yml` workflow failed every run for two reasons: the default `GITHUB_TOKEN` can't create PRs ("Resource not accessible by integration"), and because miroshark-aeon has unrelated git history from MiroShark upstream, the merge was a no-op that still pushed a dead branch.

**Commits:**
- `d83131a` — fix(sync): use GH_GLOBAL + skip dead branches on no-op merge (#62)
  - Changed `.github/workflows/sync-upstream.yml`: Switched checkout + PR creation from `GITHUB_TOKEN` to `GH_GLOBAL` PAT (matching every other workflow); added `BASE_SHA` tracking and `has_commits` gate so the push + PR steps only run when the merge actually produced new commits (+19/-4)

**Impact:** Sync workflow stops failing silently and pushing dead branches. When upstream eventually diverges, the workflow will create a real PR with the delta.

---

## Developer Notes
- **New dependencies:** Neo4j driver floor bumped from 5.15.0 to 5.26.0 (Docker image also bumped)
- **Breaking changes:** `VITE_API_BASE_URL` default changed from `http://localhost:5001` to empty (same-origin). Existing `.env` files with an explicit value are unaffected. Dev setups without `.env` now work through Vite's proxy rather than direct backend access.
- **Architecture shifts:** 3 new shared utility modules (`utils/base_url.py`, `utils/belief.py`, `utils/timeutils.py`) plus the existing `utils/json_io.py` from PR #163 establish a clear pattern — duplicated helpers go into `backend/app/utils/` with their callers importing under the original local name. 12 duplicate functions → 3 shared modules.
- **Tech debt:** The cleanup docs (`docs/cleanup/round2-*.md`) catalog 2 deliberately-deferred items: a redundant namespace import in `settings.py:14` and an unused Farcaster placeholder in `frame_metadata.py:235`, both kept to avoid hot-file conflicts and product decisions respectively.

## What's Next
- The round-2 cleanup audit found the codebase "genuinely clean of removable legacy code" — further cleanup likely targets test coverage or type annotation gaps rather than structural debt
- 39 feature PRs remain stuck as local commits (GH_GLOBAL not set on CHORUS side) — setting that secret would unblock the entire backlog at once
- Daniel Andersen's same-origin PR suggests active deployment experimentation — a public-facing MiroShark instance behind a reverse proxy may be near (tracks the Jul 15 hyperstition target)
- Next feature candidates from repo-actions 2026-06-14: Webhook Delivery for Simulation Events (#1), Simulation Data Bundle Export (#2)
