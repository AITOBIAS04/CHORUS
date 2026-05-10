# Push Recap — 2026-05-10

## Overview

1 substantive merge on MiroShark (PR #76 — Simulation Lineage Navigator) plus two new PRs opened, and 31 automation commits on miroshark-aeon from the daily skill cycle. The main thrust: bidirectional fork/counterfactual graph traversal is now live, giving researchers the ability to navigate from a parent simulation to all its public branches. The distribution-to-discovery pipeline is taking shape with PR #78 (Trending Sort) queued behind it.

**Stats:** ~50 files changed, +3,000/-50 lines across 32 commits by 1 author (aeonframework / @aaronjmars)

---

## aaronjmars/MiroShark

### Simulation Lineage Navigator (PR #76 — merged)

**Summary:** Closes the navigation gap that PR #75's reproducibility config export left behind. Previously, a child simulation knew its parent (via `parent_simulation_id` in `reproduce.json`), but the parent had no visibility into the children it spawned. A researcher who ran a base scenario then triggered three counterfactual branches had to remember each child sim id — there was no way to walk from the parent to "the three branches that diverged from this one at round 12." This PR adds bidirectional traversal.

**Commits:**

- `e05bea4` — feat: simulation lineage navigator — fork / counterfactual graph traversal (#76)
  - New file `backend/app/services/lineage_service.py` (+390 lines): Pure stdlib service that scans the public sim corpus for children whose `parent_simulation_id` matches the requested sim. Key functions: `build_lineage_payload()` assembles the full graph slice (parent entry + sorted children list + counterfactual markers), `find_children()` walks `data_dir` once collecting public children capped at 50 entries sorted by `created_at` ascending. Includes defensive helpers (`_safe_str`, `_safe_int`, `_load_state`, `_load_counterfactual`) that never raise on corrupt/missing data — every disk read is wrapped.
  - Modified `backend/app/api/simulation.py` (+101 lines): New `GET /api/simulation/<id>/lineage` endpoint. Same publish gate as share card/transcript/trajectory. Returns `{simulation_id, lineage_kind, parent, children[], total_children, counterfactual}`. `Cache-Control: public, max-age=300`.
  - New file `backend/tests/test_unit_lineage.py` (+501 lines): 16 offline unit tests covering: MAX_CHILDREN cap, public-only children filter, counterfactual marker shape, empty lineage (no parent + no children), corrupt state.json handling, scenario preview truncation, `_kind_for` discriminator logic, parent entry shape when parent is private vs public.
  - Modified `backend/openapi.yaml` (+189 lines): `SimulationLineage` schema + path definition. Drift-detection test passes.
  - Modified `frontend/src/components/EmbedDialog.vue` (+505 lines): 🌳 Lineage panel that auto-shows when there's something to navigate to. Parent row (↑ arrow, click-through to `/watch/<id>`) + Children list (↓ arrow, each row shows kind badge — 🪐 Fork or 🔀 Counterfactual — with trigger round + label). Green tint border/background to distinguish from the indigo repro block. Collapsed by default, eager-fetched on dialog open. i18n: full zh-CN translation. 200+ lines of scoped CSS including responsive breakpoints.
  - Modified `frontend/src/api/simulation.js` (+38 lines): `getSimulationLineage(simId)` helper function.
  - Modified `docs/FEATURES.md` (+25 lines), `docs/FEATURES.zh-CN.md` (+25 lines): Lineage navigator section under Publish & Embed.
  - Modified `docs/API.md` (+1 line), `docs/API.zh-CN.md` (+1 line): Endpoint reference.
  - Modified `README.md` (+2 lines): Features table addition.

**Impact:** Researchers and viewers who land on a tweeted `/share/<id>` link can now see the entire fork/counterfactual tree rooted at that simulation. This is the "graph visualization" layer that makes MiroShark's counterfactual branching feature discoverable — not just executable. Combined with PR #75's reproduce.json, the full lineage is both navigable (this PR) and reproducible (PR #75). Zero new dependencies — 17th consecutive substantive PR with no added deps.

---

### Distribution → Discovery Pipeline (PRs #77 + #78 — opened, not merged)

**Summary:** Two PRs opened today that together create the first feedback loop where shared simulations surface higher in gallery discovery.

- **PR #77** — `feat: track reproduce.json + lineage in surface-stats` (opened 07:46 UTC)
  - Extends the surface-stats counters (from PR #74) to also track reproduce.json downloads and lineage endpoint hits.

- **PR #78** — `feat: trending sort — turn surface-stats into a discovery primitive` (opened 11:24 UTC)
  - Adds `sort=trending` to `/explore` gallery. Sims are ranked by cumulative serve count (surface-stats total). The most-served sims are also the most-distributed — a strong proxy for most-interesting. This is the first feedback loop from distribution analytics back into gallery ranking. `🔥 Trending` option in sort dropdown (i18n: "🔥 热门"). 8 new unit tests, OpenAPI enum extended.

**Impact:** Once both merge, simulations that get shared get found more easily, compounding the distribution advantage of high-quality outputs. The analytics → discovery → sharing → analytics loop closes.

---

## aaronjmars/miroshark-aeon

### Daily Skill Cycle (routine automation)

**Summary:** 31 commits from the full daily skill pipeline. All skills ran green — no failures, no missing runs.

**Key skill outputs:**

- **Token Report** (06:38 UTC): $MIROSHARK at $0.00000646 (+30.6% 24h) — strongest single-day move since the May 6 ATH push. Now only -6.7% from ATH. LP grew to $336.7K. VC interest signal from Lorimer Ventures (first institutional-tier mention).
- **Fetch Tweets** (06:38 UTC): 11 new tweets found, strongly bullish sentiment. Top: @BaseCaptainHB bankrbot feature (45L/8RT), @TheGodfath13541 VC deep-dive (23L/6RT), @wshuyi organic simulation-to-GIF demo (18L/6RT).
- **Tweet Allocator** (08:26 UTC): $10 in $MIROSHARK distributed to 5 authors based on engagement-weighted scoring.
- **Repo Pulse** (10:16 UTC): MiroShark at 1,127 stars / 224 forks (+5 stars in 24h).
- **Feature** (11:27 UTC): Built "Trending Simulations Sort" → opened PR #78 on MiroShark. Also committed `.aeon-tmp-verify-trending.py` scratch file (58 lines, unused — tech debt).
- **Self-Improve** (13:11 UTC): Caught MEMORY.md growing past Claude's 25K-token Read limit. Opened PR #33 to add structural row-size caps to the memory-flush skill.
- **Repo Actions** (14:20 UTC): Generated 5 new feature ideas targeting integration security (Webhook HMAC), institutional data handoffs (Jupyter Notebook, Archive Bundle), trading signal output (signal.json), and agent storytelling (Per-Agent Sparklines).

**Commits by type:**
- `chore(scheduler): update cron state` × 8
- `chore(cron): <skill> success` × 8
- `chore(<skill>): auto-commit 2026-05-10` × 6
- Other skill markers and content commits × 9

---

### Self-Healing: Memory Index Cap (PR #33 — opened)

**Summary:** The self-improve skill detected that `MEMORY.md` had grown to 81 KB — well past the ~25K-token limit Claude's Read tool handles in one pass. Opened PR #33 to modify `skills/memory-flush/SKILL.md` with a new step 5 that enforces per-row character caps and adds a post-flush `wc -c` sanity check. Re-applies closed PR #32 (which stalled for 30h without review).

**Impact:** Without this fix, any skill that reads MEMORY.md would get a truncated view of the memory index. The cap ensures the index stays within a single Read window across all future memory-flush runs.

---

## Developer Notes

- **New dependencies:** None. MiroShark's zero-new-deps streak extends to 17 consecutive PRs.
- **Breaking changes:** None. The lineage endpoint is additive; existing APIs unchanged.
- **Architecture shifts:** The lineage service introduces a new pattern — a read-only corpus scan that builds a graph slice from existing on-disk state without writing anything. This same pattern could apply to future features that need to aggregate cross-simulation data.
- **Tech debt:** `.aeon-tmp-verify-trending.py` scratch file committed by the feature skill (cba0b79) — 58-line trending-sort verifier that should be cleaned up. miroshark-aeon PR #33 still open (memory cap fix).

## What's Next

- **PR #77 + #78 merge** — the trending sort and surface-stats extension are likely next to land on MiroShark main.
- **GH_GLOBAL blocker** — 11 features built locally but unable to push (Pre-Run Cost Estimator through Per-Agent Trajectory Export). This remains the primary velocity bottleneck.
- **Token near ATH** — at -6.7% from ATH with growing LP and VC interest, any catalyst could trigger a new high.
- **Feature pipeline** — 5 fresh ideas from today's repo-actions (Webhook HMAC, Jupyter Notebook, Trading Signal, Sparklines, Archive Bundle). The feature skill will pick from these tomorrow.
- **PR #33 review** — self-improve's memory cap fix needs review/merge to unblock clean MEMORY.md reads.

---

*Window: 2026-05-09T15:12Z → 2026-05-10T15:12Z*
*Repos: aaronjmars/MiroShark (1,127 ⭐ / 224 🍴), aaronjmars/miroshark-aeon*
