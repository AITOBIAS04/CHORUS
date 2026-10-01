*Push Recap — 2026-10-01*
MiroShark — 3 substantive commits by 2 authors
miroshark-aeon — 4 substantive commits by 2 authors (17 automation filtered)

Ecosystem Expansion: x402aff builder-code affiliation kit added to the ecosystem registry and catalog API — 14th ecosystem entry, first new tool-category addition since Crucible Sim. On-chain affiliate splits now discoverable via GET /api/ecosystem.json.

Backend Dependencies: sentence-transformers 5.3→5.6 (3 minor versions, ML embedding library for sim search), PyJWT 2.15.0, tornado 6.5.9, urllib3 2.8.0 — all lockfile-only.

Agent Configuration: LLM gateway switched from hard-pinned claude to auto mode via Bankr gateway — first multi-provider routing setup.

Agent Infrastructure: aeon-connect[bot] added .mcp.json with Base blockchain MCP server endpoint (mcp.base.org), establishing the first MCP config in the repo. Model briefly toggled Sonnet 5 → Opus 4.8 → Sonnet 5 (~70s round-trip).

Key changes:
- .mcp.json added — Base chain MCP connection (requires MCP_BASE_TOKEN secret)
- gateway.provider: claude → auto — multi-provider LLM routing enabled
- x402aff in ecosystem catalog — affiliate kit now API-discoverable

Stats: 7 files changed, +49/-40 lines across 7 substantive commits
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-10-01.md
