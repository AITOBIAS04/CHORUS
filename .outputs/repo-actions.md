*Repo Action Ideas — 2026-06-18*
Generated from analysis of aaronjmars/MiroShark (1,309 stars · 0 open PRs · recent: French i18n complete, cost.json shipped, Python 3.14).

1. Agent Influence Leaderboard (Feature, Small)
   GET /api/simulation/:id/influence-rank — surfaces influence_score already in agents.json; a "Key Voices" panel shows who drove the outcome.

2. Simulation Time-to-Complete Estimator (Feature, Small)
   GET /api/estimate?agents=N&rounds=N — pre-run duration + cost estimate from historical medians; closes the loop on the "$1 & <10 min" homepage promise.

3. Simulation Replay Stepper (Feature, Medium)
   A play/pause/scrub control on the watch page steps through trajectory.json round by round, animating BeliefDriftChart — no new backend endpoints, pure composable.

4. Per-Round Cost Curve (Feature, Small)
   GET /api/simulation/:id/cost/rounds — extends the cost.json surface to show per-round spend accumulation; operators can tune high-cost rounds before committing to a full run.

5. Topic Trend Tracker (Feature, Small)
   GET /api/topics/trends — weekly keyword frequency across published simulations, sparkline chips in ExploreView "Trending" tab; 14 ecosystem partners get a rising-topics signal without scanning individual sims.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-06-18.md
