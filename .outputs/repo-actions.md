*Repo Action Ideas — 2026-08-14*
Generated from analysis of aaronjmars/MiroShark (1,430 stars · 298 forks · OrcaRouter preset just landed · day 38 social silence).

1. Japanese (JA) UI Locale (Community/DX, Small)
   README advertises 日本語 but the frontend serves German — README.ja.md exists but locales/ja.js doesn't; one PR fixes the inconsistency and clears the 5-language hyperstition (4/5 → 5/5, 18 days before Sep 1 deadline).

2. Demographic Cohort Analysis API (Feature, Small)
   GET /api/simulation/{id}/demographics/slice — filter agents by age range, platform, or initial stance and return bullish/bearish/neutral split for that cohort; re-uses existing trajectory.json data, no new computation.

3. Simulation Ground-Truth Accuracy Score (Feature, Small)
   POST /api/simulation/{id}/accuracy — accepts real-world poll percentages as POST body, returns direction match, confidence delta, stance MAE, and a 0–100 accuracy score; stateless, enables formal researcher benchmarking.

4. OrcaRouter Lite Self-Host Docs + Config Probe (DX/Integration, Small)
   Add OrcaRouter Lite (MIT, self-hosted) section to docs/MODELS.md + a miroshark config probe CLI command that validates all four model slots are reachable before a simulation run; timely given PR #287 landing today.

5. Built-With Ecosystem Badge Generator (Growth, Small)
   GET /api/badge/{style} — inline SVG shields for the 12 ECOSYSTEM.md projects to embed in their READMEs; each back-link is a persistent GitHub Discovery signal feeding the GitHub Trending hyperstition (Sep 15, 32 days).

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-08-14.md
