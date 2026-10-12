# Repo Action Ideas — 2026-10-12

**Repo:** [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark) · [aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon)
**Snapshot:** 1,467 stars · 304 forks · 0 open issues · 0 open PRs · token +3.81% ($0.000002383; FDV $238,273; LP ~$2.65M)
**Recent changes:** docs(ecosystem): point Sparkleware links at www host (#328, Oct 11); fix(simulation): make resume work on existing DBs (#326, Oct 10); fix(report): return newest report for simulation (#325, Oct 10); fix(llm): accept repair_truncated, fail 0-node graph builds (#324, Oct 10); security: fix 4 Dependabot alerts (#320); chore: add ruff lint to CI (#318)

---

## Context

The codebase is in a stable, clean state: 0 open issues, 0 open PRs, 4 Dependabot alerts resolved, ruff lint in CI. The last two weeks were dominated by bug fixes — three Oct 8 bugs patched within 48 hours — and ecosystem housekeeping (Sparkleware and Crucible link fixes). No feature work since June due to GH_GLOBAL being unset, but 40+ ideas have been queued as local commits.

The service directory now has 50+ services covering everything from trajectory export to WaybackMachine publishing. The areas still missing are operational ergonomics (contributor setup, provider resilience, post-run annotation) and analytical depth (demographic stance disaggregation, convergence timing). These are the gaps this batch targets.

304 forks, 0 PRs. The setup barrier — Neo4j + Python + Node in sync — remains the most likely friction point. Ecosystem is growing (Sparkleware, Crucible, x402aff) but there's no frictionless path from "fork" to "first PR."

GH_GLOBAL still unset — feature skill will queue these as local commits.

Prior batches off-limits (Oct 10 / Oct 8 / Oct 6 / Oct 4 / Oct 2 / Sep 30 / Sep 28 / Sep 26 and earlier): Webhook Delivery Log, Cross-Provider Performance Telemetry, Simulation Input Provenance, CLI Live Progress Stream, Opinion Leader Influence Score, SQLite Resume Safety Fix, Report API Race Fix, Provider Capability Matrix, Agent Diversity Score, Simulation Embedding API, Simulation ZIP Bundle Export, Per-Agent Career History API, Rich Link Preview/Open Graph, token-movers Skill Repair, Simulation Watchlist Collections, Simulation Replay GIF Export, Topic Autocomplete, GitHub Discussions Auto-Publisher, Simulation Digest Markdown, Confidence Distribution Analytics, RSS/Atom Feed, x402 Pay-Per-Simulation, Jupyter Notebook Export, Cross-Topic Consensus Heatmap, Social Card Generator, Hacktoberfest Progress Dashboard, Bulk CSV Export, Similar Simulations Discovery, Interactive OpenAPI Explorer, Hot Topics Feed, Simulation Replay Visualizer, Air-Gap Bundle, JSON-LD Structured Data, First-PR Welcome Automation, Simulation Difficulty Score, and all earlier batch entries.

---

### 1. GitHub Codespaces DevContainer Config

**Type:** DX
**Effort:** Small (hours)
**Impact:** 304 forks, 0 PRs. The setup sequence — Neo4j running, Python venv, Node modules, `.env` configured — takes 30–60 minutes on a fresh machine. A `.devcontainer/devcontainer.json` reduces this to clicking "Open in Codespaces" and waiting 3 minutes. Codespaces usage in OSS repos has grown 4× since 2024; VS Code Remote Containers is the default dev environment for many contributors. Closing the fork-to-first-contribution gap is the single highest-leverage move for a 304-fork repo with zero PR conversions.

**How:**
1. Create `.devcontainer/devcontainer.json`. Use the official `python:3.11-bullseye` base image. Add a `docker-compose.devcontainer.yml` (sibling file) that starts Neo4j 5.x as a service with the same env vars as the main `docker-compose.yml`. Set `forwardPorts: [3000, 8000, 7474, 7687]` and `postCreateCommand: "pip install -r backend/requirements.txt && cd frontend && npm install"`. Add VS Code extension recommendations in `extensions`: `ms-python.python`, `ms-python.vscode-pylance`, `dbaeumer.vscode-eslint`, `vue.volar`, `neo4j.neo4j-for-vscode`. Set `PYTHONPATH` and `NEO4J_URI` env vars in `remoteEnv` pointing at the compose service. The devcontainer should match the existing `docker-compose.yml` service topology exactly — no new deps, no new ports, just a preconfigured entry point. Add a brief `## GitHub Codespaces` section to `docs/INSTALL.md` with the one-click badge and expected wait time.

2. Add a `.devcontainer/welcome.sh` that runs on container start (via `postStartCommand`): prints a two-line welcome showing `miroshark status` (checks Neo4j connectivity) and the local URL. This replaces the "did everything start?" uncertainty that makes first-time contributors give up. The script should exit 0 even if Neo4j is still booting (poll with a 10-retry loop, 3s sleep) — container start should never fail. Add the Codespaces badge (`[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/aaronjmars/MiroShark)`) to the README below the existing install buttons, at the same visual level as the "Full install" button.

3. Update `.github/CONTRIBUTING.md` to add a "Quickstart via Codespaces" section above the existing manual setup steps. Two sentences: "Click the badge above. When the terminal shows `Neo4j ready`, run `./miroshark`." No other changes to the contributing guide. The devcontainer is a new *path in*, not a replacement for the existing setup — keep both documented.

---

### 2. Agent Demographic Stance Breakdown

**Type:** Feature / Analytics
**Effort:** Medium (1-2 days)
**Impact:** `GET /api/simulation/:id/signal` returns a single `confidence_pct` (e.g., "73% BULLISH"). That aggregate hides who is bullish. MiroShark agents are grounded in five layers of real context including demographics (profession, age bracket, geographic region, risk profile). Breaking the final stance distribution by demographic group — "crypto-native agents: 91% BULLISH; institutional traders: 52% BULLISH; mainstream retail: 44% BULLISH" — turns a one-number result into a segmented signal. Researchers, analysts, and PR teams get actionable subgroup granularity. Distinct from Agent Diversity Score (Oct 8 — measures diversity of the agent *pool*, not stance *by* subgroup).

**How:**
1. Create `backend/app/services/subgroup_service.py` (~200 LoC, pure stdlib). Inputs: `agents.json` (per-agent demographics, exists for every completed simulation) and `trajectory.json` (per-agent final stance). Algorithm: (a) read each agent's demographic attributes — extract `profession_group` (derived from `profession` field: "crypto-native", "institutional", "retail-mainstream", "media", "technical", "other" — a 6-bucket classification using keyword matching on the `profession` string), `age_bracket` (< 30, 30–45, 45+, unknown — from `age` field if present), `platform` (primary platform assignment). (b) For each demographic dimension, group agents by bucket and compute stance distribution: BULLISH/NEUTRAL/BEARISH counts + percentages. (c) Include `sample_size` per bucket — suppress buckets with < 3 agents (insufficient data). Cache to `uploads/simulations/{id}/subgroups.json` (mtime-based, same pattern). Add 5 unit tests: profession classifier maps "DeFi developer" to "crypto-native"; bucket with 2 agents suppressed; stance percentages sum to 100; cache written after first call; unknown bucket is populated when age field missing.

2. Add `GET /api/simulation/{id}/subgroups` endpoint in `backend/app/api/simulation.py` (or a new `subgroups.py`). Publish-gated, 5-minute cache. Response: `{"simulation_id": str, "dimensions": {"profession_group": [{"bucket": str, "bullish_pct": float, "neutral_pct": float, "bearish_pct": float, "dominant_stance": str, "sample_size": int}], "age_bracket": [...], "platform": [...]}, "generated_at": ISO8601, "method": "6-bucket profession classifier on agent demographics"}`. Include a `"suppressed_buckets"` count per dimension — transparency about how much data was excluded. Cache-Control: `max-age=3600`. Add to `surfaces_catalog.py` (type: `analytics`) and OpenAPI with `SubgroupBreakdownResponse`. Add to `docs/API.md` under "Analytics" with the 6-bucket profession taxonomy table. Add 3 integration tests: returns 200 for published sim; all dimension arrays present; suppressed_buckets is int.

3. Surface in the Step 3 result page as a `🎯 Subgroups` toolbar button (sibling to existing toolbar buttons). Opens a dark-themed overlay with three expandable sections (Profession, Age, Platform). Each section shows horizontal stance bars per bucket: violet for BULLISH, gray for NEUTRAL, red for BEARISH, with the bucket label and sample size. Buckets sorted by BULLISH% descending. Suppress "insufficient data" buckets in the UI (show a gray "N/A (< 3 agents)" placeholder). Add a `GET /api/simulation/{id}/subgroups` cURL example in `EmbedDialog.vue` under "Data." Bilingual (EN/ZH-CN). Add 1 frontend unit test: bucket with dominant_stance=BEARISH renders a red-majority bar.

---

### 3. Consensus Convergence Round

**Type:** Feature
**Effort:** Small (hours)
**Impact:** `signal.json` reports the *final* consensus percentage after all rounds. But the round at which consensus first crystallized is equally informative: early convergence (round 2 of 10) means the topic was obvious; late convergence (round 9 of 10) means it was hotly contested until the end; no convergence means the simulation produced a genuinely split result. Researchers citing MiroShark results need this to characterize "how contested" a topic was. `peak_round.py` exists (probably tracks peak confidence) but convergence round — the first round where ≥75% of agents share a dominant stance — is a distinct, not-yet-exposed metric.

**How:**
1. Create `backend/app/services/convergence_service.py` (~80 LoC, pure stdlib). Inputs: `trajectory.json` (per-agent stance per round). Algorithm: for each round R in order, count BULLISH/NEUTRAL/BEARISH; if any single stance holds ≥75% of all agents (excluding UNKNOWN/abstaining agents from the denominator), record R as `convergence_round`. Continue scanning to detect if consensus *breaks* after being reached (round where it drops back below 75%) — record as `divergence_round`. Compute `consensus_stability`: "stable" (consensus held through final round), "transient" (consensus reached then broke), "none" (never reached 75%). Cache to `uploads/simulations/{id}/convergence.json`. Add 4 unit tests: all-BULLISH from round 1 → convergence_round=1; 74% BULLISH never triggers convergence; transient consensus sets divergence_round; rounds with UNKNOWN stances excluded from denominator.

2. Inject convergence data into `signal.json` and `GET /api/simulation/{id}/signal`. Add three new fields: `convergence_round` (int or null), `consensus_stability` ("stable"/"transient"/"none"), `divergence_round` (int or null, only set when stability="transient"). Backwards-compatible: existing consumers see new optional fields. Add to the `SignalResponse` OpenAPI schema with `nullable: true` and a note: "convergence_round is null if consensus (≥75% dominant stance) was never reached." Update `docs/API.md` signal section. Cache-Control unchanged (max-age=3600). Add 2 integration tests: `convergence_round` present in signal response; null when no consensus found.

3. Surface in the Step 3 result page's "Signal" confidence panel. Below the existing confidence gauge, add a small `Convergence` row: "Consensus reached: Round 3 of 10 · Stable" (green dot for stable, yellow for transient, gray for none). For "none": "No consensus — split result throughout." For "transient": "Consensus reached Round 4, broke at Round 7 — watch the timeline." The word "timeline" links to the existing BeliefDriftChart. No new panel needed — this is a 2-line addition to the existing signal panel. Add 1 frontend unit test: consensus_stability="transient" renders a yellow dot and divergence_round text.

---

### 4. LLM Provider Fallback Chain

**Type:** Integration / Reliability
**Effort:** Medium (1-2 days)
**Impact:** The recent `fix(llm): accept repair_truncated` commit (Oct 10) shows the LLM client is actively hardened. But the current architecture has a single-point-of-failure: if the configured provider returns consistent 429s or 5xxs mid-simulation, the run fails outright. A `PROVIDER_FALLBACK_CHAIN` env var (`openrouter/gpt-4o,anthropic/claude-haiku-5-5,ollama/llama3.1`) instructs the client to retry the next provider on retriable errors. Self-hosters using Ollama as a fallback from OpenRouter get uninterrupted simulations. Cloud deployments routing to Claude avoid outage-induced failures. Distinct from Provider Capability Matrix (Oct 8 — static feature catalog, not runtime routing).

**How:**
1. Extend `backend/app/services/` (whichever module wraps LLM calls — likely `report_agent.py` or a dedicated client module) to support a fallback chain. Parse `PROVIDER_FALLBACK_CHAIN` from env on startup: split on `,`, strip whitespace, validate each entry matches `provider/model` format. Store as an ordered list. In the `chat_json` / `chat` method: wrap the primary call in a try/except for retriable errors (HTTP 429, 500, 502, 503, 504, `requests.Timeout`, `ConnectionError`). On retriable error: log a warning `[fallback] provider X failed with 429 — retrying with provider Y`, swap to next provider in chain, retry once. If all providers exhausted: raise the last error (no silent swallowing). Non-retriable errors (400, 401, 422, content policy refusal) skip the fallback chain — they won't succeed with a different provider. Add `current_provider` to the observability `llm_call` event so the per-simulation debug panel shows which provider was actually used (important when a fallback fired). Add 5 unit tests: 429 triggers fallback to next provider; 422 does NOT trigger fallback; fallback exhausted → raises last error; `current_provider` logged correctly; `PROVIDER_FALLBACK_CHAIN` env var parsed with leading/trailing whitespace stripped.

2. Update `.env.example` with `PROVIDER_FALLBACK_CHAIN=` (commented out, with an example value: `# PROVIDER_FALLBACK_CHAIN=openrouter/gpt-4o,anthropic/claude-haiku-5-5`). Add to `docs/INSTALL.md` under a new "Provider reliability" section: table showing retriable vs. non-retriable errors, the chain format spec, and a note that `OPENROUTER_API_KEY`, `ANTHROPIC_API_KEY`, etc. must all be set for the corresponding fallback to activate. Add `fallback_chain_used` boolean and `providers_tried` array to the simulation summary response so users know a fallback fired during their run. Add 2 integration tests: fallback chain config in env results in `providers_tried` in summary; empty `PROVIDER_FALLBACK_CHAIN` (or unset) behaves identically to current behavior (no regression).

3. Surface in the existing observability debug panel. When `providers_tried` has more than one entry (fallback fired), add a yellow banner above the LLM Calls tab: "⚠ Provider fallback triggered: openrouter/gpt-4o → anthropic/claude-haiku-5-5 at round 4. Check OBSERVABILITY.md for details." In the LLM Calls tab, add a `Provider` column to the calls table — when a fallback fired, the column shows which provider answered each call (the majority will be the primary; the fallback calls stand out). Add 1 frontend unit test: `providers_tried` length > 1 renders the yellow fallback banner.

---

### 5. Post-Simulation Outcome Annotation

**Type:** Feature
**Effort:** Small (hours)
**Impact:** MiroShark predicts how a social narrative will unfold. Currently there's no way to record what *actually* happened — no retrospective feedback loop. `POST /api/simulation/:id/annotations` lets users attach structured outcome labels after real-world events resolve: "market_moved_as_predicted", "viral_moment_occurred", "media_cycle_matched". Over time, an annotated corpus enables accuracy tracking ("MiroShark BULLISH signals were followed by real upside 71% of the time") and surfaces which simulation configurations produce reliable predictions. The annotation layer is the missing bridge between simulation output and ground truth. No prior batch has suggested human annotation or labeling.

**How:**
1. Create `backend/app/services/annotation_service.py` (~120 LoC, pure stdlib). Data model: each annotation is `{"annotation_id": uuid4, "simulation_id": str, "type": str, "label": str, "note": str|null, "annotated_at": ISO8601, "annotated_by": str}`. Pre-defined `type` enum: `"outcome"` (real-world outcome label), `"quality"` (simulation quality rating), `"event"` (real-world event that occurred during the sim period). Pre-defined `label` values per type — `outcome`: ["matched_bullish", "matched_bearish", "inconclusive", "wrong_direction"]; `quality`: ["high_confidence_correct", "low_confidence_correct", "overconfident", "underconfident"]; `event`: ["viral_moment", "breaking_news", "regulatory_action", "market_event", "other"]. Reject unknown type/label combinations at service level (not just API). Store as `uploads/simulations/{id}/annotations.jsonl` (append-only, one JSON per line). Add 5 unit tests: valid annotation writes to .jsonl; invalid label rejected; annotation_id is a valid UUID4; annotated_at is ISO8601; duplicate annotation_id rejected on read-back.

2. Add two endpoints in a new `backend/app/api/annotations.py`. `POST /api/simulation/{id}/annotations` — auth-required (session or API key). Body: `{"type": str, "label": str, "note": str|null}`. Validates type+label combo, generates annotation_id and annotated_at server-side. Returns `{"annotation_id": str, "simulation_id": str, "type": str, "label": str, "created": true}`. `GET /api/simulation/{id}/annotations` — public (annotations are part of the public simulation record). Response: `{"annotations": [...], "count": int, "generated_at": ISO8601}`. Optionally filter by `?type=outcome`. Cache-Control: `no-store` (annotations are user-generated, must be fresh). Add to `surfaces_catalog.py` (type: `meta`) and OpenAPI with `AnnotationResponse` and `AnnotationEntry` schemas. Register routes in the main app. Add to `docs/API.md` under "Annotations" with the full type/label taxonomy table. Add 3 integration tests: POST returns 201 with annotation_id; GET returns the annotation just posted; invalid label returns 422.

3. Surface in the Step 3 result page. Add an `📝 Annotate` button in the result header (visible only when authenticated). Opens a compact modal with two dropdowns: "Type" and "Label" (populated from the pre-defined taxonomy), plus an optional free-text "Note" field (max 280 chars). On submit: POST to the annotations endpoint, show a "Annotation saved" toast, close the modal. In the result page header, show existing annotations as chips below the confidence badge: `outcome: matched_bullish` in green, `quality: overconfident` in yellow, `event: breaking_news` in blue-gray. Chips are visible to all users (public), not just the annotator. Add 1 frontend unit test: outcome=matched_bullish chip renders with green background.

---

## Selection Rationale

The codebase is healthy — 0 open issues, 4 security patches, ruff lint in CI. The right investments now are operational ergonomics and analytical depth, not more API surfaces.

- **DevContainer (#1)** — 304 forks, 0 PRs. The fork-to-PR conversion rate is the most broken metric in the repo. A Codespaces devcontainer turns a 60-minute setup into a 3-minute click. This is infrastructure for contributions, not features.

- **Demographic Stance Breakdown (#2)** — `signal.json` gives one number. Clients, analysts, and researchers want to know *who* was bullish — not just that 73% were. The agent grounding already captures profession, age, and platform; this surfaces it. A natural extension of the data model that requires no new data collection.

- **Consensus Convergence Round (#3)** — The trajectory is stored per-round. The round at which ≥75% consensus first formed is a single read-pass computation. It turns "73% BULLISH" into "73% BULLISH, consensus locked in by round 3 of 10 — strong signal" vs. "73% BULLISH but it didn't stabilize until round 9 — contested." High signal-to-effort ratio.

- **LLM Provider Fallback Chain (#4)** — The LLM client was just hardened with repair_truncated handling (Oct 10). Adding a fallback chain is the next layer: not just recovering from malformed responses, but recovering from provider outages. Single-provider setups fail at the worst moments. Env-var config means no code changes for existing deployments.

- **Post-Simulation Outcome Annotation (#5)** — MiroShark predicts. Nobody records whether predictions were right. Annotations close the feedback loop. The annotated corpus becomes the foundation for accuracy reporting and model calibration. No prior batch has touched human-in-the-loop labeling. Small implementation, large long-term leverage.
