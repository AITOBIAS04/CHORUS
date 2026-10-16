# Repo Action Ideas — 2026-10-16

*Generated from aaronjmars/MiroShark analysis — 1,473 stars · 304 forks · 0 open issues · recent: security hardening, uv+ruff CI, 3 bug fixes (resume, report, LLM repair)*

---

### 1. `/api/health` Deep-Check Endpoint
**Type:** DX Improvement
**Effort:** Small (hours)
**Impact:** Production deployments and external integrators have no structured way to verify that all MiroShark dependencies are healthy before running a simulation. A `/api/health` endpoint returning JSON component statuses (Neo4j connectivity, LLM provider reachability, disk space for simulation storage, API key validity) enables load-balancer health checks, uptime monitors, and self-hosted operator confidence. Existing deployment configs (Railway, Cloud Run, Docker Compose) all lack this hook.
**How:**
1. Add a `GET /api/health` route in the backend that runs lightweight probes: Neo4j `RETURN 1` ping, a zero-token LLM test call or key format validation, and `shutil.disk_usage` check.
2. Return structured JSON: `{"status": "ok"|"degraded"|"unhealthy", "components": {"neo4j": ..., "llm": ..., "disk": ...}, "version": "..."}`.
3. Add the endpoint to the OpenAPI spec and link it in `README_DEPLOYMENT.md` under each deployment guide.

---

### 2. Simulation Tagging System
**Type:** Feature
**Effort:** Small (hours)
**Impact:** As the public gallery grows, discovery degrades. Users running multi-scenario research (Bull/Bear/Neutral batches, A/B topic variants) have no way to group related simulations. A lightweight tagging system — up to 5 custom tags per simulation at creation time — makes the existing full-text search endpoint dramatically more useful and turns the gallery into an organized library rather than a flat list.
**How:**
1. Add a `tags` field (list of strings, max 5, max 32 chars each) to the simulation creation API payload and persist it alongside the simulation metadata JSON.
2. Expose `tags` on the existing `GET /api/simulation/:id` and search responses; add `?tag=foo` filter to the search endpoint.
3. Render tags as clickable chips in the Step3Simulation.vue header and the public gallery card, each linking to `?tag=` search results.

---

### 3. Simulation Cost Breakdown Receipt
**Type:** Feature
**Effort:** Small (hours)
**Impact:** MiroShark's "$1 per simulation" claim is a key conversion driver, but users currently see only a total cost figure. An itemized receipt — LLM calls × tokens × cost by phase (ontology, graph build, agents, simulation rounds, report) — builds trust, helps users optimize for cheaper runs, and gives the team concrete data on which phases dominate spend. Especially valuable for enterprise prospects evaluating at scale.
**How:**
1. Instrument the existing LLM call sites to accumulate `{phase, model, prompt_tokens, completion_tokens, cost_usd}` records into a cost ledger stored alongside `trajectory.json`.
2. Expose `GET /api/simulation/:id/cost-breakdown` returning the ledger grouped by phase with subtotals and a grand total.
3. Add a collapsible "Cost Receipt" panel in the Step3Simulation.vue sidebar, showing phase rows with a bar-proportional visualization.

---

### 4. Multi-Scenario Batch Runner
**Type:** Feature
**Effort:** Medium (1–2 days)
**Impact:** Researchers and product teams often want to test the same topic under multiple framings (different agent compositions, Bull vs Bear seed, injected events) and compare outcomes. Today that means running simulations one-by-one. A batch runner — `./miroshark batch scenarios.json` — that executes N simulations sequentially and emits a summary CSV/JSON with key metrics (final stance split, consensus round, cost, top agent) dramatically accelerates research workflows and is a natural showcase for the prediction-market use case.
**How:**
1. Add a `batch` subcommand to the `miroshark` CLI that reads a JSON array of scenario definitions and calls the existing simulation API endpoint for each, with configurable concurrency (default: sequential to respect rate limits).
2. After all runs complete, write a `batch-summary-{timestamp}.json` and `batch-summary-{timestamp}.csv` with one row per simulation: id, topic, rounds, final_bullish_pct, consensus_round, total_cost_usd, report_url.
3. Print a Markdown table to stdout on completion and add a `--open` flag to open the first report in the browser.

---

### 5. Python SDK on PyPI
**Type:** Integration
**Effort:** Large (3+ days)
**Impact:** The REST API is well-designed but requires users to hand-craft curl/fetch calls. A `pip install miroshark` SDK that wraps the API (`sim = miroshark.run(scenario="...")`, `sim.wait()`, `sim.report`, `sim.agents`) would unlock the data science and research community — the same audience that made LangChain and Hugging Face sticky. MiroShark already publishes a HuggingFace dataset; a PyPI package is the natural companion. Lower integration friction = more forks converting to real users.
**How:**
1. Create a `sdk/python/` directory with a minimal `miroshark` package: `Client`, `Simulation`, `Agent` classes wrapping the public REST endpoints with sync and async interfaces (`asyncio`-friendly).
2. Add a `pyproject.toml` (hatch/flit), typed stubs, and a `README.md` with 3-line quickstart. Pin to `httpx` as the sole dependency.
3. Publish to PyPI via a new GitHub Actions workflow triggered on `sdk/python/` tag pushes; add a `[![PyPI](https://img.shields.io/pypi/v/miroshark)](https://pypi.org/project/miroshark)` badge to the main README.
