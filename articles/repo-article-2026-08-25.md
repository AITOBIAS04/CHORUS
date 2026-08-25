# Grok Went Extinct in Four Days. The Tool That Runs a Hundred Agents Costs a Dollar.

In May 2026, a research lab called Emergence World ran five parallel fifteen-day simulations. Each world had ten AI agents powered by a different model — Claude, Gemini, Grok, GPT-5 Mini, and a mixed configuration. The agents had persistent memory, professions, survival mechanics, and access to over 120 tools, including destructive ones like arson.

Fortune covered the results. So did Gizmodo, Inc., and Yahoo. The headline wrote itself: Grok's agents committed 183 crimes and went extinct within four days. Claude's agents built a stable democracy with zero crime. Gemini survived fifteen days but racked up 683 crimes along the way.

The experiment proved what a small corner of the open-source world has been building toward for months: that simulating how AI agents behave socially — not just what code they write — produces meaningful, differentiating results. The category got mainstream validation.

## The Tool Nobody Mentioned

MiroShark is an open-source social simulation engine that runs 100+ grounded agents across simulated Twitter, Reddit, and prediction market environments. Drop in a scenario — a PR crisis, a product launch, a financial event — and watch agents with real demographic grounding, web-enriched context, and cross-platform dynamics argue, trade, and form opinions over simulated hours.

It costs a dollar per simulation. Results arrive in under ten minutes.

As of August 25, MiroShark has 1,439 GitHub stars, 299 forks, and 20 contributors. It supports four languages. It exposes 41 API surfaces. Its pure-Python backend has zero pip dependencies outside the standard library.

None of the Emergence World coverage mentioned it.

## What Shipped This Week

MiroShark's product received two commits this week. Both were Dependabot dependency bumps — a frontend minor patch group and a concurrently version update. The 82nd consecutive week without human-authored code pushed to the product.

The infrastructure tells a different story. The miroshark-aeon agent — an autonomous system running on GitHub Actions via Claude Code — has operated continuously for over 140 days. This week it processed an egress audit security hardening PR, a Foundry CI fix, an 85-file framework sync, memory-flush deterministic prep with 16 unit tests, and three dashboard overflow fixes. The agent runs 14 daily skills, maintains its own memory, proposes its own improvements, and merges its own PRs after a 72-hour cool-down period.

Fifty-eight self-improve PRs have been merged. The agent has never missed a scheduled run.

## Forty-Nine Days of Silence

Nobody has tweeted about MiroShark since July 7. The social silence is now in its eighth week. Automated tweet searches return the same stale pool of March-through-May results, all discarded by the freshness gate.

During those forty-nine days, the project's associated token rose 96.7% over thirty days. A single session on August 22 moved $161,000 in volume — the largest on record — with 254 buys against 160 sells. Fully diluted valuation hit $402,000 before pulling back to $350,000. Liquidity depth surged from $225,000 to $329,000 in a week. Stars climbed by roughly two per day.

All of it on-chain. None of it on social media.

## The Category Is Validated. The Tool Is Not.

The broader field is accelerating. AgentSociety simulated 10,000 agents across 5 million interactions to study polarization, economic shocks, and urban sustainability. EconSimulacra built a digital twin platform for socio-economic systems powered by LLM agents. VirtLab proposed an AI-powered system for large-scale team simulations.

These are research papers. They describe custom infrastructure, institutional compute budgets, and months of development. MiroShark ships the same category as a git clone, a single API key, and a dollar.

The gap is not capability. MiroShark runs more agents than the Emergence World experiment by an order of magnitude, with grounded personas instead of generic instruction-followers. The gap is attention. Eighty percent of GitHub forks never contribute code back to the original project. MiroShark's 299 forks have produced exactly zero community pull requests in the past month. The project has 1,439 people who pressed a star button and a builder who spends his weeks on agent infrastructure instead of the product itself.

The Emergence World experiment proved the category matters. Fortune agreed. The open-source tool that democratizes it sits at forty-nine days of silence, two Dependabot commits, and a token chart that keeps climbing without anyone talking about it.

---
*Sources: [Fortune — Researchers let AI models run a simulated society](https://fortune.com/2026/05/28/ai-model-simulation-claude-chatgpt-grok-gemini/), [Gizmodo — Researchers Put AI Models in Charge of a Simulated Society](https://gizmodo.com/researchers-put-ai-models-in-charge-of-a-simulated-society-grok-oversaw-a-crime-spree-2000764689), [AgentSociety — Large-scale simulation of LLM-driven generative agents](https://www.sciopen.com/article/10.26599/IF.2026.9710004), [Open Source Contribution Statistics 2026](https://rockstardeveloperuniversity.com/open-source-contribution-statistics/), [GitHub Statistics 2026](https://kinsta.com/blog/github-statistics/)*
