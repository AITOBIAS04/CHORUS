# Skill Leaderboard — 2026-06-21

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

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-06-21). Skill stack unchanged from last week.*

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

Three skills — `fetch-tweets`, `hyperstitions-ideas`, and `skill-leaderboard` — remain disabled in the source (`aaronjmars/miroshark-aeon`) but actively enabled in CHORUS. This fork continues to maintain deliberate divergence: more social signal ingestion, speculative goal tracking, and self-audit infrastructure.

---

## Adoption Gaps

Skills enabled in source (`aaronjmars/miroshark-aeon`) but absent in all Aeon forks — **5 total** (net +1 from last week):

| Skill | Notes |
|-------|-------|
| `star-milestone` | Announces star-count milestone crossings; daily 15:15 UTC |
| `star-momentum` | Projects next milestone crossing date; daily 10:10 UTC |
| `thread-formatter` | Formats top daily event as a tweet thread; daily 17:30 UTC |
| `shiplog` | Weekly shipping log; Monday 09:00 UTC (was `weekly-shiplog` in source) |
| `tweet-digest` | Daily digest of tracked X accounts; daily 17:00 UTC — **newly enabled in source this week** |

The net change: `operator-scorecard` was removed from the source's enabled list; `tweet-digest` was added. CHORUS's local `weekly-shiplog` and the source's `shiplog` are the same skill under different names — CHORUS has not adopted the renamed variant.

---

## Week-over-Week

Compared to the 2026-06-14 leaderboard:

- **Fork name:** AITOBIAS04/CHORUS — unchanged
- **Aeon fleet size:** Unchanged — 1 fork with readable `aeon.yml`
- **CHORUS skill count:** 14 → 14 (no change)
- **Rank changes:** None — all 14 skills hold their positions
- **Source enabled skills:** 15 → 15 (same count; `operator-scorecard` removed, `tweet-digest` added)
- **Adoption gaps:** 4 → 5 (net +1 — `tweet-digest` newly enabled in source, `operator-scorecard` removed)
- **CHORUS divergence count:** 3 skills enabled in CHORUS but disabled in source (fetch-tweets, hyperstitions-ideas, skill-leaderboard) — unchanged
- **MiroShark sim-tool forks (30d window):** 43 active (down from 50 — April/May fork wave continues to age out; praxstack/aaronjmars-MiroShark is the newest, pushed today)
- **Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the seventh consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet

`memory/watched-repos.md` primary target is `aaronjmars/MiroShark`, which yields 43 active sim-tool forks (pushed in last 30 days, down from 50 last week). MiroShark forks copy the simulation UI — they have no `aeon.yml` because Aeon is a separate agent runtime (`aaronjmars/miroshark-aeon`).

For skill-leaderboard purposes, the meaningful signal is the `miroshark-aeon` fleet:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-06-21 (today) |

---

## Fleet Summary

- **Target repo scanned:** aaronjmars/MiroShark
- **Active MiroShark forks (pushed in last 30 days):** 43
- **Forks with readable `aeon.yml`:** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 15
- **CHORUS extras (enabled in fork, disabled in source):** 3 (fetch-tweets, hyperstitions-ideas, skill-leaderboard)
- **Adoption gap (source enabled, fork absent):** 5
- **Source changes this week:** `tweet-digest` added (enabled); `operator-scorecard` removed
- **Forks with no `aeon.yml`:** 43 (sim-tool forks)
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
