*Feature Built — 2026-06-06*

Agent Archetype Atlas
MiroShark now has a platform-wide view of how each agent profession behaves across all published simulations. If "Financial Analyst" has appeared in 60 published sims, you can now see its aggregate stance distribution, how often it flips from bullish to bearish (or vice versa), and its average influence score — all from a single /archetypes page.

Why this matters:
Until now, agent identity data from agents.json existed only per-simulation. An operator choosing archetypes for a new sim had no way to know how "Risk Manager" typically behaves across the platform — does it converge bearish? Does it flip stances more than "Market Analyst"? The archetype atlas is the first cross-simulation analytics surface that aggregates the agents.json data (27th share surface, PR #137) into a platform-wide reference. It also feeds back into the simulation creation flow as a behavioral baseline for operators building new scenarios.

What was built:
- backend/app/services/archetype_atlas_service.py: Scans all published sim dirs for reddit_profiles.json and trajectory.json. Groups agents by profession, computing sim_count, appearances, avg_initial_bullish_pct, avg_final_bullish_pct, flip_rate, avg_influence_score, and most_common_topic. Results cached to archetype_atlas.json with a 1-hour TTL. Pure stdlib.
- backend/app/api/archetypes.py: Flask blueprint with two public endpoints — GET /api/agents/archetypes (full atlas sorted by sim_count desc) and GET /api/agents/archetypes/<name> (single entry, case-insensitive match, 404 for unknown). 60-second Cache-Control.
- frontend/src/views/ArchetypeAtlasView.vue: Dark-themed /archetypes page with responsive card grid. Each card shows a rank badge (gold/silver/bronze for top 3), profession name, sim count, three horizontal stat bars (bullish start, bullish end, flip rate), most common topic tag, and influence score. Sort toggles between Most Used and Most Volatile. Click to expand for stance shift comparison (initial → final distribution). Bilingual EN/ZH.
- 14 unit tests covering atlas aggregation across multiple sims, flip rate extremes (0% and 100%), null influence scores, topic mode detection, cache hits and forced refresh, case-insensitive lookup, and publish/status gating.

How it works:
The service scans every directory under WONDERWALL_SIMULATION_DATA_DIR, filtering for published+completed sims (same gate as platform_stats). For each sim, it reads reddit_profiles.json for profession data and trajectory.json for belief positions. Agents are grouped by profession string, and per-archetype stats are accumulated: how many sims the profession appeared in, initial and final stance distributions derived from the same ±0.2 threshold every other surface uses, flip rate (percentage of appearances where initial_stance ≠ final_stance), and average karma as an influence proxy. The atlas is written to archetype_atlas.json with an mtime-based 1-hour TTL so the first request after an hour triggers a rebuild, but subsequent requests serve from cache. The frontend fetches via a standard axios GET and renders the sorted grid.

What's next:
Add ?archetype= filter to the gallery endpoint so users can browse all sims featuring a specific profession. Link archetype cards from the sim creation flow so operators can reference behavioral baselines when choosing agent populations.

Branch: feat/agent-archetype-atlas (push blocked — GH_GLOBAL not set)
