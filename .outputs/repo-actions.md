*Repo Action Ideas — 2026-11-24*
Generated from analysis of aaronjmars/MiroShark — these are ideas that could be autonomously built by the feature skill tomorrow.

1. One-Click Dev Environment (DX improvement, Small)
   .devcontainer/devcontainer.json + Gitpod .gitpod.yml lets fork owners open a full dev environment in one browser click — direct lever for the Nov 30 external PR hyperstition (6 days).

2. Simulation CSV Export (Feature, Small)
   GET /api/simulation/:id/export.csv returns per-agent action log as a downloadable CSV (agent, round, platform, action_type, bullish_pct) for researchers doing external analysis in pandas, Excel, or R.

3. Webhook Delivery Log (DX improvement, Small)
   GET /api/webhooks/:id/deliveries returns last 50 real delivery attempts with status code, latency, and retry button — audit trail for the existing webhooks system; distinct from the Nov 12 test-event playground.

4. Automated CHANGELOG.md Generator (Content, Small)
   scripts/generate-changelog.sh + GitHub Actions workflow generates a human-readable CHANGELOG.md grouped by release and commit type — makes the codebase history legible for Docker-pull operators and new contributors.

5. Similar Simulations Discovery (Feature, Small)
   GET /api/simulation/:id/similar returns up to 5 published simulations with high topic overlap (Jaccard similarity, pure stdlib, cached index) — surfaces adjacent runs after completing a simulation and extends session depth.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-11-24.md
