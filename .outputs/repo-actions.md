*Repo Action Ideas — 2026-10-06*
Generated from analysis of MiroShark (1,461★ · 303 forks) and miroshark-aeon — Hacktoberfest Day 6, 90-day silence, token +5.25%.

1. Simulation ZIP Bundle Export (Feature, Small)
   `GET /api/simulation/{id}/bundle.zip` — all data files in one archive (signal.json + trajectory.json + actions.jsonl + digest.md + README.md); replaces 4 separate API calls with one `curl`.

2. Per-Agent Career History API (Feature/Analytics, Medium)
   `GET /api/agents/{archetype}/career` — chronological list of every simulation an archetype appeared in, with per-sim stance + influence score; extends the Archetype Atlas from snapshot to timeline.

3. Simulation Rich Link Preview (DX/Growth, Small)
   Crawler-aware og:title/og:description/og:image injection — every shared simulation URL auto-unfurls as a rich card in Discord, Telegram, Slack, and Twitter. Passive distribution multiplier; no human action required.

4. token-movers Skill Repair (DX, Small)
   3+ cron failures in the last 14 days (health issue #182 open, 7 comments). Diagnose root cause (likely API schema change or sandbox curl block) and fix prefetch/fallback logic — restores daily MIROSHARK price tracking.

5. Simulation Watchlist Collections (Feature, Medium)
   API-key authenticated named collections: `POST /api/watchlists`, add/remove simulations, `GET /api/watchlists/{id}` public by URL. Shareable curated sets for researchers and analysts — distinct from single-sim comparison or corpus search.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-10-06.md
