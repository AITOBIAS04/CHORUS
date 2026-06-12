*Repo Action Ideas — 2026-06-12*
Generated from MiroShark (1,266 stars · 269 forks · 0 open PRs · 37 surfaces). Diagnostic analytics and tooling — all over already-generated data, no new dependencies.

1. Agent Stance Flip Report (Feature, Small)
   Which agents changed conviction, from what to what, and at which round — the per-sim persuasion map for scenario designers.

2. Simulation Full-Text Search (Feature, Small)
   GET /api/simulations/search?q= — pure-stdlib mtime-indexed keyword search across published sim titles and descriptions; the missing discoverability primitive for integrators.

3. Confidence Component Breakdown (Feature, Small)
   GET /api/simulation/:id/confidence/components — exposes the four sub-scores (stability, convergence, participation, adversarial) behind the composite confidence number with a 4-bar breakdown on the watch page.

4. Simulation Fork Lineage Graph (Feature, Small)
   GET /api/simulation/:id/lineage — records fork_parent_id at fork time and surfaces the parent/child tree; makes parameter-sweep fork series navigable.

5. Per-Round Agent Participation Heatmap (Feature, Small)
   GET /api/simulation/:id/participation-heatmap — counts distinct active agents per round from actions.jsonl, broken by platform; reveals participation collapse as a data quality signal.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-06-12.md
