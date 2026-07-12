# Skill Leaderboard — 2026-07-12

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

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-07-12, today). CHORUS skill stack unchanged at 14 skills.*

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

CHORUS runs 10 skills that are disabled in the source — the broadest stack in the fleet for the tenth consecutive week.

---

## Adoption Gaps

Skills enabled in the source (`aaronjmars/miroshark-aeon`) but not enabled in CHORUS — **3 total** (same count; composition changed from last week):

| Skill | Notes |
|-------|-------|
| `changelog` | New in source this week — converts newly-merged PRs into changelog entries. Present in CHORUS aeon.yml but disabled. Requires `GH_GLOBAL`. |
| `shiplog` | Weekly shipping log variant in source. CHORUS uses `weekly-shiplog` (renamed equivalent, runs Monday 14:30 UTC). Functional overlap but different skill entry. |
| `token-movers` | New in source this week — replaces `token-report` in the source's daily market stack. CHORUS retains `token-report` (present but disabled in source) and has `token-movers` disabled. |

**Source skill changes since 2026-07-05:**

| Change | Skill |
|--------|-------|
| ➕ Added to source | `changelog`, `fetch-tweets`, `token-movers` |
| ➖ Removed from source | `docs-sync`, `token-report`, `tweet-digest` |

The source swapped its social monitoring pair: `tweet-digest` → `fetch-tweets` (CHORUS already ran `fetch-tweets`). The market pair shifted: `token-report` → `token-movers`. `docs-sync` was dropped entirely from the source's enabled stack.

---

## Week-over-Week

Compared to the 2026-07-05 leaderboard:

**Fleet size:** Unchanged — 1 Aeon fork with readable `aeon.yml`

**CHORUS skill count:** 14 → 14 (no change)

**Rank changes:** None — all 14 skills hold positions

**Adoption gaps:** 3 → 3 (count unchanged; composition changed — docs-sync and tweet-digest dropped from source, changelog and token-movers are new gaps; shiplog persists)

**CHORUS-only extras:** 10 → 10 (no change)

**Source enabled skills:** 7 → 7 (unchanged count; significant rotation — 3 removed, 3 added)

**MiroShark sim-tool forks (30d window):** 32 active (up from ~36 last week — net shift reflects the rolling 30-day window; recent entries include deepmindru-afk, kevinpinscoe, Syanhlu, agproproducts-web, Afristrat)

**Stars / forks:** 1,359 stars, 288 forks (up from ~1,357 / ~285 as of Jul 5)

**Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the tenth consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet

The leaderboard scans two layers:

**Layer 1 — MiroShark sim-tool forks (`aaronjmars/MiroShark`):** 32 active forks in the 30-day window. These fork the simulation product (frontend + backend), not the Aeon agent runtime. None have `aeon.yml` — expected. Notably active this week: deepmindru-afk, kevinpinscoe, Syanhlu, agproproducts-web, tahatalib85, dan-and, Afristrat.

**Layer 2 — Aeon runtime forks (`aaronjmars/miroshark-aeon`):** 1 active fork with readable `aeon.yml`:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-07-12 (today) |

The source repo catalogs 200+ skills but enables only 7 by default. CHORUS enables 14 — the broadest stack in the fleet.

---

## Fleet Summary

- **Target repo scanned:** aaronjmars/MiroShark
- **Active MiroShark forks (pushed in last 30 days):** 32
- **Forks with readable `aeon.yml`:** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 7 (changed composition — 3 added, 3 removed vs last week)
- **Source skills catalogued:** 200+
- **CHORUS extras (enabled in fork, disabled in source):** 10 (unchanged)
- **Adoption gap (source enabled, fork absent):** 3 (unchanged count; changelog + token-movers are new; docs-sync + tweet-digest cycled out)
- **Forks with no `aeon.yml`:** 32 (sim-tool forks)
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
