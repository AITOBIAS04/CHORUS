# When Did the Crowd Break? MiroShark Now Tells You the Exact Round.

Most simulation tools tell you what happened. A handful tell you how bad it got. Almost none tell you *when* — the precise moment a simulated crowd flipped from skeptical to convinced, or from calm to panicked. That changed today.

MiroShark's newest commit — [PR #108](https://github.com/aaronjmars/MiroShark/pull/108), peak-round belief analytics — adds an endpoint that collapses an entire simulation trajectory into the rounds that matter most. One GET request returns the round each stance peaked, the most volatile round, and the maximum swing percentage. No CSV parsing, no chart squinting. A machine-readable answer to the question every operator asks first: *when did it break?*

## The Analytical Stack Nobody Planned

Peak-round analytics didn't arrive in isolation. Over the past two weeks, MiroShark has quietly assembled a stack of machine-readable analytical primitives that, taken together, make simulation output look less like a research toy and more like instrumentation:

- **Trading Signal JSON** (PR #91) — direction, confidence percentage, and risk tier in one endpoint. A quant tool or Zapier workflow can consume it directly.
- **Prediction Market Calibration** (PR #99) — compare a simulation's final consensus to a live Polymarket price. A sim that matched the market at ±5 percentage points is a fundamentally different object than one with no external benchmark.
- **Confidence Score** (PR #105 context) — a 0–100 trust signal computed from stability, convergence, participation, and robustness. Filter the gallery by credibility, not just recency.
- **Peak-Round Analytics** (PR #108) — the inflection finder. Which round did bullish sentiment first peak? Which round had the largest swing? One O(n) pass over the trajectory data that already exists.

Each primitive reuses the same ±0.2 stance threshold as every other surface. The numbers in the peak-round JSON match the trajectory CSV row-for-row. No new computation, no new dependencies — just a derived view over data MiroShark was already producing.

## Why Inflection Points Matter More Than Conclusions

A simulation that ends 71% bullish tells you one thing. A simulation where bullish peaked at 71% on round 4 — then eroded to 58% by round 12 after a director-injected event — tells you something else entirely. The conclusion is the same direction, but the story is different. The crowd was convinced early and then started doubting.

This distinction maps directly onto the problem space Gartner flagged when it reported a [1,445% surge](https://www.gartner.com/en/articles/multiagent-systems) in multi-agent system inquiries between Q1 2024 and Q2 2025. Enterprises aren't just asking "will the public react negatively?" — they need to know *when* sentiment turns, how fast it moves, and whether it stabilizes. A PR crisis team doesn't want a final verdict. They want to know which hour of the news cycle is the inflection point.

Academic research is converging on the same question from a different direction. The [BeliefShift benchmark](https://arxiv.org/abs/2603.23848) (March 2026) introduced the first quantitative framework for measuring opinion drift in LLM agents — tracking when AI agents change their minds versus when they're nudged by confirmation bias. MiroShark's peak-round detector is the applied version of that same instinct: find the fracture, measure it, export it.

## The Community That Started Building Without Permission

The analytical primitives are one story. The other is who's writing the code. In the past seven days, MiroShark merged contributions from five different authors — up from essentially a solo project two months ago. The most telling commit isn't a feature. It's [PR #109](https://github.com/aaronjmars/MiroShark/pull/109): a community member named Nurstar added `ECOSYSTEM.md`, a canonical index of ten projects building on top of MiroShark. Nobody asked for it. The ecosystem documented itself.

Meanwhile, DYAI2025 opened [PR #106](https://github.com/aaronjmars/MiroShark/pull/106) to prepare Railway deployment infrastructure. AntFleet fixed a path-traversal vulnerability. Void Freud shipped a Neo4j Aura cloud skip and a gitignore cleanup. The project has 1,203 stars, 251 forks, and — for the first time — a contributor base that's building infrastructure, not just cloning the repo.

## Where This Points

MiroShark started as a way to see what a simulated crowd thinks. It's becoming a way to *measure* what a simulated crowd thinks — with machine-readable precision, external calibration, and community-built deployment paths. The simulation-as-instrument thesis is no longer theoretical. The endpoints exist. The numbers are stable. The community is shipping.

Thirty-three PRs merged since mid-April. Zero new dependencies for 32 of them. And now, one JSON endpoint that answers the question nobody else in the multi-agent simulation space has bothered to surface: *which round was the one that mattered?*

---
*Sources: [MiroShark GitHub](https://github.com/aaronjmars/MiroShark) · [PR #108 — Peak-Round Belief Analytics](https://github.com/aaronjmars/MiroShark/pull/108) · [PR #109 — ECOSYSTEM.md](https://github.com/aaronjmars/MiroShark/pull/109) · [Gartner: Multiagent Systems in Enterprise AI](https://www.gartner.com/en/articles/multiagent-systems) · [BeliefShift Benchmark (arXiv 2603.23848)](https://arxiv.org/abs/2603.23848) · [Gartner: 40% of Enterprise Apps to Feature AI Agents by 2026](https://www.gartner.com/en/newsroom/press-releases/2025-08-26-gartner-predicts-40-percent-of-enterprise-apps-will-feature-task-specific-ai-agents-by-2026-up-from-less-than-5-percent-in-2025)*
