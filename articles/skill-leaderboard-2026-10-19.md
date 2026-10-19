# Skill Leaderboard — 2026-10-19

*2 active Aeon forks scanned (pushed in last 30 days)*

---

## Top Skills Across the Fleet

| Rank | Skill | Forks Enabled | % of Fleet | Change |
|------|-------|---------------|------------|--------|
| 1 | fetch-tweets | 2 | 100% | — |
| 2 | heartbeat | 2 | 100% | — |
| 3 | memory-flush | 2 | 100% | — |
| 4 | repo-pulse | 2 | 100% | — |
| 5 | aeon-update | 1 | 50% | — |
| 6 | changelog | 1 | 50% | — |
| 7 | feature | 1 | 50% | — |
| 8 | holdings | 1 | 50% | — |
| 9 | hyperstitions-ideas | 1 | 50% | — |
| 10 | project-lens | 1 | 50% | — |
| 11 | push-recap | 1 | 50% | — |
| 12 | repo-actions | 1 | 50% | — |
| 13 | repo-article | 1 | 50% | — |
| 14 | self-improve | 1 | 50% | — |
| 15 | shiplog | 1 | 50% | — |
| 16 | skill-leaderboard | 1 | 50% | — |
| 17 | token-movers | 1 | 50% | — |
| 18 | token-report | 1 | 50% | — |
| 19 | weekly-shiplog | 1 | 50% | — |

---

## Consensus Skills (>50% of forks)

Four skills are enabled by every active Aeon instance — the minimum viable running stack, unchanged for two consecutive leaderboard periods:

| Skill | Both Forks | Notes |
|-------|-----------|-------|
| `fetch-tweets` | ✓ | Daily X/Twitter digest — social pulse regardless of instance purpose |
| `heartbeat` | ✓ | Ambient health check — the fleet's immune system |
| `memory-flush` | ✓ | Weekly MEMORY.md rotation — shared housekeeping discipline |
| `repo-pulse` | ✓ | Weekly stars/forks/releases digest — community growth awareness |

These four represent a convergent minimum: no matter how differently CHORUS and elegarmco are configured for their respective purposes, both decided independently that social monitoring, health checking, memory rotation, and community awareness are non-negotiable. That consensus is signal.

---

## Adoption Gaps

No adoption gaps. Every skill enabled in the source (`aaronjmars/miroshark-aeon`) appears in at least one active fork. elegarmco mirrors the source config exactly; CHORUS runs a superset.

This has been true for two consecutive leaderboard periods. The fleet isn't leaving source skills behind — it's extending beyond them.

---

## Week-over-Week

Compared to the 2026-10-04 leaderboard:

**Fleet size:** 2 → 2 (unchanged). elegarmco last pushed 2026-10-03 (pre-leaderboard, unchanged). AITOBIAS04/CHORUS pushed 2026-10-19 (today) but skill configuration is stable — same 14 enabled skills as Oct 4.

**Skill counts:** Identical to last week. No skill entered or exited either fork's enabled set.

**Rank changes:** None. The table is a flat copy of Oct 4.

**What moved:** CHORUS had commits this week (pushed today; last leaderboard the last push was 2026-10-04). The repo is active — self-improve and repo-actions have been running — but no skill was added or removed. Configuration is stable across a 15-day window.

**Takeaway:** Two consecutive identical leaderboards with 2 forks. The fleet is either converged or too small to show meaningful churn. The next meaningful signal comes when a third fork joins the 30-day window, or when either CHORUS or elegarmco flips a skill.

---

## Fleet Detail

| Fork | Last Push | aeon.yml | Enabled Skills |
|------|-----------|----------|----------------|
| AITOBIAS04/CHORUS | 2026-10-19 (today) | ✓ | 14 |
| elegarmco/miroshark-aeon | 2026-10-03 | ✓ | 9 |

**CHORUS vs elegarmco divergence:**
- **Shared skills (both enabled):** fetch-tweets, repo-pulse, heartbeat, memory-flush (4)
- **CHORUS only:** token-report, push-recap, project-lens, repo-actions, repo-article, self-improve, weekly-shiplog, hyperstitions-ideas, feature, skill-leaderboard (10)
- **elegarmco only:** token-movers, holdings, changelog, aeon-update, shiplog (5)

CHORUS remains the broadest stack (14 vs 9). elegarmco runs the source configuration without modification. The divergence pattern is stable — CHORUS extended upward, elegarmco stayed canonical.

---

## Fleet Summary

- **Target repos scanned:** aaronjmars/MiroShark + aaronjmars/miroshark-aeon
- **Active MiroShark forks (pushed in last 30 days):** 22 (up from 16 last week)
- **Forks with readable `aeon.yml` (MiroShark layer):** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 2 (unchanged)
- **Total skill slots enabled (Aeon fleet):** 23 (14 + 9)
- **Unique skills seen:** 19
- **Source skills enabled:** 9 (repo-pulse, token-movers, holdings, fetch-tweets, changelog, memory-flush, aeon-update, heartbeat, shiplog)
- **Shared skills (both forks):** 4 (fetch-tweets, repo-pulse, heartbeat, memory-flush)
- **Adoption gaps (source enabled, zero forks):** 0
- **CHORUS extras:** 10
- **elegarmco extras:** 5
- **MiroShark sim-tool forks (no aeon.yml):** 22
- **Notification sent:** yes

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
