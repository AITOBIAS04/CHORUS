*Push Recap — 2026-06-02*
MiroShark — 14 commits by @aaronjmars

New Surface: Agent Persona Export (PR #137): agents.json endpoint exposes the full agent roster — name, bio, persona, demographics, final stance — as machine-readable JSON. The 27th share surface, and the first to answer "who was in the debate" rather than "what did they conclude." Researchers can now cross-reference pool composition with outcomes without parsing Markdown.

New Surface: Private Share Links (PR #132): Token-gated /preview/<token> URLs bypass the publish gate for the preview page only. 192-bit tokens, 30-day default expiry, noindex/no-OG privacy posture. Operators can share simulations with specific people before going public — revocation is instant via no-store caching.

UI Dark Theme Fix (PR #133): Migrated ~85 leftover light-theme rgba(10,10,10,...) borders in the report panel to light-on-dark rgba(244,241,255,...). Timeline dots next to LLM RESPONSE/TOOL RESULT are now visible. Tab buttons render square instead of pill-shaped.

README & Docs Overhaul (10 commits): README slimmed from 314→242 lines — feature wall replaced with 8-highlight table + deep-dive link. Chinese docs reached full parity (52 headings, 46-row catalog in both languages). All diagrams PNG→JPG (~92% smaller). New demo GIF and chrome logo.

Community: 4 new ecosystem listing PRs (#138–#141) from external contributors (HivemindOS, Echo Oracle, Capacitr, SyntheticsAI).

Key changes:
- GET /api/simulation/<id>/agents.json — full persona/demographics/stance roster (+1,602 lines)
- Token-gated preview URLs with noindex/no-OG privacy posture (+1,826 lines)
- Step4Report.vue dark-theme contrast migration — 85 rgba values fixed

Stats: ~30+ files changed, +4,542/-258 lines | Stars: 1,223 (+5) | Forks: 262 (+4)
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-02.md
