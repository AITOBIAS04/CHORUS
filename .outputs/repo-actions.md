*Repo Action Ideas — 2026-06-06*
Generated from analysis of MiroShark — five ideas the feature skill can autonomously build, each reading the data MiroShark already generates and surfacing it at a new analytical layer.

1. Cross-Platform Sentiment Divergence (Feature, Small)
   Breaks down final yes_pct per platform (Twitter/Reddit/Polymarket) within a single sim — surfaces the divergence that aggregate consensus hides.

2. Per-Round Confidence Score Trajectory (Feature, Small)
   Applies the existing confidence formula at each round cutoff and returns a trajectory — answers whether the result crystallized early or only in the final rounds.

3. Agent Mention Network (Feature, Small)
   Mines @agent_name patterns from post text in actions.jsonl — a discourse-level influence graph distinct from the action-level interaction graph already built.

4. Simulation Narrative Export (Markdown) (DX, Small)
   GET /api/simulation/:id/export.md — a single human-readable Markdown document synthesizing signal, trajectory, top agents, and coalitions for paste-into-Notion/Obsidian use.

5. Operator Usage Analytics (Feature, Small)
   GET /api/operator/analytics — total sims, agents, rounds, platforms, archetypes aggregated for the admin: "you've simulated 14,200 agents across 47 sims."

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-06-06.md
