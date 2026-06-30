# Repo Action Ideas — 2026-06-30

**Repo:** [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)
**Snapshot:** 1,353 stars · 282 forks · 0 open issues · 0 open PRs
**Recent merges:** CLI stop (#216), CLI wait (#215), CLI cost (#208), interview hang prevention (#214), local LLM robustness (#212), i18n locale threading (#213), CLAUDE.md for AI agents (#197)

---

## Context

Q2 2026 closes today. The first half of the year delivered 1,353 stars, 282 forks, 41 API surfaces, 5 locales, and a complete CLI lifecycle — simulate, wait, stop, cost. The question isn't what verb is missing from the CLI. It's what needs to happen in the next 15 days.

Three hyperstitions expire July 15: 1,500 stars (need 147 more at ~3/day current vs ~10/day needed), HN front page, and a public-facing external MiroShark deployment. None of these close without a specific intervention. Code changes alone don't move a star counter from 3/day to 10/day. Neither does shipping another API surface into a vacuum.

Today's five ideas map directly to the July 15 pressure test. One addresses the HN hyperstition with structured launch content. One addresses the deployment hyperstition with one-command templates. One addresses the research-citation hyperstition (September) with a bundle export that makes MiroShark reproducible in a notebook. Two are production-readiness features (replay stepper, rate limiting) that make every deployed instance more compelling as a live demo.

None overlap with open PRs (zero), the 40+ push-blocked local builds, or ideas from the past 7 days (June 24: CLI simulate, OG cards, campaign series, tags, contributor leaderboard; June 26: transcript export, round-state API, GitHub Actions template, Jupyter gallery, topic autocomplete; June 28: badge API, Python SDK, CLI list, webhooks, tutorial kit).

---

### 1. Show HN Launch Kit

**Type:** Growth
**Effort:** Small (hours)
**Impact:** The "HN front page by July 15" hyperstition has 15 days left. MiroShark at 1,353 stars with 41 surfaces and a CLI is legitimately Show HN–ready, but "Show HN" posts fail when the submission text is rushed. A prepared kit — pre-written title, body, FAQ, timing guide, and demo checklist — turns the submission into a deliberate launch rather than an impulsive post. HN front page visibility generates a spike of several hundred stars in 24-48h based on historical AI/ML project launches. The entire kit is documentation-only: zero backend changes, no external dependencies.

**How:**
1. Create `docs/launch/SHOW-HN.md`. Title (under 80 chars): `Show HN: MiroShark – Run a 40-agent opinion simulation for $1 in under 10 min`. Body (~600 chars): explain what it does (multi-agent swarm intelligence engine, not a chatbot wrapper), the $1/10-min constraint, the 41 queryable API surfaces, the pure-Python stdlib architecture with zero framework lock-in, and a live demo link. Cover what makes it technically distinct: ensemble methodology, HMAC-signed results, per-round confidence trajectories, stance flip analytics. Create `docs/launch/HN-FAQ.md` — pre-written responses to 10 common HN objections: "How is this different from asking GPT-4 to role-play?", "What's the calibration accuracy?", "Is the consensus signal reliable?", "Can I see the agent prompts?", "Why not just use LangGraph?", "How do you prevent herding/sycophancy?", "What's the cost structure?", "Can I self-host?", "Is it deterministic?", "What are the known failure modes?". Each answer is 2-4 sentences, grounded in the actual codebase.
2. Create `docs/launch/DEMO-CHECKLIST.md`: what the operator needs running before submitting (Docker up, simulation pre-run so page loads instantly, cost.json visible, embed working, transcript readable). Add `docs/launch/TIMING.md` — HN posting strategy: optimal days (Monday–Wednesday, avoid Fri/Sat/Sun), optimal times (8am–10am US Eastern), how to soft-launch first by running a simulation on the live demo and posting the result link before the Show HN, monitoring pattern (check top/new, respond to every comment in the first 2h).
3. Add `docs/launch/` to `README.md` under a "Launch" or "Press" section: "Planning to feature MiroShark? The [launch kit](docs/launch/) has a pre-written Show HN submission, FAQ, and demo checklist." No backend changes, no API changes.

---

### 2. Simulation Data Bundle Export

**Type:** Feature
**Effort:** Small (hours)
**Impact:** `GET /api/simulation/:id/bundle.zip` returns every artifact from a completed simulation in a single ZIP file: `signal.json`, `agents.json`, `trajectory.json`, per-platform `actions.jsonl` files, `transcript.txt`, `signed-result.json`. Today, reproducing a MiroShark simulation requires knowing which 6-8 endpoints to call and assembling the result manually. With bundle export, it's one curl command: `curl -o simulation.zip http://localhost:5001/api/simulation/abc123/bundle.zip`. This directly serves the "peer-reviewed paper citation by September 2026" hyperstition — researchers can publish a one-liner that reproduces any result. It also serves the tutorial kit goal: a creator can run a simulation, download the bundle, and paste actual output into a blog post without knowing the API structure. Pure stdlib (`zipfile` module), zero external dependencies.

**How:**
1. Add `backend/app/services/bundle_service.py` (~100 LoC, pure stdlib). `generate_bundle(sim_dir, sim_id) → bytes`: opens a `BytesIO` buffer, uses `zipfile.ZipFile` in write mode. Adds all files that exist in `sim_dir`: `signal.json`, `agents.json`, `trajectory.json`, `signed-result.json`, `confidence_trajectory.json`, `stance_flips.json`, `mentions.json`, `platform_sentiment.json` (each skipped if absent). Scans for per-platform `actions.jsonl` files (`*/actions.jsonl` glob within `sim_dir`) and adds each as `platforms/{platform_name}.jsonl`. Adds `transcript.txt` if present. Adds a generated `README.txt` (40 lines): what each file contains, the MiroShark version, sim_id, topic, completed_at, direction, yes_pct. Returns `BytesIO.getvalue()`. Route: `GET /api/simulation/:id/bundle.zip` (publish-gated, admin-auth optional — public for published sims). `Content-Type: application/zip`, `Content-Disposition: attachment; filename="miroshark-{sim_id}.zip"`, `Cache-Control: public, max-age=86400`. Returns 404 for unknown sim_id, 403 for unpublished (unless admin token). Add 8 unit tests: bundle is valid ZIP (`zipfile.is_zipfile`), `signal.json` always present, per-platform files land in `platforms/` subfolder, absent optional files are silently skipped, `README.txt` contains sim_id, unpublished sim returns 403, unknown sim_id returns 404, response has correct Content-Type.
2. Add route to OpenAPI spec under "Simulation" tag: `GET /api/simulation/{id}/bundle.zip`. Schema: binary response, `Content-Type: application/zip`. In `docs/FEATURES.md`, add a "Bundle Export" section: what's included, the curl one-liner, research reproducibility note. In the main `README.md` Quick Start, add one line after the existing API examples: "Download all simulation artifacts in one command: `curl -o sim.zip {base}/api/simulation/{id}/bundle.zip`."
3. Add `getBundleUrl(simId)` to `frontend/src/api/simulation.js`. In `Step3Simulation.vue`, add a "Download Bundle" button to the share/embed action bar (disabled until status=complete). On click: `window.location.href = getBundleUrl(simId)` — browser download. Bilingual label ("Download Bundle" / "下载数据包"). No framework changes, no new deps.

---

### 3. API Rate Limiting & Usage Headers

**Type:** Feature / Security
**Effort:** Medium (1-2 days)
**Impact:** The "external public-facing MiroShark instance by July 15" hyperstition requires a deployment that operators feel safe making publicly accessible. Without rate limiting, a public instance is one Reddit thread away from getting DoS'd with simulation requests. With rate limiting, operators can expose the full API with confidence: 60 requests/minute per IP for public endpoints, unlimited for admin-token holders. `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset` headers in every response give integrators the visibility they need to throttle gracefully. `429 Too Many Requests` with `Retry-After` is the correct response when limits are exceeded. Pure stdlib (`collections.defaultdict`, `time.monotonic`) — no Redis, no middleware dependency.

**How:**
1. Add `backend/app/services/rate_limit_service.py` (~120 LoC, pure stdlib). Uses `collections.defaultdict(deque)` as a sliding window counter keyed by `(ip, route_prefix)`. `check_rate_limit(ip, route_prefix, limit=60, window_secs=60) → RateLimitResult(allowed: bool, limit: int, remaining: int, reset_at: float)`: drops entries older than `window_secs` from the deque, checks `len(deque) >= limit`, appends `time.monotonic()` if allowed. Thread-safe via a module-level `threading.Lock`. Configurable limits: public simulation endpoints (60/min), admin endpoints (600/min — effectively unlimited), `/api/simulate` POST (10/min per IP to prevent runaway simulation spawning). Add a Flask `before_request` hook (or equivalent WSGI middleware) that calls `check_rate_limit` and sets `g.rate_limit_result`. Add an `after_request` hook that attaches `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset` headers to every response. When `allowed=False`, return `429 Too Many Requests` with `{"error": "rate_limit_exceeded", "retry_after": N}` and `Retry-After: N` header. Admin-token requests (requests with valid `X-Admin-Token` header) bypass per-IP limiting entirely. Config: `RATE_LIMIT_PUBLIC` (env var, default 60), `RATE_LIMIT_SIMULATE` (env var, default 10).
2. Add 12 unit tests: 60th request in a window is allowed, 61st is denied; window resets after `window_secs`; `X-RateLimit-Remaining` decrements correctly; admin token bypasses limit; `/api/simulate` has tighter limit (10); `Retry-After` header equals time until oldest window entry expires; concurrent requests don't race (test with threading); `RATE_LIMIT_PUBLIC` env var overrides default; 429 response body contains `retry_after` int; valid route prefixes map to correct limits; headers present on all 200 responses; headers present on 404 responses (wrong sim_id).
3. Document in `docs/FEATURES.md` under a new "Rate Limiting" section: limits by endpoint category, how to set env vars to customize limits, the `X-RateLimit-*` header spec, admin token bypass, and `429` response format. Add a one-liner to the deployment section of the main `README.md`: "Rate limiting is built in — set `RATE_LIMIT_PUBLIC` and `RATE_LIMIT_SIMULATE` env vars to configure per-IP request limits (default: 60/min and 10/min)."

---

### 4. Simulation Replay Stepper

**Type:** Feature
**Effort:** Medium (1-2 days)
**Impact:** The current simulation result page shows the final state — direction, yes_pct, agent breakdown. `trajectory.json` contains the full per-round belief evolution, but it's invisible to most users. A replay stepper turns the static result into a story: click forward through rounds 1→5, watch agents' beliefs shift, see when the consensus locks or breaks. The API (`GET /api/simulation/:id/replay`) returns a structured sequence of frames — one per round — each with every agent's belief, round-level direction, and confidence. The frontend < Prev / Next > stepper controls animate the evolution. This is a high-engagement surface for blog posts and tutorials ("I simulated X and watched the agents debate round-by-round"), and it's the kind of UI that makes HN commenters say "wait, let me try this." Pure stdlib read of existing `trajectory.json` — no new data generated.

**How:**
1. Add `backend/app/services/replay_service.py` (~140 LoC, pure stdlib). `build_replay(sim_dir, sim_id)`: reads `trajectory.json` (already written by every simulation run). Constructs a `frames` array — one entry per round. Each frame: `{round: int, agents: [{name, role, initial_belief_pct, current_belief_pct, stance, flipped: bool}], round_direction: str, round_yes_pct: float, round_confidence_pct: float}`. `round_direction` and `round_yes_pct` derived by taking the mean of `current_belief_pct` across all agents in that round. `flipped` is True when `stance != initial_stance` (requires cross-referencing `agents.json` for initial stances). Caches result to `replay.json` (mtime-aware, 24h TTL). Route: `GET /api/simulation/:id/replay` (publish-gated, public for published sims, admin-auth for unpublished; `Cache-Control: public, max-age=3600`). Returns `{sim_id, topic, total_rounds, frames: [...]}`. Add 10 unit tests: frame count equals `num_rounds`, each frame has all agents, `round_yes_pct` is mean of beliefs, `flipped` is True when stance changed, `round_direction` is "BULLISH" when `round_yes_pct >= 60`, mtime cache hit skips recompute, published-gate respected, unknown sim_id returns 404, empty trajectory returns 400, output is valid JSON.
2. In `Step3Simulation.vue`, add a "Replay" toolbar button (only enabled when status=complete). On click: open a `ReplayPanel.vue` overlay — full-width dark panel. Shows a round counter "Round 2 / 5" with ← → stepper buttons (keyboard-accessible, ← → arrow keys when panel is focused). For each round: a sorted agent list (by belief_pct desc) with horizontal bars, colored by stance (green=bullish, red=bearish, gray=neutral), and a ↺ flip badge on agents who flipped. Round-level direction chip in the panel header. Add bilingual labels ("Replay" / "回放", "Round" / "轮次", "Flip" / "立场翻转"). Add `getReplay(simId)` to `frontend/src/api/simulation.js`.
3. Add route to OpenAPI spec under "Simulation" tag: `GET /api/simulation/{id}/replay`. Schema: `ReplayResponse` with `frames` array, `ReplayFrame` with `agents` array. Add "Simulation Replay" section to `docs/FEATURES.md`: what replay shows, API format, keyboard navigation note. Add `replay.json` to the `.gitignore` pattern for simulation data directories (already handled if sim dirs are gitignored; add note to `CONTRIBUTING.md` explaining replay frames are derived, not stored).

---

### 5. One-Click Cloud Deploy Templates

**Type:** DX / Community
**Effort:** Small (hours)
**Impact:** The "external public-facing MiroShark instance by July 15" hyperstition is 15 days out. Currently, self-hosting requires reading the full README, adapting the Docker Compose setup, figuring out environment variables, and configuring a reverse proxy. The blocker isn't ability — it's activation energy. A `deploy/` directory with ready-to-run templates for Fly.io and Google Cloud Run removes that friction: `fly launch` from the project root, answer three prompts, have a live public URL in 5 minutes. DYAI2025 already had a Cloud Run deploy script in `cloudbuild.yaml` — this formalizes and completes that work with an operator-friendly DX layer. Direct result: lowers the barrier for the hyperstition from "figure out deployment" to "run one command." Also produces a shareable artifact: the `deploy/` directory becomes the answer to "how do I host this?" in HN comments, Discord questions, and GitHub issues.

**How:**
1. Create `deploy/fly/` with `fly.toml` (app name placeholder, region `ord`, `[[services]]` mapping port 5001 → 80/443 with TCP health check, `[build]` pointing to root Dockerfile, `[env]` section with comments for all required env vars: `ADMIN_TOKEN`, `ANTHROPIC_API_KEY`, `BASE_URL`). Create `deploy/fly/deploy.sh` (15 lines, bash): checks `fly` CLI is installed (errors with install link if not), runs `fly launch --copy-config --no-deploy`, prompts for `ADMIN_TOKEN`/`ANTHROPIC_API_KEY` secrets via `fly secrets set`, runs `fly deploy`. Create `deploy/gcp/` with `cloudbuild.yaml` (build → push → deploy to Cloud Run, image tagged with commit SHA), `service.yaml` (Cloud Run service manifest: image, port 5001, env vars as `${_VAR}` substitutions, `--min-instances=0` for cost control), `deploy.sh` (20 lines: checks `gcloud` CLI, sets project/region, runs `gcloud builds submit`, prints service URL).
2. Create `deploy/README.md` — three-section doc: Fly.io (3 steps: install flyctl, `cd deploy/fly && ./deploy.sh`, visit the URL printed at the end), Google Cloud Run (4 steps: install gcloud, authenticate, set project, `cd deploy/gcp && ./deploy.sh`), and a "What's Deployed" section (what env vars are required vs optional, cost expectations: Cloud Run $0 for low traffic on free tier, Fly.io ~$2/month for Hobby). Add a "Self-Hosting" section to the main `README.md` (between "Docker Compose" and "Contributing"): "**Deploy to the cloud in one command** — templates for [Fly.io](deploy/fly/) and [Google Cloud Run](deploy/gcp/) are in `deploy/`."
3. Add `deploy/docker-compose.prod.yml` — a production-hardened Docker Compose variant: uses `restart: unless-stopped`, sets explicit `ADMIN_TOKEN` env var (not default "admin"), adds nginx reverse proxy service with SSL termination (self-signed cert included, Let's Encrypt instructions in comments), mounts a named volume for `data/` persistence. This covers the operator who wants to self-host on a VPS (Digital Ocean, Hetzner) rather than a PaaS. No changes to the main `docker-compose.yml` — the prod variant is additive.

---

## Selection Rationale

Q2 closes today. Three hyperstitions expire in 15 days. These five are targeted at each of the pressure points:

- **Show HN Launch Kit** (#1) — The HN front page hyperstition doesn't close with code. It closes with a well-timed, well-written submission backed by a live demo. The kit removes every reason to delay the post. 15 days is enough time to prepare and execute.

- **Simulation Data Bundle Export** (#2) — One curl command, one ZIP, all artifacts. Makes MiroShark reproducible for researchers, shareable for creators, and archivable for operators. The smallest possible intervention for the "peer-reviewed paper citation by September" hyperstition. Pure stdlib, no backend deps.

- **API Rate Limiting & Usage Headers** (#3) — A publicly accessible MiroShark instance without rate limiting is an invitation to abuse. Rate limiting is the feature that lets the operator who triggers the "external deployment" hyperstition safely tell anyone to try it. Standard headers (`X-RateLimit-*`, `Retry-After`) make integrations deterministic.

- **Simulation Replay Stepper** (#4) — The most visually compelling feature in this list. Round-by-round belief evolution is the story inside every simulation. The replay panel turns a static result into a dynamic narrative — the kind of thing HN commenters screenshot and share. Builds directly on `trajectory.json` data already written by every simulation run.

- **One-Click Cloud Deploy Templates** (#5) — Fly.io and Cloud Run templates lower the activation energy for the "external deployment" hyperstition from "figure it out yourself" to "run this script." DYAI2025 already started this work. Completing and formalizing it closes the hyperstition and produces a shareable artifact for every future "how do I host this?" question.
