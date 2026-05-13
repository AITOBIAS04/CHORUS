*Feature Built — 2026-05-13*

Interactive Simulation Replay Player
MiroShark simulations now have a step-by-step replay player — a browser-based VCR that lets you play, pause, scrub, and step through a completed simulation round by round. At each round the belief drift chart animates up to that point, the top influencer for the round is highlighted with their archetype and platform, and the most substantial post from that round appears in a card below. Researchers presenting simulation results in talks can now walk an audience through "what happened and when" without screenshots.

Why this matters:
The GIF export (PR #50) produces a static 12-frame animation — useful for sharing, useless for analysis. The spectator watch page (PR #67) lets you watch a simulation live, but you can't pause, rewind, or step through a completed simulation. The Interactive Replay Player fills both gaps: it's the presentation layer that turns a static chart into a step-by-step narrative. The /replay/<sim_id>?round=N permalink lets researchers deep-link to the exact round where something interesting happened — the last gap in the share surface stack. This was the #1 idea from repo-actions 2026-05-12 and the natural follow-up to the Jupyter notebook merge (PR #80).

What was built:
- backend/app/api/simulation.py: GET /api/simulation/:id/replay-data endpoint returning compact per-round payload (belief splits as bullish/neutral/bearish %, top influencer with archetype/platform, top post capped at 280 chars). 24-hour cache headers since simulation data is immutable after completion.
- frontend/src/components/ReplayPlayer.vue: Self-contained replay component with animated SVG belief drift chart (stacked area, clip-path reveal tied to currentRound), transport controls (prev/play/pause/next), scrubber bar, 4 speed settings (0.5x/1x/2x/4x), and round info card showing stance chips + top influencer avatar + top post.
- frontend/src/views/ReplayView.vue: Rewritten to embed ReplayPlayer full-screen with scenario title bar. Supports ?round=N deep-linking and ?autoplay=true for iframe embeds.
- frontend/src/components/Step3Simulation.vue: Replay toggle added to results toolbar alongside Drift/Network/Demographics overlays.
- frontend/src/components/EmbedDialog.vue: Interactive replay player section with shareable URL copy and embeddable iframe snippet with autoplay.
- backend/tests/test_unit_replay_data.py: 12 unit tests covering stance threshold parity, top influencer/post selection, consensus detection, graceful degradation, and round merging.
- backend/openapi.yaml: /replay-data path and ReplayData schema documented under Export tag.
- docs/FEATURES.md: Interactive Replay Player section with full feature description.

How it works:
The replay-data endpoint reads trajectory.json for per-round belief splits (same ±0.2 stance threshold as every other surface) and walks the platform action JSONL logs to identify per-round top influencer (most engagement received) and top post (longest CREATE_POST, capped at 280 chars). Agent metadata (archetype, platform) is enriched from profiles. The frontend fetches this once on mount and drives all playback client-side — scrubbing and speed changes don't trigger new requests. The SVG chart renders all rounds as stacked area paths but clips the visible region to currentRound via a CSS clip-path, creating the animation-on-scrub effect. A vertical orange marker tracks the current position.

What's next:
Push blocked — GH_GLOBAL secret not set (13th consecutive block since May 1). Once the secret is configured, all 13 built features can be pushed and PRs opened in one batch.

Branch: feat/interactive-replay-player (code complete, push blocked)
