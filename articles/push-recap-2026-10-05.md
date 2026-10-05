# Push Recap — 2026-10-05

## Overview
3 substantive commits by 3 authors (Aaron Elijah Mars, aeonframework, dependabot[bot]) across both watched repos, plus 25 automation commits filtered. The headline is PR #194 on miroshark-aeon — a 71-commit upstream sync from aeonfun/aeon that brings Aeon Connect (a full browser-based onboarding dashboard), a new `aeon init` CLI command, all 9 harness adapters overhauled, LLM gateway switched to multi-provider auto mode, and a massive test expansion. This is the largest single merge in the repo's history by file count.

**Stats:** 305 files changed, +17,222/-2,945 lines across 3 substantive commits

---

## aaronjmars/MiroShark

### Dependency Maintenance
**Summary:** A single dependabot patch bump to vite, the frontend build tool.

**Commits:**
- `af6ae27` — chore: bump vite in /frontend in the frontend-minor-patch group (#316)
  - Changed `frontend/package.json`: vite ^8.3.1 → ^8.3.2 (+1, -1 lines)
  - Changed `frontend/package-lock.json`: vite 8.3.1 → 8.3.2, rolldown ~1.2.9 → ~1.2.11 (+5, -5 lines)

**Impact:** Routine patch-level dependency bump. Rolldown (vite's bundler) also bumped two minors. No functional changes to the MiroShark frontend.

---

## aaronjmars/miroshark-aeon

### Upstream Sync: Aeon Connect, CLI Init & Harness Overhaul (PR #194)
**Summary:** A 71-commit upstream sync from aeonfun/aeon spanning September 24 to October 4. This merge brings the Aeon Connect browser dashboard, a new `aeon init` CLI command for terminal-based onboarding, a complete overhaul of all 9 harness adapters with a new gateway failover system, the LLM gateway switched from a single named provider to auto multi-provider mode, and over 20 new or significantly expanded test suites. 312 files applied cleanly from canon; 26 paths were held for manual review (operator config, fork-divergent docs, skill-count validators, 2 content conflicts, new skills). Baseline advanced to 1a7f07e.

**Commits:**
- `fb16817` — aeon-update: sync 71 upstream commits (531f575..1a7f07e) (#194)

  **Aeon Connect Dashboard** (the largest feature surface):
  - New `apps/dashboard/components/ConnectModal.tsx`: Full browser-based onboarding flow — 340-line modal that replaces the old AuthModal, GrokAuthModal, and HarnessAuthModal (all three removed) (+340, -189 lines net)
  - New `apps/dashboard/components/OnboardingChecklist.tsx`: Step-by-step setup progress tracker for new Connect users (+124 lines)
  - New `apps/dashboard/components/TelegramLinkCard.tsx`: Telegram bot linking UI with verification (+104 lines)
  - New `apps/dashboard/components/RunDiagnosis.tsx`: Failed-run diagnosis panel with root-cause analysis (+61 lines)
  - New `apps/dashboard/components/MobileBar.tsx`: Responsive mobile navigation bar (+26 lines)
  - New API routes: `/connect/detect` (repo detection), `/connect/found` (repo confirmation), `/connect` (main connect flow), `/onboarding` (checklist state), `/openrouter-auth` + callback (OpenRouter OAuth), `/telegram/link` + check (bot linking), `/runs/[id]/diagnosis` (run debugging)
  - New `apps/dashboard/lib/connect-detect.ts`: Repository detection logic — scans for aeon.yml, skill directories, harness config to identify existing Aeon instances (+350 lines)
  - New `apps/dashboard/lib/connect-server.ts`: Server-side Connect orchestration (+163 lines)
  - New `apps/dashboard/lib/connect-store.ts`: Client state management for Connect flow (+55 lines)
  - New `apps/dashboard/lib/connect-commands.ts`: CLI command generation for Connect setup (+84 lines)
  - New `apps/dashboard/lib/openrouter-oauth.ts`: OpenRouter as a gateway provider via OAuth (+99 lines)
  - New `apps/dashboard/lib/telegram-link.ts`: Telegram bot token verification and linking (+94 lines)
  - New `apps/dashboard/lib/run-diagnosis.ts`: Skill run failure analysis with log parsing (+163 lines)
  - New `apps/dashboard/lib/manifest.ts`: Aeon instance manifest reader (+59 lines)
  - New `apps/dashboard/lib/use-narrow.ts`: Responsive breakpoint hook (+17 lines)
  - New `apps/dashboard/lib/use-run-diagnosis.ts`: React hook for run diagnosis fetching (+47 lines)
  - Changed `apps/dashboard/app/page.tsx`: Rewired the main page to use ConnectModal instead of AuthModal; added onboarding checklist integration (+120, -42 lines)
  - Changed `apps/dashboard/lib/constants.ts`: Added Connect-related constants, gateway provider list, onboarding state keys (+98, -45 lines)
  - Changed `apps/dashboard/lib/github-auth.ts`: Extended GitHub auth to support Connect flow's repo detection (+62, -3 lines)
  - Changed `apps/dashboard/lib/github.ts`: Added push-to-repo capability for Connect setup (+46, -11 lines)
  - Changed `apps/dashboard/lib/dispatch.ts`: Extended dispatch to handle Connect-initiated runs (+24, -7 lines)
  - 10 new test files for Connect/dashboard features: connect-detect.test (299 lines), telegram-link.test (115 lines), run-diagnosis.test (209 lines), dispatch.test (75 lines), sync-push.test (83 lines), openrouter-oauth.test (78 lines), onboarding-checklist.test (28 lines), github-push.test (69 lines), gh.test (24 lines)

  **CLI `aeon init` Command:**
  - New `apps/cli/src/commands/init.ts`: Full terminal-based instance setup — detects existing repos, scaffolds aeon.yml, selects skills, configures harness and gateway, sets up secrets (+941 lines)
  - New `apps/cli/src/grok.ts`: Grok gateway integration for CLI (+39 lines)
  - New `apps/cli/src/manifest.ts`: Instance manifest generation for CLI (+71 lines)
  - New `apps/cli/test/init-sandbox.sh`: Sandbox integration test for init command (+173 lines)
  - New `apps/cli/test/fake-gh`: GitHub CLI mock for testing (+96 lines)
  - Changed `apps/cli/src/index.ts`: Registered init command in CLI entry point (+8, -1 lines)

  **Harness Adapter Overhaul:**
  - Changed `harness-adapter/adapters/claude.sh`: Permission-mode handling for Claude Code 2.1.287, sandbox gate integration (+65, -3 lines)
  - Changed `harness-adapter/adapters/codex.sh`: Full rewrite of Codex adapter with sandbox isolation, MCP translation (+81, -18 lines)
  - Changed `harness-adapter/adapters/cursor.sh`: Cursor adapter with config snapshot support (+20, -2 lines)
  - Changed `harness-adapter/adapters/grok.sh`: Grok adapter with gateway failover (+28, -22 lines)
  - Changed `harness-adapter/adapters/hermes.sh`: Hermes adapter with sandbox support (+30, -5 lines)
  - Changed `harness-adapter/adapters/kimi.sh`: Kimi adapter with config snapshot (+20, -5 lines)
  - Changed `harness-adapter/adapters/vibe.sh`: Vibe adapter with sandbox gate (+36, -10 lines)
  - New `harness-adapter/gateways.json`: Gateway provider registry — maps provider names to endpoints, models, auth patterns (+130 lines)
  - Changed `harness-adapter/harnesses.json`: Major schema update — all 9 harnesses with min_version, capabilities matrix, MCP support flags (+283, -38 lines)
  - Changed `harness-adapter/lib/sandbox.sh`: Sandbox isolation library with cgroup and network namespace support (+100, -11 lines)
  - Changed `harness-adapter/lib/mcp-translate.sh`: MCP protocol translation between harness dialects (+56, -1 lines)
  - Changed `harness-adapter/bin/generate-harnesses-json`: Generator updated for new schema fields (+73, -10 lines)
  - Changed `.github/workflows/aeon.yml`: Claude Code pin bumped to 2.1.287 (+2, -2 lines)
  - Changed `.github/workflows/messages.yml`: Same claude pin bump (+2, -2 lines)

  **LLM Gateway & Failover:**
  - Changed `scripts/llm-gateway.sh`: Switched from single named provider ("claude") to "auto" mode — probes multiple providers and selects the first healthy one (+160, -98 lines)
  - New `scripts/gateway-failover.sh`: Automatic provider failover when primary gateway returns errors (+25 lines)
  - New `scripts/ccr-aeon-gateway.mjs`: Gateway configuration reconciliation (+50 lines)

  **CI/CD Improvements:**
  - New `.github/workflows/ci-aeon-skill-sync.yml`: Validates skill definitions match canon catalog (+43 lines)
  - New `.github/workflows/ci-harness-cli.yml`: Smoke tests for all 9 harness CLI adapters (+91 lines)
  - Changed `.github/workflows/ci-gate.yml`: Added harness-cli and aeon-skill-sync to gate checks (+43, -14 lines)
  - Changed `.github/workflows/scheduler.yml`: Major rewrite — cron state management, tick scheduling, skill dispatch refactored (+157, -135 lines)

  **Scripts & Infrastructure:**
  - New `scripts/commit-run-results.sh`: Commits skill run output files after execution (+121 lines)
  - New `scripts/feature-open-pr.sh`: Opens PRs for completed feature branches (+78 lines)
  - New `scripts/harness-config-snapshot.sh`: Captures harness configuration state for debugging (+204 lines)
  - New `scripts/parse-aeon-config.sh`: Parses aeon.yml for programmatic access (+82 lines)
  - New `scripts/run-context-summary.sh`: Generates context summaries for skill runs (+107 lines)
  - New `scripts/skill_entry.sh`: Skill entry point wrapper with logging (+43 lines)
  - Changed `scripts/git-push-retry.sh`: Added exponential backoff, conflict detection, rebase recovery (+123, -21 lines)
  - Changed `scripts/install-harness.sh`: Multi-harness install with version pinning (+147, -18 lines)
  - Changed `scripts/resolve-harness.sh`: Provider-aware harness resolution (+93, -23 lines)
  - Changed `scripts/cron-due.sh`: Cron scheduling with step-day filters (+84, -35 lines)
  - Changed `scripts/validate-config.js`: Added gateway, harness, and credential validation (+68, -1 lines)

  **Testing Expansion (~20 new/expanded suites):**
  - New `scripts/tests/harness_cli_smoke.sh`: End-to-end smoke tests for all 9 harness adapters (+438 lines)
  - New `scripts/tests/test_credential_manifest.sh`: Credential manifest validation (+333 lines)
  - New `scripts/tests/test_harness_config_isolation.sh`: Config isolation between concurrent runs (+271 lines)
  - New `scripts/tests/test_scheduler_tick.sh`: Scheduler tick dispatch logic (+194 lines)
  - New `scripts/tests/test_commit_results_feature_branch.sh`: Feature branch commit flow (+179 lines)
  - New `scripts/tests/test_readonly_notify.sh`: Read-only notification guard (+150 lines)
  - New `scripts/tests/test_cron_state_commit.sh`: Cron state persistence (+142 lines)
  - New `scripts/tests/test_git_push_retry.sh`: Push retry with conflict recovery (+139 lines)
  - New `scripts/tests/test_codex_adapter.sh`: Codex adapter integration test (+114 lines)
  - New `scripts/tests/test_pi_adapter.sh` + `test_pi_adapter_mcp.sh`: Pi adapter tests (+224 lines total)
  - New `scripts/tests/test_dashboard_model_choices.sh`: Dashboard model selection (+107 lines)
  - New `scripts/tests/test_feature_open_pr.sh`: Feature PR opening (+94 lines)
  - New `scripts/tests/test_standing_instructions_restore.sh`: Standing instructions persistence (+67 lines)
  - New `scripts/tests/test_all_secrets_allowlist.sh`: Secrets allowlist validation (+67 lines)
  - New `scripts/tests/test_gateway_failover.sh`: Gateway failover logic (+32 lines)
  - New `scripts/tests/fake-llm-upstream.mjs`: Fake LLM upstream for testing (+151 lines)
  - New `scripts/tests/fake-mcp-server.mjs`: Fake MCP server for adapter tests (+75 lines)
  - Expanded test_run_harness_sandbox_gate (+212 lines), test_llm_gateway (+128 lines), test_chain_runner (+96 lines), test_install_harness (+78 lines), test_resolve_harness (+101 lines), and others

  **Documentation & Catalog:**
  - Changed `docs/harnesses.md`: Updated harness documentation for all 9 adapters (+92, -43 lines)
  - Changed `docs/community-skill-packs.md`: Packs registry synced with canon (+9, -20 lines)
  - Changed `.github/SECURITY.md`: Security policy update (+15, -7 lines)
  - Changed `docs/CONFIGURATION.md`: Configuration guide updated for Connect and gateway settings (+40, -25 lines)
  - Changed `docs/aeon-setup.md`: Setup guide updated for new counts (82 skills) (+8, -7 lines)
  - Changed `docs/examples/README.md`: Example counts updated (+3, -3 lines)
  - Changed `docs/assets/hero-animated.svg`: Updated skill/harness counts in hero graphic (+1, -1 lines)
  - New `docs/assets/btn-run.svg`: Run button asset for Connect UI (+15 lines)
  - Changed `CHANGELOG.md`: 226 new lines documenting all upstream changes
  - Changed `eyebrowlock.json`: Lock file regenerated for new dependency tree (+150, -276 lines)

  **Miscellaneous:**
  - Changed `aeon` (main entry): Expanded with gateway selection and init path (+42, -11 lines)
  - Changed `apps/webhook/src/worker.js`: Webhook handler extended for Connect events (+62, -3 lines)
  - New `.gitattributes`: Binary file handling rules (+6 lines)
  - Catalog updates: 3 new skill icons (cortx-reliability, create-prove, sc-audit) in `catalog/skill-icons.json`
  - Plugin mirrors updated to match main skill definitions

**Impact:** This sync transforms miroshark-aeon from a CLI-first agent into a multi-surface platform. Aeon Connect is a full browser-based setup flow: sign in, connect a model, pick skills, and the agent runs itself — no git clone required. The `aeon init` CLI command mirrors this for terminal users. The harness overhaul means all 9 coding-agent CLIs (Claude Code, Codex, Cursor, fx, Grok, Hermes, Kimi, Pi, Vibe) now have standardized sandbox isolation, MCP protocol translation, and gateway failover. The auto LLM gateway probes multiple providers instead of hardcoding one. And the test expansion from ~15 to ~35+ test suites materially improves the CI safety net for an autonomously operating agent.

### Token Tracking: RALLYING Verdict
**Summary:** The token-movers skill logged a RALLYING verdict — the first positive session in 8 days, driven by two whale buys.

**Commits:**
- `a268482` — token-movers: $MIROSHARK single-token report 2026-10-05 (RALLYING)
  - Changed `memory/MEMORY.md`: Updated token price line — $0.000002578 (+7.5% 24h), first whale activity since 10-01, two buys at $1.98K and $1.42K (+1, -1 lines)
  - New `memory/logs/2026-10-05.md`: Daily log with token-movers entry — price, liquidity, verdict, sources (+7 lines)
  - New `output/articles/token-report-2026-10-05.md`: Full token report article — RALLYING verdict, 2.0× avg volume, whale buy details, liquidity flat at $140K (+29 lines)

**Impact:** Breaks an 8-session losing streak. The two whale buys ($1.98K + $1.42K) are the first $1K+ trades since October 1, together accounting for ~29% of the session's $11.6K volume. Price still down 94% from ATH but the volume spike and whale re-engagement are notable.

### Automation Commits (25 filtered)
Scheduler state updates (7), cron success markers for repo-pulse/shiplog/changelog/holdings/token-movers/heartbeat/memory-flush/fetch-tweets (10), auto-commits for the same skills (8). Standard daily skill execution cycle.

---

## Developer Notes
- **New dependencies:** None (vite bump is patch-level)
- **Breaking changes:** Claude Code pin moved to 2.1.287 in aeon.yml and messages.yml — harness adapters now expect this version's permission-mode handling
- **Architecture shifts:**
  - LLM gateway switched from `"claude"` to `"auto"` — multi-provider with failover. This means the agent is no longer tied to a single LLM provider.
  - AuthModal/GrokAuthModal/HarnessAuthModal removed and replaced by unified ConnectModal — the auth surface has been consolidated
  - Scheduler workflow substantially rewritten (+157/-135) — cron state management refactored
  - Harness adapters now share sandbox isolation (cgroup/network namespace) and MCP translation libraries rather than each implementing their own
- **Tech debt:** `.aeon-update-tmp/` directory with 21 working files from the sync process was committed alongside the merge (apply scripts, drift detection, eyebrow binary, PR body draft) — these appear to be build artifacts from the sync process

## What's Next
- PR #194 landed but 26 paths were held for manual review — watch for follow-up commits resolving those held paths
- The Connect dashboard and `aeon init` CLI are now in the fork but need the Aeon Connect service (www.aeon.fun/connect) to be live for full functionality
- Gateway failover and auto LLM selection are deployed — monitor for provider probe failures in upcoming skill runs
- GH_GLOBAL secret still blocks feature work — now 90+ consecutive blocks, but the upstream sync itself succeeded via aeon-update
- Test suite nearly doubled — CI gate now includes harness-cli and aeon-skill-sync checks
- PR #66 (skill-leaderboard dedup) and PR #62 (stale, DIRTY/CONFLICTING) still open
