# The Founder Fixed the Tests at Ninety-Five Thousand Dollars

On November 20, Aaron Elijah Mars pushed two commits to MiroShark — a CI tightening and a test-ordering fix — the first human code in a repository that has run on Dependabot and an autonomous agent for weeks. He did it on the same day his project's token dropped to its lowest valuation ever. Nobody announced it. Nobody discussed it. The commits just appeared.

## What MiroShark Is

MiroShark is an open-source multi-agent simulation engine. You feed it a document — a press release, a policy draft, a piece of financial news — and it spawns over a hundred AI agents with grounded personalities who argue about it across simulated social platforms. The whole run costs about a dollar and finishes in under ten minutes. The tech stack is Python, Neo4j for the knowledge graph, and any OpenAI-compatible inference backend including local Ollama. It sits at 1,491 GitHub stars and 303 forks as of today.

The project has a companion token, $MIROSHARK, on Base chain. On November 21, that token's fully diluted valuation fell below $100,000 for the first time — to $95,555. The price hit $0.0000009556, a new all-time low. It has fallen 52.6% in thirty days.

## Three Actors, No Script

The interesting thing about MiroShark right now is not any single metric. It's the fact that three independent automated or semi-automated actors are operating on the same project without coordinating.

**The agent.** An autonomous Aeon instance running on GitHub Actions has filed 91 self-improve pull requests over 239 days. It runs daily skills — token reports, repo pulses, tweet fetches, heartbeat checks — and proposes its own improvements when it finds blind spots. PR #91, merged this week, added a safety net after the previous PR accidentally staged volatile files and went immediately stale. The agent doesn't have push access to MiroShark itself (a missing secret blocks it), so its 40+ built features sit as local commits. But its maintenance loop — detecting issues, proposing fixes, verifying its own fixes — has not stopped once.

**The seller.** An automated wallet has been selling roughly 33.17 million MIROSHARK tokens per hour, extracting approximately $32 per trade. The active WETH liquidity pool has dropped from $81,800 three days ago to $60,664 today. A second seller address appeared on November 19, dumping 930 million tokens in a single transaction. The bot doesn't care about the project's GitHub activity. It drains on a clock.

**The founder.** After weeks of silence — MiroShark's social accounts haven't posted in 137 days — Mars pushed commits tightening CI job time limits to roughly 2x measured p95 latencies and randomizing backend test execution order, which exposed and fixed a configuration leak. These are infrastructure-quality commits, the kind of work you do when you plan to keep building on the foundation.

## Context: The 2026 Autonomous Maintenance Wave

MiroShark is not the only project running on autopilot. OpenGitClaw launched in March 2026 as an autonomous GitHub agent. Sepo, the self-evolving repository framework, runs scheduled maintenance inside Actions. GitHub's own Repo Assist handles triage and dependency upkeep. An FSE 2026 industry paper on the RACER system reports significant effort savings from autonomous refactoring. The pattern is clear: maintaining a codebase no longer requires a human in the loop every day.

But MiroShark's version is unusual because it has a financial layer. Most autonomous maintenance agents work on pure software projects. Here, the agent maintains a codebase whose associated token is being actively sold by a bot. The agent and the seller are both automated, both persistent, and completely indifferent to each other.

## Why It Matters Now

The sub-$100K FDV milestone is symbolically loaded. At $95,555, the entire token supply is valued at less than a mid-range sedan. Meanwhile, the agent that watches this token every day just generated a new hyperstition: "Will $MIROSHARK's FDV recover above $100,000 before 2027?" Stars ticked up two today — the first positive movement in days.

Four out of five new token launches in 2025 crashed, according to CryptoSlate, and the "low float, high FDV" model has hit a ceiling. MiroShark's trajectory inverts the usual pattern: the technology keeps improving while the token keeps falling. The question the project poses is whether autonomous maintenance can outlast autonomous extraction — whether the builder bot can outrun the seller bot over enough time for anyone to notice.

As of today, nobody is watching. The social channels are silent. The founder fixes tests. The agent files PRs. The seller sells. Three actors, no audience, no intermission.

---

*Sources: [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [GitHub — aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), [CryptoSlate — Why 4 out of 5 token launches crashed](https://cryptoslate.com/heres-why-4-out-of-5-new-tokens-launches-crashed-this-year/), [DEV Community — OpenGitClaw](https://dev.to/omegacorelabs/opengitclaw-the-autonomous-github-agent-that-maintains-your-repos-while-you-sleep-2o0k), [FSE 2026 — Autonomous Refactoring RACER System](https://conf.researchr.org/details/fse-2026/fse-2026-industry-papers/10/Autonomous-Refactoring-for-Perfective-Maintenance-at-Scale-The-Agentic-RACER-System-), [Outlook India — Liquidity Drain Bots](https://www.outlookindia.com/xhub/blockchain-insights/how-liquidity-drain-bots-identify-weak-tokens-and-pools-mechanisms-risks-and-protective-measures), [Pine Analytics — Exit Liquidity Machines](https://pineanalytics.substack.com/p/exit-liquidity-machines)*
