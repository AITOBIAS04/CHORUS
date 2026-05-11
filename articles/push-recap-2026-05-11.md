# Push Recap — 2026-05-11

## Overview

32 commits by 2 authors (aaronjmars, aeonframework) across 2 repos. The main story: MiroShark's distribution analytics became a discovery loop. PRs #77 and #78 merged back-to-back Sunday evening, wiring the surface-stats counters into the gallery's first trending sort — what readers pull from the platform now determines what the platform shows them. On the agent side, the memory index repair (PR #33) shipped, Aeon produced its weekly shiplog and project-lens article, and the token hit a new all-time high.

**Stats:** ~80 files changed, +1,800/-150 lines across 32 commits

---

## aaronjmars/MiroShark

### Surface-Stats Completion and the Trending Discovery Loop (PRs #77 + #78)

**Summary:** Two PRs merged 2 minutes apart closed a loop that's been building for a week. PR #77 backfilled the two newest share surfaces — `reproduce.json` and `/lineage` — into the surface-stats counter system, so every citation fetch and every lineage graph navigation now increments the same per-sim counter file the Distribution panel reads. PR #78 then consumed that counter total as the ranking signal for a new `?sort=trending` axis on `/explore`, making the gallery responsive to actual reader demand rather than just chronology.

**Commits:**

- `c6edeb6` — feat: track reproduce.json + lineage in surface-stats (#77)
  - Changed `backend/app/services/surface_stats.py`: Added `reproduce_json` and `lineage` to the frozen `SURFACE_KEYS` set, expanding from 9 to 11 tracked surfaces (+4, -4 lines)
  - Changed `backend/app/api/simulation.py`: Inserted `surface_stats.increment_surface_stat(sim_dir, "reproduce_json")` in the reproduce config handler and `surface_stats.increment_surface_stat(sim_dir, "lineage")` in the lineage handler — both fire on the success path after the response is built (+14, -5 lines)
  - Changed `backend/openapi.yaml`: Extended the `SurfaceStats` component schema with `reproduce_json` and `lineage` integer fields, added both to the `required` array (+13, -2 lines)
  - Changed `backend/tests/test_unit_surface_stats.py`: Extended the locked `SURFACE_KEYS` set assertion and the parametrized handler-increment test to cover the two new keys (+4 lines)
  - Changed `frontend/src/components/EmbedDialog.vue`: Added two rows to `SURFACE_STAT_LABELS` — "Reproduce config - JSON" and "Lineage graph" — so the Distribution panel renders them immediately (+2 lines)
  - Updated bilingual docs: `README.md`, `docs/API.md`, `docs/API.zh-CN.md`, `docs/FEATURES.md`, `docs/FEATURES.zh-CN.md` — all surface-stats descriptions now list 11 surfaces instead of 9

- `77bb1ed` — feat: trending sort — turn surface-stats into a discovery primitive (#78)
  - Changed `backend/app/services/gallery_filters.py`: Added `trending` to `SORT_VALUES` frozenset, introduced `TRENDING_FIELD = "_serves_total"` constant, and implemented `_trending_key()` sort function — highest cumulative serves first, ties broken on date so most-served-and-most-recent wins. Negative and non-integer values clamp to zero (+36, -3 lines)
  - Changed `backend/app/api/simulation.py`: Added a `sort_key == "trending"` branch in `list_public_simulations` that does a single sweep over `surface_stats.read_surface_stats()` for each public sim, injects `_serves_total`, then strips the transient field before serialization so the JSON contract stays untouched (+27 lines)
  - Changed `backend/tests/test_unit_gallery_filters.py`: Added 8 new tests in `TestTrendingSort` class — trending key recognition, field name pin, descending sort by serves, date tie-break, missing field degrades to zero, garbage values clamp, end-to-end filter+sort composition, all-zero corpus graceful handling (+115, -1 lines)
  - Changed `frontend/src/views/ExploreView.vue`: Added "Trending" option to sort dropdown with fire emoji, extended `ALLOWED_SORT` set (+2, -1 lines)
  - Changed `frontend/src/api/simulation.js`: Extended JSDoc sort enum to include `trending` with semantics documentation (+9, -1 lines)
  - Changed `backend/openapi.yaml`: Extended sort query param enum and response enum to include `trending` (+8, -4 lines)
  - Updated bilingual docs: `README.md`, `docs/API.md`, `docs/API.zh-CN.md`, `docs/FEATURES.md`, `docs/FEATURES.zh-CN.md` — all gallery filter descriptions now include trending sort semantics

**Impact:** The `/explore` gallery is no longer purely recency-sorted. The trending axis creates MiroShark's first distribution-to-discovery feedback loop — simulations that get shared (via any of the 11 surfaces) accumulate serve counts, and those counts now push them higher in the gallery. This means a viral sim posted on X or embedded in a blog will organically surface for new visitors without any manual curation. Combined with PR #77's backfill, even citation-style usage (fetching reproduce.json to cite a sim in a paper) contributes to discoverability.

---

## aaronjmars/miroshark-aeon

### Memory Index Repair (PR #33)

**Summary:** The self-improve skill detected that `memory/MEMORY.md` had ballooned to 81 KB / 33K+ tokens, exceeding the Read tool's 25K-token cap and breaking every skill's context-loading step. PR #33 re-applied the fix from closed PR #32 against current main.

**Commits:**

- `9e3f55b` — improve(memory): cap MEMORY.md row sizes so the index stays readable (re-apply #32) (#33)
  - Changed `skills/memory-flush/SKILL.md`: Added step 5 enforcing per-row character caps on every flush — Skills Built <=280 chars, Recent Articles <=220 chars, Recent Digests <=180 chars — with a post-flush `wc -c` sanity check (target <25 KB)
  - Changed `memory/MEMORY.md`: Condensed every row to a one-sentence summary plus PR number. File shrank from 81 KB to ~7.7 KB (-90%). All detailed context preserved in daily logs and article files
  - Changed `.outputs/self-improve.md`: Updated skill output summary

**Impact:** Restores the memory system. Every skill that reads MEMORY.md at task start (which is all of them, per project rules) can now load context without hitting the token cap. The per-row caps in memory-flush prevent re-bloating on future Sunday/Wednesday consolidation runs.

### Weekly Shiplog and Project Lens

**Summary:** Two content-generation skills produced their scheduled outputs — a weekly review article and an ecosystem-mapping article positioning MiroShark in the AI forecasting stack.

**Commits:**

- `3521fba` — weekly-shiplog: 2026-05-11 — From Many Surfaces to a Surface Network
  - New file `articles/weekly-shiplog-2026-05-11.md`: 1,875-word review covering May 4-10. Frames the week's 8 MiroShark PRs (#71-#78) as a transition from isolated share surfaces to a self-reinforcing observability-distribution-discovery loop. Stats: +9,112/-48 across 86 files, 17-PR zero-new-deps streak, 1,130 stars (+62 lines)

- `0880de2` — project-lens: ecosystem-map angle (#8) — four-neighborhood AI forecasting stack
  - New file `articles/project-lens-2026-05-11.md`: Maps prediction markets (Polymarket, Kalshi), forecasting platforms (Metaculus), multi-agent frameworks (LangGraph/AutoGen/CrewAI), and reproducibility infra (Papers with Code, DOI) as four neighborhoods. Positions MiroShark in the gap as "simulation substrate" layer where the moat is the surface network, not the simulator (+48 lines)

### Daily Operations — Token Report, Tweets, Feature Build

**Summary:** Standard daily automation: token report captured a new ATH session, fetch-tweets found 2 new tweets, and the feature skill built an A/B Comparison View (push blocked).

**Commits:**

- `b6f4ff6` — chore(token-report): MIROSHARK daily report 2026-05-11 — new ATH
  - New file `articles/token-report-2026-05-11.md`: Price $0.000007282 (+16.53% 24h). New intraday ATH at $0.000007517, surpassing May 6 ATH of $0.000006926. LP at record $370.7K. Buy ratio 1.42 — strongest in 4 days. 7d +118.7%, 30d +282.6% (+49 lines)

- `a64b382` — feat(fetch-tweets): 2 new tweets for $MIROSHARK 2026-05-11
  - Changed `memory/fetch-tweets-seen.txt`: Added 2 URLs — @aaronjmars Costco-vs-BLS protein price sim, @btcbabycow Chinese-language framing of MiroShark as "evolved AI prediction market"
  - Changed `memory/logs/2026-05-11.md`: Logged 2 new tweets with engagement data

- Feature skill (auto-commit `759a7e6`) — Built Simulation A/B Comparison View on local branch `feat/ab-comparison-view`. Enhanced `/compare` endpoint with scorecard diff, dual SVG belief-drift charts, and gallery compare mode with checkbox selection. 8 files, +1,051/-25 lines. Push blocked — GH_GLOBAL secret not set (12th consecutive block)

### Automation Overhead (25 chore commits)

Scheduler state updates, cron success markers, auto-commit wrappers, and dashboard JSON outputs. These are the operational bookkeeping that keeps the CI pipeline's state consistent between runs.

---

## Developer Notes

- **New dependencies:** None — the zero-new-deps streak continues
- **Breaking changes:** None. The trending sort is additive — `sort=date` remains the default, existing API consumers see no change
- **Architecture shifts:** The surface-stats system is now a dual-purpose primitive: both an observability tool (Distribution panel) and a ranking signal (trending sort). This creates a dependency where gallery ordering depends on counter file integrity
- **Tech debt:** GH_GLOBAL secret still unset — 12 features built locally but unable to push PRs to MiroShark (Pre-Run Cost Estimator through Simulation A/B Comparison View). Feature skill generates ~1K LoC per day that accumulates as dead local branches

## What's Next

- **GH_GLOBAL secret** remains the single biggest blocker — 12 features waiting to ship as PRs
- **MiroShark open items:** Issue #70 (Private Impact mode + MiroResult collaboration, filed May 4) still untriaged
- **Token trajectory:** ATH breakout confirmed; next resistance level is $0.00001 (33% above current). Volume and buy ratio support continuation
- **Repo-actions backlog:** May 10 batch has 5 unbuilt ideas (Simulation Fork from Round, Agent Persona Library, Narrative Evolution Tracker, Gallery Creator Profiles). With trending sort now live, ideas that feed the distribution loop (oEmbed, operator profiles) move up the queue
- **Stars:** 1,130 — next milestone target is 1,500
