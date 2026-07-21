# Push Recap — 2026-07-21

## Overview
4 substantive commits by 1 author (14 automation commits filtered). Today's headline: a sweeping subtraction pass removed 1,325 net lines of dead code, legacy shims, and duplicated logic across 53 files in MiroShark — the project's largest single cleanup PR to date. Supporting work refined README badges and transitioned the agent's repo-pulse monitoring from daily to weekly cadence.

**Stats:** 63 files changed, +692/-2,009 lines across 4 substantive commits

---

## aaronjmars/MiroShark

### Codebase Subtraction: Dead Code, Legacy Paths, Duplication & Type Cleanup
**Summary:** PR #254 is a behavior-preserving cleanup sweep across four dimensions — dead code removal, legacy path deletion, duplication consolidation, and type annotation tightening. 53 files touched, net -1,325 lines. Verified against the full test suite (1,435 passed, frontend build, i18n scan, ruff lint all green).

**Commits:**
- `f77a671` — chore: remove dead code, legacy paths, duplication and weak types (#254)
  - Changed `backend/app/api/simulation.py`: Collapsed 23 identical publish-gate checks into a single `_load_public_summary` helper; removed unreferenced methods (+94, -325 lines — biggest single file reduction)
  - Changed `backend/app/services/simulation_runner.py`: Removed 101 lines of dead code — unreferenced methods and unused helpers
  - Changed `backend/app/services/platform_stats.py`: Removed 98 lines of duplicate logic, consolidated into shared utilities (+7, -105)
  - Changed `backend/app/services/project_stats.py`: Same pattern — 93 lines of duplicated stat-gathering code removed (+7, -100)
  - Changed `backend/app/services/telegram_notify.py`: Consolidated into `_notify_base.py` shared helper, removing 66 lines of duplicated notification logic (+7, -73)
  - Changed `backend/app/services/email_notify.py`: Same notify consolidation pattern (+6, -50)
  - Changed `backend/app/services/slack_notify.py`: Same notify consolidation (+7, -31)
  - Changed `backend/app/storage/neo4j_storage.py`: Removed `wait_for_processing` Zep shim and other dead storage methods (-63 lines)
  - Changed `backend/app/services/report_agent.py`: Removed 46 lines of unreferenced agent reporting code
  - Changed `backend/app/utils/event_logger.py`: Removed 45 lines of dead event logging utilities
  - Changed `backend/app/models/project.py`: Removed 38 lines of unused model methods
  - Changed `backend/app/services/lineage_service.py`: Consolidated duplicate logic (+3, -27)
  - Changed `backend/app/services/clone_service.py`: Consolidated duplicate logic (+3, -27)
  - Changed `backend/app/services/outcome_distribution.py`: Consolidated duplicate logic (+5, -26)
  - Changed `backend/app/services/platform_status.py`: Consolidated duplicate logic (+4, -27)
  - Changed `backend/app/storage/graph_storage.py`: Removed 24 lines of dead storage methods
  - Changed `backend/app/api/graph.py`: Removed unused `episode_uuids` return value and dead `wait_for_processing` call (+2, -5)
  - Changed `backend/app/services/text_processor.py`: Removed unused method (-15 lines)
  - Changed `backend/app/config.py`: Removed 3 env var config knobs that were read but never consumed, plus their `railway.env.example` entries (-17 lines config, -8 lines env example)
  - New file `backend/app/utils/sim_corpus.py`: Shared simulation corpus utilities extracted from duplicated logic across services (+140 lines)
  - New file `backend/app/utils/text.py`: Shared text utilities — `classify_stance()` with single `STANCE_THRESHOLD` replacing scattered inline copies (+24 lines)
  - New file `frontend/src/assets/app-shell.css`: Extracted duplicated style block from 3 Vue views into a shared CSS file (+169 lines)
  - Changed `frontend/src/views/InteractionView.vue`: Replaced inline styles with app-shell.css import (+2, -169)
  - Changed `frontend/src/views/ReportView.vue`: Same CSS extraction (+1, -171)
  - Changed `frontend/src/views/SimulationRunView.vue`: Same CSS extraction (+1, -171)
  - Changed `frontend/src/views/MainView.vue`: Removed pre-i18n `stepNames` array (+2, -3)
  - Changed `backend/app/api/share.py`: Tightened `set` → `set[str]` type annotation (+2, -2)
  - Changed `backend/app/storage/embedding_service.py`: Annotation tightenings (+12, -11)
  - Plus 8 more files with minor dead-code and type cleanups

**Impact:** This continues the subtraction trajectory from aeon v0.1.0 (which removed 73K lines). The codebase is now measurably easier to navigate: 23 redundant publish gates collapsed into one, four separate notification helpers unified, and scattered stance classification logic centralized. The railway.env.example no longer advertises dead config knobs as functional. Zero behavior change — purely structural improvement.

### README Badge Polish
**Summary:** Two quick PRs standardized the badge row across all four README language variants (EN, FR, JA, ZH-CN), tightening labels and adding documentation discoverability.

**Commits:**
- `66a2ebf` — docs: add Documentation badge to READMEs (#252)
  - Changed `.github/README.md`, `.github/README.fr.md`, `.github/README.ja.md`, `.github/README.zh-CN.md`: Added new "Documentation" badge linking to miroshark.xyz/docs across all 4 localized READMEs (+4 lines)

- `ca0e057` — docs: shorten Docs badge, drop Follow label, use $miroshark ticker (#253)
  - Changed `.github/README.md`, `.github/README.fr.md`, `.github/README.ja.md`, `.github/README.zh-CN.md`: Shortened "Documentation" → "Docs", removed "Follow" prefix from X badge (now just "@miroshark_"), changed "MiroShark on" → "$miroshark on" for the Bankr badge — tighter, more consistent badge row (+12, -12 lines)

**Impact:** The badge row now leads with documentation, uses the $miroshark ticker symbol consistently, and takes up less horizontal space. Small polish, but this is the first thing visitors see.

---

## aaronjmars/miroshark-aeon

### Repo-Pulse Skill: Daily → Weekly Transition
**Summary:** PR #116 restructured the agent's repo-pulse monitoring from a disabled every-other-day schedule to an active weekly cadence (Mondays 10:00 UTC), with all thresholds and baselines recomputed for the new window.

**Commits:**
- `693b841` — Enable repo-pulse on a weekly schedule (#116)
  - Changed `aeon.yml`: Flipped `enabled: false` → `true`, changed cron from `0 10 */2 * *` to `0 10 * * 1` (weekly Monday)
  - Changed `skills/repo-pulse/SKILL.md`: Comprehensive rewrite of timing and thresholds:
    - Lookback window: 24h → 7 days
    - Baseline: `avg7` (daily mean) → `avg4w` (4-week rolling weekly mean)
    - SURGE threshold: ≥10 stars/day → ≥50 stars/week (prevents every normal week from triggering SURGE)
    - Events API: added `--paginate` for 7-day windows that exceed single-page limits, with truncation detection
    - Fork fallback: `per_page=10` → `50` for wider weekly windows
    - Profile enrichment cap: 10 → 15 per repo, with enriched/total ratio reported when capped
    - Context step: reads 4 weeks of logs instead of 7 days, bucketing older daily entries correctly
  - (+24, -20 lines across 2 files)

**Impact:** Repo-pulse was previously disabled (running but producing no output on its off schedule). Now it actively reports weekly growth with properly calibrated thresholds — a 7-day star count compared against a weekly average instead of the previous apples-to-oranges daily comparison. The pagination fix prevents silent data truncation on busy weeks.

---

## Developer Notes
- **New dependencies:** None
- **Breaking changes:** None — PR #254 is behavior-preserving by construction; PR #116 only affects agent-internal skill configuration
- **Architecture shifts:** Four notification services (`telegram_notify`, `email_notify`, `slack_notify`, `discord_notify`) now share a `_notify_base.py` foundation. New shared utilities: `app/utils/sim_corpus.py` (simulation corpus ops), `app/utils/text.py` (stance classification), `frontend/src/assets/app-shell.css` (shared view styles). These are consolidation of existing code, not new abstractions.
- **Tech debt:** PR #254 commit message notes two deferred items: defensive-code cleanup (no Flask error boundary exists, so route-level catches remain) and circular-dep untangling (backend finding rated MEDIUM). Both explicitly skipped for now.

## What's Next
- The subtraction arc (73K in v0.1.0, now another 1,325 lines) suggests further cleanup passes are likely — the PR message mentions deferred circular-dep and defensive-code work
- Repo-pulse is now live on weekly cadence; first real weekly report expected Monday Jul 28
- GH_GLOBAL still unset (60th consecutive block) — 40+ features remain stuck as local commits
- Badge polish positions README for potential Show HN or social push (the social silence is now at 15 consecutive empty days)
