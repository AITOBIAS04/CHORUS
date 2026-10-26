# Push Recap — 2026-10-26

## Overview
2 substantive commits by 2 authors across 2 watched repos (20 automation commits filtered from miroshark-aeon). The main event today was an upstream sync that overhauled the on-chain monitor: a new evidence receipt system makes every alert replayable with offline verification, reorg detection prevents stale-chain alerts, and the state reducer got a timezone-aware sorting fix. MiroShark landed its third consecutive day of dependency maintenance with a vite patch and a Python 3.15 hold for torch compatibility.

**Stats:** 19 files changed, +671/-168 lines across 2 substantive commits

---

## aaronjmars/MiroShark

### Dependency Maintenance: vite, setup-uv, Python 3.15 Hold
**Summary:** A bundled Dependabot PR consolidated two patch bumps and added a forward-looking ignore rule for Python 3.15 Docker base images. torch 2.13 has no Python 3.15 wheels (no sdist either), so `uv sync --frozen` in the Dockerfile fails on 3.15 — this blocks the upgrade until torch ships compatible wheels.

**Commits:**
- `a72ef7b` — chore: dependabot bumps 2026-10-26 (setup-uv, vite) + hold python 3.15 (#346)
  - Changed `.github/dependabot.yml`: Added `ignore` rule for `python >= 3.15` in the Docker ecosystem group, with a comment referencing issue #343 (+5 lines)
  - Changed `.github/workflows/tests.yml`: Bumped `astral-sh/setup-uv` from v10.3.0 to v10.3.2 in both the test and lint jobs (+2, -2 lines)
  - Changed `frontend/package.json`: Bumped `vite` from ^8.3.4 to ^8.3.5 (+1, -1 line)
  - Changed `frontend/package-lock.json`: Lock file resolution — vite 8.3.4 → 8.3.5, rolldown 1.2.13 → 1.2.15 (with all 15 platform-specific bindings), postcss 8.5.29 → 8.5.31, oxc-project/types 0.153.0 → 0.155.0 (+78, -78 lines)

**Impact:** Third consecutive day of security/dependency patching (Oct 24: Next.js/MCP SDK/brotli, Oct 25: zod/fast-uri/body-parser, Oct 26: vite/rolldown/postcss). The Python 3.15 hold prevents CI breakage from a known torch incompatibility — once PyTorch ships 3.15 wheels, Dependabot will resume proposing that upgrade.

---

## aaronjmars/miroshark-aeon

### On-Chain Monitor: Evidence Receipts & Hardening
**Summary:** Five upstream commits landed via the aeon-update sync, with the bulk of the changes concentrated in the on-chain monitoring skill. The centerpiece is a new evidence receipt system — after every monitoring run, the skill writes a compact JSON file with block ranges, source statuses, event counts, and transaction hashes, sealed with a SHA-256 digest. An offline verifier validates receipts without network access. Beyond that, the skill gained reorg detection, pinned block ranges (no more open-ended `latest` queries), ERC-721 awareness, and recursive log-overflow splitting.

**Commits:**
- `23cda0c` — aeon-update: sync 5 upstream commits (a0cca77..6eddd85) (#232)

  **On-chain monitor skill rewrite** (`skills/onchain-monitor/SKILL.md`, +124/-14 lines):
  - New **Step 6.1 — Evidence mode**: After each run, writes `memory/evidence/${today}-${run_id}.json` containing schema version, per-chain block ranges, block hashes, source statuses (ok/skipped/degraded/fail), query window counts, event counters (raw/kept/dropped/unpriced), and sorted unique transaction hashes. Receipt is SHA-256 sealed via canonical JSON (sorted keys, compact separators, no `\u` escapes). 30-day auto-pruning by filename date.
  - New **Step 6.2 — Offline verification**: Documents `node scripts/verify-onchain-evidence.mjs` for receipt validation. Checks schema, chain-local invariants, counter math, hash formats, source degradation consistency, and credential leaks.
  - **Reorg detection**: New `last_block_hash` field in watch state. Before fetching, re-reads the previous `last_block` — if its hash changed, logs `REORG: block <n> changed <old> → <new>`, rewinds to finality depth, and replays. Transaction dedup prevents double-alerting during replay.
  - **Pinned block ranges**: All queries now use explicit numeric `toBlock` (resolved once per chain at run start) instead of `latest`, `endblock=99999999`, or open-ended ranges. Ensures all sources for a watch query the same range.
  - **Block range clamping**: Robinhood chain watches capped at 280,000 blocks (~8h) per run. Late/caught-up runs degrade to "last ~8h" with a `CLAMPED` log instead of walking an unbounded gap.
  - **ERC-721 support**: Path C now distinguishes ERC-20 (3-topic Transfer events, amount in data) from ERC-721 (4-topic, token ID in topics[3]) by topic count. NFT contracts skip `decimals()` call. Source footer updated from `erc20 only` to `tokens only`.
  - **Log overflow splitting**: When any `eth_getLogs` query exceeds 10,000 results, recursively halves the window and queries both halves. Documented: the v4 PoolManager on Robinhood returns ~29.7k logs in one 30k-block window, requiring 3 splits and 7 calls.
  - **Richer alerted_tx format**: Changed from plain hash strings to `{hash, block_number, first_seen}` objects with backward compatibility for legacy string entries. Purge by `first_seen` instead of position.
  - **Fetch fallback**: Path C (RPC) now retries non-429 failures through WebFetch before marking `fail`, matching the pattern used by Paths A and B.

  **Offline evidence verifier** (`scripts/verify-onchain-evidence.mjs`, +95 lines, new file):
  - Node.js CLI tool accepting a receipt JSON path. Validates `aeon.onchain-monitor.evidence.v1` schema.
  - Recomputes SHA-256 over the receipt with `sha256` removed, using recursive key sorting and compact UTF-8 JSON.
  - Validates per-chain: block range ordering, non-negative safe integers, counter arithmetic (`kept + dropped == raw`, `unpriced <= raw`), block hash format (0x-prefixed 32-byte hex or null), source status values, degradation consistency (null block_hash requires a degraded source), tx hash uniqueness and sorting.
  - Credential detection: forbidden key patterns (`api_key`, `private_key`, `secret`, `token`, `password`, `raw`, `raw_response`, `response_body`), credential-bearing URL patterns (user:pass@, Alchemy API paths). Recursive walk catches nested secrets.
  - Exit codes: 0 (valid), 1 (invalid with error message), 2 (no input path).

  **Evidence verifier test suite** (`scripts/tests/test_onchain_evidence.sh`, +117 lines, new file):
  - Generates a valid receipt with correct SHA-256 in Node.js, then runs ~25 test cases:
    - Positive: valid single-chain, valid multi-chain, key order independence.
    - Tampering: modified `kept_events` without re-signing, full digest mismatch.
    - Hash rules: duplicate tx hashes, unsorted tx hashes, uppercase hex, invalid block hash format.
    - Security: forbidden key names (`api_key`, `ALCHEMY_API_KEY`, `secret`, `raw_response`), credential-bearing URLs (Alchemy, user:pass@), newline injection in key names.
    - Schema: wrong schema string, missing chains, counter mismatches, reversed block range, negative/unsafe integers, zero watches/windows, duplicate chain IDs, missing degraded source for null block_hash.
    - Edge: malformed JSON (verifies error message doesn't leak secret content), missing argument, unreadable file.
    - Python interop: receipts generated with `ensure_ascii=False` (correct) and `ensure_ascii=True` (wrong digest) to verify cross-language canonical form.

  **State reducer timezone fix** (`scripts/state_reduce.py`, +14/-1 lines):
  - New `_event_sort_key()` function replaces raw string sorting. Parses timestamps to UTC `datetime` objects so `2026-10-01T07:00:00-05:00` (= 12:00 UTC) correctly sorts after `2026-10-01T11:00:00Z`. Timestamps-present events sort before timestamp-less ones. Ties broken by canonical JSON of the event for deterministic ordering.

  **State reducer tests** (`scripts/tests/test_state_reduce.py`, +18 lines):
  - `test_timestamp_offsets_sort_by_instant`: Verifies a `-05:00` offset event at real 12:00 UTC wins over an `11:00:00Z` event.
  - `test_same_timestamp_events_are_order_independent`: Forward and reversed input produce identical output.

  **Eyebrow lockfile** (`eyebrowlock.json`, +6/-37 lines):
  - Updated content hashes for `onchain-monitor` and `remotion` skills reflecting upstream changes.
  - Removed the `AGENTS.md` artifact entry entirely (31 lines deleted) — file appears to have been deleted upstream.
  - Regenerated timestamp.

  **Catalog manifests** (`catalog/packs.json`, `catalog/skills.json`):
  - Regenerated to reflect updated skill definitions from upstream sync.

**Impact:** The on-chain monitor is now significantly more robust and auditable. Evidence receipts mean every alert can be independently verified offline — anyone can check that the receipt is internally consistent, which block ranges were queried, which sources answered, and which transactions triggered alerts. Reorg detection prevents a class of false-positive and missed-alert bugs on chains with shallow finality. Pinned block ranges eliminate a source of non-determinism where different data sources could return results from different chain heights. The state reducer fix prevents a subtle bug where events with timezone offsets could be processed in the wrong order, potentially causing incorrect consecutive-failure counts or missed status transitions.

### Automation Activity (20 commits filtered)
Standard cron/scheduler cycle: holdings, token-movers, repo-pulse auto-commits and success markers; changelog and shiplog auto-commits; heartbeat, memory-flush, fetch-tweets state updates; plus scheduler state changes spanning both today and late yesterday.

---

## Developer Notes
- **New dependencies:** None (all updates to existing dependencies)
- **Breaking changes:** The `alerted_tx` field in `memory/on-chain-state.json` now stores objects `{hash, block_number, first_seen}` instead of plain hash strings. Legacy string entries are handled via backward-compatible dedup, but any external tooling reading this file directly would need updating.
- **Architecture shifts:** The evidence receipt system (`aeon.onchain-monitor.evidence.v1`) is a new pattern — skills producing verifiable output files with schema versioning and integrity digests. The canonical JSON format (sorted keys, compact separators, UTF-8 without escapes) establishes a cross-language serialization contract tested in both Node.js and Python.
- **Tech debt:** None introduced. The AGENTS.md artifact was cleaned up from the eyebrow lockfile.

## What's Next
- The evidence receipt verifier is ready for use but the on-chain monitor skill hasn't run with evidence mode yet — the next scheduled run will be the first test of the full pipeline.
- Three consecutive days of dependency patching (Oct 24-26) should have cleared the backlog of Dependabot alerts across both repos.
- The Python 3.15 hold in dependabot.yml is a temporary measure — will need revisiting once PyTorch releases 3.15-compatible wheels.
- PR #232 (the aeon-update sync) noted 5 files applied cleanly and 5 needing manual review — any unresolved conflicts in the manual-review files could surface as issues in subsequent runs.
