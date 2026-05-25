# Push Recap — 2026-05-25

## Overview
5 significant commits across 2 repos by 2 authors, plus ~47 automated cron commits. Today's main thrust: two new distribution surfaces landed on MiroShark — oEmbed auto-unfurl for writing platforms and a platform-level stats API with a Shields.io badge — while the Aeon skill cycle ran a full Sunday suite including a RELEASE WEEK ai-framework-watch and a feature build that produced the oEmbed PR.

**Stats:** ~30 files changed, +3,180/-12 lines across 3 MiroShark commits; ~47 cron commits on miroshark-aeon

---

## aaronjmars/MiroShark

### New Feature: oEmbed Auto-Unfurl for Writing Platforms (PR #107)
**Summary:** MiroShark share links now auto-unfurl into rich preview cards on Notion, Ghost, Substack, and WordPress — the platforms where researchers and analysts actually publish. Before this, a pasted `/share/<id>` link rendered as a bare URL on every writing platform despite existing Open Graph tags (which only social platforms read). The 21st share-surface key.

**Commits:**
- `6cde359` — feat: oEmbed provider — auto-unfurl share links on Notion / Ghost / Substack / WordPress (#107)
  - New file `backend/app/services/oembed_service.py` (+207 lines): Pure-stdlib core — URL-to-sim_id parsing with host allow-listing via regex matching `/share/`, `/embed/`, `/simulation/` paths; oEmbed 1.0 `rich`-type payload builder; JSON and XML serialization via `xml.etree.ElementTree`
  - Changed `backend/app/api/share.py` (+181 lines): Root-mounted `GET /oembed` route (publish-gated, domain-validated, json/xml with 501 on unsupported formats); `application/json+oembed` + `text/xml+oembed` discovery `<link>` tags injected into share-page `<head>` for published sims only; `_resolve_oembed_base_url()` and `_oembed_allowed_hosts()` helpers for reverse-proxy support
  - Changed `backend/app/services/surface_stats.py` (+3/-1): Registered `oembed` counter as the 21st surface key
  - New file `backend/tests/test_unit_oembed.py` (+220 lines): 18 offline tests covering URL parsing, host rejection, payload shape, XML round-trip, route wiring, surface-stat registration, OpenAPI drift
  - Changed `backend/openapi.yaml` (+98 lines): `/oembed` path + `OEmbedResponse` schema under Publish & Embed tag
  - Changed `frontend/src/api/simulation.js` (+25 lines): `getOEmbedUrl` helper builds the absolute oEmbed provider URL
  - Changed `docs/API.md` (+18/-1): Endpoint table row + curl examples section
  - Changed `docs/FEATURES.md` (+12 lines): oEmbed Auto-Unfurl feature section
  - Changed `backend/tests/test_unit_surface_stats.py` (+1): Expected set updated

**Impact:** Every organic citation of a MiroShark simulation in a research note, blog post, or Notion doc becomes a rich preview card with no user action. oEmbed adds a *protocol*, not a renderer — the thumbnail points at the existing share-card PNG and the iframe at the existing `/embed/<id>` route. Zero new dependencies. Host allow-listing ensures the endpoint can't be aimed at another site.

### New Feature: Platform Aggregate Stats API + Shields.io Badge (PR #105)
**Summary:** The first endpoints that describe MiroShark as a platform rather than individual simulations. `GET /api/stats` returns one envelope across every public, completed sim — total count, consensus distribution, average confidence, total surface views, unique projects, newest sim metadata. `GET /api/stats/badge.svg` renders a Shields.io pill for any README.

**Commits:**
- `a3fcbda` — feat: platform aggregate stats API + Shields.io platform badge SVG (#105)
  - New file `backend/app/services/platform_stats.py` (+444 lines): One O(n) scan over `WONDERWALL_SIMULATION_DATA_DIR` with 60-second module-level cache. Stance derivation reuses `signal_service.compute_signal` so platform counts match per-sim signal.json byte-for-byte. `stats_etag()` helper for ETag/304 handling. Thread-safe cache with `_cache_lock`
  - New file `backend/app/api/stats.py` (+140 lines): `stats_bp` blueprint at `/api/stats`. JSON route emits ETag, short-circuits `If-None-Match` to 304. Badge route always returns 200 (zero-sim deployment renders valid pill)
  - Changed `backend/app/services/badge_service.py` (+146 lines): `build_platform_badge_svg()` + `render_platform_badge_svg_bytes()` siblings. Platform-blue `#0ea5e9` distinct from the three stance colours. Same flat 20px Shields.io geometry
  - New file `backend/tests/test_unit_platform_stats.py` (+577 lines): 27 tests covering empty/mixed/unpublished/incomplete fixtures, cache TTL, ETag derivation, badge well-formedness, OpenAPI drift
  - Changed `backend/openapi.yaml` (+256 lines): `Platform` tag, both endpoints documented, `PlatformStats` component schema
  - Changed `backend/app/__init__.py` (+6/-1): `stats_bp` import and registration
  - Changed `backend/app/api/__init__.py` (+5 lines): `stats_bp` export
  - Changed `backend/tests/test_unit_openapi.py` (+3 lines): `stats_bp` in blueprint→prefix table
  - Changed `docs/API.md` (+2 lines): Endpoint table rows
  - Changed `docs/FEATURES.md` (+44 lines): Platform Aggregate Statistics + Platform Stats Badge SVG feature sections

**Impact:** Press kits, external dashboards, LLM-agent health checks ("is this MiroShark instance active?"), and any community README can now render a live platform-activity indicator. The per-sim badge is a pull point for specific simulations; the platform badge is a pull point for MiroShark itself. Zero new dependencies — continues the 32-PR zero-new-deps streak.

### Maintenance: .gitignore Wildcard Cleanup (PR #104)
**Summary:** Community contribution that collapses the explicit `.env` profile list into a single `.env.*` wildcard with `!.env.example` exception.

**Commits:**
- `87f1ef2` — gitignore: collapse explicit .env profile list into .env.* wildcard (#104) — by Void Freud
  - Changed `.gitignore` (+2/-5): Replaced 5 explicit `.env.local` / `.env.*.local` / `.env.development` / `.env.test` / `.env.production` lines with `.env.*` + `!.env.example`. One wildcard absorbs any future profile without growing the explicit list

**Impact:** Cleaner gitignore that doesn't need updating when new env profiles are added (`.env.aura`, `.env.staging`, etc.). Verified only `.env.example` is tracked under `.env*`.

---

## aaronjmars/miroshark-aeon

### Feature Build: oEmbed Provider
**Summary:** The daily feature skill picked oEmbed from the May-24 repo-actions batch (idea #1, re-eligible from May 16) and autonomously built the full implementation — PR #107 on MiroShark.

**Commits:**
- `e940b00` — chore(feature): auto-commit 2026-05-25
  - Updated `.outputs/feature.md` with oEmbed build summary
  - New dashboard spec `dashboard/outputs/feature-2026-05-25T11-28-08Z.json` (+148 lines)
  - Updated `memory/MEMORY.md`: added oEmbed Provider to Skills Built, updated Next Priorities and open PR tracking
  - Appended feature log to `memory/logs/2026-05-25.md`

### Reliability: bankr-prefetch EXIT Trap (PR #45)
**Summary:** Added a defensive crash sidecar to `scripts/prefetch-bankr.sh` so tweet-allocator can distinguish "script never ran" (file truly absent) from "script crashed mid-run" (file present with exit code). Triggered by a 2026-05-24 `TWEET_ALLOCATOR_ERROR` drift where `prefetch-status.json` was missing and the cause was unrecoverable from logs.

**Commits:**
- `c4e0c49` — improve(bankr-prefetch): EXIT trap stamps 'crashed' status so tweet-allocator can diagnose silent prefetch failures (#45)
  - Changed `scripts/prefetch-bankr.sh` (+25 lines): EXIT trap checks `$? != 0` and status file absent, writes `{status:"crashed", exit_code, timestamp}` via jq
  - Changed `skills/tweet-allocator/SKILL.md` (+3/-2): New `"crashed"` status branch in the prefetch-status.json decision tree; updated TWEET_ALLOCATOR_ERROR doc to include crash case

### Daily Skill Cycle (Automated)
**Summary:** Full Sunday skill suite completed. ~45 cron bookkeeping commits covering all scheduled skills.

**Key outputs:**
- **repo-pulse:** MiroShark 1,195 stars (+1), 248 forks (+1). New stargazer: irisBuild25. New fork: gosunny2050/MiroShark
- **ai-framework-watch:** RELEASE WEEK — 4 frameworks shipped (langgraph 1.2.1, crewai 1.14.5+1.14.6a1, mastra @core/1.35.0, pydantic-ai v2.0.0b1/b2/b3 + v1.102.0). Pydantic AI launched its V2 beta in three rapid iterations while maintaining the v1 stable track. Aeon +76 stars (+20.8%) leads the cohort by percentage growth despite smallest absolute delta. Article: `articles/ai-framework-watch-2026-05-25.md`
- **weekly-shiplog:** Week-in-review article. Article: `articles/weekly-shiplog-2026-05-25.md`
- **operator-scorecard:** Dashboard spec + article written. Article: `articles/operator-scorecard-2026-05-25.md`
- **project-lens:** Contrarian take on dependency-discipline streaks — "The Real Test of Dependency Discipline Is the PR That Breaks the Streak." Uses MiroShark PR #103 breaking the 31-PR zero-deps streak as the central case study. Article: `articles/project-lens-2026-05-24.md`
- **token-report, fetch-tweets, tweet-allocator, star-momentum-alert, star-milestone:** All completed normally

---

## Developer Notes
- **New dependencies:** None across both repos. MiroShark continues its zero-new-deps streak (now 32 PRs since the duckdb/huggingface_hub addition in PR #103)
- **Breaking changes:** None
- **Architecture shifts:** oEmbed is the first new *protocol* surface (as opposed to data-format surfaces like JSON/SVG/BibTeX). The platform stats API is the first endpoint scoped to the platform rather than individual simulations
- **New API surfaces:** `/oembed` (root-mounted, oEmbed 1.0), `/api/stats` (JSON aggregate), `/api/stats/badge.svg` (Shields.io pill)
- **Surface count:** 21 share-surface keys tracked in surface-stats.json (oembed added)

## What's Next
- PRs #104 (gitignore), #105 (platform stats), #106 (Railway deploy, external contributor Devin), #107 (oEmbed) are all open — 4 PRs awaiting review/merge
- May-24 batch: 1/5 addressed (oEmbed → PR #107). Remaining: Peak-Round Belief Analytics, Operator Profile Page, Agent Persona Export JSON, Simulation Search JSON API
- The platform-stats endpoint unblocks a future `/explore` gallery header stat or App.vue footer count
- The oEmbed natural follow-up is wiring a preview row into the EmbedDialog so operators can confirm the card before sharing
- 3/10 external contributor PRs toward the August 1 hyperstition target (Void Freud's #104 does not add to this count as it's a cleanup, not a feature PR — count remains at 3 from PR #98/AntFleet, PR #100/Void Freud, PR #103/community)
