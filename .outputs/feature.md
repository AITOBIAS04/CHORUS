*Feature Built — 2026-05-16*

Coalition Detection in Interaction Network
MiroShark simulations now reveal the hidden social structure behind consensus. Instead of just seeing "74% voted YES," you can now see exactly which agents clustered into self-reinforcing coalitions, how tightly each group was connected, and whether the outcome was driven by genuine cross-group persuasion or a single dominant echo chamber.

Why this matters:
The Interaction Network tab already showed who influenced whom — a wiring diagram. But wiring diagrams don't tell you the meso-level story: did a 7-agent bullish bloc absorb neutrals over time, or did two opposing coalitions of 5 and 4 agents compete for 6 undecided agents in the middle? These are categorically different consensus formation stories, and until now MiroShark couldn't distinguish them. This was the #1 idea from yesterday's repo-actions analysis — the highest-impact analytical upgrade that transforms the network view from decorative into a standalone research tool.

What was built:
- backend/app/api/simulation.py: GET /coalitions endpoint with greedy modularity-maximization algorithm (pure Python stdlib, zero new deps). Builds weighted adjacency from interaction edges, iteratively merges community pairs that maximize modularity Q, labels each coalition by dominant stance + primary archetype + top influencer, computes cohesion scores. Cached in coalitions.json.
- frontend/src/components/InteractionNetwork.vue: Coalition background ellipses (translucent SVG) behind agent node clusters; color-coded legend chips with click-to-highlight (dims non-coalition agents to 20% opacity); coalition detail cards panel showing stance badge, agent count, primary influencer, and cohesion progress bar; orange echo chamber warning banner when one coalition controls >80% of influence edges.
- frontend/src/api/simulation.js: getCoalitions() API function
- backend/openapi.yaml: /coalitions endpoint documented under Analytics tag
- backend/tests/test_unit_coalitions.py: 11 unit tests covering two-cluster detection, echo chamber flag, determinism, cohesion bounds, archetype enrichment, route + spec presence
- docs/FEATURES.md + FEATURES.zh-CN.md: Coalition Detection section with metric interpretation guide

How it works:
The algorithm starts each agent in its own community, then repeatedly merges the pair whose merge yields the largest modularity gain (greedy Louvain-style). It stops when no merge improves Q by more than 0.001. Each resulting coalition gets a dominant stance (most common final stance among members), primary archetype (from profiles.json), primary influencer (highest influence_score), and cohesion score (ratio of intra-cluster edges to all edges touching the cluster, 0-1). The echo_chamber_flag fires when any single coalition accounts for >80% of total influence edges. In the frontend, coalition ellipses are computed from the convex hull of member node positions with 25px padding. Click a coalition chip to isolate it visually — all other nodes and edges dim to near-transparent.

What's next:
Could add per-round coalition evolution tracking (how coalitions form and dissolve over time), or inject coalition metadata into the article generator for richer narratives ("Two distinct coalitions formed by round 4...").

⚠️ Push blocked — GH_GLOBAL secret not set. Branch feat/coalition-detection ready locally (15th consecutive block).
