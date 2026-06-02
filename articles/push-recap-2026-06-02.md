# Push Recap — 2026-06-02

## Overview
14 commits by 1 author (Aaron Mars / @aaronjmars) landed on MiroShark's main branch. The day split into two clear pushes: a major README and documentation overhaul that slimmed the repo's public face while deepening its bilingual coverage, and two new share surfaces — a full agent persona export and privacy-first token-gated preview links. The miroshark-aeon automation repo logged 38 routine skill commits with 100% health.

**Stats:** ~30+ files changed, +4,542/-258 lines across 14 commits (plus 20+ image files added/removed/swapped)

---

## aaronjmars/MiroShark

### New Surface: Agent Persona Export (PR #137 — 27th Share Surface)
**Summary:** Every prior share endpoint describes what the swarm *concluded* or how belief *evolved*. None described *who was in the debate* in machine-readable form — agent identities were locked in transcript.md headings, requiring Markdown regex to extract. This PR adds `GET /api/simulation/<id>/agents.json`, exposing the full roster as a JSON array: name, username, bio, persona preview (280 chars), demographics (age/gender/MBTI/country/profession/interests), karma, final stance, final position, and rounds participated.

**Commits:**
- `3d9466c` — feat: agents.json surface — per-agent identity / persona export (#137)
  - New `backend/app/services/agent_export.py` (~340 LoC stdlib): roster assembly, profile lookup (reddit then polymarket), trajectory reuse via agent_sparklines_service, field normalization, persona/bio/scenario truncation, sort order (most-bullish-first by final_position)
  - Changed `backend/app/api/simulation.py`: route handler with publish gate, scenario-preview echo, `json.dumps(sort_keys=True)`, 1-hour cache, surface_stats increment (+94 lines)
  - Updated surface registry: `agents_json` key added to `surface_stats.SURFACE_KEYS`, `surfaces_catalog._CATALOG`, `_PER_SIM_TRACKED_KEYS`, and test drift guard
  - New `backend/tests/test_unit_agent_export.py`: 24 offline unit tests
  - Updated `backend/openapi.yaml`: `AgentsExportResponse` + `AgentExportEntry` schemas
  - Updated `frontend/src/api/simulation.js`: `getAgentsJsonUrl` + `getAgentsJson` helpers (mirrors sparklines pattern, 403/404 → null)
  - Updated `frontend/src/components/EmbedDialog.vue`: agent-roster section with capped 12-row preview and CSS
  - Updated `docs/API.md` and `docs/FEATURES.md`: endpoint row and full feature section

**Impact:** Researchers can now cross-reference agent persona composition with outcome quality without parsing Markdown. AntFleet's benchmark pipeline and any external consumer can answer "did the financial-analyst-heavy sim converge faster than the retail-trader one?" programmatically. This is the *participants* companion to `/agents/sparklines` (trajectories): sparklines answer *how belief moved*, agents.json answers *who was in the room*.

---

### New Surface: Private Share Links (PR #132 — Token-Gated Preview)
**Summary:** MiroShark's sharing was binary — a simulation was either public (visible on /explore and all REST surfaces) or private (invisible). This PR adds token-gated `/preview/<token>` URLs that bypass the `is_public` gate for the preview page only, enabling selective access for stakeholder previews, co-author review, and integrator debug shares without publishing.

**Commits:**
- `f077213` — feat: private share-link tokens for selective preview without publishing (#132)
  - New `backend/app/services/share_link_service.py` (~510 LoC stdlib): token lifecycle using `secrets.token_urlsafe(24)` (192-bit entropy), default 30-day expiry clamped to [1, 365], atomic JSON writes to `<sim_dir>/share-tokens/<token>.json`
  - New `backend/app/api/share.py` extension: `/preview/<token>` landing renderer with noindex/no-OG privacy posture — `<meta name="robots" content="noindex,nofollow">`, `X-Robots-Tag`, `Referrer-Policy: no-referrer`, no Open Graph/Twitter/Farcaster Frame/oEmbed tags, `Cache-Control: no-store`
  - Changed `backend/app/api/simulation.py`: 3 admin-gated endpoints (POST mint, GET list, DELETE revoke)
  - New `backend/tests/test_unit_share_link.py`: 18 unit tests (generate, resolve, revoke, list, expiry math, path traversal guard)
  - Updated `frontend/src/api/simulation.js`: `createShareLink`, `listShareLinks`, `revokeShareLink`, `getPreviewUrl` helpers
  - Updated `frontend/src/components/EmbedDialog.vue`: "Private share links" panel with expiry dropdown, mint/copy/revoke actions, active-tokens list with remaining-days countdown
  - Updated `docs/API.md`, `docs/FEATURES.md`, `backend/openapi.yaml`: endpoints + `ShareLinkRecord` schema

**Impact:** Operators can now share simulations with specific people before going public. Unknown/revoked/expired tokens all return the same 404 so probes can't distinguish states. The token grants the preview page only — signal.json, chart.svg, transcript.md and all other per-sim REST surfaces keep the `is_public` gate. This closes the gap between binary public/private and the recipient-scoped workflows operators actually use.

---

### UI Hardening: Dark Theme Contrast Migration (PR #133)
**Summary:** Two visual bugs fixed in a single PR. The global `button { border-radius: 9999px }` was leaking into list and tab buttons that never set their own radius, rendering them as stadium/oval rings. And the report right-panel had ~85 leftover light-theme `rgba(10,10,10,...)` borders/fills that sat invisible against the #110a26 dark background.

**Commits:**
- `c428a26` — fix(ui): square off tab/row buttons and raise report-panel contrast (#133)
  - Changed `frontend/src/components/DemographicBreakdown.vue`: `border-radius: 0` on `.demo-tab` (+4 lines)
  - Changed `frontend/src/components/PolymarketChart.vue`: `border-radius: 0` on `.pm-market-row` (+4 lines)
  - Changed `frontend/src/components/Step4Report.vue`: migrated ~85 dark-on-dark `rgba(10,10,10,...)` values to light-on-dark `rgba(244,241,255,...)`, brightened dim violet text (#5B21B6/#6D28D9/#7C3AED/#8B5CF6 → #a78bfa/#c4b5fd), added `border-radius: 0` on `.insight-tab` (+99/-96 lines)

**Impact:** The report panel — the most content-dense view in MiroShark — is now fully legible on dark backgrounds. Timeline dots next to LLM RESPONSE/TOOL RESULT entries are no longer invisible. Tab buttons render as flat rectangles matching the cards around them instead of pill-shaped outlines.

---

### README & Documentation Overhaul (10 commits)
**Summary:** A comprehensive documentation refresh touching the README, diagrams, demo media, Chinese translations, and feature catalog organization. The README went from a 314-line feature wall to a 242-line highlights page with a "40+ more →" deep-dive link, while the FEATURES docs gained full bilingual parity.

**Commits:**
- `b4fe46e` — docs: refresh README diagrams with regenerated images
  - Replaced 5 README diagram illustrations (simulate-anything hero, 5-phase pipeline, cross-platform dynamics, agent grounding layers, graph memory pipeline) with regenerated versions. New filenames bust GitHub's camo cache. (+5/-5, 5 images added, 5 removed)

- `c309deb` — docs: switch README logo to new chrome shark mark
  - Swapped `miroshark.jpg` → `miroshark-logo.jpg`. New filename busts camo cache. (+1/-1)

- `fa55ebb` — docs: fix overview image mapping and drop product screenshots
  - Used regenerated cross-platform diagram for Overview slot. Removed 6 product screenshots (1.jpg–6.jpg), renamed "Screenshots" to "Diagrams". (+3/-11, 6 images removed)

- `74246e8` — docs: slim README Features to highlights, move full list to docs
  - Replaced 46-row (EN) / 37-row (ZH) feature wall with 8-feature Highlights table + "40+ more →" link. Added "All features at a glance" index table to FEATURES.md and FEATURES.zh-CN.md. README dropped from 314 to 242 lines. (+110/-76 across 3 files)

- `a117e22` — docs(zh): full-sync FEATURES.zh-CN.md with English
  - Rebuilt Chinese deep-dive from 30 sections (37-row catalog) to match English's 51 sections (46-row catalog). Added 9 missing catalog rows and 21 missing deep-dive sections. Result: both docs at 52 headings, 46-row catalog, same order. EN 987 lines / ZH 986 lines. (+590/-39)

- `eb23a85` — docs: drop diagram2, distribute remaining diagrams contextually
  - Removed circular X/Reddit/Polymarket loop diagram. Dissolved grouped "Diagrams" table. Placed remaining 3 diagrams inline next to the text they illustrate. (+11/-14)

- `fb0f197` — docs(zh): fix broken NOTIFICATIONS.md links in catalog rows
  - Fixed `docs/docs/NOTIFICATIONS.md` double-prefix links to bare `NOTIFICATIONS.md`. (+3/-3)

- `290e430` — docs(zh): add Chinese translations for DEMOGRAPHICS and NOTIFICATIONS
  - New `docs/DEMOGRAPHICS.zh-CN.md` (79 lines) and `docs/NOTIFICATIONS.zh-CN.md` (188 lines). Added language switchers to English originals. Repointed FEATURES.zh-CN.md links. (+276/-5)

- `b196460` — docs: replace demo GIF with new capture
  - New filename `miroshark-demo.gif` busts camo cache. (+1/-1)

- `e98308d` — docs: swap Chinese section image for localized overview diagram
  - Used Chinese-localized overview diagram `miroshark-overview-cn.png`. (+1/-1)

- `d3455f5` — docs: swap README diagrams for optimized JPGs (#134)
  - Replaced 6 PNG diagrams with optimized JPG versions (~9.8 MB → ~836 KB, ~92% smaller). New `-v2` filenames bust camo cache. (+6/-6, 6 images added, 6 removed)

**Impact:** The README is now a focused landing page instead of a feature dump. All diagrams are contextually placed next to the text they explain rather than dumped in a gallery. Chinese documentation reached full parity with English for the first time (52 headings, 46-row catalog in both languages). Image payload dropped ~92% with the PNG → JPG conversion.

---

### Community Ecosystem PRs (4 open)
Four external contributors submitted ecosystem listing PRs within hours of each other:
- **#138** (LiamVisionary): Add HivemindOS to ecosystem
- **#139** (BuiltByEcho): List Echo Oracle in ecosystem
- **#140** (smehrjerdian): Add Capacitr to ecosystem
- **#141** (AISynthetics): Add SyntheticsAI to ecosystem

---

## aaronjmars/miroshark-aeon

38 automated commits by aeonframework. Skill runs today: token-report, repo-pulse, star-momentum-alert, feature (Multi-Metric Simulation Leaderboard — 30th skill built), self-improve, repo-actions, plus scheduler state updates. All skills passed — 100% health.

---

## Developer Notes
- **New dependencies:** None (both PRs are pure-stdlib)
- **Breaking changes:** None — agents.json and share-links are additive surfaces behind the existing publish gate
- **Architecture shifts:** Share links introduce a new per-sim `share-tokens/` directory with atomic JSON writes, following the same pattern as surface_stats. The privacy posture (noindex, no-OG, no-cache) is a new template distinct from the public landing page.
- **Tech debt:** None introduced. The 85-line rgba migration in Step4Report.vue cleaned up the last batch of light-theme holdovers from the original design.

## What's Next
- 4 community ecosystem PRs (#138–#141) awaiting review — if merged, they'd push the downstream project count well past 10
- The agents.json surface (27th) continues the pattern of one new surface every ~1-2 days
- GH_GLOBAL remains unset — 30 Aeon-built PRs are queued as local commits
- Chinese documentation is now at full parity; future feature additions should maintain both languages simultaneously
- Stars at 1,223 (+5 from yesterday), forks at 262 (+4)
