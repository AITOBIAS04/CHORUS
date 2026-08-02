# Skill Leaderboard — 2026-08-02

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

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-08-02, today). CHORUS skill stack unchanged at 14 skills.*

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

CHORUS runs 12 skills that are absent from the source stack — the broadest independent configuration in the fleet.

---

## Adoption Gaps

Skills enabled in the source (`aaronjmars/miroshark-aeon`) but not enabled in CHORUS — **3 total** (up from 2 last run):

| Skill | Notes |
|-------|-------|
| `token-movers` | Source's market-movers scan (CoinGecko + single-token deep report). CHORUS retains the older `token-report` for the same purpose. |
| `holdings` | New source skill (Mon 08:00 UTC): wallet holdings of MiroShark from memory/holdings.json — amount, % of supply, 7d/30d growth. Not present in CHORUS. |
| `changelog` | Re-enabled in source (Mon 08:00 UTC; pushes cross-repo PR to aaronjmars/miroshark-website). CHORUS has it disabled — requires `GH_GLOBAL` secret not set. |

**Source skill changes since 2026-07-19:**

| Change | Skill |
|--------|-------|
| ✅ Re-enabled in source | `repo-pulse` |
| ✅ Re-enabled in source | `changelog` |
| ➖ Dropped from source | 2 skills (unidentified; source went from 5-without-pulse/changelog → 5-with-pulse/changelog, net-neutral count) |
| ➕ Added to source | `holdings` (new weekly wallet tracker) |

Source currently enables 5 skills: `repo-pulse`, `token-movers`, `holdings`, `fetch-tweets`, `changelog`. Count unchanged from Jul 19 but composition shifted — repo-pulse and changelog are back, holdings is new.

---

## Week-over-Week

Compared to the 2026-07-19 leaderboard (2 weeks ago — no leaderboard ran Jul 26):

**Fleet size:** Unchanged — 1 Aeon fork with readable `aeon.yml` (13th consecutive week)

**CHORUS skill count:** 14 → 14 (no change; stack stable since at least Apr 30)

**Source enabled skills:** 5 → 5 (count stable; composition changed: repo-pulse + changelog returned, holdings added, 2 others cycled out)

**Adoption gaps:** 2 → 3 (shiplog removed from source; holdings + changelog added; token-movers remains)

**CHORUS extras (enabled in CHORUS, absent from source):** 11 → 12 (changelog moved from CHORUS-unique to source-enabled adoption-gap status)

**MiroShark sim-tool forks (30d window):** 29 → 28 (rolling window; replaced by Aug-active set)

**Stars / forks:** 1,382 / 293 → 1,412 / 298 (+30 stars, +5 forks in two weeks)

**Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the fourteenth consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet

The leaderboard scans two layers:

**Layer 1 — MiroShark sim-tool forks (`aaronjmars/MiroShark`):** 28 active forks in the 30-day window. These fork the simulation product (frontend + backend), not the Aeon agent runtime. None have `aeon.yml` — expected.

**Layer 2 — Aeon runtime forks (`aaronjmars/miroshark-aeon`):** 1 active fork with readable `aeon.yml`:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-08-02 (today) |

The source repo catalogs 200+ skills but enables only 5 by default. CHORUS enables 14 — the broadest stack in the fleet.

---

## Fleet Summary

- **Target repo scanned:** aaronjmars/MiroShark
- **Active MiroShark forks (pushed in last 30 days):** 28
- **Forks with readable `aeon.yml`:** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 5 (repo-pulse, token-movers, holdings, fetch-tweets, changelog)
- **Source skills catalogued:** 200+
- **CHORUS extras (enabled in fork, disabled/absent in source):** 12 (up from 11)
- **Adoption gaps (source enabled, CHORUS disabled/absent):** 3 (token-movers, holdings, changelog)
- **Forks with no `aeon.yml`:** 28 (sim-tool forks)
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
