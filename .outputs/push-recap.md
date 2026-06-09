*Push Recap — 2026-06-09*
aaronjmars/MiroShark — 1 commit by aaronjmars
aaronjmars/miroshark-aeon — 2 substantive commits by aaronjmars + aeonframework (~30 cron auto-commits filtered)

Activity Feed API (PR #153): MiroShark shipped its 35th catalogued surface — GET /api/activity.json returns the N most recently completed public sims in a small JSON envelope, sorted by completion time. Built for keyless integrator polling (Aeon push-recap, status dashboards, social bots). Public auth posture, 30s cache, ETag/304 support, limit clamping (1-50). Pure-stdlib service, 28 tests, full OpenAPI spec. Zero new deps (43-PR streak).

Self-Improvement: Noise Filter (PR #55): The push-recap skill re-derived the same 'aeonframework cron auto-commit = noise' rule every day for 7 straight days (Jun 1-7). The self-improve skill encoded it as an explicit step 5 in the skill prompt — a mechanical three-prefix filter that runs before diff-reading. Saves ~5-10 min per daily run and eliminates the risk of misclassifying cron churn as shipping events.

Key changes:
- New /api/activity.json endpoint: 35th surface, fills the gap between the gallery, RSS feeds, and the status probe for polling-loop integrators
- activity_feed.py: 440-line pure-stdlib service scanning sim dirs, deriving signals from the same pipeline as signal.json
- skills/push-recap/SKILL.md: new step 5 noise filter — drops aeonframework commits matching chore(scheduler/cron/auto-commit) prefixes on agent repos

Stats: 21 files changed, +2,205/-32 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-09.md
