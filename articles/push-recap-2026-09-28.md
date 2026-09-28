# Push Recap — 2026-09-28

## Overview
1 substantive commit by 2 authors across aaronjmars/miroshark-aeon (26 automation commits filtered). MiroShark had no activity. The day's work was a single large upstream sync — PR #183 pulling 13 commits from aeonfun/aeon — that landed a new LLM provider gateway (HivemindOS), a new skill for Circle Arc Studio testnet turns, a deterministic expiration filter for bounty hunting, and a fresh community pack listing.

**Stats:** 45 files changed, +1,821/-253 lines across 1 substantive commit

---

## aaronjmars/miroshark-aeon

### Upstream Sync: 13 Commits from aeonfun/aeon (PR #183)
**Summary:** A bulk upstream sync merged 13 commits from the canonical Aeon repo. 42 files applied cleanly (33 updated, 6 added, 3 auto-merged 3-way), with 7 flagged for manual review. The eyebrow security lock was refreshed in a follow-up commit within the same PR to approve the new network capabilities.

**Commits:**
- `3426f04` — aeon-update: sync 13 upstream commits (ba01e9f..531f575) (#183)

  The changes break into five distinct areas:

---

### Theme 1: HivemindOS Credit-Token Gateway
**Summary:** A tenth LLM provider gateway was added, letting Aeon instances run Claude Code against a HivemindOS credit balance instead of a provider API key. The gateway runs as a claude-code-router sidecar (same architecture as Venice and Surplus), with a custom transformer that solves four concrete problems the endpoint presents.

**Key changes:**
- New file `scripts/ccr-hivemindos.js` (+188 lines): A CCR transformer class that handles idempotency (adds a `Idempotency-Key` UUID header per request — the endpoint refuses paid requests without one), SSE replay (converts the endpoint's non-streamed JSON response into the SSE frames Claude Code expects), max-token capping (defaults to 4096 to avoid the endpoint holding 32k worth of credits per in-flight call), prompt caching (marks the system prompt with `cache_control: { type: 'ephemeral' }` for providers that support it), and conversation trimming (trims oldest tool outputs when the body exceeds the endpoint's size limit)
- Changed `scripts/llm-gateway.sh` (+51/-4 lines): Added `hivemindos` as a sidecar routing arm. The `auto` cascade resolves it last (`claude → anthropic → openrouter → bankr → usepod → venice → surplus → grok → glm → hivemindos`). Native `claude-*`/`grok-*` model IDs fall back to `inclusionai/ling-3.0-flash` since the endpoint uses its own catalog. Added `AEON_GATEWAY_DRY_RUN` env var for test-time sidecar route verification without starting CCR
- Changed `.github/workflows/aeon.yml` (+46/-1 lines): Wired `HIVEMINDOS_CREDIT_TOKEN` secret and four tunables (`HIVEMINDOS_BASE_URL`, `HIVEMINDOS_MODEL`, `HIVEMINDOS_REASONING`, `HIVEMINDOS_MAX_TOKENS`) into all three workflow jobs (main skill runner, chain runner, message handler). Added `HIVEMINDOS_CREDIT_TOKEN` to the secret-check exclusion list so the preflight doesn't block runs that use it
- Changed `scripts/tests/test_llm_gateway.sh` (+60/-2 lines): Added dry-run routing tests for the hivemindos arm

**Impact:** Aeon instances can now run on a HivemindOS credit balance — no Anthropic API key, no Claude subscription, no OpenRouter account needed. At measured rates (2026-09-21), a cached agent turn through this arm costs 0.00003 USD vs 0.0017 USD on a non-caching model, making it the cheapest path in the gateway cascade. The `HIVEMINDOS_MAX_TOKENS` fix also corrects a bug where empty GitHub repo variables silently disabled the completion cap, causing each call to hold ~$0.32 in credits.

---

### Theme 2: Arc Studio Skill (Circle Arc Testnet)
**Summary:** A new `arc-studio` skill was added to drive Circle Arc Studio testnet turns from a headless GitHub Actions runner. It can start a turn detached, poll for completion on later runs, respond to `needs_input` prompts, and notify on finish. The skill is disabled by default and requires `ARC_STUDIO_TOKEN`.

**Key changes:**
- New file `scripts/arc-studio-state.mjs` (+299 lines): Durable session state manager that persists to `memory/arc-studio.json` (committed, survives runner restarts) and can restore the runner-local `~/.arc-studio/sessions.json`. Validates all inputs (IDs, addresses, TX hashes, URLs) with strict regex. Supports `show`, `restore`, `set`, `clear` subcommands
- New file `scripts/arc-studio-turn.mjs` (+364 lines): One-shot turn driver that the model runs and then stops. Handles the full lifecycle: scratch directory creation, CLI invocation with timeout, JSON output parsing (handles both compact JSONL and pretty-printed multi-line JSON), state persistence. Includes `PREAMBLE` safety constraints ("Arc testnet only. Do not deploy to mainnet. Do not ask for a secret, a seed phrase, or a private key")
- Changed `.github/workflows/aeon.yml` (+30 lines): Added Arc Studio CLI caching (pinned to `@circle-fin/arc-studio-cli@1.1.3`) with a dedicated cache prefix to avoid conflicts with the existing npm cache. Installs on cache miss, verifies the binary runs, and adds to `$GITHUB_PATH`
- Changed `catalog/skill-packs.json` (+18 lines): Catalog grows from 83 to 84 skills

**Impact:** Aeon can now participate in Circle Arc Studio testnet turns autonomously. The read-only tier means no mainnet risk. The state machine design (start → poll → input → complete) fits the ephemeral-runner model — each GitHub Actions run picks up where the last left off via the committed state file.

---

### Theme 3: Hunter-22 Expiration Hard Gate
**Summary:** The bounty-hunting skill now pipes all match responses through a deterministic expiration filter before the model sees them, preventing the agent from triaging or reporting expired bounties.

**Key changes:**
- New file `scripts/hunter-22-filter.mjs` (+87 lines): A stdin filter that reads the match API response, validates every candidate (requires string `id`, rejects non-object entries), checks `expiresAt` against `Date.now()` (or a `--now` test override), and outputs a filtered response with a `gate` object containing `inputCount`, `keptCount`, `rejectedCount`, the `rejected` list (with reason: `expired` or `invalid-expiration`), and a `seen` list of all input candidates (for dedup even after rejection)
- Changed `skills/hunter-22/SKILL.md` (+17/-10 lines): The curl command now pipes directly into `node scripts/hunter-22-filter.mjs`. Raw response inspection is removed — the model only sees gate output. Steps renumbered (8 steps → 8 steps but with different numbering). The dedup update in step 6 now reads from `gate.seen` instead of the raw response, ensuring rejected candidates still enter the dedup window
- Changed `eyebrowlock.json` (+16/-12 lines): Approved `clawhunter.fun` as a network capability for hunter-22 (previously had empty capabilities). Refreshed content hashes for hunter-22, pack-submit, and the aeon meta-skill
- New file `scripts/tests/test_hunter_22_filter.sh` (+48 lines): Test suite for the filter

**Impact:** Eliminates a class of false positives where expired bounties appeared in notifications. The gate runs before the model, so there's no chance of the agent spending context or notification budget on dead listings. Malformed expiration dates also fail closed instead of being passed through.

---

### Theme 4: Community Pack Ecosystem Updates
**Summary:** A new community pack was listed, the pack-submit skill was updated to target the correct registry file, and pack installers gained schedule normalization.

**Key changes:**
- Changed `catalog/skill-packs.json` (+18 lines): Added `richard7463/aeon-skill-pack-claim-audit` — a meta-skill that audits whether an instance's own notification claims are true against their sources. Category: dev, trust: community, capabilities: external_api + sends_notifications
- Changed `skills/pack-submit/SKILL.md` (+12/-14 lines): Registry surface moved from `.github/README.md` Community Packs section to `docs/community-skill-packs.md` Listed Packs section (reflecting upstream move in PR #845). Counter-bump logic removed (the new table doesn't have one). All references, Python insertion code, and guardrails updated
- Changed `scripts/validate-skill-packs.mjs` (+39/-39 lines): Parity validator now reads from `docs/community-skill-packs.md` (new `--table` flag, `--readme` kept as alias). Missing table is now a hard failure instead of a silent warning
- Changed `scripts/lib/skill-install.sh` (+42/-1 lines): Pack installers normalize human-readable schedule strings (`daily`, `weekly`, `@daily`, etc.) to 5-field cron expressions. Falls back to `0 12 * * *` for unrecognized formats with a warning
- Changed `scripts/tests/test_validate_pack.sh` (+53/-2 lines): Tests for schedule normalization
- Changed `scripts/tests/test_validate_skill_packs.sh` (+41/-25 lines): Updated for new table location
- Changed `scripts/tests/test_community_skill_install.sh` (+46 lines): Tests for schedule normalization in community installs

**Impact:** The Claim Audit pack gives any Aeon instance a truth-checking layer over its own outputs — a self-skepticism skill. Pack submission now targets the correct file after the upstream table migration. Schedule normalization prevents a class of "installed but never ran" bugs for community packs that use human-readable schedules.

---

### Theme 5: Documentation & Infrastructure
**Summary:** Reference docs, the CHANGELOG, and the aeon meta-skill were updated to reflect the new capabilities.

**Key changes:**
- Changed `.claude/skills/aeon/SKILL.md` (+7/-6 lines): Provider count updated 9 → 10 (HivemindOS added). Skill procedure stat updated "44 of 82 skills" → "52 of 84 skills"
- Changed `CHANGELOG.md` (+54 lines): Documented all additions (create-prove, arc-studio, HivemindOS, dev-loop ship command, idea-pipeline offer entry, Claim Audit pack), changes (schedule normalization, parity validator), and fixes (HIVEMINDOS_MAX_TOKENS default, hunter-22 expiration)
- Changed `docs/harnesses.md` (+7/-6 lines): Updated provider count and harness documentation
- Changed `docs/CONFIGURATION.md` (+5/-4 lines): Updated configuration references
- Changed `docs/ECOSYSTEM.md` (+3/-4 lines): Updated ecosystem documentation
- Changed `docs/community-skill-packs.md` (+15/-13 lines): Updated table and references
- Changed `docs/ADK.md` (+1/-1 line): Minor reference update
- Mirror changes in `plugin/skills/aeon/` (+43/-31 lines): Plugin copy of the aeon skill kept in sync

**Impact:** Documentation stays current with the codebase. The CHANGELOG entries are detailed enough to serve as release notes.

---

## Developer Notes
- **New dependencies:** `@circle-fin/arc-studio-cli@1.1.3` (cached, installed only for arc-studio skill runs), `@musistudio/claude-code-router@2.0.0` (existing, now also used by hivemindos sidecar)
- **Breaking changes:** Pack submission PRs now target `docs/community-skill-packs.md` instead of `.github/README.md` — any in-flight pack-submit runs will need to target the new location
- **Architecture shifts:** HivemindOS is the first credit-billed gateway (vs API-key-billed), introducing idempotency and credit-hold management patterns. The hunter-22 filter is the first pre-model deterministic gate in the skill pipeline — the pattern could extend to other discovery skills
- **Tech debt:** 7 files from the upstream sync flagged for manual review (not detailed in the PR)

## What's Next
- Set `HIVEMINDOS_CREDIT_TOKEN` secret to activate the tenth gateway provider
- Set `ARC_STUDIO_TOKEN` to enable the arc-studio skill (currently disabled by default)
- The 7 manually-flagged files from the upstream sync may need attention
- PR #63 (self-improve: memory-flush deadline detection fix) is open and pending merge
