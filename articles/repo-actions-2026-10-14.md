# Repo Action Ideas — 2026-10-14

**Repo:** [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark) · [aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon)
**Snapshot:** 1,469 stars · 304 forks · 0 open issues · 0 open PRs · token −1.59% ($0.000002060; FDV $205,990; LP ~$2.65M) · 99-day social silence (100-day milestone tomorrow)
**Recent changes:** docs(security): add security contact email (#333, Oct 14); ci: uv + ruff-action (#332, Oct 13); chore(deps): Dependabot bumps (#331, Oct 13); docs(ecosystem): Sparkleware link fix (#328, Oct 11); fix(simulation/report/llm): three Oct 8 bugs patched in 48h (#324–326, Oct 10)

---

## Context

The codebase is in peak health — 0 open issues, 0 open PRs, ruff lint in CI, 4 Dependabot alerts resolved, security contact added. The last two weeks were pure operational hardening: no new features, just maintenance done cleanly. Security posture improved meaningfully in a single sprint.

The services directory contains 60+ services, many built locally and queued behind GH_GLOBAL being unset. This batch deliberately avoids anything already in `backend/app/services/` (clone, oEmbed, batch_status, replay_gif, notebook_export, bibtex, volatility, archive, lineage, etc. are all queued). These 5 ideas target genuine gaps in the deployed surface.

304 forks, 0 PR conversions. The 100-day social silence milestone hits tomorrow (Oct 15). Signal-to-noise remains high. The next productive layer is: cross-simulation discovery (not per-sim analytics), community visibility (not private tooling), and the security posture completing the circle from #333's contact email.

GH_GLOBAL still unset — feature skill will queue these as local commits.

Prior batches off-limits (Oct 12 / Oct 10 / Oct 8 / Oct 6 / Oct 4 / Oct 2 / Sep 30 / Sep 28 / Sep 26 and earlier): GitHub Codespaces DevContainer, Agent Demographic Stance Breakdown, Consensus Convergence Round, LLM Provider Fallback Chain, Post-Simulation Outcome Annotation, Webhook Delivery Log, Cross-Provider Performance Telemetry, Simulation Input Provenance, CLI Live Progress Stream, Opinion Leader Influence Score, SQLite Resume Safety Fix, Report API Race Fix, Provider Capability Matrix, Agent Diversity Score, Simulation Embedding API, Simulation ZIP Bundle Export, Per-Agent Career History API, Rich Link Preview/Open Graph, token-movers Skill Repair, Simulation Watchlist Collections, Replay GIF Export, Topic Autocomplete, GitHub Discussions Auto-Publisher, Simulation Digest Markdown, Confidence Distribution Analytics, RSS/Atom Feed, x402 Pay-Per-Simulation, Jupyter Notebook Export, Cross-Topic Consensus Heatmap, Social Card Generator, Hacktoberfest Progress Dashboard, Bulk CSV Export, Similar Simulations Discovery, Interactive OpenAPI Explorer, Hot Topics Feed, Simulation Replay Visualizer, Air-Gap Bundle, JSON-LD Structured Data, First-PR Welcome Automation, Simulation Difficulty Score, and all earlier batch entries.

---

### 1. Cross-Simulation Topic Trend Feed

**Type:** Feature / Growth
**Effort:** Small (hours)
**Impact:** Every public simulation has a `signal.json` with a `topic` string. Aggregating those strings across all published simulations — tokenizing, normalizing, ranking by frequency and average confidence — produces a live "what the swarm is thinking about" feed. `GET /api/topics/trending` is the first cross-simulation discovery surface that doesn't require knowing a simulation ID. It powers a homepage trending section, external embeds, newsletter snippets, and gives new users a reason to stay on site without running their own simulation first. No existing trending/discovery endpoint exists in the API.

**How:**
1. Create `backend/app/services/topic_trends_service.py` (~120 LoC, pure stdlib). Scans `uploads/simulations/*/signal.json` for all published (`published: true`) sims. For each, extracts `topic` string and `confidence_pct`/`direction`. Tokenizes: lowercase, strip punctuation, split on whitespace, filter a 50-word English stopword list (the, a, an, is, are, was, were, in, on, at, for, to, of, and, or, but, with, from, about, by). Stem by truncating to 8 chars (avoids dependency on NLTK). Group by normalized token. Per token: `simulation_count`, `avg_confidence_pct`, `dominant_direction` (majority of BULLISH/BEARISH/NEUTRAL across sims containing the token), `most_recent_sim_id`. Rolling window: last 7d (filter `created_at`) and all-time. Cache to `.topic-trends-cache.json` with 15-minute mtime invalidation. Add 5 unit tests: stopwords filtered; 8-char stem normalizes "simulations"→"simulati"; rolling window excludes old sims; dominant_direction is majority stance; cache written after first call.

2. Add `GET /api/topics/trending` endpoint in `backend/app/api/stats.py` (or a new `trending.py`). Public, no auth. Query params: `window` (default `7d`, options `7d`, `30d`, `all`), `limit` (default 20, max 50). Response: `{"topics": [{"token": str, "simulation_count": int, "avg_confidence_pct": float, "dominant_direction": str, "most_recent_sim_id": str}], "window": str, "total_sims_in_window": int, "generated_at": ISO8601}`. Suppress tokens appearing in only 1 simulation — single-sim tokens are noise. Cache-Control: `max-age=900` (15 min). Add to `surfaces_catalog.py` (type: `discovery`) and OpenAPI with `TrendingTopicsResponse` schema. Add to `docs/API.md` under "Discovery" with the stopword and stemming spec. Add 2 integration tests: returns 200; all `simulation_count` values are int > 1.

3. Surface on the homepage (`/`) below the "Recent simulations" section. Add a `🔥 Trending Topics` row: up to 10 chip buttons, each chip showing the token and simulation count ("bitcoin · 14 sims"). Clicking a chip opens the search results for that term (calls `GET /api/simulation/search?q={token}` — the search endpoint from Jun 14). Fetch `/api/topics/trending?window=7d&limit=10` on page load (cache 15 min on the client). No new page required. Add 1 frontend unit test: chip with simulation_count=14 renders "· 14 sims" label.

---

### 2. Confidence Standard-Deviation Bands on BeliefDriftChart

**Type:** Feature / Analytics
**Effort:** Small (hours)
**Impact:** The BeliefDriftChart already renders the per-round mean `confidence_pct` line (from Per-Round Confidence Trajectory, merged Jun 11). The mean hides variance: "round 5 mean 72% BULLISH" could mean 100 agents tightly clustered at 70–74%, or half at 30% and half at 95% — the same mean, a completely different signal. Adding ±1σ shading around the line transforms the chart from a single-number history into a distribution history. Researchers citing MiroShark results gain the spread metric. No new API endpoint required — just one new field in the existing confidence trajectory response.

**How:**
1. Extend `backend/app/services/confidence_trajectory_service.py`. In the per-round computation loop, alongside the existing `mean_confidence_pct`: collect the per-agent confidence values for that round (same source — `trajectory.json`), compute `std_dev_pct = population_std_dev(per_agent_values)` (pure stdlib: `sqrt(sum((x - mean)^2 for x in vals) / len(vals))`). Add `std_dev_pct` and `sample_size` (agent count for that round, after excluding UNKNOWN stances) to each round entry. Backwards-compatible — new optional fields. Invalidate the cache for any existing `confidence_trajectory.json` files by bumping a `schema_version` field from `1` to `2` (service checks version on load, recomputes if stale). Add 4 unit tests: all-same values produce std_dev_pct=0.0; two-value array [0, 100] produces std_dev_pct=50.0; UNKNOWN stances excluded from denominator; schema_version=2 triggers cache invalidation.

2. Update `GET /api/simulation/{id}/confidence/trajectory` response: each round entry adds `{"std_dev_pct": float, "sample_size": int}`. Update `ConfidenceTrajectoryEntry` OpenAPI schema with both new fields as `nullable: false`. Add a note in `docs/API.md`: "`std_dev_pct` is population standard deviation of per-agent confidence values — lower values indicate tight consensus, higher values indicate a split swarm." Add 1 integration test: `std_dev_pct` is present in each round entry and is a non-negative float.

3. In `BeliefDriftChart.vue`, read `std_dev_pct` from each round entry. Compute upper band = `mean + std_dev_pct` (clamped to 100) and lower band = `mean - std_dev_pct` (clamped to 0). Render as a filled SVG path between the upper and lower band lines: `fill: rgba(139, 92, 246, 0.12)` (violet at 12% opacity, matching the existing chart's violet line). The mean line renders on top as before. Add a legend entry: "σ band" with the translucent violet swatch. When `std_dev_pct` is unavailable (old cached results without the new field), render chart unchanged — graceful degradation. Add 1 frontend unit test: round with std_dev_pct=20, mean=70 produces upper band point at 90 and lower at 50.

---

### 3. `/.well-known/security.txt` Endpoint

**Type:** Security / DX
**Effort:** Small (hours)
**Impact:** PR #333 (merged today) added a security contact email to `docs/SECURITY.md`. The next step in the responsible disclosure stack is `security.txt` (RFC 9116) — a machine-readable file at `/.well-known/security.txt` that security scanners, bug bounty platforms, and researchers check automatically before probing a service. HackerOne, Bugcrowd, and `securitytxt.org` all crawl this path. Every major open-source project that hardened its security posture in 2025–2026 added this after their contact page. Without it, automated tools can't find the contact and may report or probe silently. Two routes needed: `/.well-known/security.txt` (served by backend) and `SECURITY.txt` in the repo root (GitHub surfaces it under the Security tab).

**How:**
1. Create `backend/app/api/security_txt.py` (30 LoC). Serve `GET /.well-known/security.txt` with `Content-Type: text/plain; charset=utf-8` and `Cache-Control: max-age=86400`. Body (RFC 9116 format):
   ```
   Contact: [email from SECURITY.md]
   Expires: [1 year from deploy date, ISO8601 format — read from env var SECURITY_TXT_EXPIRES or default to 1 year from server start]
   Preferred-Languages: en
   Canonical: https://miroshark.xyz/.well-known/security.txt
   Policy: https://github.com/aaronjmars/MiroShark/blob/main/docs/SECURITY.md
   ```
   Register this route in the main FastAPI/Flask app before other catch-all routes. Also serve `GET /security.txt` (a courtesy redirect to `/.well-known/security.txt`) for scanners that check the root path. Add `SECURITY_TXT_EXPIRES` to `.env.example` (commented, with format note: `SECURITY_TXT_EXPIRES=2027-10-14T00:00:00Z`). Add 3 unit tests: response body contains `Contact:` line; `Expires:` is a valid ISO8601 date; `Content-Type` is `text/plain`.

2. Create `SECURITY.txt` in the repo root (distinct from `docs/SECURITY.md`). GitHub's Security tab looks for either `SECURITY.md` or `SECURITY.txt` at root, `/docs/`, or `/.github/`. The root `SECURITY.txt` ensures maximum discoverability. Content: RFC 9116 format (same fields as the endpoint), but `Canonical:` points to the live URL. Add a `# For machine-readable format, see /.well-known/security.txt` comment at the top. This is a 10-line file with no code dependencies. Add a note to `docs/SECURITY.md` linking to both the root `SECURITY.txt` and the live endpoint: "MiroShark publishes a machine-readable security.txt at `/.well-known/security.txt` per RFC 9116."

3. Register `security_txt.py` in the backend app router. Add `/.well-known/security.txt` to the `surfaces_catalog.py` (type: `meta`) — it's a public-facing surface. Add to `docs/API.md` under a new "Security" section with one line: "MiroShark serves a RFC 9116 security.txt at `GET /.well-known/security.txt`." Add 1 integration test: `GET /.well-known/security.txt` returns 200 with a body containing `Contact:`.

---

### 4. Simulation Author Attribution

**Type:** Community / DX
**Effort:** Small (hours)
**Impact:** Every published simulation share page (`/sim/{id}`) currently shows the simulation topic and results, but not who ran it. Community members, researchers, and content creators who share their simulations lose attribution — the URL and output carry no identity. `POST /api/simulation/{id}/author` lets the authenticated creator attach a display name and optional social handle to their simulation. The share page renders "By @alice" below the topic. Over time, author profiles emerge naturally: filtering by author creates a portfolio view ("all simulations by @alice"). No prior batch touched attribution or creator identity.

**How:**
1. Create `backend/app/services/author_service.py` (~80 LoC, pure stdlib). Data model: `{"display_name": str (max 50 chars), "handle": str|null (max 30 chars, alphanumeric + underscores + hyphens, no @), "profile_url": str|null (max 200 chars, must start with https://), "attached_at": ISO8601}`. Store as `uploads/simulations/{id}/author.json`. Validation: `display_name` required; `handle` optional but if provided, reject if it contains spaces or special chars other than `_` and `-`; `profile_url` optional but if provided, must pass `urllib.parse.urlparse` check (`scheme == "https"` and netloc non-empty). Add 5 unit tests: valid author data writes author.json; display_name over 50 chars rejected; handle with space rejected; profile_url with http:// (not https) rejected; valid handle with underscore accepted.

2. Add two endpoints in a new `backend/app/api/author.py`. `POST /api/simulation/{id}/author` — auth-required (only the simulation owner can set author; validate via session). Body: `{"display_name": str, "handle": str|null, "profile_url": str|null}`. Returns `{"simulation_id": str, "author": {...}, "created": true}`. `GET /api/simulation/{id}/author` — public. Returns the author JSON or `{"author": null}` if not set. Cache-Control for GET: `max-age=3600`. Add a `GET /api/simulations?author_handle={handle}` query param to the existing simulation listing endpoint: filter sims where `author.json` exists and `handle` matches (case-insensitive). Add to `surfaces_catalog.py` (type: `meta`) and OpenAPI with `AuthorResponse` schema. Add to `docs/API.md` under "Author Attribution" with the validation spec (max lengths, allowed chars). Add 3 integration tests: POST returns 201; GET returns 200 with author dict; non-owner POST returns 403.

3. Surface on the share page (`/sim/{id}`). In the simulation result header, below the topic title and above the confidence badge: conditionally render `By {display_name}` (if author is set). If `handle` is set, make it a link: `By <a href="{profile_url or https://x.com/{handle}}">{display_name}</a>`. If not set, render nothing (no "By unknown" placeholder). In the share card SVG/OG image (if share_card.py is used), include `display_name` below the topic in smaller text. On the Step 3 result page (authenticated view), add a small `✏️ Add your name` button near the result title that opens a 3-field inline form (display_name, handle, profile_url). On submit, POST to `/api/simulation/{id}/author` and refresh the page. Add 2 frontend unit tests: share page renders "By alice" when author.display_name="alice"; no "By" text when author is null.

---

### 5. Topic Subscription Webhooks

**Type:** Integration
**Effort:** Medium (1-2 days)
**Impact:** The existing webhook system (WEBHOOKS.md) fires events for simulation lifecycle changes to the *runner* — the person who started the simulation. There is no observer model: no way for a third party to say "notify me whenever a simulation on the topic 'bitcoin' is published." Topic subscriptions close this gap — creating a lightweight notification layer for ecosystem partners, market intelligence tools, and research pipelines. A n8n automation watching for "bitcoin" simulations, a Discord bot alerting when "AI regulation" gets a new sim, a Zapier zap firing on "NVIDIA earnings" — all become possible without polling. This is the first *inbound observer* feature in the webhook system; the current system is purely *outbound to the runner*.

**How:**
1. Create `backend/app/services/topic_subscription_service.py` (~150 LoC, pure stdlib). Data model per subscription: `{"subscription_id": uuid4, "keyword": str (3–50 chars, lowercase), "webhook_url": str (https:// only), "created_at": ISO8601, "last_triggered_at": ISO8601|null, "trigger_count": int}`. Store subscriptions in `uploads/topic_subscriptions.jsonl` (append-only, one JSON per line). On simulation publish (hook into `simulation_manager.py` where `published: true` is set): load all subscriptions, check if `keyword in topic.lower()` (simple substring match), fire matching webhooks with payload `{"event": "simulation.published", "keyword": str, "simulation_id": str, "topic": str, "direction": str, "confidence_pct": float, "share_url": str, "published_at": ISO8601}`. HMAC-sign the payload using the same `WEBHOOK_SECRET` as the existing webhook system for consistency. Append a delivery record to `uploads/webhook_deliveries.jsonl` (same format as future Webhook Delivery Log). Update `last_triggered_at` and `trigger_count` in the subscription record (re-read + rewrite full list on update — acceptable at low subscription counts). Add 5 unit tests: keyword match is case-insensitive; non-matching keyword does not trigger; webhook payload contains all required fields; HMAC signature computed correctly; duplicate subscription_id rejected.

2. Add three endpoints in `backend/app/api/subscriptions.py`. `POST /api/webhooks/subscriptions` — no auth required (anonymous subscriptions, validated by webhook URL ownership). Body: `{"keyword": str, "webhook_url": str}`. Validate keyword (3–50 chars, alphanumeric + spaces + hyphens, no special chars). Validate webhook_url starts with `https://`. Rate-limit: max 5 active subscriptions per webhook URL (to prevent abuse). Returns `{"subscription_id": str, "keyword": str, "webhook_url_preview": str (first 30 chars + "…"), "created_at": ISO8601}`. `DELETE /api/webhooks/subscriptions/{subscription_id}` — no auth (subscription owner proves identity by knowing the ID; subscription_id is a UUID not guessable). Soft-delete by marking `deleted: true` in the record. `GET /api/webhooks/subscriptions/{subscription_id}` — no auth. Returns status, last_triggered_at, trigger_count. Add to `surfaces_catalog.py` (type: `integrations`) and OpenAPI with `SubscriptionResponse` schema. Add to `docs/WEBHOOKS.md` under a new "Topic subscriptions" section with the keyword format spec and a n8n/Zapier example. Add 4 integration tests: POST returns 201 with subscription_id; 6th subscription for same URL returns 429; DELETE returns 204; GET returns subscription status.

3. Add a "Topic subscriptions" section to the Settings → Integrations frontend (sibling to the existing webhook URL field). Show a simple form: keyword input + webhook URL input + Subscribe button. On submit: POST to `/api/webhooks/subscriptions`, display the returned `subscription_id` in a copyable chip ("Save this ID to manage your subscription"). Show a warning: "⚠ Save this ID — it's the only way to delete your subscription." Below the form, a "Test subscription" button that fires a synthetic webhook delivery to the URL with `"event": "simulation.test"` payload — same HMAC signing, no simulation data. Add 1 frontend unit test: form submission displays subscription_id chip and warning message.

---

## Selection Rationale

The codebase has 60+ services queued locally. This batch targets 5 gaps that aren't built: one discovery layer, one analytical enhancement, one security posture step, one creator identity feature, and one observer-model integration.

- **Topic Trend Feed (#1)** — 304 forks, 0 PRs, 99-day social silence. New users arrive on the homepage with no hook. A live "trending topics" row answers "what do people simulate?" without requiring signup or a simulation run. First cross-simulation discovery surface in the API. Builds on the search endpoint (Jun 14) by adding a serendipitous entry point.

- **Confidence Std-Dev Bands (#2)** — The confidence trajectory chart shows mean. Two simulations with identical means can have wildly different distributions. Adding ±1σ shading is a 30-line service addition and a 10-line chart addition. The output transforms from "here's the trend" to "here's how uncertain the trend was." Researchers with a MiroShark citation need this to characterize their results.

- **security.txt (#3)** — PR #333 added a contact email today. The `/.well-known/security.txt` file is the machine-readable version of that — checked by automated security scanners, bug bounty platforms, and researchers before they probe a service. It's the last 10 lines that complete the responsible disclosure circle. If this isn't filed in the next week, automated tools will probe first and ask later.

- **Author Attribution (#4)** — Every simulation is anonymous today. Researchers, students, and content creators who share their simulations lose credit. Author attribution is the piece that makes MiroShark a *portfolio* tool — "here are the 40 simulations I've run." It's also the foundation for community leaderboards, author filtering, and eventual reputation systems. Small service, high social leverage.

- **Topic Subscription Webhooks (#5)** — The existing webhook system fires events to the person who *ran* a simulation. No one can *watch* for new simulations on a topic. This is the first observer-model feature: subscribe to "bitcoin" and get notified whenever anyone publishes a sim on it. n8n, Zapier, Discord bots, research pipelines — all become first-class consumers. The hardest of the 5 ideas, but the one that most directly unlocks ecosystem growth.
