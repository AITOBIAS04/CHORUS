# Push Recap — 2026-06-21

## Overview
5 substantive commits by 2 authors (aaronjmars, aeonframework) across 2 repos, with 30 automation commits filtered. Today's work split across three fronts: hardening the internationalization pipeline so non-English simulations don't silently fall back to English prompts, strengthening the agent smoke test to catch a class of silent-failure regressions, and teaching the Aeon self-improvement system to verify its own assumptions before shipping feature ideas.

**Stats:** 14 files changed, +343/-16 lines across 5 substantive commits

---

## aaronjmars/MiroShark

### i18n: Locale Threading Through ThreadPoolExecutor
**Summary:** The fallback interview path in `graph_tools.py` runs each agent interview in a `ThreadPoolExecutor`. Python's `ContextVar`-based locale state doesn't propagate into pool workers, so non-English sessions silently fell back to English role-play prompts. This fix captures the active locale on the parent thread and re-applies it inside each worker — the same pattern used in PR #194 for `report_agent`. The hardcoded English prompt was also moved into the locale registry with full EN/ZH/DE/FR translations.

**Commits:**
- `165118d` — fix(i18n): thread locale through graph_tools fallback interview ThreadPoolExecutor (#198)
  - Changed `backend/app/services/graph_tools.py`: Captured `get_active_locale()` before submitting to the thread pool; wrapped `_interview_single_agent_llm` in a `_interview_with_locale` closure that calls `use_locale()` to restore context; replaced hardcoded English prompt with `get_prompt("graph_tools.interview_single_agent_roleplay", ...)` (+16, -7 lines)
  - Changed `backend/app/prompts/locales/en/graph_tools.py`: Added `interview_single_agent_roleplay` key with role-play prompt template (+10 lines)
  - Changed `backend/app/prompts/locales/zh_CN/graph_tools.py`: Chinese translation of the role-play prompt (+10 lines)
  - Changed `backend/app/prompts/locales/de/graph_tools.py`: German translation (+10 lines)
  - Changed `backend/app/prompts/locales/fr/graph_tools.py`: French translation (+10 lines)
  - New file `backend/tests/test_unit_graph_tools_locale.py`: 107-line test suite — verifies each locale resolves the prompt key, and critically, that `_fallback_interview` threads the locale into the pool worker so a zh-CN session gets Chinese prompts, not English (+107 lines)

**Impact:** Non-English simulations now get properly localized agent interview prompts. Without this fix, a Chinese or German user would see English role-play prompts in the fallback interview path even though they'd selected another language. Closes #195.

### Agent Testing: Silent-Output Regression Guard
**Summary:** The camel smoke test previously only asserted `response is not None`, which caught the #181 signature regression but would miss a subtler failure: a structurally valid response with empty messages or whitespace content. The simulation loop reads `response.msgs[0].content` as a healthy step, so a dead agent would look alive and ship zero-action runs.

**Commits:**
- `eee7d23` — test: assert camel smoke test produces real agent output (#196)
  - Changed `backend/tests/test_smoke_camel_agent.py`: Added two assertions after the existing None check — first that `response.msgs` is non-empty, then that `response.msgs[0].content` is a non-empty string. Both include descriptive failure messages explaining the silent-failure class they guard against (+21 lines)

**Impact:** Future camel-ai changes that break the agent loop in a quiet way (returning valid but empty responses) will now fail loudly in the camel-smoke CI job instead of shipping simulations with zero agent actions.

### Developer Experience: CLAUDE.md for AI Coding Agents
**Summary:** Added a comprehensive agent-facing repo map that distills the architecture, repo layout, setup/run/test commands, CI gates, and the conventions a change must respect into a single file that AI coding tools (Claude Code, Cursor, etc.) can ingest.

**Commits:**
- `177b503` — docs: add CLAUDE.md for AI coding agents (#197)
  - New file `CLAUDE.md`: 72-line agent guide covering what MiroShark is (5-phase pipeline), full repo layout (backend/frontend/docs/wonderwall), setup commands (`npm run setup:all`, `docker compose up -d neo4j`, `npm run dev`), test markers (`integration`, `slow`, `neo4j`), CI gates (3 jobs: backend unit, frontend build, camel smoke), and 6 conventions (contract-first endpoints with openapi drift test, fail-closed auth guard, MCP stdout reservation, translation sync, Neo4j singleton DI, feature flags default on) (+72 lines)

**Impact:** AI coding agents working on MiroShark now have a structured map of the repo's architecture and rules, reducing the chance of PRs that break CI or violate conventions like the auth guard or openapi drift test.

---

## aaronjmars/miroshark-aeon

### Self-Improvement: Premise Verification Gate for repo-actions
**Summary:** On 2026-06-20, the feature skill caught that a repo-actions idea (#5) had a wrong premise — it claimed the camel smoke test asserts `total_actions>0`, but the test actually asserts `response is not None`. This false premise would have propagated into the downstream feature build with wrong How-steps and wasted CI. These two commits add a new verification gate and a safety net for when verification itself fails.

**Commits:**
- `312e4a2` — fix(repo-actions): verify anchored-file premises before ideas ship (#69)
  - Changed `skills/repo-actions/SKILL.md`: Added Gate 3 (Premise verification) — any idea claiming a file's current contents/behavior must fetch and confirm the claim against the live file via `gh api contents` or graphql blob, with WebFetch fallback. Contradicted premises get corrected-and-re-anchored or dropped. Renumbered old gates 3→4, 4→5. Added `Dropped/corrected (false premise)` log line for observability (+12, -4 lines)
  - Changed `.outputs/self-improve.md`: Updated output summary to reflect the premise verification fix (+1, -1 lines)
  - New file `apps/dashboard/outputs/self-improve-2026-06-20T13-14-06Z.json`: Dashboard render spec for the self-improve skill output (+56 lines)
  - Changed `memory/logs/2026-06-20.md`: Appended self-improve log entry documenting the problem, fix, evidence, and PR link (+8 lines)
  - Changed `memory/skill-health/self-improve.json`: Updated quality score to 4, added history entry (+8, -4 lines)
  - Changed `memory/token-usage.csv`: Added self-improve token usage row (+1 line)

- `f38400e` — fix(repo-actions): drop/demote when a premise is unverifiable (#70)
  - Changed `skills/repo-actions/SKILL.md`: Added handling for the case where both `gh api` fetch and WebFetch fallback fail — an unverifiable premise is now treated exactly like a contradicted one (drop or demote to Monitor). Previously, Gate 3 didn't specify what to do on double fetch failure, so an unverifiable premise could slip through (+1 line)

**Impact:** The repo-actions skill can no longer ship feature ideas built on false assumptions about the codebase. This closes a feedback loop: the feature skill (downstream consumer) caught a bad premise, and the self-improve skill traced it back to a missing gate and patched the source. The gate sequence is now: Filler → Novelty → Premise Verification → Implementability → Score.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None
- **Architecture shifts:** The locale-threading pattern (capture ContextVar on parent, restore in worker) is now used in two places: `report_agent` (#194) and `graph_tools._fallback_interview` (#198). This is the canonical pattern for any future `ThreadPoolExecutor` usage with locale-dependent code.
- **Tech debt:** None introduced

## What's Next
- The i18n hardening work (#194, #198) suggests there may be other ThreadPoolExecutor paths that silently lose locale context — worth auditing
- The CLAUDE.md addition (#197) positions MiroShark for more AI-assisted contributions; combined with the CONTRIBUTING.md from Jun 14, the contributor onboarding surface is now comprehensive
- The premise verification gate (#69/#70) completes a self-correction loop: feature skill detected a bad premise → self-improve skill traced the root cause → patched the source skill. The 5-gate pipeline (Filler → Novelty → Premise → Implementability → Score) is now the most rigorous version yet
- GH_GLOBAL secret still not set — 44 consecutive feature blocks, 40+ features stuck as local commits
