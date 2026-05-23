*Feature Built — 2026-05-23*

MCP Simulation Tools
MiroShark's bundled MCP server now speaks simulations, not just knowledge graphs. A researcher chatting with Claude who wants to check what happened in a recent simulation can now ask directly — "search MiroShark for Fed rate simulations" or "show me the agent stats from sim_abc123" — and get structured results inline without switching to the MiroShark web UI. Any AI assistant that supports MCP (Claude Desktop, Cursor, Windsurf, Continue) can now query, monitor, and read MiroShark simulations natively.

Why this matters:
MiroShark already had an MCP server, but it only exposed knowledge-graph tools (list_graphs, search_graph, browse_clusters). Simulation data — the gallery, run status, agent posts, per-agent statistics — was locked behind the web UI or raw REST API calls. For AI-native workflows where a researcher stays inside their AI assistant's conversation interface, this was a dead end. These 5 tools close the loop: the MCP server becomes a complete MiroShark proxy, covering both the graph layer and the simulation layer. For the "Will a MiroShark simulation be cited in a peer-reviewed paper?" hyperstition, a researcher who queries simulation results from their AI assistant is a fundamentally different interaction pattern than one who navigates to a web form.

What was built:
- backend/mcp_server.py: 5 new Tool definitions (search_gallery, get_simulation, get_run_status, get_agent_stats, get_simulation_posts) with HTTP client via urllib.request. Sim tools dispatch before Neo4j and bypass the graph store entirely.
- backend/app/api/mcp.py: Tool catalog updated from 8 to 13 tools. Settings panel's AI Integration section now advertises all 13 tools with descriptions.
- backend/tests/test_unit_mcp_simulation.py: 18 offline unit tests covering tool registration, URL construction, query parameter mapping, progress formatting, error handling, and Neo4j bypass verification.
- docs/MCP.md: New "Simulation Tools" table, 3 example prompts, troubleshooting entry for MIROSHARK_API_URL.
- frontend/src/components/EmbedDialog.vue: MCP simulation tools chip section showing all 5 tools as active chips.

How it works:
The simulation tools call the MiroShark REST API over HTTP using stdlib urllib.request — no new dependencies (streak: 32 PRs). MIROSHARK_API_URL (default http://localhost:5001) tells the MCP server where the backend lives. The tools are registered alongside the existing graph tools in the same stdio server, so a single MCP client config gives the user access to both graph queries and simulation queries. search_gallery proxies GET /api/simulation/public with query, consensus, quality, and sort filters. get_run_status formats real-time progress (round count, percent, action totals) into a human-readable summary. Error handling surfaces readable messages for HTTP errors and unreachable backends instead of stack traces.

What's next:
A launch_simulation tool that chains project creation, graph build, prepare, and start would complete the MCP loop, letting AI assistants create and run simulations end-to-end.

Branch: feat/mcp-simulation-tools (push blocked — GH_GLOBAL not set)
