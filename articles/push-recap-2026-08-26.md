# Push Recap — 2026-08-26

## Overview
3 substantive commits by 1 author (aaronjmars) across miroshark-aeon — 16 automation commits filtered. Today's work was a security-first infrastructure day: notification delivery was architecturally separated from skill execution so running skills can never read channel credentials, a shellcheck lint gate was added to CI, and the repo synced 25 upstream commits from the canon, bringing in two new skills, a 7th agent harness, and a batch of dashboard race-condition fixes.

**Stats:** 80 files changed, +1,602/-705 lines across 3 substantive commits

---

## aaronjmars/MiroShark

No commits in the last 24 hours.

---

## aaronjmars/miroshark-aeon

### Security Hardening: Notify Credential Boundary + Dead Token Cleanup

**Summary:** The notification system was architecturally split into a queue-writer and a post-run dispatcher, so skills can request notifications but never see the tokens that send them. Six dead infrastructure credentials were removed from the runtime environment, and a shellcheck lint gate was added to CI.

**Commits:**
- `8bb4f03` — security: fleet-hardening backport (notify boundary, dead-token cut, lint) (#149)
  - Rewrote `scripts/notify.sh` (+58/-210 lines): Stripped all channel delivery logic (Telegram, Discord, Slack, Buzz, Email). The script is now a pure queue-writer — it validates, deduplicates, computes `reply_markup`, and writes a single structured JSON payload to `$PENDING_DIR/notify-queue/`. No channel token is ever read during a skill run.
  - New `scripts/notify-deliver.sh` (+205 lines): Post-run dispatcher that reads queued JSON payloads and delivers per channel (Telegram HTML + reply_markup with plaintext fallback, Discord embeds, Slack Block Kit, Buzz signed Nostr, Email via Resend). Includes idempotency via hash dedup, per-send audit records, and independent channel failure handling (one channel failing doesn't drop others).
  - Changed `.github/workflows/aeon.yml` (+41/-88 lines): Removed 11 channel credential env vars (`TELEGRAM_BOT_TOKEN`, `TELEGRAM_CHAT_ID`, `DISCORD_BOT_TOKEN`, `DISCORD_CHANNEL_ID`, `DISCORD_WEBHOOK_URL`, `SLACK_BOT_TOKEN`, `SLACK_CHANNEL_ID`, `SLACK_WEBHOOK_URL`, `BUZZ_*`, `NOTIFY_EMAIL_TO`) from the skill run step. Moved them to the "Send pending notifications" post-run step, whose `if:` condition changed from `success()` to `!cancelled()` so failed skills still deliver queued notifications. `ALL_SECRETS` blob shrank from 51 to 40 keys.
  - New `scripts/lint-shell.sh` (+75 lines): Shellcheck gate that collects all git-tracked shell files (`.sh` extension + shebang-detected), runs an advisory pass at warning severity (non-blocking backlog), and fails only on error-severity findings. Ratchet floor is `error`; tighten to `warning` once advisory backlog burns down.
  - New `.github/workflows/ci-shellcheck.yml` (+52 lines): CI workflow that runs `lint-shell.sh` on pull requests touching shell files.
  - Added `# shellcheck shell=bash` directives to 8 sourced library files in `harness-adapter/lib/` and `scripts/lib/` that carry no shebang by design.
  - Removed 6 tracked xAI scratch files (`.aeon-tmp/xai-*.json`, `.tmp-xai-*.json`, `xai-*.json`) — runtime artifacts that leaked into the repo via prior auto-commits.
  - Updated `.gitignore` (+8 lines): Root-anchored rules for `/.aeon-tmp/`, `/xai-*.json`, `/.xai-*.json`, `/.tmp-xai-*.json` to prevent re-commit.
  - Rewrote `scripts/tests/test_notify.sh` (+151/-193 lines): Tests updated to validate the queue-writer + delivery split — assertions now check JSON payload structure instead of inline curl behavior.
  - New `scripts/audit.sh` (+4 lines): Structured audit logger used by notify-deliver for per-send audit records.

- `ee8f481` — feat(secrets,ci): add AI_GATEWAY_API_KEY + VERCEL_OIDC_TOKEN to allowlist + concurrency var-suffix (#150)
  - Changed `.github/workflows/aeon.yml` (+2/-2 lines): Added `AI_GATEWAY_API_KEY` and `VERCEL_OIDC_TOKEN` to the `ALL_SECRETS` JSON blob, enabling the new `fx` (Vercel) harness to receive its credentials. Also appended `inputs.var` suffix to the concurrency group name, so two dispatches of the same skill with different targets (e.g. `push-recap` for different repos) run concurrently instead of serializing on a shared group.

**Impact:** This is a meaningful security architecture change. Previously, every skill had ambient access to all notification channel credentials — a prompt injection or malicious fetched content could theoretically exfiltrate them. Now the credential boundary is enforced at the process level: skills write a message to a queue, and a separate post-run step reads the credentials and sends. The `!cancelled()` gate also fixes a reliability issue where failed skills silently dropped their queued notifications. The shellcheck gate catches shell-script errors before they reach production.

---

### Upstream Canon Sync: 25 Commits from aeonfun/aeon

**Summary:** The aeon-update bot synced 25 upstream commits from the canon repo (aeonfun/aeon), bringing the fork baseline forward from `b7a909a` to `8b8d719`. The sync adds two new skills, a 7th agent harness, dashboard race-condition fixes, and a batch of security/reliability improvements.

**Commits:**
- `a79af4d` — aeon-update: sync 25 upstream commits (b7a909a..8b8d719) (#151)
  - New `skills/skill-article/SKILL.md` (+106 lines): A new Basics-pack skill that turns any skill in the instance into a publish-ready launch article — proof-stat headline, contrarian thesis, mechanics, war stories mined from real `memory/logs/` run history, and the full SKILL.md embedded verbatim. Optional `--banner` renders a 16:9 title card via Higgsfield MCP. Catalog now at 76 skills.
  - New `skills/rightstack/SKILL.md` (+71 lines) + `skills/rightstack/run.mjs` (+64 lines): RightStack Web3 stack advisor integration — read-only skill that queries a pinned `rightstack@0.3.2` CLI for architecture recommendations, workflow inspection, tool comparisons, and package migration checks. Five operations: `recommend`, `workflow`, `compare`, `explain`, `migrate`.
  - Changed `apps/dashboard/lib/constants.ts` (+16/-6 lines): Added `fx` (Vercel) as the 7th harness in the `HARNESSES` array, with a note that fx has no model picker since it always runs on its own default model.
  - New `apps/dashboard/lib/github.ts` (+20 lines): Added `withFileLock()` — a per-path in-process mutex that serializes read-modify-write-commit sequences on `aeon.yml`. Five independent call sites (skills PATCH/DELETE, upload, gateway sync) were racing: two concurrent requests would read the same file, each patch one field, and whichever wrote last silently won the whole file.
  - New `apps/dashboard/lib/github.test.ts` (+102 lines): Test suite for `withFileLock` — verifies serialization on same path, no-op on different paths, race-condition prevention (concurrent model+harness patch), rejection propagation, and return value passthrough.
  - Changed `apps/dashboard/lib/gateway.ts` (+31/-27 lines): Wrapped `syncGatewayProvider()` and `syncHarness()` in `withFileLock('aeon.yml', ...)` to eliminate the race condition.
  - Changed `apps/dashboard/app/api/skills/route.ts` (+49/-45 lines) and `apps/dashboard/app/api/upload/route.ts` (+19/-16 lines): Wrapped in file locks; dashboard now auto-allowlists MCP secret names into generated workflows.
  - Changed `scripts/cron-due.sh` (+19/-4 lines): Added automatic GNU/BSD date detection via `DATE_FLAVOR` and a `format_epoch()` helper function, replacing hardcoded GNU `date -d` syntax. Now works on macOS without requiring `AEON_DATE=gdate`.
  - Changed `scripts/cron-due.sh` tests (+17/-3 lines): Additional test cases for the BSD-compatible date handling.
  - Changed `CHANGELOG.md` (+79 lines): Documented all upstream additions — `fx` harness, `skill-article` skill, dashboard file locking, notify dispatcher, dead-token removal, secretcurl argv leak fix, Telegram webhook dedup, concurrency group scoping, and more.
  - Changed `apps/dashboard/lib/types.ts` (+6/-3 lines): Added `fx` to the `Harness` type union.
  - Changed `apps/dashboard/lib/harness-auth.ts` (+7/-1 lines): fx harness auth support.
  - New `plugin/.minimax-plugin/plugin.json` (+19 lines), `plugin/plugin.json` (+15 lines), `plugin/icon.png`: Minimax plugin manifest and shared icon — the operator skill now installs on additional platforms.
  - New root `package.json` (+15 lines): Workspace package.json for monorepo tooling.
  - Changed `plugin/skills/aeon/scripts/mine-history.mjs` (+49/-15 lines): History mining improvements.
  - Updated `.claude/skills/aeon/SKILL.md` (+3/-3 lines), `.claude/skills/aeon/references/layout.md` (+1/-1 lines), `.claude/skills/aeon/references/mcp.md` (+2/-2 lines), `.claude/skills/aeon/references/skill-anatomy.md` (+3/-3 lines): Bumped skill count from 75 to 76, Basics pack from 17 to 18.
  - Updated 8 additional documentation, catalog, and config files with harness-count normalization (6→7), ecosystem additions, and minor corrections.
  - Changed `memory/topics/aeon-update-state.json` (+77/-9 lines): Updated sync state tracking with the 25 new commit records.

**Impact:** The fork is now current with upstream through commit `8b8d719`. The most impactful additions are the dashboard file-locking fix (eliminates a real race condition that could silently clobber config changes), the `fx` harness (Vercel's Zig coding-agent is now a first-class run target alongside Claude, Grok, Codex, Pi, Vibe, and Kimi), and the two new skills expanding the catalog to 76. The cron-due BSD compatibility fix means local development on macOS no longer requires workarounds.

---

## Developer Notes
- **New dependencies:** `foundry-rs/foundry-toolchain@908c5403` (from yesterday, SHA-pinned GitHub Action); no new npm packages today
- **Breaking changes:** Notification channel tokens are no longer available in the skill run environment — any skill that was directly reading `TELEGRAM_BOT_TOKEN` or similar (none should have been) will break. Use `./notify` exclusively.
- **Architecture shifts:** Notify split into queue-writer (`notify.sh`) + post-run dispatcher (`notify-deliver.sh`) is a permanent architectural change. The `ALL_SECRETS` blob shrank from 51 to 40 keys. `withFileLock()` introduces in-process mutex semantics to the dashboard's config editing paths.
- **Tech debt:** The old curl delivery code in `notify.sh` is fully removed (not dead code — actually deleted). The 6 tracked xAI scratch files are removed with .gitignore rules to prevent recurrence. The shellcheck advisory backlog (warning-severity) is visible in CI logs but not blocking — burn it down to tighten the gate.

## What's Next
- The `fx` (Vercel) harness is wired but needs `AI_GATEWAY_API_KEY` or `VERCEL_OIDC_TOKEN` set as a secret to actually run skills through it
- `skill-article` and `rightstack` skills are available but need to be enabled in the scheduler to start running
- The shellcheck advisory backlog should be burned down so the lint gate can be tightened from `error` to `warning` severity
- Self-improve PR #59 (pull latest main after merging stale PRs) is open and awaiting merge
- 82nd consecutive push block for MiroShark features — GH_GLOBAL still not set
