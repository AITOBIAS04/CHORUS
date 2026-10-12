*Push Recap — 2026-10-12*
MiroShark — 1 commit | miroshark-aeon — 1 substantive + 26 automation filtered

Hosted MCP Server: The upstream sync lands a remote MCP server at aeon.fun/connect/mcp — OAuth 2.1 with PKCE and GitHub sign-in, ~20 tools for skill management, memory reading, and soul/strategy editing. Any MCP-compatible client (ChatGPT, Claude Desktop, Cursor) can now drive an Aeon agent remotely.

Biome Formatting: New biome.json config standardizes the entire apps/ directory — 120-char lines, consistent quotes, trailing commas. Accounts for most of the 8,300+ added lines. One-time formatting pass for long-term diff cleanliness.

Haiku 5.5 & Plugin Cleanup: Haiku tier upgraded from 4.5 to 5.5 across the stack. MiniMax and agent-plugins.org manifests dropped — plugin now ships Claude Code + Codex only.

Key changes:
- apps/mcp-server/src/skill-executor.ts: YAML parser for aeon.yml skill configs with comment stripping (+176/-57)
- apps/dashboard/lib/connect-detect.ts: MCP OAuth connection detection expanded (+159/-49)
- biome.json: New formatter config, linter disabled, scoped quote-style overrides
- ECOSYSTEM.md: Sparkleware URLs fixed to use www prefix

Stats: 156 files changed, +8,373/-3,591 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-10-12.md
