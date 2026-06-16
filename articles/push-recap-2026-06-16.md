# Push Recap — 2026-06-16

## Overview
13 substantive commits by 4 authors across both watched repos. The day's main thrust: MiroShark gained self-hosted search and scraping infrastructure (SearXNG + Firecrawl) so any model — including local Ollama — can ground persona research with live web results, plus a new per-simulation cost surface that makes the "$1 to simulate anything" claim queryable. On the CI side, Dependabot landed its first sweep of version bumps across all five dependency ecosystems, and a new frontend build job catches broken UIs at PR time. Aeon's self-improvement loop sharpened its own repo-pulse and feature skills.

**Stats:** 47 files changed, +2,254/-235 lines across 13 substantive commits (~20 cron noise filtered from miroshark-aeon)

---

## aaronjmars/MiroShark

### Self-Hosted Search & Scraping Infrastructure (SearXNG + Firecrawl)
**Summary:** Community contributor Daniel Andersen's PR #178 adds two self-hosted alternatives to the existing websearch-enabled LLM path. SearXNG provides real web search (search → synthesize with the default LLM), so even a local Ollama model can produce grounded persona research. Firecrawl provides page scraping via POST /v1/scrape, replacing the LLM-reads-the-URL approach for URL document ingestion. Both are opt-in, fallback-safe, and configurable via the Settings UI.

**Commits:**
- `8bdaa73` — Alternative websearch/scrape via SearXNG / Firecrawl for non-websearch capable LLMs (#178)
  - New file `backend/app/utils/searxng_client.py`: Full SearXNG JSON-API client — retry with exponential backoff on 5xx/connection errors, immediate raise on 4xx, HTML tag/entity stripping from snippets, configurable max results/timeout/language (+193 lines)
  - Changed `backend/app/services/web_enrichment.py`: Three-tier precedence — SearXNG (live snippets + default LLM synthesis) → WEB_SEARCH_MODEL (websearch-enabled LLM) → default LLM (training data only). New `_search_web()` method disambiguates one-word names with entity type (+45/-12 lines)
  - Changed `backend/app/utils/url_fetcher.py`: Firecrawl primary path for URL ingestion — POST /v1/scrape → markdown; falls back to LLM path when unconfigured or text < 100 chars (+81/-26 lines)
  - New files `backend/app/prompts/locales/{en,zh_CN}/web_enrichment.py`: Added `system_grounded` prompt variant and `user_sources_block` for injecting search results into context (+36 lines total)
  - Changed `backend/app/config.py`: Added SEARXNG_BASE_URL/TIMEOUT/MAX_RESULTS and FIRECRAWL_BASE_URL/API_KEY config entries from env vars (+13 lines)
  - Changed `backend/app/api/settings.py`: POST /api/settings now accepts searxng_base_url and firecrawl fields with URL validation; new POST /api/settings/test-searxng endpoint runs a one-result test search (+65 lines)
  - Changed `frontend/src/components/SettingsPanel.vue`: SearXNG section with instance URL input and "Test search" button showing latency on success; Firecrawl section with URL + API key inputs; both bilingual EN/ZH (+90/-1 lines)
  - Changed `frontend/src/api/settings.js`: Added `testSearxng()` API helper (+18/-1 lines)
  - New file `docker-compose.ollama.yml`: Bundled Ollama stack (Neo4j 5.26 + Ollama + MiroShark) for local deployment without external LLM providers (+53 lines)
  - New file `docker-compose.traefik.yml`: Production deployment with Traefik reverse proxy, SSL, basic auth, same-origin API routing (+79 lines)
  - Changed `backend/app/utils/logger.py`: File handler creation wrapped in try/except OSError — gracefully degrades to console-only when the log file is unwritable (Docker bind mounts, read-only deployments) (+19/-11 lines)
  - Changed `backend/openapi.yaml`: Documented test-searxng endpoint + SearXNG/Firecrawl fields in SettingsPayload schema (+36 lines)
  - Changed `.env.example` and `railway.env.example`: Documented all new env vars (+22 lines)
  - Changed `.dockerignore`: Switched from excluding frontend/ entirely to excluding installed deps (node_modules, .venv) — the image now includes the frontend for same-container builds (+3/-4 lines)
  - New test files: `test_unit_searxng_client.py` (188 lines, 10 tests), `test_unit_url_fetcher.py` (115 lines, 5 tests), `test_unit_web_enrichment.py` (111 lines, 5 tests)

**Impact:** MiroShark operators running local models (Ollama, vLLM) can now get web-grounded persona research without paying for a websearch-enabled cloud model. The SearXNG + default-LLM path is strictly cheaper and works offline. Firecrawl handles JS-heavy pages and PDFs that the LLM-reads-URL approach couldn't. Both paths degrade gracefully — existing WEB_SEARCH_MODEL setups continue working unchanged.

---

### New Surface: Per-Simulation Cost Breakdown (40th surface)
**Summary:** The "$1 to simulate anything" headline number was already computed at simulation completion and written to run_summary.md, but never exposed as structured data. This PR extracts the pricing logic into a pure read-only service and serves it at a new endpoint — the 40th catalogued surface.

**Commits:**
- `a52ea34` — feat: GET /api/simulation/<id>/cost.json — per-sim cost breakdown (#179)
  - Changed `backend/app/api/simulation.py`: New `get_cost_json()` route — publish-gated (403 private, 404 no-calls-yet), 60s cache, surface_stats counter, pretty-printed JSON with Content-Disposition filename (+82 lines)
  - New file `backend/app/services/cost_service.py`: Pure aggregator — takes run_summary's event collection output, reshapes into a stable public envelope with headline `estimated_cost_usd`, token/latency totals, p50/p90/max latency, wall_clock start/end, and per-model + per-phase breakdowns. `is_estimate=true` and `pricing_basis` note baked in; untracked models price at $0 (explicit lower bound) (+126 lines)
  - Changed `backend/app/utils/run_summary.py`: Extracted `_collect_llm_events()` from `generate_run_summary()` so both the markdown report and the JSON surface share the same event reader. Added `collect_cost_summary()` — pure aggregation without writes or prints (+71/-25 lines)
  - Changed `backend/openapi.yaml`: Full CostResponse + CostBreakdownRow schemas with detailed field-level documentation (+214 lines)
  - Changed `backend/app/services/surfaces_catalog.py`: Registered "cost" surface (type: analytics, PR #179) (+12 lines)
  - Changed `backend/app/services/surface_stats.py`: Added "cost" to SURFACE_KEYS (+1 line)
  - Changed `docs/API.md`: Documented cost.json endpoint in the surfaces table (+1 line)
  - New file `backend/tests/test_unit_cost_service.py`: 191 lines covering aggregation, lower-bound pricing, envelope shape, honesty flags, dedup, empty-event edge case, and drift guards tying the surface key into catalog + stats (+191 lines)
  - Changed `backend/tests/test_unit_surface_stats.py`: Added "cost" to the locked expected surface key set (+1 line)

**Impact:** Ecosystem partners and evaluators can now programmatically answer "what did this simulation cost?" — the first question anyone asks before trusting the output. The honest-by-construction posture (lower bound, not a billed invoice) matches the project's credibility strategy. Surfaces now at 40.

---

### CI/CD & Dependency Management
**Summary:** Dependabot was configured from scratch to cover all five dependency ecosystems in the repo, immediately producing its first batch of version bumps. A new CI job catches broken frontends at PR time rather than at release.

**Commits:**
- `3a56a19` — chore: add Dependabot config for pip, npm, GitHub Actions, and Docker (#166)
  - New file `.github/dependabot.yml`: Covers backend pip, root npm, frontend npm, GitHub Actions, and Docker base image. Minor/patch grouped per ecosystem to limit PR noise; majors open individually. Uses `chore:` commit prefix (+78 lines)

- `0f23339` — ci: build the frontend on every PR (#180)
  - Changed `.github/workflows/tests.yml`: Added "Frontend build" job — Node 22, `npm ci && npm run build`. Runs alongside the existing backend unit test job so a broken frontend (from a dependency bump, a Vue config change, etc.) is caught at PR time (+22 lines)

- `541ebf9` — chore: bump docker/build-push-action from 5 to 7 (#169)
- `5b947b1` — chore: bump actions/checkout from 4 to 6 (#170)
- `82cdb9a` — chore: bump actions/setup-python from 5 to 6 (#171)
  - Three GitHub Actions major version bumps — Dependabot's first output. Keeps CI runners on supported action versions.

- `3c7685c` — chore: update nashpy requirement from >=0.0.41 to >=0.0.43 (#172)
- `4158304` — chore: update pywebpush requirement from >=2.0.0 to >=2.3.0 (#173)
  - Backend dependency floor bumps (game theory lib + push notification lib).

- `e97306a` — chore: bump the frontend-minor-patch group in /frontend with 5 updates (#174)
  - axios 1.13.2→1.18.0, dompurify 3.3.3→3.4.10, marked 18.0.0→18.0.5, vue 3.5.25→3.5.38, @vitejs/plugin-vue 6.0.2→6.0.7. Grouped as a single PR per Dependabot config. (+172/-120 lines, mostly package-lock.json churn)

**Impact:** MiroShark now has automated dependency management for the first time. The frontend build gate would have caught the vue 3.5.25→3.5.38 bump if it broke anything — exactly the scenario it was designed for. GitHub Actions are on current major versions.

---

## aaronjmars/miroshark-aeon

### Aeon Self-Improvement: Repo-Pulse & Feature Skill
**Summary:** Three self-improvement PRs sharpened Aeon's own skills. Repo-pulse now profiles every new stargazer and forker with rich GitHub data, while dropping noisy zero-follower counts. The feature skill was corrected to stop claiming that workspace-relative clones enable pytest in the sandbox (they don't).

**Commits:**
- `c17dbcb` — Disable operator-scorecard; enrich repo-pulse with stargazer/forker profiles (#64)
  - Changed `aeon.yml`: Set operator-scorecard `enabled: false` (+1/-1 lines)
  - Changed `skills/repo-pulse/SKILL.md`: Expanded from notable-stargazer-only lookup to full profile enrichment for ALL new stargazers AND forkers — name, bio, location, company, repos, website, twitter. Capped at 10 stargazer + 10 forker lookups per repo. Profile cards now render one-per-block with full detail instead of pipe-joined handles. Added forker profile section to logs. Untrusted-input guardrails for all user-controlled fields (+35/-11 lines)

- `838a775` — repo-pulse: surface bio, drop noisy 0/low follower counts (#65)
  - Changed `skills/repo-pulse/SKILL.md`: Bio is now always rendered when present (highest-signal field), truncation widened from ~100 to ~140 chars. Follower count hidden when <10 (never print "0 followers" or near-zero). Card reordered so identity leads and follower count sits at end. Notification example updated to match (+14/-9 lines)

- `e83f732` — fix(feature): stop over-promising local pytest validation in sandbox (#63)
  - Changed `skills/feature/SKILL.md`: Corrected step 7's false claim that workspace-relative clones let pytest execute — Python is sandbox-blocked regardless of clone path (confirmed across 2026-06-15 and 2026-06-16 runs). Now attempts once, treats repo CI as the real validation gate. Kept Node-runs-workspace-relative guidance (+5/-3 lines)
  - Changed `.outputs/self-improve.md`: Updated output summary (+1/-1 lines)
  - Changed `memory/logs/2026-06-16.md`: Detailed self-improve log entry (+7 lines)
  - Changed `memory/skill-health/self-improve.json`: Quality score 4→5 for this run, avg 4→4.5 (+8/-4 lines)

**Impact:** Repo-pulse notifications now tell the operator *who* just starred or forked — not just how many. The bio field is the highest-signal piece ("Rust + distributed systems. Maintainer of foo-rs" says more than "450 followers"). The feature skill fix prevents false confidence in test validation and stops wasting retries on a known sandbox limitation.

---

## Developer Notes
- **New dependencies:** SearXNG client uses `requests` (already a transitive dep); no new packages added. Frontend bumps are all minor/patch.
- **Breaking changes:** None. SearXNG/Firecrawl are opt-in (unconfigured = silent fallback). Cost surface follows the same publish gate as every other surface.
- **Architecture shifts:** `run_summary.py` now has a clean read-only path (`collect_cost_summary`) separate from the write path (`generate_run_summary`), sharing `_collect_llm_events()`. This pattern enables future read-only surfaces without touching the summary writer.
- **Tech debt:** None introduced. The Dependabot config is the first step toward automated dependency hygiene.

## What's Next
- Dependabot will continue opening PRs weekly — expect a steady stream of grouped minor/patch bumps.
- The cost surface (40th) opens the door for a cost comparison endpoint or a cost badge for ecosystem partners.
- SearXNG + Firecrawl may get a health check in the Settings UI (SearXNG already has "Test search"; Firecrawl has no test button yet).
- 39 features remain blocked as local commits due to missing GH_GLOBAL secret — this is the single highest-impact unblock.
