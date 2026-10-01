# Push Recap — 2026-10-01

## Overview
4 substantive commits by 2 authors (Aaron Elijah Mars, dependabot[bot]) across both watched repos, plus 13 automation commits filtered from miroshark-aeon. The day's headline is an ecosystem expansion: MiroShark's registry gained x402aff — the builder-code affiliation kit that powers MiroShark's on-chain affiliate splits. Backend dependencies caught up on four Python packages, and miroshark-aeon's LLM gateway switched from hard-pinned Claude to auto-routing.

**Stats:** 6 files changed, +36/-38 lines across 4 substantive commits

---

## aaronjmars/MiroShark

### Ecosystem Expansion: x402aff Onboarding
**Summary:** The x402aff builder-code affiliation kit — the open-source infrastructure behind MiroShark's x402 API affiliate splits — was added to both the human-readable ecosystem table and the programmatic catalog endpoint. This is the first "tool" category addition since Crucible Sim, expanding the category from a single entry to two.

**Commits:**
- `936a4bb` — Add x402aff to the ecosystem registry (#313)
  - Changed `ECOSYSTEM.md`: Added a new row to the ecosystem table with x402aff's icon, name, website (x402aff.xyz), GitHub repo (MiroShark/x402aff), and live claims dashboard link (+1 line)
  - Changed `backend/app/services/ecosystem_catalog.py`: Added a new catalog entry for x402aff under the "tool" category with description "Open-source builder-code affiliation kit behind MiroShark's x402 API: on-chain affiliate splits for any x402 seller." Also updated the module docstring to include x402aff in the tool category description (+10, -1 lines)
  - Changed `docs/FEATURES.md`: Updated the ecosystem documentation's "Five categories" bullet to include x402aff alongside Crucible Sim in the tool category (+1, -1 lines)
  - Changed `docs/FEATURES.zh-CN.md`: Same update in the Chinese translation — x402aff added to the tool category description (+1, -1 lines)

**Impact:** x402aff is now discoverable through both the Markdown ecosystem page (for humans) and the `GET /api/ecosystem.json` endpoint (for integrators). The drift-guard test in `test_unit_ecosystem_catalog.py` will cross-check the new entry against `ECOSYSTEM.md` to prevent silent desync. This is the 14th ecosystem entry.

### Backend Dependency Updates: Python Security & ML Stack
**Summary:** Two Dependabot PRs updated four Python packages in the backend's `uv.lock`. The most significant is sentence-transformers jumping three minor versions (5.3.0 → 5.6.0), which is the ML embedding library used for similarity search across simulations.

**Commits:**
- `8ddbd12` — chore: bump pyjwt in /backend (#314)
  - Changed `backend/uv.lock`: PyJWT 2.13.0 → 2.15.0 — JWT authentication library, two minor version jump (May → September release). Package grew from 31KB to 33KB wheel, suggesting new features or expanded algorithm support (+3, -3 lines)

- `6d60339` — chore: bump the uv group across 1 directory with 3 updates (#315)
  - Changed `backend/uv.lock`: Three dependency updates in a single grouped PR:
    - **sentence-transformers** 5.3.0 → 5.6.0 — HuggingFace's ML embedding library. Three minor versions (March → June release). Wheel grew from 512KB to 596KB (+16%), indicating substantial new functionality across the 5.4/5.5/5.6 releases.
    - **tornado** 6.5.8 → 6.5.9 — Async web framework, patch release (August → September). Source tarball grew from 520KB to 536KB.
    - **urllib3** 2.7.0 → 2.8.0 — HTTP client library, minor version bump (May → September). Wheel grew from 131KB to 135KB.
  - (+17, -17 lines — all in uv.lock hash/URL updates)

**Impact:** Keeps the Python backend current on security patches and feature releases. The sentence-transformers bump is the most consequential — it's the library behind MiroShark's simulation similarity search, and a 3-version jump likely includes model improvements and new embedding strategies. The PyJWT bump ensures the auth stack stays current. All changes are lockfile-only; no code modifications required.

---

## aaronjmars/miroshark-aeon

### Agent Configuration: LLM Gateway Auto-Routing
**Summary:** The aeon agent's LLM gateway was switched from hard-pinned `claude` to `auto` mode, enabling automatic provider selection through the Bankr LLM gateway. The same commit cleaned up two multi-line YAML skill entries (changelog and deploy-uni-hook) into single-line format for consistency.

**Commits:**
- `320b97b` — chore: set LLM gateway provider to auto
  - Changed `aeon.yml`: The `gateway.provider` field was changed from `claude` to `auto`. Per the inline comments, the gateway supports provider routing through the Bankr gateway (docs.bankr.bot). The `auto` setting likely enables cost-optimized or availability-based routing across providers instead of always hitting Claude directly. Also collapsed the `changelog` and `deploy-uni-hook` skill entries from multi-line to single-line YAML (+3, -15 lines — net 12-line reduction is entirely formatting)

**Impact:** This is a configuration shift for the agent's LLM backend. With `auto` routing, the agent can potentially use alternative providers through the Bankr gateway when Claude is unavailable or when cost optimization is desired. The practical effect depends on which providers the gateway has configured, but it removes a hard dependency on a single LLM provider for the agent's daily operations.

### Automation Commits (13 filtered)
Dependabot PRs (4): bumped tsx/yaml in apps/cli (#192), next/react/react-dom and 5 others in apps/dashboard (#191), @modelcontextprotocol/sdk and @types/node in apps/mcp-server (#190), and alexverify/eyebrow/action in CI with a version-skew fix (#189). Scheduler state updates (3), cron success markers for token-movers/heartbeat/fetch-tweets (3), auto-commits for token-movers/heartbeat/fetch-tweets (3). Standard skill execution cycle.

Notable: PR #189 (eyebrow bump) included a real CI fix — Dependabot moved the action ref to v0.5.6 but left the step's version input on v0.4.2, causing a version skew. aaronjmars and Claude Opus 5.5 co-authored a follow-up commit in the same PR to align the version input, update the aeon-update script's derivation logic, and refresh the eyebrowlock.json hashes.

---

## Developer Notes
- **New dependencies:** None new; version bumps only (PyJWT 2.15.0, sentence-transformers 5.6.0, tornado 6.5.9, urllib3 2.8.0)
- **Breaking changes:** None
- **Architecture shifts:** LLM gateway provider changed from `claude` to `auto` — first time the agent has been configured for multi-provider routing
- **Tech debt:** None introduced. YAML formatting cleanup in aeon.yml reduced visual noise.

## What's Next
- Hacktoberfest Day 1 — 302 forks at 0% upstream PR conversion rate; watch for first-time contributor PRs
- The sentence-transformers 5.3→5.6 jump may affect embedding quality/behavior in simulation similarity search; worth monitoring if search results shift
- The `auto` gateway setting is new — first few days of operation will reveal whether provider switching causes any behavioral differences in skill outputs
- GH_GLOBAL secret still blocks all feature work; 90+ consecutive blocks
- 3 improve PRs (#62, #63, #64) still open from Sep 28–30
- Eyebrow CI action bump to v0.5.6 — verify CI runs pass with the new version
