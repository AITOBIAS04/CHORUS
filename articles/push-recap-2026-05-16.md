# Push Recap — 2026-05-16

## Overview
48 commits across 2 repos by 2 authors (@aaronjmars, aeonframework). MiroShark landed three PRs that collectively close the platform's biggest gaps: simulations can now be cryptographically anchored to a decentralized knowledge graph, completion events fire native Discord/Slack notifications, and a deprecation-breaking model swap keeps the cloud preset functional after xAI killed grok-4.1-fast. On the Aeon side, the autonomous agent ran 12 skills — building a full Coalition Detection feature, fixing its own monitoring data, and generating daily reports and content.

**Stats:** ~75 files changed, +6,400/-250 lines across 48 commits

---

## aaronjmars/MiroShark

### On-Chain Provenance: OriginTrail DKG Citation (#84)
**Summary:** Adds optional integration with the OriginTrail Decentralized Knowledge Graph (v9/v10) that lets operators anchor a finished, public simulation as a permanent Knowledge Asset. One click in the share dialog walks the WM→SWM→VM pipeline on the operator's local DKG daemon, hashes the byte-stable reproduce.json, and returns a UAL + Merkle root + transaction hash — a tamper-proof citation that survives the MiroShark host going away.

**Commits:**
- `6b8e605` — feat: OriginTrail DKG citation — on-chain provenance for finished sims (#84)
  - New file `backend/app/services/dkg_publisher.py`: 709-line stdlib-only publisher service — composes Turtle RDF from reproduce.json + webhook payload, walks four daemon endpoints (assertion/create → write → promote → shared-memory/publish), persists `dkg-citation.json` atomically. Idempotent on re-click (+709 lines)
  - Changed `backend/app/api/simulation.py`: Two new routes — `GET /<id>/dkg-citation` (public read) + `POST /<id>/publish-dkg` (admin-token trigger). Daemon failures map to 502/503/504 with stage info (+233 lines)
  - Changed `backend/app/api/notifications.py`: `GET /api/config/notifications` now exposes `dkg_configured` + `dkg_network` so the SPA renders the right state (+13 lines)
  - Changed `backend/app/config.py`: Added `DKG_ENDPOINT`, `DKG_AUTH_TOKEN`, `DKG_NETWORK` env vars (+21 lines)
  - Changed `backend/openapi.yaml`: Full path specs for both DKG endpoints + `DkgCitation` component schema + updated notifications-config envelope (+257 lines)
  - Changed `backend/tests/test_unit_notifications_config.py`: Updated 5 existing tests for new keys + 2 new tests covering fully-configured and partial-configuration cases (+72 lines)
  - New file `docs/DKG.md`: Setup walkthrough, payload schema, endpoint table, verification recipe, cost model (+240 lines)
  - Changed `frontend/src/api/simulation.js`: Added `getDkgCitation()` and `publishDkg()` API functions (+48/-1 lines)
  - Changed `frontend/src/components/EmbedDialog.vue`: Citation card slotted between Jupyter export and lineage navigator — testnet/mainnet chip, UAL + Merkle + tx hash with copy buttons, explorer link, "Publish to DKG" CTA (+393/-1 lines)
  - Changed `README.md`: Feature row for DKG citation (+2 lines)

**Impact:** Closes the provenance gap the reproduce.json + share-card stack always implied — simulations are now reproducible (reproduce.json), shareable (share card), and un-rewritable (DKG citation). This is the DOI equivalent for social simulations.

---

### Channel-Native Completion Notifications: Discord + Slack (#83)
**Summary:** The generic webhook (#46) accepted Discord/Slack URLs but rendered nothing useful — Discord showed nothing, Slack inlined raw JSON as an ugly code dump. This PR adds two channel-native notification paths that fire alongside the generic webhook on every `simulation.completed` / `simulation.failed` event, with rich formatting tailored to each platform.

**Commits:**
- `1d6f6ee` — feat: Discord rich-embed + Slack Block Kit completion notifications (#83)
  - New file `backend/app/services/discord_notify.py`: Discord embed builder + dispatch — consensus-coloured border (green/grey/red/amber), scenario title, belief/quality/scale fields, share-card thumbnail, share-page link (+441 lines)
  - New file `backend/app/services/slack_notify.py`: Slack Block Kit builder + dispatch — scenario header, status-verb context line, mrkdwn belief bars (`█████░░░░░ 52.0%`), quality/scale/resolution fields, "View simulation" action button (+432 lines)
  - New file `backend/app/api/notifications.py`: `GET /api/config/notifications` probe — exposes presence booleans (Webhook/Discord/Slack) without leaking URLs (+59 lines)
  - Changed `backend/app/services/simulation_runner.py`: Three hook sites — completed exit-code, failed exit-code, `simulation_end` event. Per-channel `(sim_id, status)` dedup prevents duplicate cards (+82 lines)
  - New file `backend/tests/test_unit_discord_notify.py`: 24 tests (+368 lines)
  - New file `backend/tests/test_unit_slack_notify.py`: 24 tests (+327 lines)
  - New file `backend/tests/test_unit_notifications_config.py`: 9 tests (+173 lines)
  - Changed `backend/openapi.yaml`: New endpoint under Settings & Push (+55 lines)
  - Changed `frontend/src/api/simulation.js`: `getNotificationsConfig` API function (+20 lines)
  - Changed `frontend/src/components/EmbedDialog.vue`: Three status chips (Webhook/Discord/Slack) in callout row (+155 lines)
  - New file `docs/NOTIFICATIONS.md`: Setup guide with payload examples (+114 lines)
  - Changed `.env.example`: `DISCORD_WEBHOOK_URL` + `SLACK_WEBHOOK_URL` entries (+19 lines)
  - Changed `docs/FEATURES.md`: Notification section (+9 lines)
  - Changed `README.md`: Feature row (+4 lines)

**Impact:** Operators who use Discord or Slack now get beautifully formatted completion cards instead of silence or JSON dumps. Both channels are opt-in and independent — set the webhook URL and it activates. 57 tests, zero new dependencies (23rd consecutive zero-new-deps PR).

---

### Model Migration: Grok-4.1 Fast → Gemini 3 Flash (#86)
**Summary:** xAI deprecated grok-4.1-fast on OpenRouter (404 on every call), breaking the Smart, NER, and WEB_SEARCH slots in the cloud preset. This PR swaps all three to google/gemini-3-flash-preview, which has comparable latency with reasoning disabled and supports structured outputs + tool calling.

**Commits:**
- `44d1c4e` — fix: swap deprecated x-ai/grok-4.1-fast → google/gemini-3-flash-preview (#86)
  - Changed `.env.example`: Updated 3 model references + comment text (+5/-5 lines)
  - Changed `backend/app/api/settings.py`: Updated cloud preset label and 3 model slots (`SMART_MODEL_NAME`, `NER_MODEL_NAME`, `WEB_SEARCH_MODEL`) (+4/-4 lines)
  - Changed `backend/app/config.py`: Updated 3 inline comments referencing the model name (+3/-3 lines)
  - Changed `backend/app/utils/run_summary.py`: Replaced pricing entry — removed `x-ai/grok-4.1-fast` ($0.20/$0.50), added `google/gemini-3-flash-preview` ($0.50/$3.00) (+1/-1 lines)
  - Changed `backend/app/utils/llm_client.py`: Updated comment referencing model name (+1/-1 lines)
  - Changed `backend/app/utils/url_fetcher.py`: Updated docstring + error message model reference (+2/-2 lines)
  - Changed `README.md`: Updated quickstart comments — EN + ZH-CN (+2/-2 lines)
  - Changed `docs/CONFIGURATION.md` + `docs/CONFIGURATION.zh-CN.md`: Updated 3 model references each (+4/-4 each)
  - Changed `docs/INSTALL.md` + `docs/INSTALL.zh-CN.md`: Updated preset description + 3 model references each (+4/-4 each)
  - Changed `docs/MODELS.md` + `docs/MODELS.zh-CN.md`: Updated model table, mode description, and pricing references (+5/-5 each)

**Impact:** Restores cloud preset functionality after xAI deprecation. End-to-end verified: ontology generation ~11s, graph build 22 entities + 22 edges in stable JSON, web enrichment working. Pricing went up (Smart/NER: $0.20→$0.50 in, $0.50→$3.00 out) but these slots only handle ~19 calls/run — marginal cost impact.

---

## aaronjmars/miroshark-aeon

### Autonomous Feature Build: Coalition Detection
**Summary:** Aeon's `feature` skill built a complete Coalition Detection system for MiroShark — greedy modularity-maximization community detection on the interaction graph, with full API, UI, and tests. Push blocked by missing `GH_GLOBAL` secret (16th consecutive block).

**Commits:**
- `5cc7d8d` — chore(feature): auto-commit 2026-05-16
  - Updated `.outputs/feature.md` with build results
  - Added `dashboard/outputs/.pending-feature.md` for deferred push
  - Updated `memory/MEMORY.md` with Coalition Detection entry
  - Updated `memory/logs/2026-05-16.md` with build log (+41/-25 lines)

**Impact:** Feature is code-complete locally but cannot be pushed upstream. This is the 16th feature blocked by the missing `GH_GLOBAL` secret — the backlog now includes Pre-Run Cost Estimator through Coalition Detection.

---

### Monitoring Fix: Self-Improve PR #9
**Summary:** The `self-improve` skill identified and fixed two monitoring data quality issues: heartbeat auto-dispatch failing with HTTP 403 on every run (creating false alert noise), and cron-state success rates poisoned by the 15-day auth outage (Apr 16–30) showing 1–7% instead of actual 100%.

**Commits:**
- `3e8f383` — chore(self-improve): auto-commit 2026-05-16
  - Updated `.outputs/self-improve.md` with fix details
  - Added `dashboard/outputs/self-improve-2026-05-16T13-08-00Z.json` (+176/-7 lines)
- `1ec3230` — chore(memory): log self-improve PR #40
  - Updated `memory/MEMORY.md` and `memory/logs/2026-05-16.md` (+10 lines)

**Impact:** PR #9 opened on miroshark-aeon. Monitoring data now reflects actual skill health (100%) instead of outage-poisoned rates (1–7%). Heartbeat stops generating false "dispatch blocked" alerts.

---

### Daily Operations & Content
**Summary:** Twelve autonomous skill runs producing daily reports, content, and analysis.

**Commits:**
- `89185b9` — feat(token-report): $MIROSHARK daily report 2026-05-16 — new ATH $0.0000162
  - Price $0.00001446 (+28.56% 24h), LP $574.8K (new ATH), FDV $1.45M, 7d +143.3%
  - Saved `articles/token-report-2026-05-16.md` (+66 lines)

- `b454d25` — chore(cron): tweet-allocator 2026-05-16
  - $9.99 in $MIROSHARK allocated to 3 authors: tsubixxx $4.44, PoodleFi_ $3.33, btcbabycow $2.22

- `04ed4b5` — chore(repo-pulse): auto-commit 2026-05-16
  - 1,162 stars (+6), 232 forks (+1), 6 new stargazers
  - Dashboard output generated (+212/-6 lines)

- `4a61a95` — chore(hyperstitions-ideas): auto-commit 2026-05-16
  - New question: "Will $MIROSHARK liquidity pool depth exceed $1M by July 1, 2026?"
  - LP hit new ATH $574.8K during recovery phase (+216/-6 lines)

- `bc27687` — chore(star-momentum-alert): auto-commit 2026-05-16
  - Star growth trajectory analysis, article saved (+83/-16 lines)

- `79af8bd` — chore(repo-actions): auto-commit 2026-05-16
  - Analyzed MiroShark at 1,164 stars, 232 forks
  - Generated 5 feature ideas: Private Share Links, Adversarial Stress-Test, Weekly Digest, Curator Collections, Scenario Pre-flight Analyzer
  - Saved `articles/repo-actions-2026-05-16.md` (+489/-13 lines)

- `f313c8a` — chore(fetch-tweets): auto-commit 2026-05-16
  - Scanned for new tweets — all results already reported (FETCH_TWEETS_NO_NEW)
  - Updated seen-tweets list (+154/-31 lines)

- `2397ff2` — chore(star-milestone): auto-commit 2026-05-16
  - Milestone check completed (+23/-7 lines)

Plus 15 `chore(cron)` success markers and `chore(scheduler)` state updates maintaining the autonomous scheduling system.

---

## Developer Notes
- **New dependencies:** Zero. MiroShark's zero-new-deps streak continues (now 23 consecutive PRs). DKG publisher uses stdlib only (`urllib.request` + `json` + `os` + `hmac`). Discord/Slack notifiers use stdlib only.
- **Breaking changes:** Cloud preset model swap from `x-ai/grok-4.1-fast` to `google/gemini-3-flash-preview`. Existing `.env` files with hardcoded model names will continue to 404 until updated. Pricing increased ($0.20→$0.50/M in, $0.50→$3.00/M out for Smart/NER slots).
- **Architecture shifts:** DKG citation adds the first external blockchain dependency (optional, env-gated). The notification stack now has three independent channels (Webhook, Discord, Slack) all firing from the same simulation runner hooks.
- **Tech debt:** 16 features built locally by Aeon but unable to push upstream (GH_GLOBAL unset). This backlog grows by one feature every ~2 days and represents significant unreleased work.

## What's Next
- **GH_GLOBAL secret** remains the top blocker — 16 features queued locally, each with tests and docs, waiting to be pushed as PRs to aaronjmars/MiroShark.
- **Open PR:** `feat/chart-svg-trajectory` is the only open PR on MiroShark — likely next merge candidate.
- **Model pricing:** Gemini 3 Flash is 2.5×/6× more expensive than Grok-4.1 Fast was. If Smart/NER call volume increases beyond the current ~19 calls/run, a cheaper alternative may be worth evaluating.
- **Token momentum:** $MIROSHARK recovering toward May 12 ATH ($0.0000160057), LP at new ATH $574.8K. The "LP $1M by July" hyperstition question frames the next liquidity milestone.
