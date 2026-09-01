# Push Recap — 2026-09-01

## Overview
3 substantive commits by 2 authors (44 automation commits filtered). The headline: miroshark-aeon synced 34 upstream commits from aeonfun/aeon, jumping the harness count from 7 to 10 (Cursor, Hermes, and GLM join the fleet), rewriting the MCP server's blocking skill executor to async, and adding Telegram reply-to-previous threading. A second commit pins GLM reasoning effort to `high` by default. The holdings skill logged a fifth straight accumulating snapshot.

**Stats:** ~100 files changed, +2,519/-487 lines across 3 substantive commits

---

## aaronjmars/miroshark-aeon

### Upstream Sync: 10th-Generation Harness Fleet
**Summary:** PR #161 merged a sync of 34 upstream commits from aeonfun/aeon. This is the largest single sync in recent weeks — 96 files touched, +2,481/-486 lines. It brings the harness count from 7 to 10, rewrites the MCP server's core execution path, adds Telegram threading, introduces two new skills, and hardens several subsystems.

**Commits:**
- `ac5747f` — aeon-update: sync 34 upstream commits (8b8d719..3b4c5a3) (#161)

  **New harnesses (Cursor, Hermes, GLM):**
  - New file `harness-adapter/adapters/cursor.sh`: Cursor CLI adapter using documented `agent -p` headless mode. Uses `--trust` for fresh CI homes, `--force` only in write mode, `--output-format json` for structured parsing. Auth via `CURSOR_API_KEY` (+34 lines)
  - New file `harness-adapter/adapters/hermes.sh`: Hermes Agent adapter using `hermes -z` with `--usage-file` for full token accounting. Auth via `HERMES_AUTH` (base64 tar of `~/.hermes/auth.json`) or OpenRouter fallback (+29 lines)
  - Modified `harness-adapter/harnesses.json`: Added cursor and hermes entries with full capability manifests. Count updated 7→9 (GLM moved to gateway, not counted as adapter) (+54/-2 lines)
  - Modified `scripts/install-harness.sh`: Install recipes for cursor (curl installer + `CURSOR_API_KEY`) and hermes (curl installer + `HERMES_AUTH` archive restore or OpenRouter fallback) (+19 lines)
  - Modified `docs/harnesses.md`: Updated all counts from 7→9/10, added auth rows for cursor and hermes, documented `--trust` vs `--force` distinction (+11/-10 lines)
  - Modified `apps/mcp-server/src/skill-executor.ts`: `HARNESSES` array extended with `cursor` and `hermes`

  **MCP server async rewrite:**
  - Modified `apps/mcp-server/src/skill-executor.ts`: Replaced `spawnSync` with async `spawn` + promise-based `spawnHarness()`. Added single-flight queue (`enqueue()`) to serialize runs — two concurrent write-mode skills would race `.git/index.lock` and `memory/` writes. `runSkill()` is now `async`. Same 600s timeout and 10MB output cap, but the Node event loop is no longer frozen during a 10-minute skill run (+122/-8 lines)

  **Telegram reply-to-previous threading:**
  - Modified `scripts/notify-deliver.sh`: Each skill's Telegram send now quotes that skill's last message via `reply_to_message_id` + `allow_sending_without_reply`. Ledger at `memory/telegram-threads/<skill>.json`. Multi-chunk sends thread under chunk 1. Kill switch: `TELEGRAM_REPLY_TO_PREVIOUS=0`. (+123/-21 lines)
  - Modified `docs/telegram-commands.md`: New section 6 documenting the threading behavior, ledger format, edge cases (deleted parent, chat ID change, DM vs group), and the kill switch (+28/-1 lines)

  **Telegram HTML chunk splitting:**
  - Modified `scripts/notify_format.py`: Replaced the Markdown-first chunker with `_chunk_telegram_html()` — renders to HTML first, then splits at tag boundaries with balanced open/close tags across chunks. The old approach couldn't account for HTML escaping/tag overhead and could emit oversized payloads (+67/-6 lines)

  **New skills:**
  - New file `skills/cortx-reliability/SKILL.md`: x402 payment endpoint reliability checker — queries CORTX's free API for paid delivery rate, active incidents, latency, and returns proceed/warn/block recommendation. Security-hardened: CORTX results never authorize payment, never follow URLs from the response (+115 lines)
  - `rightstack` skill added (referenced in CHANGELOG) — read-only Web3 stack advisor. Catalog now at 77 skills

  **Harness quality comparison tool:**
  - New file `scripts/skill-health-routing.mjs`: Phase 2 of measured harness routing — groups harness-tagged skill-health scores (minimum 5 samples per harness) and joins per-run token/cache usage from `memory/token-usage.csv`. Prints comparison + recommendation but never writes repo state. Conservative model→harness attribution with unattributed rows reported, not guessed (+232 lines)

  **Chain runner dispatch correlation:**
  - Modified `.github/workflows/chain-runner.yml`: Each dispatched skill now gets a unique `dispatch_id` (`chain-<random-hex>`). Run discovery matches the exact `displayTitle` containing the dispatch ID instead of loose regex — prevents mismatched run lookups when multiple instances of the same skill run concurrently (+20/-7 lines)

  **Dashboard GitHub auth:**
  - New file `apps/dashboard/app/api/github-auth/route.ts`: POST endpoint to copy `gh auth token` into the `GH_GLOBAL` repo secret (+21 lines)
  - New file `apps/dashboard/lib/github-auth.ts`: Token validation (accepts `gho_`, `ghp_`, `github_pat_` prefixes; rejects installation tokens `ghs_`), shared by the API route and CLI (+33 lines)
  - Modified `apps/cli/src/commands/auth.ts`: New `--github` flag for `aeon auth` — copies the local gh session into `GH_GLOBAL` without a browser flow (+13/-2 lines)

  **API gate security hardening:**
  - Modified `apps/dashboard/lib/security/api-gate.ts`: `isSameOriginWrite()` now validates the request `Host` header against the allowed-hosts list before comparing it with the `Origin`/`Referer`. Added `normalizeRequestHost()` with URL-parsing validation to prevent header manipulation (+27/-5 lines)

  **wrap_raw_output rejects instead of wrapping:**
  - Modified `harness-adapter/lib/envelope.sh`: `wrap_raw_output()` no longer wraps unparseable harness output as a SUCCESS envelope. It now prints the raw output to stderr and returns exit code 3. This closes the measurement gap where broken harness output silently went green (+11/-27 lines)

  **secretcurl x.ai retry:**
  - Modified `scripts/secretcurl.sh`: Built-in 3-attempt retry loop for `https://api.x.ai/v1/responses` — handles timeouts, HTTP 429/5xx, and empty-body 200s with exponential backoff. Other authenticated requests remain a transparent curl passthrough (+89/-1 lines)

  **deploy-uni-hook: Labs routing + fleet audit rules:**
  - Modified `skills/deploy-uni-hook/SKILL.md`: New "Labs routing" section documenting which hook flag sets are auto-routable vs allowlist-required. New "Fleet audit rules" section codifying standing defects measured on the live fleet (fee sign guards, custody patterns, gate anti-patterns, test requirements). Freeform hooks must not recreate these. Dry-run output now includes the `routing` classification (+50/-4 lines)
  - Modified `skills/deploy-uni-hook/templates/`: Minor hardening across template Solidity files

  **skill-health/skill-repair lifecycle hardening:**
  - Modified `skills/skill-health/SKILL.md`: New `fix-pending` status lifecycle — `skill-repair` sets `fix-pending` with a `fix_pr`; `skill-health` reconciles by checking the PR's real merge state via `gh pr view`. Merged → resolved. Closed unmerged → reopened. A lucky HEALTHY classification no longer closes a repair that hasn't shipped (+16/-7 lines)
  - Modified `skills/skill-repair/SKILL.md`: PRs now set `status: fix-pending` instead of `resolved` — an open PR is not a fix (+5/-3 lines)

  **Other notable changes:**
  - New file `scripts/tests/test_chain_runner.sh`: Chain runner regression tests (+108 lines)
  - New file `scripts/tests/test_cursor_adapter.sh`: Cursor adapter tests (+43 lines)
  - New file `scripts/tests/test_hermes_adapter.sh`: Hermes adapter tests (+48 lines)
  - New file `scripts/tests/test_secretcurl_xai_retry.sh`: x.ai retry tests (+38 lines)
  - New file `scripts/tests/test_skill_health_routing.sh`: Health routing comparison tests (+44 lines)
  - New file `scripts/tests/test_workflow_harness_choices.sh`: Workflow harness resolution tests (+18 lines)
  - Modified `CHANGELOG.md`: 67 lines of changelog entries covering all changes above
  - Three community skill packs listed: CultOS (exact-commit PR review), Farcaster (Neynar-backed cast publish), Spoolis Outcome Gate
  - First repo lint gates: eslint (per app) and shellcheck (whole shell surface)
  - `bin/add-skill` provenance fix: skills.lock now records the real source commit instead of "unknown"

**Impact:** This sync brings the harness fleet to its 10th generation — Aeon can now dispatch skills to Claude, Grok, Codex, Pi, Vibe, Kimi, fx, Cursor, Hermes, and GLM (via gateway). The MCP server rewrite unblocks concurrent tool requests during long skill runs. Telegram threading means daily digests from the same skill stack under each other instead of flooding the chat as siblings. The `wrap_raw_output` fix closes a silent-failure path where broken harness output was published as successful. The deploy-uni-hook fleet audit rules codify real defects observed on the live fleet — future freeform hooks must not recreate them.

---

### GLM Reasoning Effort Pin
**Summary:** The GLM gateway arm now pins reasoning effort to `high` by default, with a `GLM_REASONING_EFFORT` repo variable override.

**Commits:**
- `6e318b0` — llm-gateway(glm): pin reasoning effort to high (var-overridable)
  - Modified `scripts/llm-gateway.sh`: Added `CLAUDE_CODE_EFFORT_LEVEL="${GLM_REASONING_EFFORT:-high}"` and `CLAUDE_CODE_ALWAYS_ENABLE_EFFORT=1` to the GLM provider arm. Verified on api.z.ai: low produces ~2.4k think chars, high ~15.3k, max ~32.7k. Without the pin, the endpoint leaves depth model-decided (+9 lines)

**Impact:** Skills running through the GLM gateway now get consistent reasoning depth. The `ALWAYS_ENABLE_EFFORT` flag is needed because Claude Code only sends effort for model IDs it recognizes — GLM model IDs (`glm-5.2`, `glm-5.3`) would otherwise skip the parameter entirely. Operators can tune per-repo with `GLM_REASONING_EFFORT=low|high|max`.

---

### Holdings Snapshot
**Summary:** Daily holdings snapshot logged. Fifth consecutive accumulating snapshot.

**Commits:**
- `bbf0f4e` — holdings: 2026-08-31 snapshot — 11.78B (11.78%), 7d +507.7M
  - Modified `memory/MEMORY.md`: Updated holdings line — 11.78% of supply (11.78B tokens), up from 11.28% on Aug 24. Five straight accumulating snapshots: 10.72B → 11.09B → 11.13B → 11.15B → 11.28B → 11.78B (+1/-1 lines)
  - Modified `memory/logs/2026-08-31.md`: Appended holdings log entry with state, sources, and backfill note (+6 lines)
  - New file `output/articles/holdings-2026-08-31.md`: Holdings article with per-wallet breakdown (mish-safe: 11.73B, mish-deployer: 53.9M) and 7d/30d deltas (+22 lines)

**Impact:** The accumulation trend continues — +507.7M tokens in 7 days (+4.50%), +1.06B in ~30 days (+9.90%). No dollar value tracked; this is purely token-balance movement.

---

## aaronjmars/MiroShark

No new commits in the last 24 hours.

---

## Automation Summary
44 automation commits filtered from miroshark-aeon:
- 12x `chore(scheduler): update cron state`
- 4x `chore(cron): * success` (token-movers ×2, aeon-update, fetch-tweets)
- 5x `chore(cron): * failed` (heartbeat ×2, token-movers, aeon-update, fetch-tweets ×3, repo-pulse, shiplog) — failure rate still elevated from GLM gateway transition
- 3x `chore(cron): * success` (repo-pulse, changelog, holdings, heartbeat)
- 4x `chore(*): auto-commit` (repo-pulse ×2, token-movers ×2, fetch-tweets, aeon-update, shiplog, heartbeat, changelog, holdings)

---

## Developer Notes
- **New dependencies:** None added to package.json; `confbox` appeared in yesterday's vue-router bump
- **Breaking changes:** `runSkill()` in `apps/mcp-server/src/skill-executor.ts` is now async — any callers must `await` it. `wrap_raw_output()` now returns exit 3 instead of wrapping as SUCCESS — adapters relying on the old always-green behavior will see failures surface
- **Architecture shifts:** The MCP server's single-flight queue serializes all skill runs — a second `tools/call` waits rather than racing the working tree. This is the correct behavior but means MCP clients can no longer fire-and-forget concurrent skill calls. The harness fleet hitting 10 CLIs means `HARNESSES` arrays in several files grew — keep in sync with `scripts/resolve-harness.sh`
- **Tech debt:** The Telegram threading ledger (`memory/telegram-threads/*.json`) adds per-skill state files that need periodic cleanup if skills are renamed or removed. The `skill-health-routing.mjs` comparison tool is read-only (Phase 2) — Phase 3 would be auto-switching harness in `aeon.yml`, which is not yet implemented

## What's Next
- The `aeon auth --github` flow and dashboard API now exist — GH_GLOBAL can be set with a single command, which would unblock the 40+ queued feature PRs
- GLM reasoning effort is pinned but per-tier model vars (`GLM_MODEL_OPUS/SONNET/HAIKU`) may need tuning based on skill quality scores once enough harness-tagged health data accumulates
- The skill-health routing comparison tool is ready to use — once 5+ runs per harness exist, it can recommend switches
- The fix-pending lifecycle means skill-repair PRs are now tracked through to merge/close — existing `status: open` issues in `memory/issues/` are unaffected until the next skill-health run
- MiroShark remains quiet — no commits today, GH_GLOBAL still blocking feature PRs
