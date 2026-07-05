# Skill Leaderboard — 2026-07-05

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

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-07-05, today). CHORUS skill stack unchanged at 14 skills.*

---

## Consensus Skills (>50% of forks)

With one active Aeon fork, all 14 enabled skills qualify at 100% adoption. The fleet's single running instance continues to maintain the complete operational stack:

- **Market & Social:** token-report, fetch-tweets, repo-pulse
- **Shipping & Content:** push-recap, project-lens, repo-article
- **Automation & Meta:** repo-actions, self-improve
- **Weekly:** weekly-shiplog, hyperstitions-ideas
- **Build:** feature
- **Housekeeping:** heartbeat, memory-flush
- **Self-monitoring:** skill-leaderboard

CHORUS runs 10 skills that are disabled in the source — the broadest stack in the fleet for the ninth consecutive week.

---

## Adoption Gaps

Skills enabled in the source (`aaronjmars/miroshark-aeon`) but not enabled in CHORUS — **3 total** (unchanged from last week):

| Skill | Notes |
|-------|-------|
| `docs-sync` | Converts newly-merged product-repo PRs into changelog entries on the marketing site via a draft PR. Requires `GH_GLOBAL`. Runs every 3 days at 08:00 UTC. |
| `shiplog` | Weekly shipping log (Monday + Thursday); analogous to CHORUS's `weekly-shiplog`. Functional overlap remains — CHORUS has not adopted the renamed/rescheduled variant. |
| `tweet-digest` | Daily account-based X digest of tracked accounts. Enabled in source; CHORUS has the skill present but disabled. |

---

## Week-over-Week

Compared to the 2026-06-28 leaderboard:

**Fleet size:** Unchanged — 1 Aeon fork with readable `aeon.yml`

**CHORUS skill count:** 14 → 14 (no change)

**Rank changes:** None — all 14 skills hold positions

**Adoption gaps:** 3 → 3 (no change — docs-sync, shiplog, tweet-digest remain unmirrored)

**CHORUS-only extras:** 10 → 10 (no change)

**Source enabled skills:** 7 → 7 (no change — docs-sync, token-report, repo-pulse, shiplog, tweet-digest, heartbeat, memory-flush)

**MiroShark sim-tool forks (30d window):** 36 active (down from ~38 — two more forks aged out of the 30-day window; swarm-ai-research and dan-and are among the most recently active, both pushed 2026-07-03/04)

**Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the ninth consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet

The leaderboard scans two layers:

**Layer 1 — MiroShark sim-tool forks (`aaronjmars/MiroShark`):** 36 active forks in the 30-day window (down from 38). These fork the simulation product (frontend + backend), not the Aeon agent runtime. None have `aeon.yml` — expected.

**Layer 2 — Aeon runtime forks (`aaronjmars/miroshark-aeon`):** 1 active fork with readable `aeon.yml`:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-07-05 (today) |

The source repo catalogs 200+ skills but enables only 7 by default. CHORUS enables 14 — the broadest stack in the fleet.

---

## Fleet Summary

- **Target repo scanned:** aaronjmars/MiroShark
- **Active MiroShark forks (pushed in last 30 days):** 36
- **Forks with readable `aeon.yml`:** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 7 (unchanged)
- **Source skills catalogued:** 200+
- **CHORUS extras (enabled in fork, disabled in source):** 10 (unchanged)
- **Adoption gap (source enabled, fork absent):** 3 (unchanged)
- **Forks with no `aeon.yml`:** 36 (sim-tool forks)
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
