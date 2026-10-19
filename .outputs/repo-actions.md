*Repo Action Ideas — 2026-10-19*
Generated from analysis of aaronjmars/MiroShark (1,477 stars · 306 forks) — these are ideas that could be autonomously built by the feature skill tomorrow.

1. OpenGraph Social Preview for Simulation Share URLs (Growth, Small)
   Add OG meta tags + a server-rendered SVG to simulation permalinks so Twitter/LinkedIn shares generate rich preview cards — free distribution every time a result is shared.

2. Wonderwall Broadcast Discovery Feed (Feature, Medium)
   Build on the recent PR #335 Wonderwall wiring with a /api/broadcast/feed endpoint + gallery tab, turning broadcast from a silent push signal into a pull-based simulation discovery mechanism.

3. Simulation Trajectory CSV Export (Feature, Small)
   One-click "Download CSV" button exporting per-agent, per-round belief time series — removes the friction blocking data scientists and researchers from using MiroShark in academic work.

4. Community Examples Directory (Community/DX, Small)
   Add examples/ with 5–7 pre-configured scenario JSONs (crypto, election, climate, etc.) plus a README to give 306 forks a zero-friction first run without having to configure agents from scratch.

5. OpenRouter Attribution Header CI Lint Guard (DX/Security, Small)
   Enforce the PR #337 shared-constant refactor with a grep-based CI check that fails if any new LLM call site in llm/ or wonderwall/ omits the attribution header import.

Full details: https://github.com/AITOBIAS04/CHORUS/blob/main/articles/repo-actions-2026-10-19.md
