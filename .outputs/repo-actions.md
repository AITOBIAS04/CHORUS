*Repo Action Ideas — 2026-10-08*
Generated from analysis of aaronjmars/MiroShark — 1,464 stars · 303 forks · 3 bugs filed today. Three open issues (first multi-issue wave in 199 days), no open PRs.

1. SQLite Resume Data Safety Fix (DX, Small)
   Fixes #322 — CREATE TABLE IF NOT EXISTS + ROLLBACK wrapper prevents data loss on failed resume retries.

2. Report API Race Condition Fix (Performance, Small)
   Fixes #323 — return 202+Retry-After while generating instead of 400; atomic status record swap kills the force_regenerate race.

3. Provider Capability Matrix (Feature, Small)
   GET /api/providers/capabilities — surfaces which NLP features each provider supports and known issues (e.g. #321 NER crash on claude-code) before a simulation runs.

4. Agent Diversity Score (Analytics, Small)
   GET /api/simulation/{id}/diversity — composite score (stance entropy + archetype variety + platform spread) measuring whether the ensemble was heterogeneous enough to trust.

5. Simulation Embedding API (Analytics, Small)
   GET /api/simulation/{id}/embedding — 384-dim sentence-transformer vector; includes GET /api/simulations/similar?to={id} semantic search as a direct consequence.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-10-08.md
