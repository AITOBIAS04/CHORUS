# Push Recap — 2026-07-03

## Overview
13 substantive commits by 4 authors (12 automation commits filtered). The headline is a major community contribution: full French localization landed on MiroShark via PR #222, touching 32 Vue components with ~1,627 translated strings and a new CI scanner to prevent i18n regressions. Meanwhile, miroshark-aeon enabled Dependabot and immediately absorbed a wave of dependency updates — including a TypeScript 5.9 → 6.0 major version bump across three packages that required manual tsconfig fixes.

**Stats:** ~50 files changed, +2,301/-1,752 lines across 13 substantive commits

---

## aaronjmars/MiroShark

### French Internationalization — Community PR #222
**Summary:** Zarbel974 (co-authored by Abel) delivered full French language support for the MiroShark frontend, adding `fr:` translations to ~1,627 `tr()` calls across 32 Vue component files. The PR also introduced a Python CI scanner that gates future i18n quality, and included a critical fix for 320 runtime ReferenceErrors caused by using the template-only `\` alias in `<script setup>` scope.

**Commits:**
- `99b5663` — feat(i18n): French (fr) frontend translations for ~1627 tr() calls (#222)
  - Modified 32 Vue components (BeliefDriftChart, CounterfactualBranchPanel, CountryPicker, DebugPanel, DemographicBreakdown, EmbedDialog, GraphPanel, HistoryDatabase, InfluenceLeaderboard, InteractionNetwork, NetworkPanel, PolymarketChart, ScenarioSuggestions, SettingsPanel, Step1-5, TemplateGallery, TrendingTopics, WhatIfPanel, ZhWarningBanner, ComparisonView, EmbedView, ExploreView, Home, InteractionView, MainView, ReplayView, ReportView, SimulationRunView, SimulationView): Added `fr:` key to every `$tr()` call with proper French translations (+1,447/-1,425 lines across components)
  - New file `scripts/scan_i18n.py` (+463 lines): CI scanner that detects 5 bug classes (copy-paste errors, length anomalies, encoding issues) with 3 blocking categories — runs on every PR
  - Modified `.github/workflows/tests.yml`: Added `i18n-scan` CI job using Python 3.11 (+21 lines)
  - Modified `frontend/src/i18n.js`: Added `isFr` computed ref, exposed in `useI18n()` composable and plugin install (+3 lines)
  - Fix: Reverted 320 `\()` calls in `<script setup>` scope back to `tr()` — `\` is only registered as a Vue template global (`app.config.globalProperties.\`) and is undefined in script context, causing ReferenceError for ALL users (not just French). The SettingsPanel crash was particularly severe since it contains the language switcher itself.

**Impact:** MiroShark now supports 4 languages (EN, ZH-CN, DE, FR). This is the second community-contributed language after German, and the first with a CI quality gate. The scanner prevents future i18n regressions by catching copy-paste bugs, encoding errors, and length anomalies before merge. The `\` → `tr` fix resolved a real production bug that would have crashed 24 components.

### Dependency Patch — Vite
**Summary:** Routine patch update for the frontend build tool.

**Commits:**
- `f04db7d` — chore: bump vite from 8.1.0 to 8.1.3 (#225)
  - Modified `frontend/package.json` and `frontend/package-lock.json`: Vite patch update (+10/-10 lines)

**Impact:** Bug fixes and stability improvements in the Vite bundler. No breaking changes.

---

## aaronjmars/miroshark-aeon

### Dependabot Enablement & Configuration
**Summary:** aaronjmars enabled Dependabot for the miroshark-aeon monorepo, configuring it to scan npm dependencies across all `/apps/*` directories, bundler deps in `/docs`, and GitHub Actions workflows — all on a weekly cadence. This immediately triggered a cascade of 9 dependency PRs that were merged within hours.

**Commits:**
- `f7ebe2c` — Enable Dependabot (#87)
  - New file `.github/dependabot.yml` (+23 lines): Three package ecosystems configured (npm for `/apps/*` with grouped minor/patch updates, bundler for `/docs`, github-actions for `/`), 10 open PR limit

**Impact:** The miroshark-aeon monorepo now has automated dependency monitoring. The grouped minor/patch strategy keeps PR noise manageable while ensuring security patches land promptly.

### TypeScript 6.0 Migration
**Summary:** TypeScript jumped from 5.9.3 to 6.0.3 across three packages (mcp-server, a2a-server, dashboard). This is a semver-major upgrade — TypeScript 6.0 with `NodeNext` module resolution no longer auto-includes `@types/node` ambient globals, requiring explicit `"types": ["node"]` in tsconfig to resolve `process`, `fs`, `Buffer`, `URL`, and the `NodeJS` namespace.

**Commits:**
- `691bd0a` — bump typescript 5.9.3 → 6.0.3 in /apps/mcp-server (#96)
  - Modified `apps/mcp-server/package.json`: TypeScript version bump (+1/-1)
  - Modified `apps/mcp-server/tsconfig.json`: Added `"types": ["node"]` to compilerOptions (+1 line)

- `880dd15` — bump typescript 5.9.3 → 6.0.3 in /apps/a2a-server (#92)
  - Modified `apps/a2a-server/package.json`: TypeScript version bump (+1/-1)
  - Modified `apps/a2a-server/tsconfig.json`: Added `"types": ["node"]` to compilerOptions (+1 line)

- `b49b398` — bump typescript 5.9.3 → 6.0.3 in /apps/dashboard (#95)
  - Modified `apps/dashboard/package.json` and `package-lock.json` (+5/-5)

**Impact:** All three TypeScript packages in the monorepo are now on TS 6.0. The `"types": ["node"]` additions were co-authored by Claude and prevent build failures from the ambient type resolution change. Dashboard didn't need the tsconfig fix (likely already had it or uses a different module strategy).

### Node Type Definitions Upgrade
**Summary:** `@types/node` bumped from v22.x to v26.1.0 across all three packages, aligning type definitions with the latest Node.js LTS APIs.

**Commits:**
- `1290d26` — bump @types/node 22.20.0 → 26.1.0 in /apps/mcp-server (#97)
  - Modified `apps/mcp-server/package.json` (+1/-1)

- `d492854` — bump @types/node 22.19.15 → 26.1.0 in /apps/dashboard (#94)
  - Modified `apps/dashboard/package.json` and `package-lock.json` (+9/-9)

- `4bcc2fb` — bump @types/node 20.19.43 → 26.1.0 in /apps/a2a-server (#93)
  - Modified `apps/a2a-server/package.json` (+1/-1)

**Impact:** Type definitions now match the current Node.js API surface. This is a semver-major type bump (v20/v22 → v26) but should be transparent since the actual Node runtime version hasn't changed.

### Dashboard & Webhook Dependency Sweep
**Summary:** A large batch update covering 13 npm packages across the dashboard and webhook apps. Highlights include React 19.2.4 → 19.2.7, Next.js 16.2.6 → 16.2.10, Tailwind CSS 4.2.2 → 4.3.2, GSAP 3.14.2 → 3.15.0, json-render packages 0.15.0 → 0.19.0, and Wrangler 4.98.0 → 4.107.0.

**Commits:**
- `9eb7371` — bump npm-minor-and-patch group across 2 directories with 13 updates (#91)
  - Modified `apps/dashboard/package.json`, `apps/dashboard/package-lock.json`, `apps/webhook/package.json` (+221/-183)
  - Key updates: @json-render/* 0.15→0.19, gsap 3.14→3.15, next 16.2.6→16.2.10, react/react-dom 19.2.4→19.2.7, yaml 2.8→2.9, @tailwindcss/postcss 4.2→4.3, tailwindcss 4.2→4.3, tsx 4.22.4→4.22.5, wrangler 4.98→4.107

- `f88dede` — bump esbuild from 0.28.0 to 0.28.1 in /apps/dashboard (#90)
  - Modified `apps/dashboard/package-lock.json` (+108/-107 — indirect dependency, lockfile churn)

**Impact:** The json-render jump (0.15 → 0.19) is notable — four minor versions of the dashboard's rendering engine. React and Next.js patches improve stability. Tailwind 4.3 brings new utility classes. Wrangler 4.107 for the webhook worker includes 9 minor versions of Cloudflare tooling improvements.

### CI Workflow Actions Bump
**Summary:** GitHub Actions runners updated to latest major versions across all workflow files.

**Commits:**
- `767f07f` — bump actions/checkout from 4 to 7 (#89)
  - Modified 5 workflow files (aeon.yml, chain-runner.yml, ci-capabilities-parity.yml, messages.yml, sync-upstream.yml): checkout@v4 → checkout@v7 (+7/-7)

- `b08bf62` — bump actions/setup-node from 5 to 6 (#88)
  - Modified 2 workflow files (aeon.yml, messages.yml): setup-node@v5 → setup-node@v6 (+2/-2)

**Impact:** Latest actions versions bring performance improvements and security fixes. The checkout v4→v7 jump spans three major versions — v7 likely includes improvements to sparse checkout and submodule handling.

---

## Developer Notes
- **New dependencies:** @types/node v26.1.0 (all packages), TypeScript 6.0.3 (all packages), json-render 0.19.0, gsap 3.15.0, next 16.2.10, react 19.2.7, tailwindcss 4.3.2, wrangler 4.107.0, vite 8.1.3
- **Breaking changes:** TypeScript 6.0 requires `"types": ["node"]` in tsconfig.json when using `NodeNext` module resolution — already handled in mcp-server and a2a-server
- **Architecture shifts:** New i18n CI gate (scan_i18n.py) — all future PRs touching tr() calls will be scanned for translation quality
- **Tech debt:** None introduced. The `\` → `tr` fix in script scope actually resolves pre-existing tech debt from the German localization that wasn't caught without a scanner.

## What's Next
- The French i18n scanner could be extended to validate DE and ZH-CN translations retroactively
- Dependabot will continue generating weekly PRs — expect a steady cadence of dependency updates
- The TypeScript 6.0 migration may surface type errors in downstream consumers if any rely on implicit @types/node resolution
- MiroShark vite 8.1.3 aligns with miroshark-aeon's earlier vite bump (8.1.0 → current), keeping the frontend toolchain in sync
- Community contributor pipeline is active: Zarbel974's French PR is the first community language contribution to successfully merge with CI validation
