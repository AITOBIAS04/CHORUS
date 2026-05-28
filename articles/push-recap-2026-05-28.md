# Push Recap — 2026-05-28

## Overview
4 substantive commits across 2 repos by 3 authors (noelclaw, @aaronjmars, Aeon). The main thrust: MiroShark shipped its 24th consumable surface — a webhook event filter that lets each integrator subscribe to only the slice of the simulation stream they care about — alongside a significant README overhaul and the 6th community ecosystem contribution. On the aeon side, the self-improve skill tightened the Grok query that was feeding spam into the daily token report.

**Stats:** ~17 files changed, +1,065/-49 lines across 4 substantive commits (+ ~16 housekeeping commits in miroshark-aeon)

---

## aaronjmars/MiroShark

### New Feature: Webhook Event Filtering (24th Share Surface)
**Summary:** PR #120 adds `WEBHOOK_EVENTS`, an optional comma-separated allow-list that filters outbound completion webhooks before dispatch. With ECOSYSTEM.md now listing 10+ integrators, not every downstream consumer wants every simulation — a Polymarket bot only cares about directional high-confidence signals, a research pipeline only about excellent-quality outcomes. This gives each integrator a subscription filter at the source.

**Commits:**
- `85890ed` — feat: add WEBHOOK_EVENTS dispatch filter (24th surface) (#120)
  - Changed `.env.example`: Added 19-line documented config block explaining token categories, AND/OR semantics, and examples like `WEBHOOK_EVENTS=bullish,high_confidence` (+19 lines)
  - Changed `backend/app/services/webhook_service.py`: Full filtering system — `_resolve_event_filter()` parses the env var into a normalized token set (late-bound, no restart needed); `_payload_direction()` derives bullish/neutral/bearish using the same `>=` plurality rule as the Discord embed colour; `_payload_confidence_pct()` reads the leading-stance percentage; `_payload_quality_key()` normalizes quality health; `payload_passes_event_filter()` evaluates all three categories with OR-within/AND-across semantics. Failed sims always bypass the filter. Unknown tokens are silently ignored so a typo never disables the webhook. Integrated into `fire_webhook_for_simulation()` between dedup-mark and dispatch-thread spawn (+237 lines)
  - New file `backend/tests/test_unit_webhook_events.py`: 24 unit tests covering parser normalization, direction-only filtering, confidence thresholds, quality filtering, cross-category AND logic, unknown token handling, failed-sim bypass, and end-to-end `fire_webhook_for_simulation` integration (+454 lines)
  - Changed `docs/FEATURES.md`: New "Webhook Event Filtering" section documenting the three-category token system, AND/OR semantics, failed-sim bypass, and implementation details (+13 lines)
  - Changed `docs/WEBHOOKS.md`: User-facing reference — token table (direction/confidence/quality), logic rules, bash examples, suppression logging behavior (+46 lines)

**Impact:** Every integrator in ECOSYSTEM.md can now self-select which simulation outcomes trigger their webhook. A Polymarket bot sets `bullish,bearish,high_confidence` and ignores neutral low-confidence noise. A research pipeline sets `excellent_quality` and only processes high-quality runs. The filter is late-bound (reads `os.environ` on every dispatch) so operators flip rules without restarting. Manual retries bypass the filter — same pattern as the existing dedup bypass. Zero new dependencies.

---

### Community: Noelclaw Joins Ecosystem
**Summary:** The 6th external contributor added their project to the ecosystem registry, continuing the community contribution momentum tracked since PR #109.

**Commits:**
- `d4c15f0` — feat: add Noelclaw to ecosystem (#117)
  - Changed `ECOSYSTEM.md`: Added Noelclaw entry — X handle (@noelclawfun), website (noelclaw.com), and MCP integration repo (+1 line)

**Impact:** ECOSYSTEM.md now lists 11+ projects. This is the 6th community contribution toward the August 2026 hyperstition target of 10 merged PRs from non-core contributors (5+/10 as of yesterday's count).

---

### README Overhaul: Condensed Features + Visual Assets
**Summary:** Two PRs restructured the README for scannability — feature descriptions condensed from multi-sentence paragraphs to crisp one-liners, Use Cases moved above the feature table for narrative flow, and three new diagrams added to the screenshots section.

**Commits:**
- `ab6d12f` — docs: condense feature table to one-liners + add diagram images (#118)
  - Changed `README.md`: Every feature row in the table condensed from a paragraph to a single punchy line (e.g. "Per-round agent posts + stance labels as Markdown or structured JSON" replaces a 3-line description of export formats and pipeline compatibility). Added "Simulate anything" hero banner under the intro. Added grounding pipeline and graph memory architecture diagrams to the screenshots table (+40/-32 lines)
  - New files: `docs/images/simulate-anything.jpg`, `docs/images/grounding.jpg`, `docs/images/graph-memory.jpg` (3 images)
- `287022f` — docs: move Use cases section above Features in README (#119)
  - Changed `README.md`: Moved the 7-item Use Cases list (PR crisis testing, market reaction, advertisement, policy analysis, life decision, what-if history, creative experiments) from below the feature table to above it — visitors now see *why* before *what* (+10/-10 lines)

**Impact:** The README is significantly more scannable. Feature descriptions that were 50+ words are now under 15. Three architectural diagrams (simulate-anything flow, agent grounding layers, graph memory pipeline) give visual context that the text-only table couldn't convey. Use Cases above Features means a first-time visitor hits the "why should I care" before the "here's everything we built."

---

## aaronjmars/miroshark-aeon

### Self-Improvement: Token Report Grok Spam Filter
**Summary:** PR #48 tightened the Grok query in `prefetch-xai.sh` so the daily token report's Social Pulse section stops citing zero-engagement spam contract drops. The same spam pattern drove PR #47's disable of fetch-tweets and tweet-allocator on May 27.

**Commits:**
- `5da2ba5` — improve: token-report Grok query filters zero-engagement spam (#48)
  - Changed `scripts/prefetch-xai.sh` (~line 187): Replaced the token-report Grok prompt with a version that applies three explicit pre-filters before picking results — (1) drop zero-likes AND zero-RT tweets, (2) drop contract-drop / "vote for" / "fam drop" templates and known clone domains (arbihunter.live, toknsite.live, etc.), (3) drop duplicate-template spam across handles. Tells Grok to return zero results rather than fall back to spam (+1/-1 line, prompt rewrite)
  - Changed `.outputs/self-improve.md`: Updated output file with new PR details (+6/-6 lines)
  - New file `dashboard/outputs/self-improve-2026-05-28T13-44-21Z.json`: json-render spec for dashboard (+171 lines)
  - Changed `memory/logs/2026-05-28.md`: Detailed self-improve log entry (+18 lines)

**Impact:** Higher signal-to-spam ratio in the daily Social Pulse section. On quiet days with only bot activity, the section now cleanly degrades to "X/Grok data unavailable" instead of citing scam contract drops as genuine sentiment. The fix is query-level (Grok sees full tweet metadata) rather than post-process (which would only see rendered text). Tomorrow's 06:00 UTC token-report run validates end-to-end.

---

### Project Lens: Ecosystem Map Article
**Summary:** The project-lens skill published its daily article — an ecosystem map placing MiroShark in the 2026 agent landscape, between orchestration frameworks (LangGraph, CrewAI, Microsoft Agent Framework) and generative social simulators (AgentSociety).

**Commits:**
- `d803f5a` — content(project-lens): ecosystem-map article placing MiroShark in the 2026 agent landscape
  - New file `articles/project-lens-2026-05-27.md`: "The 2026 Agent Map Has Two Continents. Almost Nothing Lives in the Strait Between Them." — maps the orchestration-framework continent (LangGraph/CrewAI/MS Agent Framework v1.0 GA) vs the research-simulator continent (AgentSociety/discourse_simulator), positions MiroShark in the strait between them as a queryable belief simulator with API ergonomics and DKG-anchored reproducibility (+42 lines)

**Impact:** Adds the ecosystem-map angle (#8 in the rotation, last used May 19) to the article archive. Cites 10 external sources including the 2026 Springer "validation is the central challenge" review and the Medium/Gurusup framework comparison guides.

---

### Housekeeping
~16 additional miroshark-aeon commits: cron success markers (token-report, repo-pulse, star-momentum-alert, feature, self-improve, repo-actions), scheduler state updates, auto-commits for each skill run. Standard daily automation cycle.

---

## Developer Notes
- **New dependencies:** None. Both PR #120 (webhook filter) and PR #48 (Grok spam filter) are pure stdlib / prompt-only changes. Zero-dep streak continues.
- **Breaking changes:** None. `WEBHOOK_EVENTS` is opt-in; blank/unset preserves existing fire-on-everything behavior.
- **Architecture shifts:** The webhook event filter establishes a new pattern — source-side subscription filtering with category-based AND/OR semantics. This could extend to other notification channels (Discord, Slack, Telegram, SMTP) if integrators want per-channel filtering.
- **Tech debt:** None introduced. The README condensation reduced feature-table verbosity significantly.

## What's Next
- **WEBHOOK_EVENTS in practice:** First integrators can start setting filter rules now. The 10+ ECOSYSTEM.md projects are the immediate audience.
- **GH_GLOBAL still blocked:** 25 built features remain as local commits, unable to push. The Agent Interaction Graph Export (built today) is the latest addition to the queue.
- **Community contributor target:** 5+/10 merged PRs from non-core contributors (Noelclaw is the 6th contributor). On pace for the August 2026 target of 10.
- **Tomorrow's validation:** The 06:00 UTC token-report run will be the first to use the spam-filtered Grok query.
- **Stars:** MiroShark at 1,208 (+3 today). Next milestone: 1,500.
