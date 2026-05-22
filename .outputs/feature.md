*Feature Built — 2026-05-22*

Prediction-Market Calibration
MiroShark simulations can now be benchmarked against live prediction markets. When launching a simulation, paste a Polymarket or Manifold Markets URL for the same question — after the simulation completes, the Calibrate panel shows the simulation's final consensus side-by-side with what traders were pricing at that moment, including the exact percentage-point delta and a verdict: close (within 5pp), near (within 10pp), or divergent.

Why this matters:
Until now, simulation consensus ('72% YES') had no external benchmark. A researcher or analyst looking at MiroShark output had to take the number on faith — there was no reference price from a liquid prediction market to compare against. Calibration turns simulation output from 'interesting' to 'benchmarked.' For the academic-citation hyperstition, a track record of simulations that match Polymarket at ±5pp is the empirical foundation that makes citing MiroShark in a paper credible rather than speculative. This was the #2 idea from the May 20 repo-actions batch, specifically targeting the feedback/calibration gap.

What was built:
- backend/app/services/calibration_service.py (new, ~250 LoC): Pure-stdlib service with URL validation (regex for polymarket.com/event/ and manifold.markets/), verdict computation (close ±5pp / near ±10pp / divergent >10pp), read/write calibration.json with atomic tempfile+replace, prefetch cache reader for .xai-cache/market_calibration/.
- backend/app/api/simulation.py: GET /<id>/calibration endpoint with publish-gate check, calibration_market_url validation on create (rejects non-Polymarket/Manifold URLs with 400), has_calibration field in gallery cards, ?calibrated=1 gallery filter.
- scripts/prefetch-market-calibration.sh: Sandbox-safe prefetch script that runs before Claude — fetches Polymarket og:description probability and Manifold embedded JSON probability for each configured simulation.
- frontend: Calibrate toolbar button + full overlay panel (side-by-side consensus vs market with large stat numbers, signed delta with color-coded verdict chip, market title, human-readable note, 'View market →' link). Launch form gains a 'Calibration market' URL input with inline validation (✓ Polymarket/Manifold detected). Gallery gets ◎ Calibrated filter chip and pill badge. EmbedDialog shows calibration verdict section.
- backend/tests/test_unit_calibration.py: 30 unit tests covering URL validation, verdict thresholds (exact boundary values), compute roundtrip, NaN handling, missing data, read/write/cache.
- OpenAPI CalibrationResponse schema + docs/FEATURES.md + docs/API.md updated.

How it works:
At simulation launch, the operator pastes a Polymarket or Manifold URL. The URL is validated client-side (regex match) and server-side (stored in config.json). Before Claude starts, prefetch-market-calibration.sh curls the market page and extracts the probability — Polymarket from the og:description meta tag ('X% chance'), Manifold from the embedded JSON probability field — writing the result to .xai-cache/market_calibration/<sim_id>.json. When the calibration endpoint is hit, the service reads the prefetch cache, pulls the simulation's final bullish/neutral/bearish split from the embed summary, computes the signed delta (sim YES% minus market YES%), maps it to a verdict, and writes the result to calibration.json for future reads. The verdict thresholds (±5pp close, ±10pp near, >10pp divergent) are tight enough to be meaningful but loose enough that normal variance doesn't always trigger 'divergent.'

What's next:
Calibration history chart when the same scenario has been run multiple times against the same market. Integration with the archive bundle (calibration.json as an additional ZIP entry). Auto-calibration at simulation completion time rather than on-demand.

Push blocked — GH_GLOBAL secret not set (21st consecutive local-only build).
