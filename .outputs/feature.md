*Feature Built — 2026-05-01*

Pre-Run Cost Estimator
MiroShark simulations now show you the estimated cost before you hit Start. A compact panel appears in Step 3 with the projected USD spend, total token count, wall-clock time, and the active model name — all computed instantly from a built-in pricing table covering OpenRouter, direct OpenAI, and local Ollama models. No LLM call needed, just arithmetic.

Why this matters:
MiroShark supports six LLM configurations spanning two orders of magnitude in cost — GPT-4o at ~$12 for a 50-agent run down to Mimo V2 Flash at under $0.10. Until now, users launching their first simulation had no idea what they'd spend until the run completed. A 50-agent GPT-4o run could surprise someone with a $12 bill on what they thought was a test. The estimator closes this gap — new users see the cost upfront, academic users without corporate API budgets can pick the right model before committing, and everyone avoids the sticker shock that causes churn.

What was built:
- backend/app/services/cost_estimator.py: Pure-arithmetic estimation engine with pricing table for 15+ models. Computes input/output tokens, USD cost (simulation loop vs preparation), wall-clock time, and a cost tier badge (free/minimal/low/moderate/high).
- backend/app/api/simulation.py: New POST /api/simulation/estimate-cost endpoint — accepts agent_count and total_rounds, returns the full estimate. No auth required.
- frontend/src/components/Step3Simulation.vue: Cost panel between the events summary and platform rows, visible only before the sim starts. Colour-coded: green for <$0.10, yellow for <$1, orange for <$5, red for >$5.
- backend/tests/test_unit_cost_estimator.py: 15 offline unit tests covering pricing lookup, format helpers, tier classification, scaling invariants.
- backend/openapi.yaml + docs/API.md + docs/FEATURES.md + README.md: Full documentation.

How it works:
The estimator multiplies agent_count × total_rounds × empirical tokens-per-agent-round (1800 input + 300 output, from production run averages) against the active Wonderwall model's per-1K-token price from a static lookup table. Preparation costs (profile generation + config generation) are estimated separately using the default model's pricing. Wall-clock time uses 12 seconds per agent-round (empirical async gather average). The cost tier thresholds — free (0), minimal (<$0.10), low (<$1), moderate (<$5), high (>$5) — are deliberately conservative so users are never surprised by a bill higher than advertised.

What's next:
Once actual token usage tracking is added (reading provider response headers), the estimator can be calibrated against real costs — turning the rough estimate into an increasingly accurate predictor.

Branch: feat/pre-run-cost-estimator (push blocked — GH_GLOBAL not set)
