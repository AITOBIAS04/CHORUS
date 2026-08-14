# Push Recap — 2026-08-14

## Overview
3 substantive commits by 3 authors (9 automation commits filtered). Today's headline: a community contributor landed OrcaRouter as MiroShark's fourth cloud provider option, the operator patched a CI break caused by the openai 3.0 SDK migration, and the agent repo shipped its daily token analysis. A docs-heavy day with meaningful ecosystem expansion.

**Stats:** 12 files changed, +189/−9 lines across 3 substantive commits

---

## aaronjmars/MiroShark

### New Provider: OrcaRouter Cloud Gateway Integration
**Summary:** Marc-oss-hub contributed a comprehensive OrcaRouter preset (PR #287) — a full cloud provider setup path that lets operators cover every MiroShark slot (Default, Smart, NER, Wonderwall, embeddings) with a single OrcaRouter API key. The PR touches config, install guides, and model docs across both English and Chinese, making OrcaRouter MiroShark's fourth officially supported cloud provider alongside OpenRouter, OpenAI, and Anthropic.

**Commits:**
- `93161dd` — docs: add OrcaRouter cloud preset (#287)
  - Changed `.env.example`: Added 32-line OrcaRouter preset block with commented-out config for all slots — `sk-orca-` key format, namespaced model IDs (`openai/gpt-5.5`, `anthropic/claude-sonnet-5`, `google/gemini-3.5-flash`, `openai/gpt-4o-mini`), embeddings at `openai/text-embedding-3-large` with 768 dims (+32 lines)
  - Changed `docs/INSTALL.md`: New "Option A.4: OrcaRouter" section with full setup guide, verified model table, latency notes, embeddings URL caveat (no `/v1` suffix), prompt caching support; renumbered "Custom endpoint" to A.5 (+41/−3 lines)
  - Changed `docs/INSTALL.zh-CN.md`: Chinese translation of the OrcaRouter section with identical structure (+40/−3 lines)
  - Changed `docs/MODELS.md`: New "OrcaRouter preset" section with slot/model table, `cache_control` support note, latency warning about `reasoning: {enabled: false}` not applying on OrcaRouter base URLs (+15 lines)
  - Changed `docs/MODELS.zh-CN.md`: Chinese translation of the models section (+15 lines)
  - Changed `docs/CONFIGURATION.md`: Added OrcaRouter URL as alternative in `LLM_BASE_URL` comment (+1/−1)
  - Changed `docs/CONFIGURATION.zh-CN.md`: Same for Chinese config docs (+1/−1)
  - Also included a follow-up fix: softened the NER "no hidden CoT" claim — OrcaRouter doesn't inject `reasoning: {enabled: false}` like OpenRouter does, so `gemini-3.5-flash` may still emit reasoning tokens; `LLMClient` strips `<think>` blocks client-side

**Impact:** MiroShark now supports four cloud providers out of the box. OrcaRouter's value prop is vendor mixing — operators can route Anthropic models to the report slot and OpenAI to the high-volume sim loop with a single API key. This is the first merged community contribution in recent weeks, coming from a new fork contributor (Marc-oss-hub forked Aug 13).

---

### CI Fix: httpx Dependency for openai 3.0 SDK
**Summary:** openai 3.0.0 switched its transitive HTTP dependency from classic `httpx` to `httpx2`. Since `oracle_seed.py` imports `httpx` directly (not via the openai SDK), unit tests broke — `httpx` resolved to `None`, causing `resolve_oracle_tools()` to return an empty string and failing the markdown block assertion.

**Commits:**
- `6115fe8` — fix(ci): declare httpx explicitly so unit tests pass under openai 3.0 (#288)
  - Changed `.github/workflows/tests.yml`: Added `httpx>=0.28,<1.0` to the unit test pip install list (+2/−1 lines)
  - Changed `backend/requirements.txt`: Declared httpx as an explicit dependency with version pin and explanatory comment noting the openai 3.0 migration context (+3 lines)

**Impact:** CI is green again. The fix correctly pins httpx to the classic branch (`>=0.28,<1.0`) matching what `camel-ai/mcp` already pulls in for the full-deps job, preventing future breakage if httpx2 becomes the default across more packages.

---

## aaronjmars/miroshark-aeon

### Automated Token Analysis: CONSOLIDATING Verdict
**Summary:** The agent's token-movers skill produced its daily $MIROSHARK report, recording a CONSOLIDATING verdict — down 17.1% but volume at 1.98x average fell just short of the 2.0x BREAKDOWN threshold.

**Commits:**
- `5034c1e` — token-movers: single-token report for $MIROSHARK — 2026-08-14
  - New file `memory/logs/2026-08-14.md`: Log entry with CONSOLIDATING verdict, price $0.000002015, liquidity $222K, volume $7.2K, 6 buys / 17 sells, 1 whale trade (+10 lines)
  - New file `output/articles/token-report-2026-08-14.md`: Full token report article with 24h metrics table, trend analysis (7d: −20.4%, 30d: +4.6%), and narrative of the sharp sell-off at 01:33 UTC ($3.4K whale dump) (+29 lines)

**Impact:** Automated monitoring continues. The −17.1% drop broke the $0.0000025 floor for the second consecutive day, tracked alongside the 38-day social silence.

### Automation (9 commits filtered)
- 3× `chore(scheduler): update cron state` — routine scheduler state
- 2× `chore(cron): *` — cron success markers (token-movers, heartbeat)
- 2× `chore(*): auto-commit` — auto-committed output files
- 2× `chore(cron/fetch-tweets): *` — fetch-tweets cron success and auto-commit

---

## Developer Notes
- **New dependencies:** `httpx>=0.28,<1.0` added as explicit dep in MiroShark (was previously a transitive dep via openai SDK)
- **Breaking changes:** None — OrcaRouter is additive config, httpx fix is CI-only
- **Architecture shifts:** openai 3.0's switch to `httpx2` is a signal — any code importing `httpx` directly (not via the openai SDK) needs to declare it explicitly going forward
- **Tech debt:** None introduced

## What's Next
- OrcaRouter is now documented — community testing and feedback on edge cases (reasoning token handling, latency profiles) likely follows
- The openai 3.0 / httpx2 migration may surface in other places that import httpx directly — worth auditing
- $MIROSHARK price broke the $0.0000025 floor for the 2nd day; the token-movers verdict narrowly avoided BREAKDOWN (1.98x vs 2.0x threshold)
- GH_GLOBAL remains unset — 75th consecutive push block for the feature skill
