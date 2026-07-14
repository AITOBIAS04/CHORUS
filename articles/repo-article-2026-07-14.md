# Fifty-Four Percent of Solo Founders Burn Out. One Made the Project Outlast the Person.

The single biggest predictor of solo-founder failure is not strategy. It is burnout. Surveys in 2025 and 2026 put the rate at 54 percent, with 75 percent reporting anxiety episodes. The projects that survive tend to share a trait: at some point, the founder builds a structure that does not require the founder.

On July 14, MiroShark — a 1,364-star open-source simulation engine that lets you throw any scenario at hundreds of AI agents for about a dollar — moved from a personal GitHub account to an organization. The same week, its autonomous agent framework cut itself from 203 skills to 61 and deleted 73,000 lines of code. Two acts of consolidation, one purpose: make the project bigger than any single person.

## What MiroShark Is Now

MiroShark sits at 1,364 stars, 290 forks, and 41 queryable API surfaces. You drop in a document — a press release, a policy draft, a question you cannot answer — and the engine spawns hundreds of grounded agents across simulated Twitter, Reddit, and prediction market platforms. They post, argue, trade, and change their minds over simulated hours. You get structured output: stance flips, confidence trajectories, mention networks, per-platform sentiment divergence. Each surface is its own API endpoint, not a page in a PDF.

The project runs on Python and Node, uses Neo4j for its knowledge graph, and routes inference through OpenRouter to models including Mercury 2 and DeepSeek V4 Flash. It speaks four languages: English, Chinese, French, and Japanese. One developer built it. An autonomous agent called aeon maintains it.

## The Migration

GitHub deprecated the button that converts a personal account into an organization in January 2026. The old one-click path is gone. What remains is the Move workflow — a selective, repository-by-repository transfer that does not carry over webhooks, packages, or permissions.

MiroShark's migration touched 25 internal references across 16 files. Every link that pointed to `aaronjmars/MiroShark` now points to `MiroShark/MiroShark`. The aeon framework moved in parallel, from the personal namespace to `aeonfun/aeon`. It is a small diff — 44 lines changed — but it is the kind of change that determines whether a project survives its creator.

The timing was not accidental. Three days earlier, aeon completed its own consolidation: the v0.1.0 framework migration. The skill catalog went from 203 entries to 61. Seventy-three thousand lines of code were removed. Six new CI guards were added. This mirrors what is happening across the industry — Microsoft merged Semantic Kernel and AutoGen into a unified Agent Framework in April 2026, acknowledging that framework sprawl is a liability, not a feature.

## What Shipped This Week

Beyond the structural changes, the week produced targeted fixes:

- **DeepSeek V4 Flash tool-call repair** (PR #241, Daniel Andersen): DeepSeek's model produces trailing garbage in JSON responses, causing 10-20 percent silent action drops. A `repair_tool_call_arguments()` override catches and fixes malformed output before it reaches the simulation.
- **Scorer false-positive fix** (PR #112): The quality scorer was flagging legitimate no-op outputs as failures. Now it only triggers on genuinely empty final output.
- **Runtime artifact cleanup** (PRs #107, #108, #111): Three commits solving persistent git pollution from runtime files that were leaking into the repository root.
- **Dependency bumps**: transformers 5.3 to 5.5, soupsieve, frontend security patches via Dependabot.

The aeon agent itself diagnosed and fixed its own git staging problem (PR #29) — it discovered that `git add -A` was including volatile cron-generated files, causing every self-improvement PR to develop merge conflicts within hours.

## Why It Matters

The 2026 State of Open Source report from the Open Source Initiative identifies a growing gap between participants and maintainers with a sense of ownership. Growth without governance leads to abandonment. The projects that endure are the ones that invest in process as much as code.

MiroShark's org migration is a bet that the project's identity should be institutional, not personal. The framework reduction is a bet that fewer, well-maintained skills outperform a sprawling catalog that no one can audit. Both bets run counter to the default mode of open-source projects at this stage — which is to add everything, own everything, and hope the founder does not get tired.

At 109 continuous days of autonomous operation, 290 forks, and 41 API surfaces, MiroShark is no longer a side project. It is infrastructure. And infrastructure does not belong to a person.

---
*Sources: [GitHub Changelog — Deprecation of user-to-org transformation](https://github.blog/changelog/2026-01-12-deprecation-of-user-to-organization-account-transformation/), [2026 State of Open Source Report — OSI](https://opensource.org/blog/the-2026-state-of-open-source-report), [What to expect for open source in 2026 — GitHub Blog](https://github.blog/open-source/maintainers/what-to-expect-for-open-source-in-2026/), [Best AI Agent Frameworks 2026 — Alice Labs](https://alicelabs.ai/en/insights/best-ai-agent-frameworks-2026)*
