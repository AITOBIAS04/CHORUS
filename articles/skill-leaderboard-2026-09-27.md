# Skill Leaderboard — 2026-09-27

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

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-09-27, today). CHORUS skill stack unchanged at 14 skills.*

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

CHORUS runs 10 skills absent from the source stack (unchanged from last week).

---

## Adoption Gaps

Skills enabled in the source (`aaronjmars/miroshark-aeon`) but not enabled in CHORUS — **4 total** (down from 5 last week: `changelog` disabled in source):

| Skill | Notes |
|-------|-------|
| `token-movers` | Source's market-movers scan (CoinGecko + single-token deep report). CHORUS retains the older `token-report` for the same purpose. |
| `holdings` | Weekly Mon 08:00 UTC — wallet holdings of MiroShark from memory/holdings.json; amount, % of supply, 7d/30d growth. Not present in CHORUS. |
| `shiplog` | Weekly Mon 09:00 UTC — everything shipped since the last run (PRs/commits, security fixes, star deltas, X/ecosystem traction). CHORUS runs the older `weekly-shiplog` variant but not this updated form. |
| `aeon-update` | Weekly Mon 11:00 UTC — pull upstream framework changes (canon) into this instance as a PR; 3-way merge, never clobbers operator config. Not present in CHORUS. |

**Source skill configuration change this week:** `changelog` disabled in source (was enabled Mon 08:00 UTC — cross-repo changelog PR to miroshark-website). This closes one adoption gap without CHORUS doing anything.

---

## Week-over-Week

Compared to the 2026-09-22 leaderboard:

**Fleet size:** Unchanged — 1 Aeon fork with readable `aeon.yml` (18th consecutive week)

**CHORUS skill count:** 14 → 14 (no change; stack stable)

**Source enabled skills:** 9 → 8 (-1: `changelog` disabled in source)

**Adoption gaps:** 5 → 4 (-1: `changelog` no longer an adoption gap since it's disabled in source; the gap closed from the source side, not CHORUS adding the skill)

**CHORUS extras (enabled in CHORUS, absent from source):** 10 → 10 (unchanged)

**Shared skills (in both):** 4 (repo-pulse, fetch-tweets, memory-flush, heartbeat — unchanged)

**MiroShark sim-tool forks (30d window):** 13 → 12 (one fork fell outside the 30-day window; 12 active forks, none with `aeon.yml` — expected)

**Stars / forks:** 1,453 / 300 → 1,457 / 300 (+4 stars, 0 new forks this week)

**Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the eighteenth consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet

The leaderboard scans two layers:

**Layer 1 — MiroShark sim-tool forks (`aaronjmars/MiroShark`):** 12 active forks in the 30-day window (Aug 28 – Sep 27). These fork the simulation product (frontend + backend), not the Aeon agent runtime. None have `aeon.yml` — expected.

**Layer 2 — Aeon runtime forks (`aaronjmars/miroshark-aeon`):** 1 active fork with readable `aeon.yml`:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-09-27 (today) |

The source repo catalogs 200+ skills but enables only 8 by default (down from 9 — `changelog` disabled this week). CHORUS enables 14 — still the broadest stack in the fleet.

**Source skill configuration (current, as of 2026-09-27):**

| Skill | Schedule | Notes |
|-------|----------|-------|
| `repo-pulse` | Mon 10:00 UTC | Weekly stars/forks/releases digest for watched repos |
| `token-movers` | Daily 06:00 UTC | Market-movers scan + single-token report |
| `holdings` | Mon 08:00 UTC | Wallet MiroShark holdings tracker |
| `fetch-tweets` | Daily 17:00 UTC | Tracked X accounts digest |
| `shiplog` | Mon 09:00 UTC | Weekly shipped-commits digest |
| `memory-flush` | Sun 18:00 UTC | Weekly MEMORY.md rotation |
| `aeon-update` | Mon 11:00 UTC | Upstream canon sync via PR (3-way merge) |
| `heartbeat` | Daily 19:00 UTC | Fleet-health ambient check |

*(Removed since last week: `changelog` — cross-repo changelog PR to miroshark-website, previously Mon 08:00 UTC)*

---

## Fleet Summary

- **Target repos scanned:** aaronjmars/MiroShark + aaronjmars/miroshark-aeon
- **Active MiroShark forks (pushed in last 30 days):** 12
- **Forks with readable `aeon.yml` (MiroShark layer):** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 8 (repo-pulse, token-movers, holdings, fetch-tweets, shiplog, memory-flush, aeon-update, heartbeat)
- **Source skills catalogued:** 200+
- **Shared skills (CHORUS + source):** 4 (repo-pulse, fetch-tweets, memory-flush, heartbeat)
- **CHORUS extras (enabled in CHORUS, disabled/absent in source):** 10 (unchanged)
- **Adoption gaps (source enabled, CHORUS disabled/absent):** 4 (token-movers, holdings, shiplog, aeon-update)
- **Forks with no `aeon.yml` (sim-tool layer):** 12
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
