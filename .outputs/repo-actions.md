*Repo Action Ideas — 2026-10-10*
All 3 bugs from Oct 8 fixed in 48h — resume data loss, report 400 race, NER crash. Issue queue empty. 1,467 stars · 304 forks · 95-day silence.

1. Webhook Delivery Log (Feature, Small)
   Append-only delivery log + `GET /api/webhooks/deliveries` — operators can see success rate, latency, and retry history for every webhook dispatch.

2. Cross-Provider Performance Telemetry (Observability, Small)
   Roll up existing llm_call events into `GET /api/observability/providers` — p50/p95 latency, error rate, and avg cost per provider across the last 7 days.

3. Simulation Input Provenance (Feature, Small)
   SHA-256 hash of canonical inputs at `GET /api/simulation/{id}/provenance` — makes MiroShark results scientifically citable; distinct from Signed Result JSON (Jun 8) which signs outputs.

4. CLI Live Progress Stream (DX, Small)
   `--live` flag connects `miro run` to the existing SSE event stream and renders a real-time progress bar + cost ticker; zero new backend code.

5. Opinion Leader Influence Score (Feature, Medium)
   `GET /api/simulation/{id}/opinion-leaders` correlates @-mentions with subsequent stance flips to produce a causal influence score per agent — synthesizes the Jun 12 mention network and Jun 13 stance-flip data.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-10-10.md
