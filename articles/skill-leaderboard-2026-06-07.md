# Skill Leaderboard — 2026-06-07

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

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-06-07). Skill stack unchanged from last week.*

---

## Consensus Skills (>50% of forks)

With one active Aeon fork, all 14 enabled skills qualify at 100% adoption. The fleet's single running instance covers the complete core stack:

- **Market & Social:** token-report, fetch-tweets, repo-pulse
- **Shipping & Content:** push-recap, project-lens, repo-article
- **Content & Meta:** repo-actions, self-improve
- **Weekly:** weekly-shiplog, hyperstitions-ideas
- **Build:** feature
- **Housekeeping:** heartbeat, memory-flush
- **Meta:** skill-leaderboard

Three of these skills — fetch-tweets, hyperstitions-ideas, and skill-leaderboard — are disabled in the source repo (aaronjmars/miroshark-aeon) but actively enabled in CHORUS. This fork has diverged from the upstream default configuration in a deliberate direction: more social signal capture, more speculative goal-tracking, and self-monitoring infrastructure.

---

## Adoption Gaps

Skills enabled in source (`aaronjmars/miroshark-aeon`) but absent in all forks — **4 total** (unchanged from last week):

| Skill | Setup Barrier | Notes |
|-------|---------------|-------|
| `thread-formatter` | Low — no external secrets | Formats today's top event as a 5-tweet thread ready to paste; daily 17:30 UTC |
| `operator-scorecard` | Low — reads local memory | Weekly operator health self-assessment; Monday 10:30 UTC |
| `star-milestone` | Low — GitHub API via `gh` | Announces star-count milestone crossings; daily 15:15 UTC |
| `star-momentum-alert` | Low — reads repo-pulse history | Projects next milestone crossing date; daily 10:10 UTC |

All four gaps are low-friction additions with no external secret requirements. The source repo has also grown its disabled skill catalog significantly — 20+ new skills were added upstream (fork-cohort, fleet-state, contributor-spotlight, smithery-manifest, show-hn-draft, skill-analytics, and others), all shipped disabled. None of these represent adoption gaps in the strict sense because the source itself doesn't enable them.

---

## Week-over-Week

Compared to the 2026-05-31 leaderboard:

- **Fork name:** AITOBIAS04/CHORUS — unchanged
- **Aeon fleet size:** Unchanged — 1 fork with readable `aeon.yml`
- **Skill count in fork:** 14 → 14 (no change)
- **Rank changes:** None — all 14 skills hold their positions
- **Adoption gaps:** 4 → 4 (no change — same 4 skills)
  - *Unchanged:* `thread-formatter`, `operator-scorecard`, `star-milestone`, `star-momentum-alert`
- **Source enabled skills:** 15 → 15 (no change in enabled count)
- **Source catalog growth:** ~20 new disabled skills added upstream since last week (fleet-management, social syndication, and platform-monitoring skill families)
- **CHORUS divergence count:** 3 skills enabled in CHORUS but disabled in source (fetch-tweets, hyperstitions-ideas, skill-leaderboard) — unchanged
- **MiroShark sim-tool forks (30d window):** 54 active (down from 72 — 30-day window continuing to roll past the April/May fork wave)
- **Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the fifth consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet (miroshark-aeon)

`memory/watched-repos.md` primary target is `aaronjmars/MiroShark`, which yields 54 active sim-tool forks (pushed in last 30 days). MiroShark forks copy the simulation UI — they have no `aeon.yml` because Aeon is a separate agent runtime repo (`aaronjmars/miroshark-aeon`).

For skill-leaderboard purposes, the meaningful signal is the `miroshark-aeon` fleet:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-06-07 (today) |

---

## Fleet Summary

- **Target repo scanned:** aaronjmars/MiroShark
- **Active MiroShark forks (pushed in last 30 days):** 54
- **Forks with readable `aeon.yml`:** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 15
- **CHORUS extras (enabled in fork, disabled in source):** 3 (fetch-tweets, hyperstitions-ideas, skill-leaderboard)
- **Adoption gap (source enabled, fork absent):** 4
- **Forks with no `aeon.yml`:** 54 (sim-tool forks)
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
