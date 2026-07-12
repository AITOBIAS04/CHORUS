*Repo Action Ideas — 2026-07-12*
Generated from live analysis of aaronjmars/MiroShark (1,359 stars · 288 forks · 0 open PRs). Targeting September hyperstitions: 5 languages (4/5 now), peer-review citation, public case study.

1. Japanese (JA) UI Locale (Feature, Small)
   README.ja.md already exists; adding JA to the UI switcher closes the September '5 languages' hyperstition using the same dictionary pattern as FR/DE.

2. Simulation Diff API (Feature, Small)
   GET /api/simulation/diff?a={id}&b={id} returns structured delta (direction, yes_pct, confidence, per-platform sentiment) — the minimum viable 'two-run comparison' for research methodology.

3. Per-Agent Belief Timeline (Feature, Small)
   GET /api/simulation/{id}/agent/{agent_id}/timeline — per-round belief arc for a single agent; trajectory.json is aggregate, this is per-agent and rounds out the agent observability stack.

4. Verified Predictions JSON API (Feature, Small)
   GET /api/verified — machine-readable version of the existing /verified page with accuracy meta block; one API call to cite 'MiroShark accuracy across N verified predictions.'

5. Research Series / Campaign Tracker (Feature, Medium)
   POST /api/series + GET /api/series/{slug} — named collection of simulations with yes_pct trend tracking; enables longitudinal research and is the direct path to the 'public case study' hyperstition.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-07-12.md
