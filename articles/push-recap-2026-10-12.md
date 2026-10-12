# Push Recap — 2026-10-12

## Overview
2 substantive commits by 2 authors across both watched repos (26 automation commits filtered). The day's centerpiece is a massive upstream sync that lands a hosted MCP server, adopts Biome formatting, upgrades the Haiku model tier, and cleans up legacy plugin manifests. MiroShark itself got a small ecosystem link fix.

**Stats:** 156 files changed, +8,373/-3,591 lines across 2 substantive commits

---

## aaronjmars/MiroShark

### Ecosystem Link Fix
**Summary:** A one-line documentation fix correcting Sparkleware URLs in the ecosystem directory to use the `www.` prefix, ensuring the links actually resolve.

**Commits:**
- `e1f61f2` — docs(ecosystem): point Sparkleware links at www host (#328)
  - Changed `ECOSYSTEM.md`: Updated 3 Sparkleware URLs from `sparkleware.fun` to `www.sparkleware.fun` — logo image source, kits page link, and main site link (+1, -1 lines)

**Impact:** Ecosystem directory links for the Sparkleware integration now resolve correctly. Without the `www.` prefix, visitors were likely hitting DNS resolution failures or redirect issues.

---

## aaronjmars/miroshark-aeon

### Hosted MCP Server
**Summary:** The headline feature in this upstream sync. Aeon Connect now serves a remote MCP server at `aeon.fun/connect/mcp` using Streamable HTTP with OAuth 2.1 (dynamic client registration + PKCE + GitHub sign-in). About 20 tools let external clients list and run skills, read runs/output/memory, edit skills/strategy/soul, show setup status, and install packs — all without exposing secret values.

**Commits:**
- `f64b3f0` — aeon-update: sync upstream 1a7f07e..df013db (#204)
  - Changed `CHANGELOG.md`: Added hosted MCP server documentation — OAuth 2.1 flow, tool inventory, consent screen, `switch_instance` for multi-repo, integration commands for Claude Code/ChatGPT/Cursor (+27 lines)
  - Changed `apps/mcp-server/src/skill-executor.ts`: Major overhaul (+176, -57 lines) — new `skillConfigLine()` function parses aeon.yml entries (both single-line and block YAML shapes), `stripComment()` handles `#` comments outside double-quoted strings, `loadSkills()` now enriches catalog entries with their actual schedule from aeon.yml
  - Changed `apps/mcp-server/src/index.ts`: Refactored server setup (+20, -25 lines)
  - Changed `apps/mcp-server/README.md`: Updated with hosted MCP server docs (+33, -5 lines)
  - Changed `apps/dashboard/lib/connect-detect.ts`: Expanded connection detection logic (+159, -49 lines) for MCP OAuth flows
  - Changed `apps/dashboard/lib/connect-detect.test.ts`: Comprehensive test coverage for new detection paths (+374, -242 lines)
  - Changed `apps/dashboard/lib/mcp-oauth.ts`: Enhanced OAuth flow handling (+45, -20 lines)
  - Changed `apps/dashboard/lib/mcp-oauth.test.ts`: Updated test suite (+110, -101 lines)
  - Changed `apps/dashboard/app/api/mcp-auth/route.ts`: Extended MCP auth API (+41, -10 lines)
  - Changed `apps/dashboard/components/McpPanel.tsx`: UI for MCP server management (+210, -46 lines)
  - Changed `apps/dashboard/components/ConnectModal.tsx`: Connect flow UI expanded (+274, -66 lines)
  - Changed `bin/add-mcp`: Safety warning before `claude mcp remove aeon` would delete a hosted entry (+30, -5 lines)

**Impact:** Any MCP-compatible client (ChatGPT, Claude Desktop, Cursor) can now drive an Aeon agent remotely. This is the "API surface" for Aeon — it means agents are controllable from any editor or chat interface that speaks MCP, without needing the dashboard open.

### Biome Code Formatting
**Summary:** A new `biome.json` config is added and applied across the entire `apps/` directory. This accounts for the majority of the diff's line count — standardizing formatting to 120-char lines, single quotes (double in mcp-server/webhook/tests), trailing commas, and minimal arrow parens.

**Commits:**
- `f64b3f0` (continued)
  - New file `biome.json`: Biome 2.5.15 formatter config — space indent, 120-char width, single quotes (double for mcp-server/webhook/tests), trailing commas, minimal arrow parens, linter disabled (+32 lines)
  - Changed `apps/dashboard/app/page.tsx`: Expanded from dense one-liners to formatted multi-line blocks (+737, -106 lines) — the actual logic is largely unchanged, this is formatting normalization
  - Changed `apps/dashboard/lib/secrets-catalog.ts`: Reformatted from single-line object literals to multi-line (+244, -44 lines) — same data, readable formatting
  - Changed `apps/cli/src/commands/init.ts`: Reformatted imports, interfaces, and control flow (+539, -138 lines)
  - Changed ~60 additional `apps/` files: Formatting-only changes (quote style, semicolons, line breaks, import grouping)

**Impact:** The codebase now has a consistent formatter enforced by Biome. This is the kind of commit that makes every future diff cleaner — one-time pain for long-term readability. No behavioral changes in any of the reformatted code.

### Haiku 5.5 Model Upgrade
**Summary:** The Haiku model tier is upgraded from Claude Haiku 4.5 to Haiku 5.5 across the stack.

**Commits:**
- `f64b3f0` (continued)
  - Changed `apps/dashboard/lib/constants.ts`: Model picker updated to `claude-haiku-5-5`, Haiku 4.5 retained as legacy option (+38, -18 lines)
  - Changed `apps/dashboard/lib/constants.test.ts`: Test updates for new model IDs (+37, -8 lines)
  - Changed `scripts/fleet-scorecard.mjs`: Haiku 5.5 priced at $0.10 in / $0.50 out per 1M tokens (+2, -1 lines)
  - Changed `scripts/notify-jsonrender.sh`: Updated model reference (+1, -1 lines)

**Impact:** All new skill runs on the Haiku tier now use Claude Haiku 5.5 by default. The older Haiku 4.5 remains selectable for backwards compatibility.

### Plugin Cleanup
**Summary:** The plugin drops support for MiniMax and the agent-plugins.org (Kiro Powers) format. It now ships for Claude Code and Codex only.

**Commits:**
- `f64b3f0` (continued)
  - Removed `plugin/.minimax-plugin/plugin.json`: Entire MiniMax manifest deleted (-19 lines)
  - Removed `plugin/plugin.json`: agent-plugins.org format manifest deleted (-15 lines)
  - Changed `plugin/.claude-plugin/plugin.json`: Added `displayName`, author email, `icon`, and directory listing links (+10, -3 lines)
  - Changed `plugin/.codex-plugin/plugin.json`: Updated metadata (+10, -5 lines)

**Impact:** Simplifies the plugin surface — two fewer manifest formats to maintain. The Claude Code and Codex manifests now have proper directory listing metadata (display name, icon, links to docs/support/privacy/terms).

### Dashboard & CLI Refinements
**Summary:** Beyond formatting, several functional improvements landed in the dashboard and CLI.

**Commits:**
- `f64b3f0` (continued)
  - Changed `apps/dashboard/lib/types.ts`: New type definitions for MCP tools, connect flow, and skill metadata (+83, -14 lines)
  - Changed `apps/dashboard/lib/utils.ts`: New utility functions (+87, -19 lines)
  - Changed `apps/dashboard/lib/run-diagnosis.ts`: Enhanced run diagnosis logic (+94, -31 lines)
  - Changed `apps/dashboard/lib/run-diagnosis.test.ts`: Test coverage for diagnosis improvements (+223, -162 lines)
  - Changed `apps/dashboard/lib/security/api-gate.ts`: Refactored API security gate (+72, -80 lines)
  - Changed `apps/dashboard/lib/github-auth.ts`: Auth flow improvements (+20, -9 lines)
  - Changed `apps/dashboard/components/SecretsPanel.tsx`: Expanded secrets UI (+234, -67 lines)
  - Changed `apps/dashboard/components/SkillDetail.tsx`: Skill detail view improvements (+247, -69 lines)
  - Changed `apps/dashboard/components/SpecNode.tsx`: Spec visualization expanded (+199, -19 lines)
  - Changed `apps/dashboard/components/RightPanel.tsx`: Right panel layout refined (+200, -61 lines)
  - Changed `apps/dashboard/components/LeftSidebar.tsx`: Sidebar navigation updated (+174, -50 lines)
  - Changed `apps/dashboard/components/PacksPanel.tsx`: Packs UI improvements (+138, -33 lines)
  - Changed `apps/dashboard/components/SoulPanel.tsx`: Soul editing UI enhanced (+114, -46 lines)
  - Changed `apps/dashboard/components/ScheduleEditor.tsx`: Schedule editing improved (+92, -18 lines)
  - Changed `apps/dashboard/components/InstantModeCard.tsx`: Instant mode UI updates (+113, -47 lines)
  - Changed `apps/dashboard/components/TelegramLinkCard.tsx`: Telegram link flow updated (+111, -25 lines)
  - Changed `apps/dashboard/components/ImportModal.tsx`: Import flow enhanced (+105, -13 lines)
  - Changed `apps/dashboard/lib/telegram-link.ts`: Telegram link logic improved (+21, -6 lines)

**Impact:** The dashboard is significantly more polished — skill detail views, secrets management, and the connect/import flows all received functional and visual improvements alongside the Biome formatting pass.

---

## Developer Notes
- **New dependencies:** Biome 2.5.15 (formatter only — linter and assist disabled)
- **Breaking changes:** MiniMax and agent-plugins.org plugin manifests removed; plugin now Claude Code + Codex only
- **Architecture shifts:** Skill schedule now read from aeon.yml at runtime (not hardcoded in catalog); MCP skill executor parses YAML entries directly with comment stripping
- **Tech debt:** 22 files from the upstream sync flagged as needing manual review (per the PR description)

## What's Next
- The 22 files flagged for manual review in the aeon-update sync likely need attention before the next sync
- MCP server is live upstream — downstream forks (including miroshark-aeon) can now be driven remotely from any MCP client
- Self-improve PR #71 (fetch-tweets modulo fix) just opened today — should merge within the next cycle
- GH_GLOBAL secret still unset — continues to block 40+ built PRs and all new feature work
