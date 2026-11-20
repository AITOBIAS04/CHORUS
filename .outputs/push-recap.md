*Push Recap — 2026-11-20*
aaronjmars/MiroShark — 2 substantive commits by Aaron Elijah Mars

CI & Testing Hardening: Two PRs landed that tighten CI feedback loops and kill hidden test ordering bugs. Job timeouts dropped from a blanket 15 min to measured p95 values (2–3 min), so hangs go red fast instead of silently eating runner minutes. Separately, pytest-randomly was added to shuffle test execution order — and it immediately caught a real bug: POST /api/settings was leaking Config state (API keys, provider, model) across tests, causing 15-second Neo4j retry loops in unrelated tests (~135s wasted per run on unlucky seeds).

Key changes:
- .github/workflows/tests.yml: timeout-minutes 15→2/2/3/2 per job, based on measured p95 since uv switch
- backend/tests/test_unit_settings_presets.py: new autouse fixture snapshots and restores all Config class attrs, fixing the state leak
- New dev dependency: pytest-randomly 5.1.0 (randomizes test order, prints seed for reproducibility)

Stats: 4 files changed, +46/-4 lines
Full recap: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/push-recap-2026-11-20.md
