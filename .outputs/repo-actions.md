*Repo Action Ideas — 2026-05-08*
Generated from analysis of aaronjmars/MiroShark (1,117 stars · 222 forks · 0 open PRs). Today's thread: making simulation results scientifically defensible — citable, robust, individually analyzable.

1. Agent Belief Heatmap (Feature, Small)
   Grid of agents × rounds colored by stance — makes individual trajectory patterns visible where the aggregate drift chart only shows totals.

2. Per-Agent Trajectory CSV Export (Feature, Small)
   Unit-record export (agent × round × yes/no/neutral price × stance) for researchers doing statistical modeling, survival analysis, or influence attribution.

3. Adversarial Robustness Mode (Feature, Medium)
   Run the same scenario twice — baseline and with a devil's advocate agent — to report whether consensus is Robust, Pressured, or Fragile under active challenge.

4. Live Round Event Stream / SSE (Integration, Small)
   GET /api/simulation/:id/events SSE endpoint for real-time per-round belief events; no webhook server, no polling loop — curl --no-buffer works.

5. Academic Citation Block Generator (DX, Small)
   BibTeX + APA + IEEE citation modal from simulation metadata + PR #75 config hash; one click to a paper-ready reference.

Full details: https://github.com/AITOBIAS04/miroshark-aeon/blob/main/articles/repo-actions-2026-05-08.md
