*Push Recap — 2026-06-21*
MiroShark — 3 commits + miroshark-aeon — 2 commits (30 automation filtered)

i18n Locale Fix (#198): Non-English simulations were silently getting English role-play prompts in the fallback interview path. ThreadPoolExecutor drops ContextVar locale state, so zh-CN/de/fr sessions fell back to English. Fixed by capturing locale on the parent thread and restoring it inside each worker — same pattern as #194 for report_agent. All 4 locales now have the interview_single_agent_roleplay prompt key, with 107 lines of locale-propagation tests.

Agent Test Hardening (#196): The camel smoke test only checked response is not None, which would miss a dead agent returning structurally valid but empty responses. Now asserts response.msgs is non-empty and msgs[0].content is a non-empty string — silent-output failures fail loudly in CI.

CLAUDE.md for AI Agents (#197): 72-line agent-facing repo map covering architecture, layout, setup, CI gates, and 6 key conventions (openapi drift test, auth guard, MCP stdout, translation sync, Neo4j DI, feature flags). AI coding tools now have a structured entry point.

Premise Verification Gate (#69/#70): repo-actions can no longer ship feature ideas built on false code assumptions. After the feature skill caught a wrong premise on 06-20 (claimed smoke test asserts total_actions>0 — it actually asserts response is not None), self-improve added Gate 3: any idea claiming current file behavior must fetch+confirm against the live file. Unverifiable premises are dropped.

Key changes:
- graph_tools.py locale capture+restore pattern for ThreadPoolExecutor workers
- 5-gate pipeline for repo-actions: Filler → Novelty → Premise → Implementability → Score
- camel smoke test now guards silent-empty-output failure class

Stats: 14 files changed, +343/-16 lines across 5 substantive commits
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-21.md
