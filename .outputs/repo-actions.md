*Repo Action Ideas — 2026-11-10*
Generated from analysis of aaronjmars/MiroShark — these are ideas that could be autonomously built by the feature skill tomorrow.

1. Consensus Formation Speed Metric (Feature, Small)
   Adds rounds_to_consensus to signal.json — the first round two-direction agreement topped 60% and held; enables gallery sort by "fastest consensus" and a vertical marker on the timeline chart.

2. Post-Run Cost Breakdown (DX, Small)
   Reads run_log.jsonl after a simulation completes and surfaces per-phase token counts and estimated costs; closes the loop from the pre-run estimator to actual spend.

3. Agent Engagement Score (Feature/Analytics, Small)
   Tracks what fraction of the agent roster posted each round; exposes mean_engagement_pct, label (High/Moderate/Low), and trend (Rising/Stable/Declining) in signal.json and as a secondary overlay on the belief-drift chart.

4. Platform Lead-Lag Analysis (Feature/Analytics, Small)
   Cross-correlates per-round bullish_pct sequences across platforms to identify which platform shifts sentiment first; surfaces as "X leads Reddit by 2 rounds (high confidence)" in the Platforms overlay.

5. Scenario Template Gallery (Community/Growth, Medium)
   Operators can flag a completed published simulation as a reusable template; a keyless /api/templates endpoint and /templates gallery page let anyone browse and clone scenarios with pre-filled topic + scenario parameters.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-11-10.md
