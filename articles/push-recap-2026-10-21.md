# Push Recap — 2026-10-21

## Overview
1 substantive commit by aaronjmars across 1 watched repo (18 automation commits filtered from miroshark-aeon). Today's work was a major upstream sync — PR #222 merged 16 commits from aeonfun/aeon, bringing the aeon-update skill rewrite, gateway failover improvements, dashboard fixes for half-hour timezones, config validation for misspelled keys, and the Codex plugin 0.2.0 release with hosted MCP server support.

**Stats:** 53 files changed, +2504/-516 lines across 1 substantive commit

---

## aaronjmars/MiroShark

*No commits in the last 24 hours.*

---

## aaronjmars/miroshark-aeon

### aeon-update Skill Rewrite
**Summary:** The aeon-update skill's file-compare-and-apply logic — previously spelled out as shell snippets in the SKILL.md — has been extracted into a standalone Python script (`scripts/aeon_update.py`, 840 lines). Claude Code's permission layer was blocking the shell-snippet approach, causing two recent sync runs to exit green with nothing actually synced. The new script runs as a single allowed `python3` command, handling the entire compare/classify/apply pass in code rather than relying on the model to interpret the steps.

**Commits:**
- `da23911` — aeon-update: sync 16 upstream commits (3a747cd..a0cca77) (#222)
  - New file `scripts/aeon_update.py`: Complete rewrite of the sync engine in Python (+840 lines). Handles upstream diff, file classification (apply/auto-merge/conflict/operator-owned), 3-way merge via `git merge-file`, and baseline tracking. Includes `plan` and `apply` subcommands.
  - New file `scripts/tests/test_aeon_update.py`: 231 lines of unit tests covering the new sync engine
  - Changed `skills/aeon-update/SKILL.md`: Dramatically simplified from shell-snippet steps to delegating to the Python script (+80, -202 lines). The skill now calls `python3 scripts/aeon_update.py plan` and `apply` instead of inline bash.

**Impact:** Fixes the fundamental reliability problem where the skill ran successfully but synced nothing. The Python script approach sidesteps Claude Code's permission layer entirely, making upstream syncs deterministic rather than model-interpreted.

### Gateway Failover & Error Reporting
**Summary:** Cleaner error diagnostics when the gateway cascade (Claude → fallback provider) fails, plus faster failure detection for dead fallback keys. Previously, a spent Claude plan behind a dead fallback produced a cryptic timeout error; now each attempt's failure reason is captured and joined into a single line.

**Commits:**
- `da23911` (cont.)
  - New file `scripts/gateway-error.sh`: Extracts a one-line error reason from each gateway attempt's stderr (+45 lines). Detects plan limits, rate limits, auth errors, and timeouts. The aeon.yml Run step joins these into the saved error.
  - Changed `harness-adapter/adapters/claude.sh`: Added `AEON_FAILOVER_MAX_WAIT_MS` (default 2 min) for failover attempts (+9 lines). A dead fallback key that returns 429 with no usage-limit header no longer retries for the full 1800s budget.
  - Changed `harness-adapter/lib/otel-span.sh`: Added `plan_limit` error class for subscription usage caps. Gateway provider and attempt number now tracked in OTEL spans (+20, -6 lines).
  - Changed `scripts/langfuse-otel.sh`: Gateway attributes (`GATEWAY`, `AEON_GATEWAY_ATTEMPT`) added to Langfuse trace metadata (+13 lines). Both attempts of a failed-over run share one trace.

**Impact:** Operators can now see exactly why each gateway attempt failed (e.g., "claude: You've hit your weekly limit | glm: API Error: 429") instead of a generic timeout. Failover attempts also fail faster, preserving budget for the next cascade route.

### Dashboard & MCP Server Fixes
**Summary:** Half-hour timezone handling fixed in the dashboard's cron display, skill upload logic refactored for correctness, and the MCP server's harness process timeout handling improved.

**Commits:**
- `da23911` (cont.)
  - New file `apps/dashboard/lib/schedule.ts`: Extracted schedule validation and normalization into a shared module (+20 lines). Collapses whitespace and delegates to `validate-config.js` rules.
  - New file `apps/dashboard/lib/schedule.test.ts`: 48 lines of tests for schedule validation
  - New file `apps/dashboard/lib/skill-upload.ts`: Extracted skill name derivation and path stripping from the upload route (+68 lines). Slugifies folder names so "My Skill" doesn't create an invalid `skills/My Skill/` path.
  - New file `apps/dashboard/lib/skill-upload.test.ts`: 48 lines of tests for upload name derivation
  - Changed `apps/dashboard/lib/utils.ts`: Fixed UTC offset calculation from hours to minutes (+37, -17 lines). Half-hour zones (India +5:30, Nepal +5:45, Newfoundland -3:30) previously showed wrong cron times because the offset was truncated to whole hours.
  - Changed `apps/dashboard/lib/utils.test.ts`: 75 new test lines for timezone and utility functions
  - Changed `apps/dashboard/app/api/skills/route.ts`: Skills PATCH now validates and normalizes schedules via the new module (+12, -1 lines)
  - Changed `apps/dashboard/app/api/upload/route.ts`: Refactored to use the new `skill-upload.ts` module (+2, -62 lines)
  - Changed `apps/mcp-server/src/skill-executor.ts`: Exported `RUN_TIMEOUT_SECONDS`; improved harness kill timing to account for `timeout -k` grace period (+36, -7 lines)
  - New file `apps/mcp-server/test/spawn-harness.test.mjs`: 77 lines testing the harness process lifecycle

**Impact:** Users in half-hour timezones now see correct local cron times in the dashboard. Skill uploads with non-slug names no longer create broken directory paths. The MCP server more reliably cleans up child processes after a timeout.

### Config Validation: Misspelled Key Detection
**Summary:** `validate-config.js` now catches unknown or misspelled keys on skill entries (like `enabld:` instead of `enabled:`, or `shedule:` instead of `schedule:`), with did-you-mean suggestions. YAML silently drops unrecognized keys, so a typo previously meant a skill would lose its schedule or run on defaults with no warning.

**Commits:**
- `da23911` (cont.)
  - Changed `scripts/validate-config.js`: Added rule 7 — skill entry key validation with Levenshtein-distance "did you mean?" hints. Also validates that `enabled: true` skills have a schedule, reactive target, or chain step (+214, -7 lines)
  - Changed `scripts/validate-config.test.js`: 141 new test lines for misspelled key detection
  - New file `scripts/validate-config.d.ts`: TypeScript declarations for the validator (+5 lines)

**Impact:** A single typo in `aeon.yml` can no longer silently disable a skill. CI catches it with a clear error and suggestion.

### Plugin 0.2.0: Hosted MCP Server Support
**Summary:** The Codex plugin bumped to v0.2.0 with support for connecting to the hosted Aeon MCP server, a new onboarding skill, and updated descriptions across all marketplace listings.

**Commits:**
- `da23911` (cont.)
  - Changed `plugin/.codex-plugin/plugin.json`: Version 0.1.0 → 0.2.0; added `mcpServers` field pointing to `.mcp.json`; updated description and expanded interface metadata (+71, -5 lines)
  - New file `plugin/.mcp.json`: MCP server configuration for the hosted Aeon Connect endpoint (+8 lines)
  - New file `plugin/skills/get-started/SKILL.md`: First-run onboarding skill (+59 lines). Checks the MCP connection, shows available skills, and runs one skill to demonstrate.
  - Changed `plugin/README.md`: Updated to reflect 0.2.0 capabilities (+32, -1 lines)
  - Changed `plugin/SECURITY.md`: Updated security documentation (+11, -5 lines)
  - Changed `.agents/plugins/marketplace.json` and `.claude-plugin/marketplace.json`: Updated descriptions to match 0.2.0 scope (+1, -1 each)

**Impact:** The plugin can now connect to Aeon's hosted MCP server (aeon.fun/connect/mcp) instead of requiring a local setup. New users get a guided onboarding flow.

### Smaller Changes
**Summary:** Robinhood Chain support for onchain-monitor, git auth preservation fix, documentation updates, and test hardening.

**Commits:**
- `da23911` (cont.)
  - Changed `skills/onchain-monitor/SKILL.md`: Added Robinhood Chain to the supported chain list (+22, -7 lines)
  - Changed `skills/aeon-doctor/SKILL.md`: Minor wording update (+1, -1 lines)
  - Changed `scripts/commit-run-results.sh`: Fixed stash-pop to restore only changed files, not entire directories (+9, -5 lines). Prevents agent branch commits from leaking into the main checkout.
  - Changed `docs/CONFIGURATION.md`: Documented read-only mode enforcement (+12 lines)
  - Changed `docs/harnesses.md`: Documented OpenRouter app attribution headers (+10 lines)
  - Changed `docs/ADK.md`, `docs/ECOSYSTEM.md`, `docs/community-skill-packs.md`: Minor link and text fixes
  - Changed `.github/CONTRIBUTING.md`: Minor wording update
  - Changed `skills/deploy-uni-hook/templates/chains.tsv`: Added Robinhood Chain Alchemy slug (+1, -1 lines)
  - Changed `catalog/skills.json`, `catalog/packs.json`: Regenerated catalogs
  - Changed `eyebrowlock.json`: Rescanned with eyebrow v0.5.6 (+71, -41 lines)
  - Test improvements across 6 test files: gateway failover, dev-loop, OTEL spans, commit results

**Impact:** Onchain monitoring now covers Robinhood Chain. Git authentication is preserved across skill runs (fixing upstream PR #1241). Documentation catches up with recent features.

---

## Developer Notes
- **New dependencies:** None (Python stdlib only for `aeon_update.py`)
- **Breaking changes:** None — the aeon-update skill interface is the same; only the implementation moved from shell snippets to Python
- **Architecture shifts:** The aeon-update sync engine is now a Python script rather than model-interpreted shell steps. This is a pattern shift: when Claude Code's permission layer blocks a skill's inline commands, the work moves into a script the model can invoke as a single command.
- **Tech debt:** 6 files flagged for manual review in the PR body (aeon.yml, .gitignore, CHANGELOG.md, docs/langfuse.md, ci-lanes.txt, test_langfuse_otel.sh) — these are operator-customized files where upstream changes conflicted with local edits. 41 pending conflicts carried forward.

## What's Next
- The 6 manual-review files from PR #222 need human attention — notably `aeon.yml` which carries the gateway cascade and trusted-auth fix
- The `.gitignore` conflict is low-risk but should be resolved to pick up upstream's scratch-file ignores
- With `scripts/aeon_update.py` now in place, the next weekly aeon-update run should succeed autonomously instead of exiting green with nothing synced
- Plugin 0.2.0's hosted MCP server support may need operator configuration on the Aeon Connect side
