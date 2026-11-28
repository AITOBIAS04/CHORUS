*Repo Action Ideas — 2026-11-28*
Generated from analysis of aaronjmars/MiroShark — these are ideas that could be autonomously built by the feature skill tomorrow.

1. Simulation Round Annotation (Feature, Medium)
   Annotate specific simulation rounds with real-world event context; markers appear on the belief chart; enriches Verified Predictions with temporal precision for academic citation.

2. Python SDK `pip install miroshark` (Integration, Medium)
   Thin typed wrapper for the HTTP API — `Client.run(scenario)` blocks until completion, returns a `SimulationResult`; also creates a PyPI discovery vector separate from GitHub search.

3. CLI Export Subcommand (DX, Small)
   `miroshark export <sim_id> --format json|csv|notebook|bibtex` added to existing cli.py; stdout-safe for piping; `--all` flag batch-exports every published simulation.

4. Custom Agent Demographics CSV Import (Feature, Medium)
   Upload a CSV of agent personas to bypass auto-generation; enterprise operators model known audience segments; population is explicit and re-runnable for reproducible research citation.

5. Ecosystem Registry Submission Form (Community, Small)
   Web form at /ecosystem/submit generates a structured GitHub issue for new projects to register in ecosystem.json; surfaces builders who forked and built locally; 304 forks is a latent catalog.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-11-28.md
