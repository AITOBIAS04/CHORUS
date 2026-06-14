# Skill Leaderboard — 2026-06-14

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

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-06-14). Skill stack unchanged from last week.*

---

## Consensus Skills (>50% of forks)

With one active Aeon fork, all 14 enabled skills qualify at 100% adoption. The fleet's single running instance holds the complete core stack:

- **Market & Social:** token-report, fetch-tweets, repo-pulse
- **Shipping & Content:** push-recap, project-lens, repo-article
- **Meta & Iteration:** repo-actions, self-improve
- **Weekly:** weekly-shiplog, hyperstitions-ideas
- **Build:** feature
- **Housekeeping:** heartbeat, memory-flush
- **Self-monitoring:** skill-leaderboard

Three skills — `fetch-tweets`, `hyperstitions-ideas`, and `skill-leaderboard` — are disabled in the source (`aaronjmars/miroshark-aeon`) but actively enabled in CHORUS. This fork maintains a deliberate divergence: more social signal ingestion, speculative goal tracking, and self-audit infrastructure.

---

## Adoption Gaps

Skills enabled in source (`aaronjmars/miroshark-aeon`) but absent in all forks — **4 total** (unchanged from last week, with one rename):

| Skill | Notes |
|-------|-------|
| `thread-formatter` | Formats top daily event as a tweet thread; daily 17:30 UTC |
| `operator-scorecard` | Weekly operator health self-assessment; Monday 10:30 UTC |
| `star-milestone` | Announces star-count milestone crossings; daily 15:15 UTC |
| `star-momentum` | Projects next milestone crossing date; daily 10:10 UTC (renamed from `star-momentum-alert`) |

All four are low-friction additions. The source renamed `star-momentum-alert` → `star-momentum` this cycle, but the skill's function is unchanged.

**Source catalog expansion:** `aaronjmars/miroshark-aeon`'s skill library grew significantly this week with 25+ new disabled skills added across four new families:
- **Strategy & Identity:** `strategy-builder`, `soul-builder`
- **GitHub intelligence:** `pr-triage`, `skill-triage`, `huggingface-trending`
- **Onchain investigation:** `rug-scan`, `investigation-report`, `fund-flow`, `linked-wallets`, `lp-lock`, `honeypot-check`, `approval-audit`, `contract-audit`, `wallet-profile`, `deployer-trace`, `tx-explain`, `holder-concentration`, `vigil-revoke`, `vigil`
- **Market signals:** `price-alert`, `market-context`, `monitor-kalshi`, `aixbt-pulse`, `liquidpad-launch`

None of these trigger an adoption gap in the strict sense — they're shipped disabled in the source itself. But the catalog is clearly building toward a multi-operator, multi-use-case framework rather than a single-project deployment.

---

## Week-over-Week

Compared to the 2026-06-07 leaderboard:

- **Fork name:** AITOBIAS04/CHORUS — unchanged
- **Aeon fleet size:** Unchanged — 1 fork with readable `aeon.yml`
- **Skill count in fork:** 14 → 14 (no change)
- **Rank changes:** None — all 14 skills hold their positions
- **Adoption gaps:** 4 → 4 (same skills; `star-momentum-alert` renamed to `star-momentum` in source)
- **Source enabled skills:** 15 → 15 (no change in enabled count)
- **Source catalog growth:** 25+ new disabled skills added (onchain investigation suite, strategy/identity builders, advanced market monitoring)
- **CHORUS divergence count:** 3 skills enabled in CHORUS but disabled in source (fetch-tweets, hyperstitions-ideas, skill-leaderboard) — unchanged
- **MiroShark sim-tool forks (30d window):** 50 active (down from 54 — April/May fork wave continues to age out of the 30-day window)
- **Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the sixth consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet

`memory/watched-repos.md` primary target is `aaronjmars/MiroShark`, which yields 50 active sim-tool forks (pushed in last 30 days). MiroShark forks copy the simulation UI — they have no `aeon.yml` because Aeon is a separate agent runtime (`aaronjmars/miroshark-aeon`).

For skill-leaderboard purposes, the meaningful signal is the `miroshark-aeon` fleet:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-06-14 (today) |

---

## Fleet Summary

- **Target repo scanned:** aaronjmars/MiroShark
- **Active MiroShark forks (pushed in last 30 days):** 50
- **Forks with readable `aeon.yml`:** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 15
- **CHORUS extras (enabled in fork, disabled in source):** 3 (fetch-tweets, hyperstitions-ideas, skill-leaderboard)
- **Adoption gap (source enabled, fork absent):** 4
- **Source catalog new additions (disabled):** 25+ (onchain investigation, strategy/identity, advanced market)
- **Forks with no `aeon.yml`:** 50 (sim-tool forks)
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
