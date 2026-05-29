# Most Software Has a Front Door. This One Has Twenty-Four.

In February 2026, NIST launched the AI Agent Standards Initiative — the first federal effort to set interoperability rules for autonomous software agents. By May, Anthropic's Model Context Protocol had crossed 97 million SDK downloads and 10,000 enterprise server deployments. Google shipped A2A for agent-to-agent coordination. IBM backed ACP. The Linux Foundation gave MCP a governance home. Every major cloud vendor signed on.

And yet the interoperability problem got worse.

## The Wall Nobody Named

The protocols solved the easy half. MCP standardized how an agent connects to a tool — authentication, capability declaration, transport format. Think of it as USB for AI: plug in, handshake, go. But as the Conectia research group put it bluntly this spring: "Two MCP servers can both expose a `get_customer` tool with completely different schemas, semantics, and consistency guarantees. The protocol moves the problem up one level; it doesn't make it disappear."

The harder half lives on the other side of the connection. Not how agents reach software, but what software gives them when they arrive.

Most applications have two integration points: a user interface and maybe a REST API. A human opens a dashboard and clicks around. An agent hits `/api/v1/results` and parses JSON. That is the entire surface. When a research firm found that 65% of organizations now generate revenue from APIs and that agents "invoke interfaces continuously and at machine speed," the implication was clear — a two-door building cannot handle machine-speed traffic any better than a two-lane highway handles rush hour. The bottleneck is not the on-ramp. It is the destination.

## Twenty-Four Doors, No Lobby

MiroShark is an open-source simulation engine — 1,210 stars, 257 forks — that models how opinions spread through networks of AI agents. It runs a simulation, generates a result, and then exposes that result through twenty-four independently addressable integration points. The project calls them "share surfaces."

This number sounds like a boast. It is not. It is an architectural decision with a specific consequence: almost any consumer — human, agent, platform, protocol — can access MiroShark's output in the format it already understands, without asking the MiroShark team to build anything new.

Here is what twenty-four surfaces actually looks like in practice. A researcher pastes a simulation link into a Notion doc; oEmbed auto-unfurls it into a rich preview card, no plugin required. A Polymarket bot subscribes to completion webhooks filtered by `bullish,high_confidence` — source-side subscription with AND/OR semantics, so it never receives a simulation it does not care about. A network scientist downloads the agent interaction graph as GraphML 1.1 and opens it directly in NetworkX or Gephi. An RSS reader picks up new results through a filtered feed. A dashboard embeds a Shields.io badge that updates live. A Substack writer drops in an iframe embed. An archival system pins the result to IPFS via WaybackClaw. An LLM agent queries five simulation tools through MCP without touching a browser.

Each of these is a different protocol — oEmbed, RSS, GraphML, SVG, webhooks, MCP — not just a different URL path on the same API. The simulation data is identical. The consumption modes are radically different.

## The Architectural Choice That Made It Possible

The surfaces did not arrive as a grand plan. They accumulated over thirty-eight pull requests in six weeks, each one adding a single integration point. The pattern that held across all of them: every new surface is a standalone Python service using only the standard library. The oEmbed provider serializes XML with `xml.etree.ElementTree`. The badge renderer draws SVG geometry by hand. The GraphML exporter writes directed graphs with seven node attributes and three edge attributes using the same XML library. No Flask extensions. No requests. No image libraries. Zero new dependencies across the entire run.

This constraint — pure stdlib, one service per surface — is what made twenty-four surfaces possible without the codebase collapsing under its own weight. Each surface is roughly 200-400 lines. Each has its own unit tests — 24 for webhooks, 18 for oEmbed, 24 for GraphML. Each reads the same simulation data directory and reuses the same stance-threshold constants, so a "bullish" signal in the trading JSON matches the "bullish" label on the RSS feed matches the "bullish" badge colour on the SVG. The surfaces are consistent not because a framework enforces consistency, but because they all derive from the same source files through the same arithmetic.

The most recent addition — PR #120, the webhook event dispatch filter — illustrates the pattern at its sharpest. It added 237 lines to the webhook service. It lets each downstream integrator set an environment variable (`WEBHOOK_EVENTS=bearish,excellent_quality`) that filters outbound webhooks at the source before dispatch. The filter is late-bound — it reads `os.environ` on every call, so an operator flips rules without restarting. Failed simulations bypass the filter entirely, because a consumer that subscribed to good news still needs to know about failures. Twenty-four unit tests. Zero new dependencies. One afternoon of work that gave every integrator in MiroShark's ecosystem the ability to self-select their signal.

## Why Outputs Matter More Than Inputs

The AI interoperability conversation in 2026 is almost entirely about inputs — how agents connect to tools, how they authenticate, how they discover capabilities. MCP, A2A, ACP: all input protocols. They assume the software on the other end has something composable to offer once the connection is made.

MiroShark's twenty-four surfaces suggest the real leverage is on the output side. A simulation engine that only returns JSON on one endpoint is useful to one kind of consumer. A simulation engine that returns JSON, RSS, oEmbed, GraphML, SVG badges, filtered webhooks, MCP tool responses, IPFS-pinned archives, and embeddable iframes is useful to anyone who shows up — including consumers the developer never anticipated.

NIST's new standards initiative is grappling with exactly this asymmetry. The protocols for reaching software are converging. The question of whether software has enough surface area to be worth reaching — enough doors, in enough shapes, speaking enough protocols — is still wide open. Twenty-four is not a magic number. But it is evidence that the answer involves building more exits, not just wider entrances.

---
*Sources: [NIST AI Agent Standards Initiative (Feb 2026)](https://www.pillsburylaw.com/en/news-and-insights/nist-ai-agent-standards.html) · [Conectia: AI Agents, MCP, and the Interoperability Wall](https://conectia.pro/en/blog/ai-agents-mcp-interoperability-wall-2026) · [API Trends Shaping Modern Platform Architecture in 2026](https://tblocks.com/articles/api-trends/) · [MiroShark GitHub](https://github.com/aaronjmars/MiroShark) · [PR #120 — Webhook Event Filtering](https://github.com/aaronjmars/MiroShark/pull/120) · [PR #107 — oEmbed Provider](https://github.com/aaronjmars/MiroShark/pull/107)*
