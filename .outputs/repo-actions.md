*Repo Action Ideas — 2026-10-20*
Generated from analysis of aaronjmars/MiroShark — ideas that could be autonomously built by the feature skill tomorrow.

1. Observability Live Trace Panel (Feature, Medium)
   Subscribe to the live SSE event stream inside Step3Simulation.vue so users can watch agent posts, LLM calls, and cost increments in real time — the observability API is already built, this is the UI cap.

2. Simulation A/B Compare Endpoint (Feature, Small)
   GET /api/simulation/compare?a={id1}&b={id2} returns structured diffs (stance delta, confidence delta, rounds-to-consensus delta, top-3 divergent agents) across two runs of the same topic.

3. Polymarket Context Lookup (Integration, Small)
   Surface polymarket_service.py as GET /api/simulation/:id/polymarket, returning the top 3 matching Polymarket prediction markets alongside the swarm outcome so users can cross-reference real-money prices.

4. Agent Bio Card API (Feature, Small)
   GET /api/simulation/:id/agents/:agent_name/bio returns a structured character sheet — demographic, stance arc, influence score, top mentions, signature phrase — making agents feel like characters instead of data points.

5. Ecosystem Embed Widget (Growth, Small)
   GET /api/ecosystem/embed.js returns a <2KB self-contained JS snippet that partners paste into any page to show a live latest-simulation card, turning ECOSYSTEM.md relationships into active distribution channels.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-10-20.md
