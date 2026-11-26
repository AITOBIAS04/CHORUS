*Repo Action Ideas — 2026-11-26*
Generated from analysis of aaronjmars/MiroShark — these are ideas that could be autonomously built by the feature skill tomorrow.

1. Good First Issue Auto-Generator (Community, Small)
   Files 3–5 tagged GitHub issues with implementation guidance before the Nov 30 external PR deadline — creates contribution targets for 304 fork owners who currently have nothing to reach for.

2. Jupyter Notebook Export (Feature, Small)
   notebook_export.py already exists in the codebase; this surfaces it as a keyless /api/simulation/:id/notebook.ipynb endpoint + Step 3 download button — zero new data collection.

3. BibTeX Academic Citation (Growth, Small)
   bibtex_service.py already exists; expose as /api/simulation/:id/cite.bib + a Cite modal in Step 3 with BibTeX and APA tabs — cited tools get rediscovered by paper readers.

4. Simulation Lineage Visualization (Feature, Medium)
   lineage_service.py already exists; surface it as /api/simulation/:id/lineage + an SVG tree in Step 3 showing parent/child simulation relationships — one share exposes 3–6 simulations at once.

5. Gallery Trending Feed (Feature, Small)
   New /api/feed/trending endpoint (heat score = views × 2 + clones × 5 + embeds × 3) with a 🔥 Trending tab on the gallery — surfaces high-engagement simulations to new visitors.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-11-26.md
