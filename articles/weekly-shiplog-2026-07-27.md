# Week in Review: The Subtraction Week

*2026-07-27 — Weekly shipping update*

## The Big Picture

This was a week about making MiroShark smaller, harder, and more secure. The headline: a single PR deleted 1,325 net lines of dead code across 53 files — the largest cleanup pass since the v0.1.0 migration that shed 73,000 lines in early July. On top of that, four security advisories were patched within hours of publication, and the agent infrastructure got quieter and smarter about when to speak up. No new features shipped. The codebase got better by losing weight.

## What Shipped

### The 1,325-Line Subtraction (PR #254)

The week's defining commit was a behavior-preserving cleanup sweep across the entire MiroShark backend and frontend. Twenty-three identical publish-gate checks in `simulation.py` collapsed into a single `_load_public_summary` helper — a file that went from 325 deletions against 94 additions. Four separate notification services (Telegram, email, Slack, Discord) that each reimplemented the same formatting logic now share a `_notify_base.py` foundation. Scattered stance-classification code that lived in half a dozen services got centralized into `utils/text.py` with a single `STANCE_THRESHOLD` constant. Three Vue views that duplicated 170 lines of identical CSS each now import one `app-shell.css` file. Dead storage methods, unused model methods, unreferenced agent code, orphaned config knobs — all cut. The test suite (1,435 tests) passed clean afterward. This is what maintenance looks like when you take it seriously: not adding things, but removing everything that shouldn't be there.

### Four Security Patches in Four Days

Monday through Thursday, MiroShark shipped same-day or next-day patches for four distinct security advisories:

- **CVE-2026-59950** (CVSS 7.6) — Cross-Site WebSocket Hijacking in the MCP Python SDK. Bumped `mcp` from 1.27.2 to 1.28.1. This one had real attack surface: any deployment accepting WebSocket connections was exposed.
- **CVE-2026-13311** (CVSS 7.5) — Quadratic-complexity DoS in `shell-quote`. Required a scoped npm override because the upstream dependency (`concurrently`) pins an exact vulnerable version. The vulnerable `parse()` function isn't reachable in this codebase, but the patch prevents future code from accidentally calling it.
- **GHSA-rrmf-rvhw-rf47** — Memory corruption in PyTorch ≤2.12.1. Bumped to 2.13.0, pulling in tighter CUDA platform markers that now explicitly enumerate `aarch64` and `x86_64` instead of broad `linux`.
- **Setuptools advisory** — Bumped from 81.0.0 to 83.0.0, clearing an open Dependabot alert.

The industry average mean time to remediation for CVEs runs 74–252 days. MiroShark patched all four within 24 hours of advisory publication. That's not a fluke — it's been the pattern since the project started tracking CVE response times.

### Agent Infrastructure Tuning

The autonomous agent layer (miroshark-aeon) got three configuration changes that matter:

- **Repo-pulse activated on weekly cadence** (PR #116): Previously disabled, the monitoring skill now runs every Monday with properly calibrated 7-day thresholds. Star surge detection shifted from ≥10/day to ≥50/week. Baseline comparison moved from daily average to 4-week rolling weekly mean.
- **Changelog skill silenced** (PR #119): No more notifications for routine changelog runs.
- **Schedule tuning** (PR #118): Shiplog and changelog moved to weekly cadence, reducing noise from daily runs that produced near-identical output.

## Fixes & Improvements

- **Self-improve duplicate PR detection** (CHORUS PR #40): The self-improvement skill was creating duplicate PRs when run multiple times targeting the same improvement. Now checks for existing open PRs before creating new ones.
- **Repo-article same-day dedup** (CHORUS PR #39): Re-runs within the same day no longer overwrite earlier articles.
- **Skill-leaderboard early exit** (CHORUS PR #36): Previously ran the full 8-step pipeline even when there were fewer than 2 active forks — 12 consecutive wasted runs. Now exits early at step 2.
- **Dependabot bumps**: `concurrently` 10.0.3→10.0.4, `marked` 18.0.6→18.0.7. Routine maintenance keeping the frontend toolchain current.
- **README badge polish** (PRs #252, #253): Documentation badge added, ticker symbol standardized to `$miroshark`, badge row tightened across all four language variants.

## By the Numbers

- **Commits:** 12 substantive across 3 repos (MiroShark: 9, miroshark-aeon: 3 PRs + ~85 automation commits, CHORUS: 3 self-improve PRs)
- **PRs merged:** 15 (MiroShark: 9, miroshark-aeon: 3, CHORUS: 3)
- **Files changed:** ~65
- **Lines:** +747 / -2,054 (net -1,307)
- **Contributors:** aaronjmars, dependabot[bot], aeonframework
- **Stars:** 1,417 (+4 from last week)
- **Forks:** 298 (+1)

## Momentum Check

This is the third consecutive maintenance-only week. No new features have shipped since the v0.1.0 migration completed July 11. The pattern is deliberate: after the massive restructuring that cut 73,000 lines and consolidated 203 skills down to 61, the project is in a tightening phase — removing what shouldn't have survived the migration, hardening dependencies, and tuning the agent infrastructure. The pace is steady: 15 PRs merged, 4 CVEs patched, and the codebase is 1,300 lines lighter. The feature pipeline remains blocked by the missing GH_GLOBAL secret (62nd consecutive block), with 40+ built features stuck as local commits. That's the single biggest unlock waiting to happen.

The token sits at $0.000001802, up 4.8% on the week but still 95.9% below its May ATH. Social monitoring has been empty for 21 consecutive days. The project ships code; the market doesn't notice. That gap is the story of this quarter.

## What's Next

- **GH_GLOBAL secret**: Still the top priority. Setting it would immediately unblock 40+ features that have been built and tested but can't be pushed.
- **First weekly repo-pulse report**: Expected Monday July 28 — the newly activated skill's first real run.
- **Feature candidates queued**: i18n Contribution Kit, Portuguese locale, Simulation OG Image API, GitHub Discussions templates, Air-Gapped HuggingFace Cache — all waiting on push access.
- **Community PR hyperstition**: The 10-merged-PRs-by-August-1 target sits at roughly 5/10 with 4 days left. Unlikely to clear without activation.
- **Social silence**: 21 days and counting. The project's next phase transition requires moving from repo to community — live calls, tweet engagement, external content. Code alone won't break the silence.

---
*Sources: [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), [AITOBIAS04/CHORUS](https://github.com/AITOBIAS04/CHORUS), [MiroShark on ToolHunter](https://toolhunter.cc/tools/miroshark), [MiroShark on Openflows](https://openflows.org/currency/currents/miroshark/)*
