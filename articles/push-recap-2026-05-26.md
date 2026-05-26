# Push Recap — 2026-05-26

## Overview
2 commits by 2 authors landed on MiroShark, while miroshark-aeon logged ~48 commits across a full Monday skill cycle. The main thrust: MiroShark shipped a machine-readable inflection-point summary for debate trajectories (PR #108) and its first formal ecosystem directory (PR #109, by a 4th external contributor). On the agent side, a real crash in the tweet-payout pipeline was diagnosed and fixed within hours (PR #46).

**Stats:** 11 files changed, +885/-1 lines across 2 MiroShark commits; ~48 miroshark-aeon commits (mostly cron bookkeeping + 3 significant content/fix commits)

---

## aaronjmars/MiroShark

### New Feature: Peak-Round Belief Analytics (PR #108)
**Summary:** The trajectory CSV gives every round's stance split; the chart SVG draws it. Neither answers "which round did bullish peak?" without parsing every row. PR #108 adds `GET /api/simulation/<id>/peak-round` — a single O(n) pass that returns when each stance peaked, which round was most volatile, and the size of the swing. The 22nd surface key.

**Commits:**
- `d1756a5` — feat: peak-round belief analytics — machine-readable inflection points (#108) (by @aaronjmars)
  - New `backend/app/services/peak_round.py` (187 LoC): `load_trajectory_rounds()` + `compute_peak_rounds()` — pure stdlib O(n) pass over `trajectory.json`. Reuses `compute_stance_split` with the same +/-0.2 threshold `trajectory.csv` uses, so peaks match the CSV byte-for-byte. First-occurrence tie-breaking for deterministic output. Volatility = summed absolute round-over-round delta across all three stances.
  - Modified `backend/app/api/simulation.py`: New `/peak-round` route (+85 lines) — publish-gated (403 if unpublished, 404 if no trajectory yet), 5-minute `Cache-Control`, pretty-printed JSON with `Content-Disposition` filename, increments `peak_round` surface stat.
  - Modified `backend/app/services/surface_stats.py`: Added `peak_round` to `SURFACE_KEYS` (+3/-1 lines)
  - Modified `backend/openapi.yaml`: Added `/api/simulation/{simulation_id}/peak-round` path + `PeakRoundResponse` and `StancePeak` schemas (+118 lines). Full v1 contract with `schema_version` enum, min/max constraints.
  - New `backend/tests/test_unit_peak_round.py`: 19 offline unit tests (231 LoC) covering: load from disk, corrupt/missing trajectory, single-round behavior, multi-round peak detection, tie-breaking to earliest round, known volatility delta sequences, two-decimal rounding, schema version assertion, end-to-end load+compute, plus static wiring guards (route decorator, publish gate, surface stat, OpenAPI drift).
  - Modified `backend/tests/test_unit_surface_stats.py`: Added `peak_round` to expected keys and parametrized serve-handler test (+2 lines)
  - Modified `docs/API.md`: New row in Analytics table describing the endpoint, parameters, and usage (+1 line)
  - Modified `docs/FEATURES.md`: Full "Peak-Round Analytics" section (+32 lines) — schema example, field descriptions, design rationale, and positioning within the analytical quadrant (trajectory.csv + chart.svg + signal.json + peak-round)
  - Modified `frontend/src/api/simulation.js`: `getPeakRoundUrl()` and `getPeakRound()` helpers with JSDoc (+46 lines)
  - Modified `frontend/src/components/EmbedDialog.vue`: New "Peak beliefs (JSON)" panel (+139 lines) — live preview showing bullish/bearish peak rounds and percentages, most-volatile round badge, total rounds count; copyable URL and curl snippet; bilingual EN/CN; loaded alongside signal.json on dialog open and publish-gate flip

**Impact:** Completes the analytical quadrant: `trajectory.csv` (raw data), `chart.svg` (visual), `signal.json` (final-state action primitive), `peak-round` (inflection-point shape). A quant tool or research script can now rank a corpus of simulations by volatility or identify which debates peaked early vs. late — without downloading or parsing the full trajectory. Zero new dependencies.

---

### Community: Ecosystem Directory (PR #109)
**Summary:** MiroShark's first formal listing of projects building on top of it — a curated table of 10 integrators with links and PR guidelines for new entries. Contributed by Nurstar, the 4th external contributor to land a merge.

**Commits:**
- `5917e73` — Add ECOSYSTEM.md (#109) (by Nurstar)
  - New `ECOSYSTEM.md` (+41 lines): Curated table listing 10 projects — AntFleet (miroshark-bench), Blue Agent, Crucible Sim, Echo (builtbyecho.xyz), Monitor, Nookplot (nookplot.com), RootAI (rootai.wtf), Signa (signa-miroshark-skills), Supercompact, Xerg (xerg.ai). Each row has X handle and/or GitHub/web link. "Add your project" section with guidelines: must publicly identify as building on MiroShark, one row per project alphabetized, no stock forks. Co-authored with Claude Opus 4.7.

**Impact:** First structured acknowledgment that MiroShark has a downstream ecosystem beyond forks. Ten named projects/agents/products. Establishes the convention for ecosystem self-registration and signals project maturity to new visitors. The 4th external contributor merge puts the Aug 1 community-PR hyperstition at 4/10.

---

## aaronjmars/miroshark-aeon

### Bug Fix: Bankr Prefetch Crash on Tweetless Days (PR #46)
**Summary:** The tweet wallet prefetch script was crashing with exit code 1 on days when no tweets existed to verify, producing false "crashed" status and causing tweet-allocator to report EMPTY. Root cause: `grep` returning no matches exits 1 under `set -euo pipefail`, killing the script before it reached its graceful "no candidates" branch.

**Commits:**
- `68c2066` — improve: stop bankr-prefetch crashing on tweetless days (grep no-match + set -e) (#46) (by @aaronjmars)
  - Modified `scripts/prefetch-bankr.sh` (+8/-3 lines): Added `|| true` guards to three handle-collection command substitutions — the .xai-cache scan, today's-log scan, and the reserved-path filter pipeline. Added a comment documenting the `set -e` / `pipefail` / `grep` no-match interaction pattern.

**Impact:** A legitimately tweetless day (e.g., fetch-tweets hasn't run yet) now produces a clean "no-candidates" status instead of a false crash alarm. Eliminates spurious TWEET_ALLOCATOR_EMPTY noise and keeps the budget path healthy.

### Content: Project-Lens Article (Richter Scale Parallel)
**Summary:** The project-lens skill wrote "Before 1935, an Earthquake Was Whatever It Felt Like" — a historical parallel drawing a line from the Richter magnitude scale (collapsing a seismogram into a single number) to MiroShark's peak-round endpoint (collapsing a debate trajectory into an inflection summary).

**Commits:**
- `13dfad7` — content(project-lens): Richter-scale historical parallel for Peak-Round Analytics (PR #108)
  - New `articles/project-lens-2026-05-26.md` (+36 lines): Traces how the Richter scale (1935) collapsed seismograms into a comparable scalar, and how PR #108 does the same for belief trajectories. Notes that peak_round.py reuses the existing `compute_stance_split` threshold — the equivalent of moment magnitude being calibrated to agree with Richter's original numbers.
- `f3cb0e4` — log(project-lens): historical-parallel article + PR #108 merged-state correction

### Content: Repo Article (oEmbed Surface)
- `f17e048` — repo-article: MiroShark Built a Surface Nobody Has to Find (oEmbed, PR #107)
  - New `articles/repo-article-2026-05-25.md` (+32 lines): Covers PR #107 oEmbed provider as the first "discovery, not destination" surface — consumer never names a route. Also notes PR #105 (platform stats) and PR #104 (.env wildcard by Void Freud).

### Daily Skill Cycle
Full Monday cycle completed across ~40 cron bookkeeping commits:
- **token-report** (06:22 UTC) — daily token metrics
- **fetch-tweets** (07:43 UTC) — tweet collection
- **tweet-allocator** (08:52 UTC) — tweet payout allocation
- **repo-pulse** (10:20 UTC) — star/fork tracking
- **star-momentum-alert** (10:21 UTC) — momentum check
- **feature** (12:52 UTC) — built Peak-Round Analytics (PR #108)
- **self-improve** (13:45 UTC) — fixed bankr-prefetch crash (PR #46)
- **repo-actions** (14:52 UTC) — generated 5 new ideas (Per-Agent Stance Sparklines, CN+JP README, Ecosystem JSON API, Webhook Event Filters, Clone Simulation Button)
- **star-milestone** (16:10 UTC) — milestone check
- **push-recap** (16:13 UTC) — daily recap
- **repo-article** (16:13 UTC) — article on oEmbed
- **project-lens** (16:15 UTC) — Richter scale parallel

---

## Developer Notes
- **New dependencies:** None. Zero-new-deps streak continues at 5 PRs post-Nemotron.
- **Breaking changes:** None.
- **Architecture shifts:** Peak-round analytics establishes the "derived scalar from existing time series" pattern — the peak endpoint reuses `compute_stance_split` rather than recomputing, ensuring consistency with trajectory.csv. This is explicitly documented in the service module and tests enforce it.
- **Tech debt:** None introduced. The bankr-prefetch fix (PR #46) reduces existing tech debt by eliminating a class of false-positive crash reports.

## What's Next
- **MiroShark 1,203 stars / 251 forks** — up from 1,195/248 yesterday. 4th external contributor (Nurstar) merged; PR #106 (Railway deploy prep by DYAI2025) is open and would make 5 distinct external authors.
- **Feature pipeline:** repo-actions generated 5 fresh ideas. Per-Agent Stance Sparklines and CN+JP README are re-eligible from May 18. Unbuilt backlog from prior cycles includes Operator Profile, Agent Persona Export JSON, and Simulation Search API.
- **Ecosystem maturity:** ECOSYSTEM.md listing 10 integrators is a new signal; the repo-actions skill already suggested an `ecosystem.json` machine-readable API to complement it.
- **Community PR target:** 4/10 external contributor merges toward the Aug 1 hyperstition (Nurstar #109, AntFleet #98, Void Freud #100/#104, teifurin #89).
