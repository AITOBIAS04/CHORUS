# Push Recap — 2026-05-24

## Overview
5 commits by 3 authors landed on aaronjmars/MiroShark in the last 24 hours — a major feature day. The headline is demographic grounding via NVIDIA Nemotron-Personas, which pins AI agent personas to census-real demographic baselines. Alongside it, the Polymarket prediction JSON surface shapes simulation output for trading bots, a path-traversal security fix hardens the project manager, and CI drift from the WaybackClaw merge gets cleaned up. The miroshark-aeon repo logged its full daily skill cycle (~30 cron commits) with the Simulation Tag System built as the 24th consecutive feature.

**Stats:** 30 files changed, +3,004/-18 lines across 5 significant commits (+ ~30 cron bookkeeping on miroshark-aeon)

---

## aaronjmars/MiroShark

### Demographic Grounding — Nemotron-Anchored Personas
**Summary:** The biggest commit of the day introduces an optional layer that pulls census-grounded demographic rows from NVIDIA's Nemotron-Personas parquet dataset on HuggingFace and feeds them to the LLM persona generator as a `DEMOGRAPHIC ANCHOR` block. Instead of the model inventing age/sex/geography/occupation/education from its defaults, each agent gets pinned to a real demographic baseline. Group entities receive an `AUDIENCE ANCHOR` framing instead, keeping institutional voice intact while localizing tone.

**Commits:**
- `58a80e5` — feat: demographic grounding — Nemotron-anchored personas (#103)
  - New `backend/app/services/demographic_sampler.py`: Core sampling engine — schema introspection, seed-to-entity pairing, parquet row extraction via duckdb, HuggingFace snapshot caching (+360 lines)
  - New `backend/app/services/country_registry.py`: Country pack registry — discovers JSON packs in `backend/app/countries/`, returns region lists and metadata per country code (+78 lines)
  - New `backend/app/countries/singapore.json`: Singapore country pack — 39 planning areas (+47 lines)
  - New `backend/app/countries/usa.json`: US country pack — 51 states (+47 lines)
  - New `backend/app/api/countries.py`: REST endpoints `GET /api/countries` and `GET /api/countries/<code>` for the SPA country picker (+92 lines)
  - New `frontend/src/components/CountryPicker.vue`: Dropdown country selector mounted in Step 1 (New Sim form), auto-hides when no packs are registered (+235 lines)
  - New `frontend/src/api/countries.js`: API helpers for country registry (+41 lines)
  - New `backend/tests/test_unit_demographic_grounding.py`: 15 unit tests covering registry, sampler, schema introspection, seed-entity pairing, and the WonderwallProfileGenerator smoke path (+233 lines)
  - New `docs/DEMOGRAPHICS.md`: Full documentation with architecture, usage, and extension guide (+110 lines)
  - Modified `backend/app/services/wonderwall_profile_generator.py`: Integrated demographic anchor block injection into persona prompt assembly (+99/-13 lines)
  - Modified `backend/app/services/simulation_manager.py`: Plumbed `demographics_country` through SimulationState so each run picks a country (+28/-1 lines)
  - Modified `backend/app/config.py`: Added `DEMOGRAPHICS_COUNTRY` env var as deployment-wide default (+15 lines)
  - Modified `backend/requirements.txt`: Added duckdb and huggingface-hub dependencies (+8 lines)
  - Modified `backend/pyproject.toml`: Same deps in project config (+5 lines)
  - Modified `frontend/src/components/Step1GraphBuild.vue`: Mounted CountryPicker (+7 lines)
  - Modified `docs/FEATURES.md` and `docs/CONFIGURATION.md`: Documentation entries

**Impact:** This is the first time MiroShark agents are grounded in real-world demographics rather than pure LLM imagination. A simulation of public reaction to a Singapore policy now generates agents with actual Singapore planning-area anchored bios. Purely additive — missing env vars, unreachable HuggingFace, or no duckdb all degrade silently to graph-only persona generation. Country packs are drop-in JSON files: add a new country, no code changes. **Breaks the zero-new-deps streak** — duckdb and huggingface-hub are the first new Python dependencies since PR #72.

### Polymarket-Ready Prediction JSON — First Integrator-Shaped Surface
**Summary:** The fifteenth machine-readable share surface, and the first one shaped for a specific external integrator. Where `signal.json` emits a generic action primitive (direction + confidence_pct + risk_tier), `polymarket.json` reshapes that into the binary YES/NO probability envelope a Polymarket trading bot expects. Direction-aware: a Bullish swarm emits high `yes_probability`, Bearish emits low, Neutral lands at exactly 0.5.

**Commits:**
- `f3b9401` — feat: Polymarket-ready prediction JSON — first integrator-shaped surface (#99)
  - New `backend/app/services/polymarket_service.py`: Core adapter — `compute_polymarket()` calls `signal_service.compute_signal()` and reshapes output; `_confidence_tier()` maps continuous confidence into four-bucket scale (speculative/moderate/confident/high-conviction); `_yes_probability()` direction-aware probability derivation; `_suggested_market_title()` synthesizes `"Will …?"` titles (+253 lines)
  - New `backend/tests/test_unit_polymarket_service.py`: 30+ unit tests — payload shape, direction-aware probabilities, sum-to-1.0 invariant, four-bucket confidence tier with exclusive boundaries, market title shaping, non-completed/missing-belief returns None, ISO-8601 regex, route decorator presence (+432 lines)
  - Modified `backend/app/api/simulation.py`: `GET /<id>/polymarket.json` route handler with completed-only publish gate, JSON serialization, 5-min Cache-Control, Content-Disposition, surface stats hook (+82 lines)
  - Modified `backend/openapi.yaml`: `/polymarket.json` path entry + `PolymarketPrediction` schema (15 required fields documented) (+192 lines)
  - Modified `frontend/src/components/EmbedDialog.vue`: Full Polymarket prediction section — live YES/NO preview, confidence-tier chip, suggested-title rail, Download .json anchor, copyable URL, paste-ready `curl | jq` snippet (+201 lines)
  - Modified `frontend/src/api/simulation.js`: `getPolymarketJsonUrl` + `getPolymarketJson` helpers (+52 lines)
  - Modified `backend/app/services/surface_stats.py`: `polymarket_json` added to SURFACE_KEYS (+4/-1 lines)
  - Modified `docs/API.md`: Routes table entry + Polymarket trading-bot quickstart with curl + Python snippets (+20 lines)
  - Modified `docs/FEATURES.md`: Polymarket-Ready Prediction JSON section (+39 lines)
  - Modified `backend/tests/test_unit_surface_stats.py`: Updated expected key set (+1 line)

**Impact:** The first share surface naming a specific external integrator. A Polymarket trading bot can go from simulation result to actionable YES/NO signal in a single curl call. Stricter publish gate than signal.json — only completed sims emit a payload, preventing bots from sizing positions against mid-run numbers. Pure derivation layered on `signal_service` — a "Bullish 62%" sim emits identical underlying numbers across gallery card, share card, signal.json, badge.svg, and polymarket.json.

### Security & CI Fixes
**Summary:** Two focused fixes: a critical path-traversal vulnerability in project management, and CI test drift from the WaybackClaw merge.

**Commits:**
- `cf692c7` — fix: validate project_id to prevent path traversal (#98)
  - Modified `backend/app/models/project.py`: Added `_validate_project_id()` helper with strict regex (alphanumeric + hyphens + underscores, max 128 chars) at the single entry point `_get_project_dir`, protecting all downstream methods (+10 lines)
  - Found by AntFleet two-model consensus review (Claude Opus 4.7 + GPT-5) — the **second external contributor PR** after @teifurin's Neo4j security fix

- `ec6eb26` — fix(ci): clear notifications-config + openapi waybackclaw drift on main (#102)
  - Modified `backend/tests/test_unit_notifications_config.py`: Added `_clear_waybackclaw(monkeypatch)` helper, cleared `WAYBACKCLAW_AGENT_TOKEN` in all 8 test fixtures, added `"waybackclaw_configured": False` to every expected-dict assert (+28 lines)
  - Modified `backend/openapi.yaml`: Documented `GET /api/simulation/{id}/waybackclaw-record` and `POST /api/simulation/{id}/publish-waybackclaw` alongside existing DKG routes; added `WaybackClawRecord` schema (+233 lines)

**Impact:** The path-traversal fix closes a real vulnerability — `../../etc/passwd` as a project_id could read or write arbitrary files. The CI fix unblocks the test suite after the WaybackClaw merge left `main` red on every PR.

### Cloud Neo4j Support
**Summary:** One-line quality-of-life fix for cloud deployments.

**Commits:**
- `c3bd5fc` — launcher: skip local Neo4j startup when .env points at Aura (#100)
  - Modified `miroshark` launcher script: Detects `neo4j+s://` URI at the top of `ensure_neo4j` and returns early — the backend's dotenv loader already reads the URI/USER/PASSWORD, so the launcher's local-startup steps (CLI / Docker) only get in the way for cloud deployments (+5 lines)
  - Contributed by **Void Freud** (@voidfreud) — the **third external contributor**

**Impact:** Removes a friction point for anyone deploying MiroShark against Neo4j Aura or any remote Neo4j instance. The launcher no longer tries to start a local Neo4j when a cloud URI is already configured.

---

## aaronjmars/miroshark-aeon

~30 cron bookkeeping commits by aeonframework covering the full daily skill cycle:
- **token-report** (06:00 UTC) — completed
- **fetch-tweets** (07:30 UTC) — completed
- **repo-pulse** (10:00 UTC) — MiroShark at 1,194 stars, 247 forks; +4 stars, +2 forks in 24h
- **star-momentum-alert** (10:49 UTC) — projection: 1,194 → 1,500 stars in ~77 days (Aug 9); v7=4.00/day, v3=2.67/day; OUT_OF_WINDOW (>14d away)
- **feature** (11:37 UTC) — built Simulation Tag System (24th consecutive feature, push blocked)
- **self-improve** (13:23 UTC) — completed
- **repo-actions** (14:45 UTC) — generated 5 new feature ideas: oEmbed, Peak-Round, Operator Profile, Agent Export, Search API
- **push-recap** (15:13 UTC) — completed (previous run)

---

## Developer Notes
- **New dependencies:** `duckdb` and `huggingface-hub` added to backend requirements (PR #103) — **breaks the 31-PR zero-new-deps streak**. These are optional runtime deps; missing installs degrade gracefully.
- **Breaking changes:** None. All additions are purely additive with graceful fallbacks.
- **Architecture shifts:** The demographic grounding layer introduces a new data pipeline pattern: HuggingFace parquet → duckdb sampling → LLM prompt injection. The country-pack JSON registry (`backend/app/countries/*.json`) establishes a new extension point — drop a file, add a country.
- **Tech debt:** None introduced. The WaybackClaw CI fix (#102) actually resolves existing tech debt from the WaybackClaw merge.
- **External contributors:** 2 of 5 commits are from external contributors (AntFleet + Void Freud), bringing the total to 3 external contributor PRs merged. The AntFleet PR used a novel two-model consensus security review approach.

## What's Next
- The demographic grounding opens a path to richer simulation fidelity — expect follow-up country packs and potentially age/income distribution-weighted opinion modeling.
- GH_GLOBAL secret remains unset — 24 features now blocked from pushing, including today's Simulation Tag System. This is the single biggest bottleneck.
- Star momentum projects 1,500 stars by Aug 9 at current pace (4.00/day over 7 days). The 77-day window is outside the alert threshold.
- The Polymarket surface completes the "simulation → signal → market" pipeline. Next logical step: a live bot demo or integration guide for Polymarket's API.
- 3 external contributor PRs merged now (teifurin, AntFleet, Void Freud) — the hyperstition question "Will MiroShark receive 10 merged PRs from community contributors by August 1, 2026?" is 30% complete.
