# Repo Action Ideas — 2026-10-19

*Generated from aaronjmars/MiroShark analysis — 1,477 stars · 306 forks · 1 open issue · recent: Wonderwall/OpenRouter broadcast wiring, Blacksmith CI runners, uv+ruff lint, simulation resume fix, shared attribution header refactor (#337)*

---

### 1. OpenGraph Social Preview for Simulation Share URLs
**Type:** Growth
**Effort:** Small (hours)
**Impact:** Public simulation permalinks have no `<meta og:*>` tags, so sharing on Twitter, LinkedIn, or Bluesky produces a blank, unbranded card. Adding OG title, description (final stance split + agent count), and a server-rendered SVG image turns every share into a rich preview — free distribution every time a user shares a result. With 1,477 stars and a public gallery, this compounds across every simulation ever shared.
**How:**
1. Inject `<meta property="og:title">` (simulation topic), `og:description` (e.g. "63% bullish · 12 agents · 5 rounds"), and `og:image` (a server-generated `/api/simulation/:id/og-image.svg` returning a minimal stance-split graphic) into the server-rendered simulation permalink HTML.
2. Generate the SVG on the fly from the existing `signal.json` data — no new storage, no new dependencies.
3. Add `og:url` and `twitter:card: summary_large_image` to complete the standard set; test via opengraph.xyz.

---

### 2. Wonderwall Broadcast Discovery Feed
**Type:** Feature
**Effort:** Medium (1–2 days)
**Impact:** PR #335 wired the agent trace data into the correct OpenRouter Broadcast shape — but broadcast is still push-only. There's no way to discover what simulations others found worth sharing. A `/api/broadcast/feed` endpoint (latest N broadcast simulations) plus a "Shared via Wonderwall" badge in the gallery turns broadcast from a silent signal into a discovery mechanism, driving cross-simulation exploration.
**How:**
1. Log a `broadcast_at` timestamp and `broadcast_topic` to `simulation_meta.json` whenever a simulation is broadcast via Wonderwall; expose `GET /api/broadcast/feed?limit=20` returning broadcast simulations sorted by `broadcast_at` desc.
2. Add a "Wonderwall" filter tab to the public gallery that calls this endpoint, showing a "Shared" badge on broadcast cards.
3. Surface a "Share via Wonderwall" button in Step3Simulation.vue that POSTs to the broadcast endpoint and flips the badge state inline.

---

### 3. Simulation Trajectory CSV Export
**Type:** Feature
**Effort:** Small (hours)
**Impact:** Data scientists and researchers using MiroShark for academic work need the raw per-agent, per-round belief time series for their own analysis — right now they must hand-parse the JSON API. A one-click "Download CSV" export of `agent_id, round, belief_pct, stance, influence_score` rows removes that friction entirely and directly unblocks the audience the existing HuggingFace dataset targets. Low implementation cost, high research-community value.
**How:**
1. Add `GET /api/simulation/:id/trajectory.csv` (publish-gated) that reads the existing `trajectory.json` and emits a `text/csv` response — no new storage, pure transformation.
2. Wire a "Download CSV" button in the Step3Simulation.vue data panel that triggers a file download using the browser's native fetch + blob approach.
3. Add the endpoint to the OpenAPI spec and note it in `docs/API.md` under "Data Export."

---

### 4. Community Examples Directory
**Type:** Community/DX
**Effort:** Small (hours)
**Impact:** 306 forks with near-zero inbound PRs signals "I want to use this but don't know where to start." The gap between cloning the repo and running a meaningful first simulation is the primary conversion blocker. An `examples/` directory with 5–7 pre-configured scenario JSONs (crypto rally, US election, AI regulation, climate COP, tech IPO) plus a one-command runner gives new users a zero-friction entry point without having to decide a topic or configure agents from scratch.
**How:**
1. Create `examples/` with 5–7 scenario JSON files (one per use case), each paired with a 3-line comment block explaining the framing and expected outcome range.
2. Add a `examples/README.md` showing the exact command to run each (`miroshark run examples/crypto-rally.json`) and a quick-start section linking back from the main README.
3. Add one example to the CI smoke-test suite so the `examples/` directory stays runnable as the API evolves.

---

### 5. OpenRouter Attribution Header CI Lint Guard
**Type:** DX/Security
**Effort:** Small (hours)
**Impact:** PR #337 extracted a shared `OPENROUTER_ATTRIBUTION_HEADER` constant to standardize attribution across all LLM call sites — but any new file under `llm/` or `wonderwall/` could silently omit it. Without enforcement, the refactor's intent degrades as the codebase grows. A fast CI check (grep-based or a custom ruff rule) that fails if any new `httpx.post` or OpenAI client call lacks the constant locks in correctness as infrastructure rather than convention.
**How:**
1. Add a `scripts/check-attribution.sh` that greps `llm/` and `wonderwall/` for LLM call patterns (`httpx.post`, `openai.`) and verifies each file also imports `OPENROUTER_ATTRIBUTION_HEADER` from the shared constants module; exit 1 on violation.
2. Add the check as a step in the existing lint CI job (already running ruff-action after PR #332) — runs fast (<1s) and needs no new dependencies.
3. Add a `# noqa: attribution` escape hatch comment pattern for any intentional exceptions (e.g. a test mock), documented in `CONTRIBUTING.md`.
