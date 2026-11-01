# Skill Leaderboard — 2026-11-01

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

Four skills are enabled across every active Aeon instance — the same four as the last four consecutive leaderboard periods:

| Skill | Both Forks | Notes |
|-------|-----------|-------|
| `fetch-tweets` | ✓ | Daily X/Twitter digest — social pulse regardless of instance purpose |
| `heartbeat` | ✓ | Ambient health check — the fleet's immune system |
| `memory-flush` | ✓ | Weekly MEMORY.md rotation — shared housekeeping discipline |
| `repo-pulse` | ✓ | Weekly stars/forks/releases digest — community growth awareness |

Four skills. Across a fleet of two. Stable for at least six weeks. That's not a coincidence — it's an emergent minimal stack. Any Aeon instance that wants to stay oriented needs: something watching the outside world (fetch-tweets), something watching itself (heartbeat), something maintaining its memory (memory-flush), and something watching its community (repo-pulse). Everything else is operator preference. These four are invariant.

---

## Adoption Gaps

No adoption gaps. Every skill enabled in the source (`aaronjmars/miroshark-aeon`) appears in at least one active fork. The source runs 9 skills; elegarmco mirrors that set exactly; CHORUS runs a 14-skill superset that includes all 9 source skills plus 5 custom extensions. No source skill is being orphaned.

---

## Week-over-Week

Compared to the 2026-10-19 leaderboard:

**Fleet size:** 2 → 2 (unchanged). elegarmco/miroshark-aeon last pushed 2026-10-03 — just inside the 30-day window (cutoff: 2026-10-02). AITOBIAS04/CHORUS pushed today (2026-11-01), active.

**Skill counts:** Identical to Oct 19. No skill added or removed in either fork.

**Rank changes:** None.

**Third consecutive identical leaderboard.** Oct 4 → Oct 19 → Nov 1: same 19 skills, same counts, same ranks. The configuration is frozen. The interesting question is whether elegarmco will push again before its 30-day window closes (next check: Nov 2 cuts off Oct 3 pushes). If elegarmco goes quiet past Nov 2, it exits the active window — dropping the fleet from 2 to 1 and triggering the INSUFFICIENT_DATA gate. The leaderboard's continuity depends on a single push timestamp.

---

## Fleet Detail

| Fork | Source Repo | Last Push | aeon.yml | Enabled Skills |
|------|-------------|-----------|----------|----------------|
| AITOBIAS04/CHORUS | miroshark-aeon | 2026-11-01 (today) | ✓ | 14 |
| elegarmco/miroshark-aeon | miroshark-aeon | 2026-10-03 | ✓ | 9 |

**CHORUS vs elegarmco divergence:**
- **Shared skills (both enabled):** fetch-tweets, repo-pulse, heartbeat, memory-flush (4)
- **CHORUS only:** token-report, push-recap, project-lens, repo-actions, repo-article, self-improve, weekly-shiplog, hyperstitions-ideas, feature, skill-leaderboard (10)
- **elegarmco only:** aeon-update, changelog, holdings, shiplog, token-movers (5)

The split tells you something about operator purpose. elegarmco runs the source defaults plus `aeon-update` (stays synced upstream) and `changelog` (publishes a changelog to an external website). It's a maintenance-oriented instance. CHORUS runs a broader editorial and intelligence stack — token-report, repo-article, self-improve, hyperstitions-ideas — with skill-leaderboard itself in the mix, making it self-referential. The fleet watches itself watching the fleet.

---

## MiroShark Sim-Tool Forks (No aeon.yml)

18 active MiroShark forks pushed in the last 30 days — none carry aeon.yml. As expected: MiroShark is a simulation engine, not an agent framework. These forks are running simulations, not agents. The two fleets (sim-tool and Aeon) are cleanly distinct at the file-tree level.

Active MiroShark forks in window: aiapienthusiast, Ripnrip, kotthoff, Aigov-consulting, OpmRain, Yizrael, q-qp-p, veridian69, rbenegas, pellera9, digitalarchivo, nothingtosurprise, lucadeg, dorucioclea, mmbeamsplitter, danielabelski, atlonxp, praxstack (18 forks, 0 with aeon.yml).

---

## Fleet Summary

- **Target repos scanned:** aaronjmars/MiroShark + aaronjmars/miroshark-aeon
- **Active forks total (pushed in last 30 days):** 20 (18 MiroShark + 2 Aeon)
- **Forks with readable `aeon.yml`:** 2
- **Total skill slots enabled (Aeon fleet):** 23 (14 CHORUS + 9 elegarmco)
- **Unique skills seen:** 19
- **Consensus skills (>50%):** 4 (fetch-tweets, heartbeat, memory-flush, repo-pulse)
- **Adoption gaps (source enabled, zero forks):** 0
- **Forks without aeon.yml:** 18 (all MiroShark sim-tool forks)
- **Notification sent:** yes

---

*Source: GitHub API — forks of aaronjmars/MiroShark + aaronjmars/miroshark-aeon*
