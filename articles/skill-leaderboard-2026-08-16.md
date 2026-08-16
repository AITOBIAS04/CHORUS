# Skill Leaderboard — 2026-08-16

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

*1 active Aeon fork scanned: AITOBIAS04/CHORUS (pushed 2026-08-16, today). CHORUS skill stack unchanged at 14 skills.*

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

CHORUS runs 10 skills that are absent from the source stack — down from 12 two weeks ago as the source expanded its enabled set.

---

## Adoption Gaps

Skills enabled in the source (`aaronjmars/miroshark-aeon`) but not enabled in CHORUS — **4 total** (up from 3):

| Skill | Notes |
|-------|-------|
| `token-movers` | Source's market-movers scan (CoinGecko + single-token deep report). CHORUS retains the older `token-report` for the same purpose. |
| `holdings` | Weekly Mon 08:00 UTC — wallet holdings of MiroShark from memory/holdings.json; amount, % of supply, 7d/30d growth. Not present in CHORUS. |
| `changelog` | Weekly Mon 08:00 UTC — cross-repo changelog PR to aaronjmars/miroshark-website. CHORUS has it disabled (requires `GH_GLOBAL` secret not set). |
| `shiplog` | **New in source since Aug 2.** Weekly Mon 09:00 UTC — everything shipped since the last run (PRs/commits, security fixes, star deltas, X/ecosystem traction). CHORUS runs the older `weekly-shiplog` variant but not this updated form. |

**Source skill changes since 2026-08-02:**

| Change | Skill |
|--------|-------|
| ✅ Newly enabled in source | `memory-flush` (Sun 18:00 UTC — now enabled in source; was CHORUS-only) |
| ✅ Newly enabled in source | `heartbeat` (daily 19:00 UTC — now enabled in source; was CHORUS-only) |
| ➕ Added to source | `shiplog` (weekly Mon 09:00 UTC — new; distinct from CHORUS's `weekly-shiplog`) |

Source now enables 8 skills, up from 5 two weeks ago. The expansion added three operational-health skills (`memory-flush`, `heartbeat`, `shiplog`), narrowing the CHORUS-vs-source configuration gap.

---

## Week-over-Week

Compared to the 2026-08-02 leaderboard (2 weeks ago — no leaderboard ran Aug 9):

**Fleet size:** Unchanged — 1 Aeon fork with readable `aeon.yml` (15th consecutive week)

**CHORUS skill count:** 14 → 14 (no change; stack stable)

**Source enabled skills:** 5 → 8 (source expanded: added memory-flush, heartbeat, shiplog)

**Adoption gaps:** 3 → 4 (shiplog newly added to source; token-movers, holdings, changelog persist)

**CHORUS extras (enabled in CHORUS, absent from source):** 12 → 10 (memory-flush and heartbeat moved from CHORUS-unique to shared-with-source status)

**Shared skills (in both):** 2 → 4 (repo-pulse, fetch-tweets, memory-flush, heartbeat)

**MiroShark sim-tool forks (30d window):** 28 → 19 (rolling window shift; 9 forks from the previous cohort dropped below the 30-day cutoff)

**Stars / forks:** 1,412 / 298 → 1,430 / 298 (+18 stars, forks unchanged)

**Notification status:** SKILL_LEADERBOARD_INSUFFICIENT_DATA for the fifteenth consecutive week (1 Aeon fork, need ≥2)

---

## Context: The Aeon Fleet

The leaderboard scans two layers:

**Layer 1 — MiroShark sim-tool forks (`aaronjmars/MiroShark`):** 19 active forks in the 30-day window (Jul 17 – Aug 16). These fork the simulation product (frontend + backend), not the Aeon agent runtime. None have `aeon.yml` — expected.

**Layer 2 — Aeon runtime forks (`aaronjmars/miroshark-aeon`):** 1 active fork with readable `aeon.yml`:

| Fork | Active? | aeon.yml | Enabled Skills | Last Push |
|------|---------|----------|----------------|-----------|
| AITOBIAS04/CHORUS | Yes | ✓ | 14 | 2026-08-16 (today) |

The source repo catalogs 200+ skills but enables only 8 by default (up from 5). CHORUS enables 14 — still the broadest stack in the fleet.

**Source skill configuration (current, as of 2026-08-16):**

| Skill | Schedule | Notes |
|-------|----------|-------|
| `repo-pulse` | Mon 10:00 UTC | Weekly stars/forks/releases digest |
| `token-movers` | Daily 06:00 UTC | Market-movers scan + single-token report |
| `holdings` | Mon 08:00 UTC | Wallet MiroShark holdings tracker |
| `fetch-tweets` | Daily 17:00 UTC | Tracked X accounts digest |
| `changelog` | Mon 08:00 UTC | Cross-repo changelog PR to website |
| `shiplog` | Mon 09:00 UTC | Weekly shipped-commits digest (new) |
| `memory-flush` | Sun 18:00 UTC | Weekly MEMORY.md rotation (newly enabled) |
| `heartbeat` | Daily 19:00 UTC | Fleet-health ambient check (newly enabled) |

---

## Fleet Summary

- **Target repos scanned:** aaronjmars/MiroShark + aaronjmars/miroshark-aeon
- **Active MiroShark forks (pushed in last 30 days):** 19
- **Forks with readable `aeon.yml` (MiroShark layer):** 0 (expected — sim-tool forks)
- **Aeon fleet (miroshark-aeon) — active forks:** 1
- **Total skill slots enabled (Aeon fleet):** 14
- **Unique skills seen (Aeon fleet):** 14
- **Source skills enabled:** 8 (repo-pulse, token-movers, holdings, fetch-tweets, changelog, shiplog, memory-flush, heartbeat)
- **Source skills catalogued:** 200+
- **Shared skills (CHORUS + source):** 4 (repo-pulse, fetch-tweets, memory-flush, heartbeat)
- **CHORUS extras (enabled in CHORUS, disabled/absent in source):** 10 (down from 12)
- **Adoption gaps (source enabled, CHORUS disabled/absent):** 4 (token-movers, holdings, changelog, shiplog)
- **Forks with no `aeon.yml` (sim-tool layer):** 19
- **Notification sent:** no (SKILL_LEADERBOARD_INSUFFICIENT_DATA)

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
*Notification skipped: SKILL_LEADERBOARD_INSUFFICIENT_DATA (0 readable aeon.yml in primary target, 1 in miroshark-aeon fleet — need ≥2)*
