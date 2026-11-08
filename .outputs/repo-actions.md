*Repo Action Ideas — 2026-11-08*
Generated from analysis of aaronjmars/MiroShark — 1,489 stars · 303 forks · 0 open issues · 0 open PRs · these are ideas that could be autonomously built by the feature skill tomorrow.

1. Simulation Controversy Index (Feature, Small)
   Adds a controversy_score (0–100) to signal.json measuring stance polarization + debate intensity — distinguishes strong consensus from contentious near-misses.

2. Agent Pool Pre-Filter by Profession (Feature, Small)
   Optional agent_filter on the sim start payload weights roster toward specified professions (e.g. retail investors) while preserving a 20% minimum cross-perspective floor.

3. "Run This Scenario" Embed Button (Growth, Small)
   An SVG embed button that pre-fills the new-simulation UI with the scenario parameters — lets anyone re-run a published scenario with one click from a GitHub README or blog post.

4. Email Digest Export (Feature, Small)
   POST /api/simulation/:id/digest returns a compact email-ready HTML fragment (direction badge, top 3 agent quotes, inline chart, CTA link) for pasting into Substack, Beehiiv, or Mailchimp.

5. Cross-Platform Divergence Alert (Feature, Small)
   Extends the existing platform-sentiment service to flag when two platforms' BULLISH% differ by ≥30 points — surfaces echo-chamber vs. cross-platform consensus as a signal field and gallery filter.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-11-08.md
