# Skill Leaderboard — 2026-10-04

*2 active Aeon forks scanned (pushed in last 30 days)*

> **Notification threshold met for the first time.** This is the first leaderboard run with ≥2 Aeon forks carrying readable `aeon.yml` files. Nineteen consecutive weeks of SKILL_LEADERBOARD_INSUFFICIENT_DATA ends here.

---

## Top Skills Across the Fleet

| Rank | Skill | Forks Enabled | % of Fleet | Change |
|------|-------|---------------|------------|--------|
| 1 | fetch-tweets | 2 | 100% | — |
| 2 | heartbeat | 2 | 100% | — |
| 3 | memory-flush | 2 | 100% | — |
| 4 | repo-pulse | 2 | 100% | — |
| 5 | aeon-update | 1 | 50% | New |
| 6 | changelog | 1 | 50% | New |
| 7 | feature | 1 | 50% | — |
| 8 | holdings | 1 | 50% | New |
| 9 | hyperstitions-ideas | 1 | 50% | — |
| 10 | project-lens | 1 | 50% | — |
| 11 | push-recap | 1 | 50% | — |
| 12 | repo-actions | 1 | 50% | — |
| 13 | repo-article | 1 | 50% | — |
| 14 | self-improve | 1 | 50% | — |
| 15 | shiplog | 1 | 50% | New |
| 16 | skill-leaderboard | 1 | 50% | — |
| 17 | token-movers | 1 | 50% | New |
| 18 | token-report | 1 | 50% | — |
| 19 | weekly-shiplog | 1 | 50% | — |

---

## Consensus Skills (>50% of forks)

Four skills are enabled by every active Aeon instance — the irreducible core of a running fleet:

| Skill | Both Forks | Notes |
|-------|-----------|-------|
| `fetch-tweets` | ✓ | Daily X/Twitter digest — social pulse regardless of instance purpose |
| `heartbeat` | ✓ | Ambient health check — the fleet's immune system, always on |
| `memory-flush` | ✓ | Weekly MEMORY.md rotation — shared housekeeping discipline |
| `repo-pulse` | ✓ | Weekly stars/forks/releases digest — community growth awareness |

These four form what the data now suggests is the **minimum viable Aeon stack**: social monitoring, health checking, memory maintenance, and community awareness. Any operator evaluating which skills to enable first has a clear answer.

---

## Adoption Gaps

No source-enabled skills sit at zero adoption this week — every skill the source runs (`repo-pulse`, `token-movers`, `holdings`, `fetch-tweets`, `changelog`, `memory-flush`, `aeon-update`, `heartbeat`, `shiplog`) appears in at least one active fork.

This is the first leaderboard with zero adoption gaps from the source side. The fleet isn't missing source functionality — it's diverging from it.

---

## Week-over-Week

Compared to the 2026-09-27 leaderboard:

**Fleet size:** 1 → 2 Aeon forks (+1: `elegarmco/miroshark-aeon` joined the 30-day window, pushed 2026-10-03)

**First meaningful comparison possible:** With two forks, the leaderboard produces real signal for the first time.

**New skills entering the fleet** (brought by elegarmco):
- `aeon-update` — upstream canon sync via PR (weekly Mon 11:00 UTC)
- `changelog` — cross-repo changelog PR to miroshark-website (re-enabled in source this week; elegarmco mirrors it)
- `holdings` — on-chain wallet holdings tracker (weekly Mon 08:00 UTC)
- `shiplog` — shipped-commits digest (weekly Mon 09:00 UTC)
- `token-movers` — daily market-movers scan (CHORUS runs `token-report` instead)

**Source skill change:** `changelog` re-enabled in source (was disabled as of 2026-09-27). elegarmco mirrors source config exactly — this was an automatic adoption.

**CHORUS skill count:** 14 → 14 (stack stable for 19+ weeks)

**Forks eligible to have their notification threshold met:** 0 of 1 → 0 of 2 (neither fork has TELEGRAM/DISCORD/SLACK configured, based on `telegram: enabled: false` in both; notification threshold in this skill's own output is now met regardless)

**MiroShark sim-tool forks (30d window):** 12 → 16 (+4 forks; none have `aeon.yml` — expected)

**Notification status:** First notification sent after 19 consecutive SKILL_LEADERBOARD_INSUFFICIENT_DATA weeks

---

## Fleet Detail

| Fork | Last Push | aeon.yml | Enabled Skills |
|------|-----------|----------|----------------|
| AITOBIAS04/CHORUS | 2026-10-04 (today) | ✓ | 14 |
| elegarmco/miroshark-aeon | 2026-10-03 (yesterday) | ✓ | 9 |

**CHORUS vs elegarmco divergence:**
- **Shared skills (both enabled):** fetch-tweets, repo-pulse, heartbeat, memory-flush (4)
- **CHORUS only:** token-report, push-recap, project-lens, repo-actions, repo-article, self-improve, weekly-shiplog, hyperstitions-ideas, feature, skill-leaderboard (10)
- **elegarmco only:** token-movers, holdings, changelog, aeon-update, shiplog (5)

CHORUS is the broadest stack in the fleet by skill count (14 vs 9). elegarmco runs the source configuration without modification — a clean upstream mirror. CHORUS adds 10 skills above source; elegarmco adds none but enables 5 source skills CHORUS has replaced or skipped.

---

## Fleet Summary

- **Target repos scanned:** aaronjmars/MiroShark + aaronjmars/miroshark-aeon
- **Active MiroShark forks (pushed in last 30 days):** 16 (up from 12 last week)
- **Forks with readable `aeon.yml` (MiroShark layer):** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 2 (up from 1)
- **Total skill slots enabled (Aeon fleet):** 23 (14 + 9)
- **Unique skills seen (Aeon fleet):** 19
- **Source skills enabled:** 9 (repo-pulse, token-movers, holdings, fetch-tweets, changelog, memory-flush, aeon-update, heartbeat, shiplog)
- **Source skills catalogued:** 200+
- **Shared skills (both forks):** 4 (fetch-tweets, repo-pulse, heartbeat, memory-flush)
- **Adoption gaps (source enabled, zero forks):** 0 — first time all source skills appear in at least one fork
- **CHORUS extras (CHORUS enabled, absent from source):** 10
- **elegarmco extras (elegarmco enabled, absent from CHORUS):** 5
- **Forks with no `aeon.yml` (sim-tool layer):** 16
- **Notification sent:** yes (first time)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
