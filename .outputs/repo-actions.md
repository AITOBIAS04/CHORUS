*Repo Action Ideas — 2026-05-02*
MiroShark at 976 stars — 5 new ideas for the feature skill, distinct from the 10 suggested on Apr 30.

1. Community Scenario Template Gallery (Growth/DX, Small)
   Extend the 6 hardcoded presets into a user-created, browsable, forkable template gallery — each shared template is a domain-specific discovery entry point and the viral lever for the push to 1K stars.

2. Fork / Counterfactual Diff View (Feature, Medium)
   Side-by-side comparison of a fork against its parent simulation — overlaid belief drift chart, divergence round marker, final price delta, and agent overlap score. Closes the loop on the fork primitive as a publishable controlled-experiment surface.

3. Programmatic Agent Interrogation API (Integration, Small)
   POST /api/simulation/:id/agents/:agent_id/query — API access to the Trace Interview feature (currently UI-only since PR #26). Unlocks agent interrogation for GitHub Actions, n8n, and research pipelines. Rate-limited; multi-turn via session_id.

4. Mid-Run Belief Threshold Alert Webhooks (Integration, Small)
   Webhook fires when agent consensus crosses a user-defined threshold mid-simulation (e.g., bearish > 60%). Complements the completion webhook with a real-time monitoring primitive — signal arrives 12 rounds earlier for a threshold hit at round 3 of 15.

5. Simulation Series / Longitudinal Study Tracker (Feature, Medium)
   Group simulations into a named study with a time-series belief dashboard, recurring-agent table, and bundled ZIP export (summary CSV + transcripts + study-level Jupyter notebook). The research container that turns MiroShark into a longitudinal platform.

Full details: https://github.com/AITOBIAS04/miroshark-aeon/blob/main/articles/repo-actions-2026-05-02.md
