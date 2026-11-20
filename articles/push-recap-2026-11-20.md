# Push Recap — 2026-11-20

## Overview
2 substantive commits by Aaron Elijah Mars on aaronjmars/MiroShark (0 automation commits filtered). Today's work was entirely CI/testing infrastructure hardening — tighter job timeouts and randomized test ordering that surfaced (and fixed) a real state leak bug.

**Stats:** 4 files changed, +46/-4 lines across 2 substantive commits

---

## aaronjmars/MiroShark

### CI & Testing Hardening

**Summary:** Two PRs landed that tighten the feedback loop on CI failures and eliminate hidden test ordering dependencies. The first drops all job timeouts from a blanket 15 minutes down to measured p95 values, so a hang goes red in 2–3 minutes instead of 15. The second introduces `pytest-randomly` to shuffle test execution order — which immediately caught a Config state leak that had been silently adding ~135 seconds to every test run when certain seeds hit.

**Commits:**

- `f8adc4b` — ci: tighten job time limits to about 2x measured p95 (#363)
  - Changed `.github/workflows/tests.yml`: Reduced `timeout-minutes` from 15 → 2 (unit), 15 → 2 (frontend), 15 → 3 (camel-smoke), 15 → 2 (lint) — each set to roughly 2× the job's p95 wall time since the uv migration, rounded up to whole minutes with a floor of 2 (+8, -4 lines)
  - Added a comment block explaining the measurement methodology and asking maintainers to re-measure when a job legitimately grows

- `fa7722f` — test: run backend unit tests in random order, fix the Config leak it found (#362)
  - Changed `.github/workflows/tests.yml`: Added `pytest-randomly>=3.16.0` to the CI unit-test dependency install, with a comment showing how to reproduce failures locally using `--randomly-seed=<seed>` (+5 lines)
  - Changed `backend/pyproject.toml`: Added `pytest-randomly>=3.16.0` to both `[project.optional-dependencies.dev]` sections (+2 lines)
  - Changed `backend/tests/test_unit_settings_presets.py`: Added an `autouse` fixture `_restore_config` that snapshots every uppercase `Config` attribute before each test and restores it afterward via `monkeypatch.setattr`. The root cause: `POST /api/settings` writes provider, model, base URL, and key slots directly onto the `Config` class, but the preset tests only monkeypatched a few of them. The leaked `LLM_API_KEY` let subsequent `create_app()` calls reach Neo4j's schema retry loop, costing ~15s per test (about 135s across 9 `test_unit_internal_auth` tests) when no Neo4j was available (+15 lines)
  - Changed `backend/uv.lock`: Lock file updated with `pytest-randomly 5.1.0` resolution (+16 lines)

**Impact:** CI jobs now fail fast on hangs (2–3 min vs 15 min), saving runner minutes and surfacing issues sooner. Random test ordering makes the suite robust against implicit ordering dependencies — the Config leak it caught on day one was costing over 2 minutes of phantom Neo4j retries per run. Combined, these two changes make the test suite both faster and more trustworthy.

---

## Developer Notes
- **New dependencies:** `pytest-randomly>=3.16.0` (dev only, v5.1.0 resolved)
- **Breaking changes:** None — these are internal CI/test-infrastructure changes
- **Architecture shifts:** Test execution order is now randomized; any future ordering-dependent test will surface as a failure rather than passing silently
- **Tech debt:** The `Config` class being used as mutable global state (class-level attributes written directly by route handlers) is the deeper issue. The fixture papers over it, but a proper config isolation pattern (instance-based, or a fresh Config per request context) would eliminate the class entirely

## What's Next
- The Config-as-global-state pattern flagged here may warrant a deeper refactor if more routes write to Config directly
- With tighter timeouts in place, any CI slowdown from new dependencies or heavier tests will surface immediately — the comment in tests.yml asks maintainers to re-measure and raise limits when jobs legitimately grow
- No branches created but not merged; both PRs were merged clean
