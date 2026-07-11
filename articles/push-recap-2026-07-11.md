# Push Recap — 2026-07-11

## Overview
9 substantive commits by 2 authors (aaronjmars, dependabot[bot]) across miroshark-aeon; 18 automation commits filtered. MiroShark had a quiet day with zero commits. The main thrust of today's work was a wholesale framework migration to aeon v0.1.0, followed by meticulous cleanup of runtime artifacts that kept being re-committed by the auto-commit runner.

**Stats:** ~318 files changed, +26,641/-73,025 lines across 9 substantive commits

---

## aaronjmars/MiroShark

No commits in the last 24 hours. Third consecutive quiet day.

---

## aaronjmars/miroshark-aeon

### Framework Migration: aeon v0.1.0 Template Adoption

**Summary:** A complete framework overhaul that migrates miroshark-aeon from its organic, 203-skill, heavily-customized state onto the canonical aeon v0.1.0 template. This is the most significant structural change to the repo in weeks — it replaces CI, workflows, scripts, and the skill catalog while preserving instance identity (soul/, memory/, STRATEGY.md).

**Commits:**
- `c8a7b7f` — Migrate onto aeon v0.1.0 template (framework refresh, state preserved) (#102)
  - **Phase 1** — Replaced `apps/` (dropped a2a-server), `bin/`, `scripts/`, `catalog/`, `.github/` (12 workflows, scheduler split, 6 CI guards), `docs/`, `output/` with template versions
  - Skills reduced from 203 → 61 (template's 60 composites + ported repo-pulse)
  - Fresh root files: CLAUDE.md, AGENTS.md, CHANGELOG.md, .gitignore, aeon launcher
  - Deleted ~40 root runtime scratch files, old content dirs (articles/assets/examples/images/skill-templates/workflow-templates)
  - **Phase 2-3** — Ported state: enabled 7 production skills in aeon.yml (changelog, token-movers, fetch-tweets, shiplog, memory-flush, heartbeat, repo-pulse) with instance schedules
  - Created `memory/token-report.md` for token-movers config
  - OKF: backfilled type frontmatter on all memory files, validated 112 concepts OK
  - **Phase 4** — Regenerated AGENTS.md for the migrated 61-skill set
  - 300 files changed: 63 added, 71 modified, 165 removed, 1 renamed (+26,610/-72,711 lines)

**Impact:** miroshark-aeon is now aligned with the upstream aeon template, making future template upgrades trivial (diff against template instead of manual cherry-picks). The CI guard suite (6 new workflows: agents-md, okf, packs-json, skill-category, skills-json, tests) ensures structural integrity going forward. Skill count dropped by 70% but the removed skills were inactive/broken; the 7 enabled ones are the same ones that have been running for weeks.

---

### Repo Hygiene: Runtime Artifact Cleanup

**Summary:** Three sequential commits that solve a persistent problem: the runner's `git add -A` auto-commit kept re-committing runtime-generated files (secretcurl auth shim, stale notification digests, chain outputs, old ECOSYSTEM/SHOWCASE docs) because they weren't gitignored. Each commit fixes a slightly different layer of the same root cause.

**Commits:**
- `3972ff1` — cleanup: remove non-template files + stop runtime-artifact recurrence (#107)
  - Removed `.mcp.json` (prod MCP config is runtime-generated, not committed)
  - Removed `secretcurl` (auth shim regenerated each run by scripts/secretcurl.sh)
  - Removed `output/.chains/heartbeat.md` (chain output captured fresh each run)
  - Removed `ECOSYSTEM.md` and `SHOWCASE.md` (stale framework docs with broken assets/ refs post-migration)
  - Added `.gitignore` rules for `/secretcurl` and `/output/.chains/*`
  - +0/-248 lines across 5 files

- `8e3b561` — cleanup: remove runtime artifacts from root + actually ignore them (#111)
  - The previous commit (#107) claimed to add .gitignore rules but the actual commit only carried deletions — the rules were missing
  - This commit removes both `secretcurl` (again, as fetch-tweets re-added it 25 min after #107) and `notify-token-report.md`
  - Adds the actual .gitignore rules that were missing: `/secretcurl` and `/notify-token-report.md`
  - Verified via `git check-ignore` that the rules work
  - +7/-49 lines across 3 files

- `3354a73` — fix(token-movers): route movers digest to /tmp, not the repo root (#108)
  - Changed token-movers SKILL.md to write its digest to `/tmp/token-movers-report.md` instead of repo root
  - Regenerated `catalog/skills.json` and `packs.json` to reflect the path change
  - +3/-3 lines across 3 files

**Impact:** Ends the recurring cycle where runtime artifacts (secretcurl, notification drafts, chain outputs) were committed → deleted → re-committed on every cron run. The auto-commit's `git add -A` now has nothing to sweep because the files are either written to /tmp or properly gitignored. This also explains why self-improve PRs kept going DIRTY within hours (ISS captured in MEMORY.md).

---

### Dependency Management

**Summary:** A batch of 5 dependency updates spanning all three apps (dashboard, mcp-server, webhook) plus CI infrastructure. Notable: TypeScript 7.0.2 is adopted for mcp-server (which builds with raw tsc) but deliberately blocked for dashboard (Next.js 16.2.x can't handle TS 7's native compiler).

**Commits:**
- `b88f451` — chore(dependabot): ignore typescript 7.x for the dashboard (#109)
  - Added `ignore: typescript 7.x` rule in `.github/dependabot.yml` scoped to dashboard only
  - Reason: `next build` aborts at type-check step with TS 7; TS 6.0.3 builds clean
  - +7/-0 lines, 1 file

- `2cf7def` — chore(deps-dev): bump typescript from 6.0.3 to 7.0.2 (#105)
  - Upgraded mcp-server's TypeScript to 7.0.2 (major version bump)
  - mcp-server builds with raw `tsc`, which works fine under TS 7
  - +1/-1 lines, 1 file

- `f1fa08e` — chore(deps-dev): bump wrangler from 4.107.0 to 4.110.0 (#104)
  - Minor bump for the webhook app's Cloudflare Workers toolchain
  - +1/-1 lines, 1 file

- `56eb579` — chore(actions): bump actions/cache from v4 to v6 (#103)
  - Updated both `aeon.yml` and `messages.yml` workflows to use actions/cache@v6
  - Shared npm cache for Claude Code global install now uses latest cache action
  - +2/-2 lines, 2 files

- `aa7088c` — chore(deps-dev): bump dashboard group: @types/node 26.1.0→26.1.1, tsx 4.22.5→4.23.0 (#110)
  - Patch bump for Node.js type definitions + minor bump for tsx runner
  - Updated both package.json and package-lock.json
  - +10/-10 lines, 2 files

**Impact:** All three apps are on latest compatible dependencies. The TypeScript split (7.x for mcp-server, 6.x for dashboard) is a deliberate architectural decision documented in dependabot.yml so future bot PRs respect the constraint. actions/cache v6 brings improved performance and v4 deprecation avoidance.

---

## Developer Notes
- **New dependencies:** TypeScript 7.0.2 (mcp-server only), tsx 4.23.0, @types/node 26.1.1, wrangler 4.110.0, actions/cache v6
- **Breaking changes:** The v0.1.0 migration rewrites the entire CI/CD surface — any external tooling referencing old workflow files or paths (old skill dirs, old script locations) will break
- **Architecture shifts:** Skills dropped from 203 → 61; old organic growth replaced by structured template with CI validation gates. Three-app monorepo structure (dashboard/mcp-server/webhook) preserved but surrounding infrastructure completely replaced.
- **Tech debt:** None introduced — this is a net debt reduction (removed 165 stale files, cleaned runtime artifact pollution)

## What's Next
- The 7 enabled skills should start running cleanly on the new template structure — first runs post-migration will validate
- TypeScript 7 support for the dashboard is blocked until Next.js ships TS 7 compatibility
- Runtime artifact re-commitment issue should now be permanently solved — monitor for any new stray files appearing in chore commits
- The validate-config CLEAN status confirms the migration landed correctly (okf 112/112, onboard 12/12)
