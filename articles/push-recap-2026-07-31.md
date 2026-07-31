# Push Recap — 2026-07-31

## Overview
12 substantive commits by 2 authors (14 automation commits filtered). Today was a high-velocity day spanning both repos — a community contributor's Atlas Cloud provider preset landed in MiroShark, the agent platform gained a new holdings tracking skill and a Telegram security fix, and the entire model stack migrated to Claude 5.

**Stats:** 26 files changed, +1,040/-174 lines across 12 substantive commits

---

## aaronjmars/MiroShark

### New Feature: Atlas Cloud Provider Preset
**Summary:** A community-contributed provider preset (#259 by nb213/binyangzhu000-sudo) adds Atlas Cloud as a first-class OpenAI-compatible backend. The PR went through four commit rounds addressing review feedback — notably fixing a key-leak bug where switching providers with a blank key field carried the old provider's API key as bearer token to the new endpoint.

**Commits:**
- `f3fb0ec` — feat(settings): add Atlas Cloud provider preset (#259)
  - Modified `backend/app/api/settings.py`: Added `atlascloud` preset with DeepSeek V4 Pro (base/smart), Qwen 3.5 Flash (NER), DeepSeek V4 Flash (Wonderwall); added WONDERWALL_BASE_URL/API_KEY to `cheap` and `local` presets; refactored `_apply_preset` to snapshot prior base URLs and clear stale keys when a slot's provider changes with blank key input; added `needs_api_key` and `note` fields to preset list endpoint (+58/-5 lines)
  - New file `backend/tests/test_unit_settings_presets.py`: 153-line test suite covering Atlas Cloud configuration, key clearing on provider switch, stale key leak prevention, and same-provider re-apply key retention (+153 lines)
  - Modified `frontend/src/components/SettingsPanel.vue`: Generalized "OpenRouter API key" label to "Provider API key"; added preset note display; extracted `syncFormFromSettings()` helper to eliminate duplicated form-sync logic; made `presetNeedsKey` dynamic from backend metadata instead of hardcoded; fixed `saveSettings` to not send stale form values alongside a preset selection (+60/-59 lines)
  - Modified `.env.example`: Added Atlas Cloud configuration block with model recommendations (+22 lines)
  - Modified `backend/openapi.yaml`: Added `atlascloud` to preset enum (+1/-1)
  - Modified `frontend/src/api/settings.js`: Updated preset documentation (+1/-1)

**Impact:** Atlas Cloud is now a one-click provider option alongside OpenRouter and local Ollama. The key-leak fix (`_apply_preset` stale-key clearing) is a security improvement that applies to all provider switches, not just Atlas. This is the first merged community feature contribution beyond bug fixes — PR #259 was open for 4 days.

### CI Fix: MCP 2.0 Compatibility Pin
**Summary:** The camel-ai smoke test broke on main because `pip install -r requirements.txt` (which doesn't honor uv.lock) pulled mcp 2.0.0, released July 28. MCP 2.0 relocated FastMCP, breaking camel-ai 0.2.90's import path.

**Commits:**
- `fdb8809` — fix(deps): pin mcp<2.0.0 so the camel smoke test passes (#263)
  - Modified `backend/requirements.txt`: Added `mcp>=1.3.0,<2.0.0` version constraint to match uv.lock's 1.28.1 resolution (+4 lines)

**Impact:** Unblocks CI on main. The pin is conservative — locks to the 1.x range that camel-ai 0.2.90 was tested against, matching what uv.lock already resolves.

---

## aaronjmars/miroshark-aeon

### New Feature: Holdings Skill
**Summary:** A new skill tracks wallet holdings of the instance's token on-chain — amount held, percentage of total supply, and 7d/30d amount growth (measured in tokens, not dollars). Uses keyless public RPC for balances and GeckoTerminal for total supply. The skill went through a rapid three-commit evolution: initial build with dual-token + dollar values, then scoped to instance-only token with dollar reporting removed, then schedule moved from daily to weekly.

**Commits:**
- `6d646fe` — feat(holdings): add holdings skill - wallet balances of aeon/MiroShark via public RPC
  - New file `skills/holdings/SKILL.md`: 216-line skill definition with 5-step pipeline — fetch balances, compute growth from prior snapshots, compile article, log state, notify (+216 lines)
  - New file `skills/holdings/holdings.py`: 218-line Python stdlib-only balance checker — ERC-20 `balanceOf` via JSON-RPC, SPL token accounts for Solana, GeckoTerminal price/supply lookup, exponential backoff with Retry-After honor, browser UA for public RPC compatibility (+218 lines)
  - New file `memory/holdings.json`: Wallet + token configuration for 4 wallets (aeon-safe, aeon-deployer, mish-safe, mish-deployer) and 2 tokens (aeon, MiroShark) (+12 lines)
  - Modified `aeon.yml`: Added holdings skill at daily 08:00 UTC (+1 line)

- `6ab5771` — refactor(holdings): scope to instance token, drop dollar value
  - Modified `memory/holdings.json`: Removed aeon wallets and token — each instance now tracks only its own token (MiroShark on this instance) (-3 lines)
  - Modified `skills/holdings/SKILL.md`: Removed all USD/price reporting; reframed as holdings tracker not portfolio-value report; scoped to instance's own token (+54/-52 lines)
  - Modified `skills/holdings/holdings.py`: Stripped `price_usd`, `usd`, and `grand_usd` fields from output (+8/-18 lines)

- `c227cea` — chore(catalog): regenerate skills.json + packs.json for holdings skill
  - Modified `catalog/packs.json` and `catalog/skills.json`: Added holdings to the catalog (+2/-2 lines)

- `29175c1` — chore(holdings): move schedule to weekly (Mon 08:00 UTC)
  - Modified `aeon.yml`: Changed holdings schedule from `"0 8 * * *"` (daily) to `"0 8 * * 1"` (weekly Monday) (+1/-1)
  - Modified `skills/holdings/SKILL.md`: Updated growth timeline references to reflect weekly cadence (+3/-2 lines)

**Impact:** The operator now gets a weekly snapshot of MiroShark holdings across 2 wallets — pure on-chain data, no price dependency. The skill builds its own history via `HOLDINGS_STATE:` log lines, so growth tracking improves over time. The daily-to-weekly pivot suggests the founder wants this as a low-frequency checkpoint, not a daily digest.

### Security: Telegram Group Access Control
**Summary:** A critical security fix ported from the upstream aeon repo (aeonfun/aeon PR #797). In group/public Telegram chats, any member could command the bot by tapping inline buttons (Run again, Schedule weekly) because the gate only checked `TELEGRAM_CHAT_ID`, which is shared across all group members. The fix adds user-level gating and auto-suppresses interactive elements when the Messages workflow is disabled.

**Commits:**
- `d4551fe` — fix(telegram): owner-user gate + auto-suppress buttons in public chats (#123)
  - Modified `scripts/notify.sh`: Added Messages workflow state resolution via GitHub API; suppress inline buttons and force_reply when workflow is disabled; new `AEON_MESSAGES_WF_STATE` override (+50/-3 lines)
  - Modified `.github/workflows/messages.yml`: Added `TELEGRAM_ALLOWED_USER_ID` to inbound gate; updated fallback model (+33/-3 lines)
  - Modified `apps/webhook/src/worker.js`: Added `from.id` check against `TELEGRAM_ALLOWED_USER_ID` in Cloudflare Worker route (+17/-3 lines)
  - Modified `scripts/tests/test_notify.sh`: Added 49 lines of test coverage for button suppression paths (+49/-0 lines)
  - Modified `docs/telegram-commands.md`: Updated docs for owner-user gate and group behavior (+49/-4 lines)
  - Modified 5 additional files: README, webhook config, dashboard secrets catalog, telegram-instant docs (+7/-2 lines)

- `f1d8f86` — fix(test): pin AEON_MESSAGES_WF_STATE=active on notify button attach tests
  - Modified `scripts/tests/test_notify.sh`: Added `AEON_MESSAGES_WF_STATE=active` to tests 7, 8, 12, 13, 14 so button-attach tests are hermetic regardless of this repo's messages.yml state (+8/-5 lines)

**Impact:** Closes a real attack surface — any member of a Telegram group could dispatch skills or schedule crons via posted notification buttons. The fix gates on `from.id` at both the poller and Cloudflare Worker layers. The auto-suppress behavior means notifications in groups still post but without actionable buttons a non-owner would see.

### Infrastructure: Claude 5 Model Migration
**Summary:** The entire model stack migrated from Claude Sonnet 4.6 / Opus 4.8 to Claude Sonnet 5 / Opus 5 across four commits touching every model reference point — the default config, the gateway script's provider remapping, and both workflow fallback paths.

**Commits:**
- `df65067` — chore: bump default model to claude-sonnet-5
  - Modified `aeon.yml`: Changed global default model and updated skill-level override comment (+2/-2 lines)

- `3572e79` — chore: bump stale gateway remap / workflow fallback model ids to sonnet-5/opus-5
  - Modified `scripts/llm-gateway.sh`: Updated OpenRouter default opus/sonnet slugs, Surplus Intelligence fallback, and Venice model whitelist (+5/-5 lines)

- `764d459` — chore: bump stale gateway remap / workflow fallback model ids to sonnet-5/opus-5
  - Modified `.github/workflows/messages.yml`: Updated inbound messaging fallback model (+1/-1 line)

- `b6a4d32` — chore: bump stale gateway remap / workflow fallback model ids to sonnet-5/opus-5
  - Modified `.github/workflows/aeon.yml`: Updated skill execution fallback model (+1/-1 line)

**Impact:** All skill runs and inbound messaging now default to Claude Sonnet 5. Gateway providers (OpenRouter, Surplus, Venice) also map to 5.x models. The migration was split across four commits touching four distinct files — likely to isolate blast radius.

---

## Developer Notes
- **New dependencies:** `mcp>=1.3.0,<2.0.0` pinned in MiroShark requirements.txt
- **Breaking changes:** None — Atlas Cloud is additive; holdings is a new skill; model bump is backward-compatible
- **Architecture shifts:** Holdings introduces a self-historying pattern: the skill writes `HOLDINGS_STATE:` lines to its own logs and reads them back for delta computation, building its own time series without an external database. The `_apply_preset` refactor in settings.py adds provider-aware key clearing — a security pattern that prevents credential leaks on preset switches.
- **Tech debt:** The three model-bump commits (`3572e79`, `764d459`, `b6a4d32`) share the same commit message but touch different files — suggests a manual multi-file edit that could have been a single commit.

## What's Next
- Holdings skill runs weekly Monday — first run will establish the baseline snapshot; 7d growth appears on the second run (~Aug 11)
- Atlas Cloud preset is live but untested in production — operator needs to enter an Atlas Cloud API key to activate
- The Telegram security fix adds `TELEGRAM_ALLOWED_USER_ID` — operator should set this if the bot runs in any group chat
- MiroShark had 2 substantive commits vs miroshark-aeon's 10 — the agent platform continues to see more infrastructure work than the product repo
- PR #259 merged after 4 days — first community feature contribution to clear review
