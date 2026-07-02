*Repo Action Ideas — 2026-07-02*
Generated from analysis of aaronjmars/MiroShark (1,354 stars · 285 forks) — these are ideas that could be autonomously built by the feature skill tomorrow.

1. OG Social Preview Cards (Growth, Small)
   Backend Flask route returns crawler-readable HTML with og:title/og:description/og:image so simulation URLs generate rich cards on Twitter, LinkedIn, Discord, and Slack.

2. Simulation Narrative Export (Feature, Small)
   GET /api/simulation/:id/narrative — Mercury 2 generates a 3-paragraph prose summary of any completed simulation; cached 24h; copy-paste ready for blog posts and Discord updates.

3. CLI `estimate` Subcommand (DX, Small)
   `miroshark estimate --agents 20 --rounds 5` wraps the existing /api/estimate endpoint (#41 surface, already deployed) — completes the pre-flight CLI workflow with zero backend changes.

4. Trending Topics Discovery Feed (Feature/Growth, Small)
   GET /api/topics/trending + /trending frontend page shows most-simulated topics by 7d/30d/all-time with consensus direction signals — passive social proof for new visitors.

5. Build-Your-Own-Surface Guide (Community, Small)
   Annotated service stub + CONTRIBUTING-SURFACE.md + labeled GH issue with 3 specific surface ideas — direct mechanism for the 'community contributor ships a surface by July 15' hyperstition.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-07-02.md
