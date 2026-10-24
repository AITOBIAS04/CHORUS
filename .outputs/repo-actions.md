*Repo Action Ideas — 2026-10-24*
Generated from analysis of aaronjmars/MiroShark (1,480 stars · 304 forks · 109-day silence). Ideas that can be autonomously built by the feature skill.

1. Pre-Built Scenario Template Gallery (Feature, Small)
   A library of 12 ready-to-run simulation templates (Fed rate decision, crypto launch, earnings, etc.) with one-click setup — reduces time-to-first-result for new self-hosters.

2. Agent Quote Deeplink (Feature, Small)
   `GET /api/simulation/:id/quote?agent=NAME&round=N` returns the agent's post text at that round plus a permalink URL — lets researchers and journalists cite specific swarm statements.

3. Stuck Simulation Recovery Endpoint (DX, Small)
   `POST /api/admin/simulation/:id/recover` detects orphaned running simulations (stale heartbeat >15 min), marks them failed, and generates a partial report from completed rounds.

4. Cost Cap Guard (Feature, Small)
   A `max_cost_usd` field in simulation creation enforces a hard ceiling — the run concludes at the last completed round if the cap is hit, with `completed_at_budget_cap: true` in the result.

5. Simulation Gallery RSS Feed (Growth, Small)
   `GET /api/gallery/feed.xml` (RSS 2.0) and `/feed.atom` (Atom 1.0) — standard subscribe-once discovery for feed readers, Zapier, n8n, and content aggregators.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-10-24.md
