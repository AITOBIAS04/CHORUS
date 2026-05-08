## Summary

**Feature Built: Per-Round Annotation Layer** for `aaronjmars/MiroShark`

**What it does:** Users can attach text notes (max 280 chars) to specific rounds on the belief drift chart. Annotations appear as purple dashed vertical markers on the chart, are included in Markdown/JSON transcript exports as a "Simulation Notes" section, and mark gallery cards with an "✎ Annotated" badge.

**Files created (3):**
- `backend/app/services/annotations.py` — Annotation service with atomic JSON writes, CRUD operations
- `frontend/src/components/AnnotationPanel.vue` — Round selector, text input, annotation list
- `backend/tests/test_unit_annotations.py` — 22 unit tests

**Files modified (11):**
- `backend/app/api/simulation.py` — 3 new API endpoints + gallery card `annotated` flag
- `backend/app/services/transcript.py` — Annotations in transcript exports
- `backend/openapi.yaml` — `RoundAnnotation` schema + 3 endpoint docs
- `frontend/src/api/simulation.js` — 3 API helpers
- `frontend/src/components/BeliefDriftChart.vue` — Annotation markers
- `frontend/src/components/Step3Simulation.vue` — AnnotationPanel integration
- `frontend/src/views/ExploreView.vue` — Annotated gallery badge
- `README.md`, `docs/FEATURES.md`, `docs/API.md`, `docs/API.zh-CN.md` — Documentation

**Total: +1,183 lines across 14 files.**

**Status:** Code complete. Branch `feat/per-round-annotations` committed locally. Push blocked — GH_GLOBAL secret not set (8th consecutive feature blocked since May 1). Notification saved to `.pending-notify/`.
