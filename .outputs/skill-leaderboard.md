Done. Here's what was executed:

## Summary

**Skill:** `skill-leaderboard` — 2026-06-28

**Fleet scan:**
- Primary target (`aaronjmars/MiroShark`): **38 active forks** in the 30-day window — all sim-tool forks with no `aeon.yml` (expected)
- Aeon runtime (`aaronjmars/miroshark-aeon`): **1 active fork** — AITOBIAS04/CHORUS (pushed today)

**CHORUS skill stack (14 enabled — unchanged):** token-report, fetch-tweets, repo-pulse, push-recap, project-lens, repo-actions, repo-article, self-improve, weekly-shiplog, hyperstitions-ideas, feature, heartbeat, memory-flush, skill-leaderboard

**Big story this week:** The source repo (`aaronjmars/miroshark-aeon`) underwent a major restructure. Its enabled-by-default stack shrank from ~15 → 7 skills (dropping push-recap, repo-actions, repo-article, self-improve, project-lens, feature, star-milestone, star-momentum, thread-formatter) while adding `docs-sync` and expanding the total skill catalog to 200+. CHORUS now runs 10 skills that the source has disabled — up from 3 last week. The source has shifted to a "minimal core + opt-in" philosophy.

**Adoption gaps (source enabled, not in CHORUS):** `docs-sync` (new), `shiplog`, `tweet-digest`

**Notification:** Skipped — SKILL_LEADERBOARD_INSUFFICIENT_DATA (need ≥2 Aeon forks, found 1, eighth consecutive week)

**Files written:** `articles/skill-leaderboard-2026-06-28.md`, `memory/logs/2026-06-28.md` (appended)
