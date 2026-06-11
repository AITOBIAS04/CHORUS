## Summary

**Built: Per-Round Confidence Score Trajectory** — the 36th share surface for MiroShark.

**What it does:** Applies `signal.json`'s confidence formula (`(leading_pct - 33.33) / 66.67 * 100`) to each round independently and returns the series as `[{round, confidence_score}]`. This reveals whether confidence built steadily from round 1 or spiked only at the end — a simulation that hits confidence 88 by round 4 is structurally different from one that reaches 88 only at round 11.

**Files created/modified (8 files, +615 lines):**
- `backend/app/services/confidence_trajectory_service.py` — pure-stdlib service with mtime-based disk cache
- `backend/app/api/simulation.py` — `GET /api/simulation/<id>/confidence/trajectory` endpoint (publish-gated, 5-min HTTP cache)
- `backend/app/services/surfaces_catalog.py` — 36th catalog entry + tracked key
- `backend/app/services/surface_stats.py` — `confidence_trajectory` counter key
- `frontend/src/api/simulation.js` — `getConfidenceTrajectory` + `getConfidenceTrajectoryUrl`
- `frontend/src/components/BeliefDriftChart.vue` — dashed violet confidence overlay line with right-side Y axis
- `frontend/src/components/EmbedDialog.vue` — confidence trajectory section with preview + URL/curl snippets
- `backend/tests/test_unit_confidence_trajectory.py` — 14 unit tests

**Push status:** BLOCKED — `GH_GLOBAL` secret not set (36th consecutive block). Branch `feat/confidence-trajectory` committed locally at `/tmp/build-target`.
