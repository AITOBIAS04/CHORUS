*Feature Built — 2026-06-13*

Agent Stance Flip Report
MiroShark simulations now have a "persuasion map" surface. The new Stance Shifts panel shows which specific agents changed their mind during a simulation — from bullish to bearish or vice versa — at exactly which round they first diverged, and ranks them by how much influence they carried. Instead of just seeing "60% ended bullish," operators can now trace whether the consensus was driven by many agents flipping early or a few high-influence agents dragging the crowd late.

Why this matters:
Until now, MiroShark tracked what the crowd concluded (trajectory chart) and who the agents were (agents.json), but not the persuasion dynamics between the two. A simulation where 40 agents flip in round 2 has completely different dynamics from one where 2 influential agents flip in round 8 — and both could produce the same final trajectory. This was the #1 idea from yesterday's repo-actions analysis, filling the "diagnostic gap" identified across the last three feature cycles: the layer that tells operators *why* a simulation produced the result it did.

What was built:
- stance_flip_service.py (new, ~246 LoC): Pure-stdlib service that reads trajectory.json snapshots, identifies every agent whose stance changed between their first and last round, pinpoints the exact flip round (first divergence from initial stance), and ranks flippers by influence score. Mtime-based disk cache to stance_flips.json.
- GET /api/simulation/:id/stance-flips: New endpoint with publish gate, 5-minute cache, and surface stat tracking. Returns flip_count, flip_rate_pct, total_agents, and top 10 flippers with agent name, initial/final stance, flip round, and influence score.
- StanceFlipsPanel.vue (new): Dark-themed overlay panel with a flip count headline, percentage rate bar, and a ranked list of the top 5 flippers — gold/silver/bronze badges, colored stance chips (green for bullish, red for bearish, gray for neutral), and round indicators.
- Step3Simulation.vue: New "↻ Stance Shifts" toolbar button alongside the existing Influence, Drift, and Network buttons.
- EmbedDialog.vue: Stance flips embed section with preview stats, copyable URL, and curl snippet.
- 14 unit tests covering: no flippers, single flipper detection, flip_round identification, same-initial-final exclusion, rate calculation, influence sorting, cap at 10, cache write/read/staleness, and surface registration.

How it works:
The service walks trajectory.json's per-round snapshots — the same data source agent_sparklines and chart.svg use — and computes each agent's stance per round using the shared ±0.2 threshold. For each agent where the final stance differs from the initial, it records the first round of divergence (the "flip round") and the agent's influence score from influence_scores.json. Results are sorted by influence descending so the most impactful opinion-changers appear first, capped at 10 for the top_flippers array. The panel renders on the existing toolbar overlay system with the same dark-themed styling as the Influence and Network panels. 38th catalogued surface, zero new dependencies, pure stdlib.

What's next:
Push is blocked (GH_GLOBAL not set — 38th consecutive block). Next candidates: Simulation Full-Text Search (#2) or Confidence Component Breakdown (#3) from yesterday's repo-actions ideas.
