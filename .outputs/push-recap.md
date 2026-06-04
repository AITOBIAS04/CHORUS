*Push Recap — 2026-06-04*
2 repos — 36 commits by 2 authors (aaronjmars, aeonframework)

Per-Project Simulation Statistics (MiroShark PR #147): New GET /api/project/<id>/stats endpoint — the per-project sibling of /api/stats. Operators managing multiple projects can now pull consensus distribution, confidence, surface views, and quality distribution scoped to a single workspace in one API call. 522-line service module, 28 unit tests, zero new dependencies (39-PR streak).

Pre-Existing Features Registry (Aeon PR #52): Self-improve skill identified 8 feature ideas that kept being re-suggested after MiroShark already shipped them (eating up to 3 of 5 idea slots per batch). New permanent registry completes the "do not suggest" memory layer alongside the blocked-features registry from two days ago.

Daily Skill Cycle: French Locale built (600+ translations, push blocked — GH_GLOBAL), 5 new DX/integration ideas generated (webhook log, platform status, batch polling, leaderboard, webhook retry), repo-article drift guard caught its first drift in 52 minutes.

Key changes:
- backend/app/services/project_stats.py: +522 lines, per-project aggregate scan with quality distribution buckets and 60s cache
- memory/topics/pre-existing-features.md: 8 bootstrapped entries filtering already-shipped features from repo-actions batches
- MiroShark surface catalog: 30 → 31 (project_stats entry added)

Stats: ~30 files changed, +3,600/-80 lines
MiroShark: 1,231 stars / 265 forks (+5/+2 24h)
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-06-04.md
