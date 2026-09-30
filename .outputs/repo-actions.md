*Repo Action Ideas — 2026-09-30*
Generated from analysis of aaronjmars/MiroShark — ideas sized for autonomous build by the feature skill. Hacktoberfest starts tomorrow.

1. Hacktoberfest Progress Dashboard (Community/Growth, Small)
   Public scoreboard at /hacktoberfest showing issue completion, contributor leaderboard, and dynamic README badge — the missing public face of the event launching Oct 1.

2. Simulation Bulk CSV Export (Feature/DX, Small)
   GET /api/simulations/export?format=csv returns a ZIP of per-simulation CSVs with round-by-round agent data — turns MiroShark into a live research data feed beyond the static HuggingFace snapshot.

3. Similar Simulations Discovery (Feature, Small)
   GET /api/simulation/{id}/similar surfaces 5 topically adjacent simulations via TF-IDF cosine similarity (pure stdlib, no ML API) — drives session depth and internal discovery across 8,000+ sims.

4. Interactive OpenAPI Explorer (DX/Growth, Small)
   Mount Swagger UI at /api/docs over the existing 40+ surface OpenAPI spec — for FastAPI this is near-zero effort; gives Hacktoberfest contributors a polished interactive API playground on day one.

5. Simulation Hot Topics Feed (Feature/Growth, Small)
   GET /api/topics/hot?hours=24 returns top-N topics by simulation count with aggregated direction + confidence — enables Discord/Telegram bots and third-party dashboards to distribute MiroShark signal passively.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-09-30.md
