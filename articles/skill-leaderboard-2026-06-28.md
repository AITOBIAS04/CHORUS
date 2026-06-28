# Skill Leaderboard — 2026-06-28

*1 active Aeon fork scanned (pushed in last 30 days) — AITOBIAS04/CHORUS*

> **Notification threshold not met** (requires ≥2 forks with readable `aeon.yml`; found 1).
> Baseline preserved for future comparison.

---

## Top Skills Across the Fleet

| Rank | Skill | Forks Enabled | % of Fleet | Change |
|------|-------|---------------|------------|--------|
| 1 | token-report | 1 | 100% | — |
| 2 | fetch-tweets | 1 | 100% | — |
| 3 | repo-pulse | 1 | 100% | — |
| 4 | push-recap | 1 | 100% | — |
| 5 | project-lens | 1 | 100% | — |
| 6 | repo-actions | 1 | 100% | — |
| 7 | repo-article | 1 | 100% | — |
| 8 | self-improve | 1 | 100% | — |
| 9 | weekly-shiplog | 1 | 100% | — |
| 10 | hyperstitions-ideas | 1 | 100% | — |
| 11 | feature | 1 | 100% | — |
| 12 | heartbeat | 1 | 100% | — |
| 13 | memory-flush | 1 | 100% | — |
| 14 | skill-leaderboard | 1 | 100% | — |

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-06-28). CHORUS skill stack unchanged at 14 skills.*

---

## Consensus Skills (>50% of forks)

With one active Aeon fork, all 14 enabled skills qualify at 100% adoption. The fleet's single running instance maintains the complete operational stack:

- **Market & Social:** token-report, fetch-tweets, repo-pulse
- **Shipping & Content:** push-recap, project-lens, repo-article
- **Automation & Meta:** repo-actions, self-improve
- **Weekly:** weekly-shiplog, hyperstitions-ideas
- **Build:** feature
- **Housekeeping:** heartbeat, memory-flush
- **Self-monitoring:** skill-leaderboard

**The source divergence gap widened significantly this week.** CHORUS now runs 10 skills that are disabled in the source — up from 3 last week. The source has undergone a radical restructuring: it shed nine previously-enabled skills and now runs a minimal core of 7. CHORUS maintains the full pre-restructure operational stack.

---

## Adoption Gaps

Skills enabled in the source (`aaronjmars/miroshark-aeon`) but not enabled in CHORUS — **3 total**:

| Skill | Notes |
|-------|-------|
| `docs-sync` | **New** — converts merged PRs from a product repo into changelog entries on a marketing site, via draft PR. Requires `GH_GLOBAL`. Every 3 days, 08:00 UTC. Added to source this week. |
| `shiplog` | Weekly shipping log (Monday + Thursday); analogous to CHORUS's `weekly-shiplog`. Functional overlap — CHORUS has not adopted the renamed/rescheduled variant. |
| `tweet-digest` | Daily account-based X digest. Enabled in source this week per prior tracking. CHORUS has the skill present but disabled. |

The big story this week is what CHORUS has that the source *dropped*. Nine skills that were enabled in source last week are now disabled: `push-recap`, `repo-actions`, `repo-article`, `self-improve`, `project-lens`, `feature`, `star-milestone`, `star-momentum`, and `thread-formatter`. CHORUS continues running all of them.

---

## Week-over-Week

Compared to the 2026-06-21 leaderboard:

**Fleet size:** Unchanged — 1 Aeon fork with readable `aeon.yml`

**CHORUS skill count:** 14 → 14 (no change)

**Rank changes:** None — all 14 skills hold positions

**Source restructure — major event:**
The `aaronjmars/miroshark-aeon` source was comprehensively rewritten this week. Its catalog expanded from ~80-90 to 200+ catalogued skills (new additions include fork-fleet, fork-cohort, contributor-spotlight, skill-analytics, skill-gap, skill-adoption, ecosystem-pulse, and dozens more — all disabled by default). Simultaneously, the source's enabled-by-default set shrank from ~15 down to 7:

| | Last Week | This Week |
|---|---|---|
| Source enabled | ~15 | 7 |
| CHORUS-only | 3 | 10 |
| Source-only | 5 | 3 |
| Shared | ~11 | 4 |

Skills dropped from source (were enabled, now disabled): `push-recap`, `repo-actions`, `repo-article`, `self-improve`, `project-lens`, `feature`, `star-milestone`, `star-momentum`, `thread-formatter`

Skills added to source (now enabled): `docs-sync`

Skills retained in source: `token-report`, `repo-pulse`, `shiplog`, `tweet-digest`, `heartbeat`, `memory-flush`

The source's new enabled defaults represent a "minimal viable core" — observe, ship logs, stay alive — with everything else available but opt-in. CHORUS's full operational stack now reads as a deliberate, high-engagement configuration rather than the default.

**MiroShark sim-tool forks (30d window):** 38 active (down from 40 — April/May fork wave continues aging out of the 30-day window; `swarm-ai-research` pushed today)

**Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the eighth consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet

The leaderboard scans two layers:

**Layer 1 — MiroShark sim-tool forks (`aaronjmars/MiroShark`):** 38 active forks in the 30-day window. These fork the simulation product (frontend + backend), not the Aeon agent runtime. None have `aeon.yml` — expected.

**Layer 2 — Aeon runtime forks (`aaronjmars/miroshark-aeon`):** 1 active fork with readable `aeon.yml`:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-06-28 (today) |

The source repo now catalogs 200+ skills but enables only 7 by default. CHORUS enables 14 — the broadest stack in the fleet.

---

## Fleet Summary

- **Target repo scanned:** aaronjmars/MiroShark
- **Active MiroShark forks (pushed in last 30 days):** 38
- **Forks with readable `aeon.yml`:** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 7 (down from ~15 last week — major restructure)
- **Source skills catalogued:** 200+ (up from ~80-90 — major expansion)
- **CHORUS extras (enabled in fork, disabled in source):** 10 (up from 3 last week)
- **Adoption gap (source enabled, fork absent):** 3 (down from 5 last week)
- **Forks with no `aeon.yml`:** 38 (sim-tool forks)
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
