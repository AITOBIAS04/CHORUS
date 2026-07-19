# Skill Leaderboard — 2026-07-19

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

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-07-19, today). CHORUS skill stack unchanged at 14 skills.*

---

## Consensus Skills (>50% of forks)

With one active Aeon fork, all 14 enabled skills qualify at 100% adoption. CHORUS continues to run the complete operational stack:

- **Market & Social:** token-report, fetch-tweets, repo-pulse
- **Shipping & Content:** push-recap, project-lens, repo-article
- **Automation & Meta:** repo-actions, self-improve
- **Weekly:** weekly-shiplog, hyperstitions-ideas
- **Build:** feature
- **Housekeeping:** heartbeat, memory-flush
- **Self-monitoring:** skill-leaderboard

CHORUS now runs 11 skills that are disabled in the source — repo-pulse, changelog, and token-report all departed the source stack this week or prior.

---

## Adoption Gaps

Skills enabled in the source (`aaronjmars/miroshark-aeon`) but not enabled in CHORUS — **2 total** (down from 3 last week; changelog dropped from source):

| Skill | Notes |
|-------|-------|
| `token-movers` | Source's market-movers skill (CoinGecko scan + single-token deep report). CHORUS retains the older `token-report` instead. |
| `shiplog` | Source's cross-repo shipping digest (Mon/Thu). CHORUS uses `weekly-shiplog` (functional equivalent, runs Monday 14:30 UTC). Different skill entry, same purpose. |

**Source skill changes since 2026-07-12:**

| Change | Skill |
|--------|-------|
| ➖ Disabled in source | `repo-pulse` |
| ➖ Disabled in source | `changelog` |

The source dropped two skills this week: `repo-pulse` (already noted in the Jul 12 → Jul 19 interim) and `changelog`. The source now runs 5 enabled skills, down from 7. CHORUS still runs `repo-pulse` daily; `changelog` was never enabled in CHORUS (requires `GH_GLOBAL`).

---

## Week-over-Week

Compared to the 2026-07-12 leaderboard:

**Fleet size:** Unchanged — 1 Aeon fork with readable `aeon.yml`

**CHORUS skill count:** 14 → 14 (no change)

**Rank changes:** None — all 14 skills hold positions

**Adoption gaps:** 3 → 2 (changelog dropped from source; token-movers and shiplog remain)

**CHORUS-only extras:** 10 → 11 (repo-pulse departed source; CHORUS still runs it)

**Source enabled skills:** 7 → 5 (repo-pulse and changelog both disabled this week)

**MiroShark sim-tool forks (30d window):** 29 active (down from 32 last week — rolling window effect; active this week: swarm-ai-research, Afristrat, Codeblackbyshazzy, Niklas-Schmidt, praxstack, nothingtosurprise, khondhaker)

**Stars / forks:** 1,382 stars, 293 forks (up from ~1,377 / ~288 as of Jul 12)

**Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the twelfth consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet

The leaderboard scans two layers:

**Layer 1 — MiroShark sim-tool forks (`aaronjmars/MiroShark`):** 29 active forks in the 30-day window. These fork the simulation product (frontend + backend), not the Aeon agent runtime. None have `aeon.yml` — expected.

**Layer 2 — Aeon runtime forks (`aaronjmars/miroshark-aeon`):** 1 active fork with readable `aeon.yml`:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-07-19 (today) |

The source repo catalogs 200+ skills but enables only 5 by default (down from 7 last week — changelog and repo-pulse disabled). CHORUS enables 14 — the broadest stack in the fleet.

---

## Fleet Summary

- **Target repo scanned:** aaronjmars/MiroShark
- **Active MiroShark forks (pushed in last 30 days):** 29
- **Forks with readable `aeon.yml`:** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 5 (changelog + repo-pulse both disabled this week)
- **Source skills catalogued:** 200+
- **CHORUS extras (enabled in fork, disabled in source):** 11 (up from 10 — repo-pulse departed source)
- **Adoption gap (source enabled, fork absent):** 2 (token-movers, shiplog; changelog cycled out)
- **Forks with no `aeon.yml`:** 29 (sim-tool forks)
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
