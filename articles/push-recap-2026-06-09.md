# Push Recap — 2026-06-09

## Overview
3 substantive commits by 2 authors (aaronjmars, aeonframework) across 2 repos. The main thrust of today's work: MiroShark shipped its 35th catalogued surface — a lightweight activity-feed polling endpoint — while the agent repo absorbed a self-improvement PR that encodes a week-old convention into the push-recap skill prompt. A quiet, focused day: one new feature, one operational hardening commit, zero drama.

**Stats:** 21 files changed, +2,205/-32 lines across 3 substantive commits (plus ~30 cron auto-commits excluded as noise on miroshark-aeon per the May-31 convention)

---

## aaronjmars/MiroShark

### New Surface: Simulation Activity Feed (`/api/activity.json`) — PR #153
**Summary:** A new `GET /api/activity.json` endpoint returns the N most recently completed public simulations in reverse-chronological order. It fills the gap between the full filterable gallery (`/api/simulation/public`), the RSS/Atom subscription feeds, and the liveness probe (`/api/status.json`) — none of which served the "poll every 30 seconds, render a recent-runs strip" use case that integrators (Aeon push-recap, Capacitr, AntFleet polling loops, status dashboards, social bots) actually need.

**Commits:**
- `97e39f8` — feat: add /api/activity.json — what-just-completed polling feed (#153)
  - New file `backend/app/api/activity.py`: Flask blueprint with one route (`GET /api/activity.json`). Public-keyless auth posture (added to `internal_auth_guard` allow-list alongside `/api/status.json` and `/api/simulation/batch-status`). 30-second `Cache-Control`. ETag derived from `count` + newest `completed_at` — `If-None-Match` short-circuits to 304 without re-serialising (+144 lines)
  - New file `backend/app/services/activity_feed.py`: Pure-stdlib service module (~440 lines). Scans sim dirs, applies publish gate (`is_public=true AND status=completed`), derives signal fields (direction, confidence_pct, quality_health) from the same `signal_service.compute_signal` pipeline as per-sim `signal.json`. Truncates scenario titles to 100 chars. Sorts by `completed_at` descending with deterministic tie-breaking on `sim_id`. `?limit=` clamped into [1, 50] — typos don't 400. Empty deployment returns `{count: 0, results: []}`, never 404s
  - New file `backend/tests/test_unit_activity_feed.py`: 28 tests covering 18 documented properties — empty/missing sim_root, publish gate, ordering, limit clamping, scenario truncation, signal pipeline derivation, total_rounds matching, degraded trajectories, timestamp fallback, corrupt folders, JSON serialisability, ETag, catalog entry, OpenAPI spec, blueprint registration, auth allow-list, cache header, If-None-Match handling (+694 lines)
  - Changed `backend/app/__init__.py`: Added `activity_bp` import + blueprint registration at `/api`. Added `/api/activity.json` to the `internal_auth_guard` exemption list with comment explaining the public-keyless design decision (+19, -1 lines)
  - Changed `backend/app/api/__init__.py`: Exported `activity_bp` with routing comment (+9 lines)
  - Changed `backend/app/services/surfaces_catalog.py`: Added `activity_feed` entry — key `activity_feed`, endpoint `/api/activity.json`, type `discovery`, PR 153. Catalog now at 35 entries (+9 lines)
  - Changed `backend/openapi.yaml`: Full spec for `/api/activity.json` path + `ActivityFeed` and `ActivityFeedEntry` component schemas. Detailed description covering the positioning relative to sibling surfaces, query params, auth posture, cache/ETag semantics, empty-deployment behaviour (+248 lines)
  - Changed `backend/tests/test_unit_openapi.py`: Added `activity_bp` → `/api` to `_BLUEPRINT_PREFIXES` map so the drift test sees the new route (+3 lines)
  - Changed `docs/API.md`: One-line entry documenting the endpoint in the API reference table (+1 line)
  - Changed `frontend/src/api/simulation.js`: `getActivityFeedUrl()` URL builder + `getActivityFeed()` async fetch helper. `credentials: 'omit'` + `cache: 'no-store'` for polling-loop use (+49 lines)

**Impact:** 35th catalogued surface. Gives integrators a single-request, keyless, fast-cache way to discover what just completed — the missing primitive between the gallery (heavy), the RSS feed (XML, human-oriented), and the status probe (no per-sim payload). Zero new dependencies (43-PR streak continues). The auth-posture decision was made up-front per the step-7 framework encoded in the feature skill prompt on June 6 (PR #53).

---

## aaronjmars/miroshark-aeon

### Agent Self-Improvement: Push-Recap Noise Filter — PR #55
**Summary:** The self-improve skill encoded a convention that had been re-derived from log precedent on every single push-recap run for 7 consecutive days (June 1–7) directly into the skill prompt as an explicit mechanical filter.

**Commits:**
- `4eb9efb` — improve: encode push-recap agent-repo noise-exclusion as step 5 (#55)
  - Changed `skills/push-recap/SKILL.md`: New step 5 inserted between dedup (step 4) and diff-reading (now step 6). Drops commits where author is `aeonframework` AND first message line matches `chore(scheduler):` / `chore(cron):` / `chore(<skill>): auto-commit`. Only applies to agent repos (name ending `-aeon`). Substantive `aeonframework` commits (interactive PR merges, manual fixes) survive the prefix match. Steps 5–10 renumbered to 6–11 (+21, -6 lines)
  - Changed `.outputs/self-improve.md`: Updated output artifact with the noise-exclusion improvement description (+8, -10 lines)
  - New file `dashboard/outputs/self-improve-2026-06-08T13-51-38Z.json`: json-render dashboard spec for the self-improvement notification (+106 lines)
  - Changed `memory/MEMORY.md`: Added Skills Built row and Lessons Learned row (+2 lines)
  - Changed `memory/logs/2026-06-08.md`: Detailed self-improve log entry documenting trigger (7 consecutive days of re-derivation), design alternatives considered and rejected, and impact assessment (+25 lines)
  - Changed `memory/token-usage.csv`: Token usage entry for the self-improve run (+1 line)

**Impact:** Saves ~5–10 minutes of analysis per daily push-recap run. The filter runs before the expensive per-commit `gh api` fan-out, so collapsed-to-zero days skip diff-reading entirely. Eliminates the risk of misclassifying a cron auto-commit as a substantive shipping event. This is the third self-improvement PR in the "encode each near-miss into the skill prompt" pattern (after PR #52 pre-existing-features registry and PR #53 auth-posture decision step).

### Feature Skill Output: Activity Feed Built
**Summary:** The feature skill ran today and built the activity feed feature (the same PR #153 that was merged on MiroShark). The auto-commit records the skill's output and logs.

**Commits:**
- `d604b57` — chore(feature): auto-commit 2026-06-09
  - Changed `.outputs/feature.md`: Updated feature output description from Signed Result (Jun 8) to Activity Feed (Jun 9) (+15, -12 lines)
  - New file `dashboard/outputs/feature-2026-06-09T11-42-03Z.json`: json-render dashboard spec for the feature notification (+389 lines)
  - Changed `memory/MEMORY.md`: Added Skills Built row for activity feed (+3, -1 lines)
  - Changed `memory/logs/2026-06-09.md`: Feature skill log entry (+19 lines)
  - Changed `memory/token-usage.csv`: Token usage entry (+1, -2 lines)

### Cron Auto-Commits (Filtered)
~30 commits by `aeonframework` excluded as noise per the May-31 convention. These cover scheduler state updates, per-skill success markers, and skill output payloads for token-report, repo-pulse, star-momentum-alert, star-milestone, feature, operator-scorecard, heartbeat, thread-formatter, repo-article, push-recap, and project-lens.

---

## Developer Notes
- **New dependencies:** None. 43-PR streak of zero new deps on MiroShark continues.
- **Breaking changes:** None. The activity feed is a net-new surface with no impact on existing endpoints.
- **Architecture shifts:** The activity feed follows the established pattern of pure-stdlib service module + Flask blueprint + OpenAPI spec + unit tests + catalog entry + docs. Auth posture (public-keyless) was decided up-front using the step-7 framework. The `signal_service.compute_signal` pipeline is now consumed by a fourth surface (alongside signal.json, batch-status, and the leaderboard).
- **Tech debt:** None introduced. The self-improve PR #55 reduced tech debt by eliminating a daily re-derivation cost.

## What's Next
- The activity feed is the 35th surface — the feature skill's candidate pool from the June 6 repo-actions run had Per-Round Confidence Trajectory (#2), Agent Mention Network (#3), Simulation Narrative Export (#4), and Operator Usage Analytics (#5) remaining. Per-Round Confidence Trajectory was skipped on June 8 (push preflight — GH_GLOBAL not set).
- GH_GLOBAL secret still not set — 34+ consecutive feature skill blocks. 34 built PRs remain unpushable as local commits.
- Stars at 1,243, forks at 263. Star momentum alert projects 1,500 stars ~Sep 7 at current v7=2.86/day pace.
- 9+ autonomous skills ran today: token-report, repo-pulse, star-momentum-alert, star-milestone, feature, and this push-recap. Operator-scorecard, heartbeat, thread-formatter, repo-article, and project-lens ran in the Jun 8 evening window.
