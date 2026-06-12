*Feature Built — 2026-06-12*

Agent Mention Network
MiroShark simulations now have a directed mention graph that reveals who gets talked about in agent discourse. The new surface scans every platform's action logs (Twitter, Reddit, Polymarket), finds @agent_name patterns in post text, and builds a weighted graph showing which agents are the center of attention — often different from who posts the most. A simulation where @Bob gets mentioned 40 times by 8 different agents tells a very different story than one where Bob simply posted 40 times himself.

Why this matters:
The existing Interaction Network graph tracks action-level edges — who replied to, quoted, or liked whom. But textual mentions are a qualitatively different signal: an agent can be talked about constantly without ever being directly interacted with, and vice versa. For researchers studying information diffusion and agenda-setting ('which agent set the narrative?'), mention frequency is the missing primitive. This was idea #3 from the June 6 repo-actions analysis, following Cross-Platform Sentiment Divergence and Per-Round Confidence Trajectory.

What was built:
- mentions_service.py (~270 LoC, pure stdlib): Scans per-platform actions.jsonl files, extracts @-mentions via regex, resolves against agent roster (from agents.json or action lines), builds weighted directed graph with mtime-based disk cache
- GET /api/simulation/<id>/mentions: Publish-gated endpoint returning top_mentioned (ranked list, self-mentions excluded) + mention_matrix (from/to/count directed edges), 5-min cache, 37th catalogued surface
- MentionsPanel.vue: Dark-themed overlay with ranked most-cited agents (gold/silver/bronze badges for top 3), expandable mention matrix table, bilingual EN/ZH
- Step3Simulation.vue: New '@ Mentions' toolbar toggle alongside Influence, Drift, Network, Demographics
- 14 unit tests covering mention extraction, caching, multi-platform aggregation, case-insensitive matching

How it works:
The service reads actions.jsonl from every platform subdirectory in a sim, filters for CREATE_POST actions with content, and applies a regex to extract @word patterns. It resolves each handle against the known agent roster (case-insensitive) — handles not matching a real agent (like @twitter or @reddit) are silently dropped. The output distinguishes the mention_matrix (full directed graph including self-loops) from top_mentioned (top 10, self-mentions excluded from both count and mentioned_by_count). Results are cached to mentions.json with mtime invalidation so the endpoint serves from disk after the first compute.

What's next:
Simulation Narrative Export (Markdown) — a single human-readable document synthesizing signal, trajectory, agents, coalitions, and confidence into a paste-into-Notion format. Push remains blocked (GH_GLOBAL not set — 37th consecutive block).
