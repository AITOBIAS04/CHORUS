*Feature Built — 2026-06-07*

Cross-Platform Sentiment Divergence

MiroShark multi-platform simulations now surface per-platform sentiment breakdowns. When a simulation runs across Twitter, Reddit, and Polymarket simultaneously, the new endpoint reveals where those platforms agreed and where they diverged — a signal the aggregate consensus was silently obscuring.

Why this matters:
Until now, a multi-platform sim that ended at 56% YES was just that — one number. But if Twitter agents were 72% YES while Reddit agents were 39% YES, the 33-point divergence between platforms is the real story. Operators designing multi-platform simulations for crisis modeling, product launches, or policy analysis need to know not just what the crowd decided, but whether the crowd agreed with itself across platforms. This was the top idea from yesterday's repo-actions analysis — the data was already being generated in per-platform action logs; no surface was reading it at the cross-platform aggregate level.

What was built:
- backend/app/services/platform_sentiment_service.py: Pure-stdlib service (~270 LoC) that reads per-platform actions.jsonl files, maps agents to platforms, cross-references the final trajectory snapshot's belief positions, and computes per-platform bullish/neutral/bearish splits. Mtime-based cache to platform_sentiment.json.
- backend/app/api/simulation.py: GET /api/simulation/:id/platform-sentiment route with publish gate, surface_stats counter, and 5-minute Cache-Control.
- frontend/src/components/Step3Simulation.vue: "Platforms" toolbar button (visible only for multi-platform sims) that opens a compact breakdown overlay with per-platform horizontal bars — violet for bullish, red for bearish, gray for neutral.
- frontend/src/components/EmbedDialog.vue: "Platform sentiment (JSON)" section with live preview, copyable URL, and curl snippet.
- 16 unit tests covering service logic, cache behavior, route wiring, and catalog/openapi drift guards.

How it works:
The service scans each platform's actions.jsonl to build a set of agent_ids per platform. It then reads the final snapshot from trajectory.json to get each agent's belief position (the same ±0.2 stance threshold every other surface uses). For each platform, it filters beliefs to only that platform's agents and computes the bullish/neutral/bearish split using the existing compute_stance_split function from trajectory_export. The result is cached to disk with mtime invalidation — only recomputed when action files change. No new dependencies; pure stdlib (json + os). The frontend loads the data alongside existing analytics when a simulation completes and renders the toolbar button only when multiple platforms are present.

What's next:
Could add max divergence score (max delta between platforms' yes_pct) as a gallery filter, or a per-round platform divergence trajectory showing how platforms converged or diverged over time.

PR: push blocked — GH_GLOBAL secret not set (33rd consecutive block)
