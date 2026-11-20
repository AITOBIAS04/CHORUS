# Everyone Built an Agent Framework. Almost Nobody Built a Crowd.

A survey published in Q1 2026 counted over 120 production-ready AI agent tools across eleven categories. By October, a working map of the ecosystem had consolidated them into five: autonomous platforms, developer frameworks, workflow automation with agent layers, chat-first copilots, and vertical specialists. Every major AI lab now ships a first-party agent SDK. OpenAI has the Agents SDK. Anthropic has the Claude Agent SDK. Google has ADK. Microsoft folded both AutoGen and Semantic Kernel into a single successor framework. CrewAI, LangGraph, and Pydantic AI compete for the developer middleware layer. Cursor, Claude Code, Replit Agent, Factory.ai, and Devin compete for the coding vertical. Intercom Fin, Sierra, and Ada compete for support. Harvey and Leya compete for legal.

The map is detailed, well-funded, and almost entirely oriented in one direction: an agent that completes a task for a user. Write this code. Answer this ticket. Draft this contract. The unit of work is a single agent acting on a single instruction. Even the "multi-agent" frameworks — CrewAI's role-based crews, LangGraph's orchestration graphs — coordinate multiple agents toward the same goal. The agents collaborate. They do not disagree.

Now ask a different question. What happens when a hundred agents with different beliefs, different information, and different platform incentives start arguing about the same topic at the same time? On the 2026 ecosystem map, that square is nearly blank.

## The Three Meanings of "Swarm"

The word "swarm" appears everywhere in the agent landscape, but it means three different things depending on who is using it.

The first meaning is **orchestration swarm**: multiple agents dividing a single task. This is what OpenAI's retired Swarm library did before Microsoft's Agent Framework absorbed it. One agent routes, others execute, the system converges on an answer. The agents have roles, not opinions.

The second meaning is **coding swarm**: parallel agents building software simultaneously. Addy Osmani documented the pattern in January 2026 — a loop where an agent picks a task, implements it, runs validation, commits if it passes, and repeats. Cursor reportedly ran hundreds of agents in parallel to build a web browser, producing over a million lines of code across a thousand files in a week. The agents share a codebase, not a worldview.

The third meaning is **simulation swarm**: agents that model a crowd. Each agent has a persona, a starting belief, and access to a platform. They post, respond, shift positions, and produce emergent group dynamics that no individual agent was programmed to exhibit. This is what opinion researchers study. It is what prediction markets approximate with money. And it is where the production tooling mostly does not exist.

## What Lives in the Blank Square

MiroShark — a 1,489-star open-source project described as a "Universal Swarm Intelligence Engine" — sits in this third category. Users upload a seed document, set a question, configure agents with professions and starting stances, and run a simulation across platforms. The output is not a single answer but a trajectory: how beliefs formed, shifted, fractured, and sometimes converged across rounds. The analytics layer goes deep — stance flip reports, confidence trajectories, mention networks, platform-level sentiment divergence, full-text search across simulation history. The architecture is FastAPI and Vue, MIT-licensed, self-hostable, and designed to run a simulation for under a dollar in less than ten minutes.

It has direct competitors now, though they are small. SimSwarm, launched on Product Hunt in 2026, covers similar territory: upload a document, set a prediction goal, watch agents debate and trade. LeanSwarm, a Python package by a solo developer, targets the same cost thesis with batching and sparse activation. Both are MIT-licensed. Both have single-digit GitHub stars.

The academic side is more populated but further from production. The DEBATE benchmark, published in late 2025, evaluated role-playing LLM agents across 697 groups and 107 topics using data from 2,788 human participants. Its central finding: in zero-shot settings, LLM agent groups exhibit strong opinion convergence relative to human groups — the simulated crowds agree too easily. A February 2026 paper modeled multi-round LLM dialogues using the DeGroot framework for opinion dynamics. A June 2026 paper on "hidden anchors" argued that earlier work failed to recover per-agent latent state from deliberation trajectories. The research is active. The tooling is papers, not products.

## The Dimension Nobody Mapped

The ecosystem maps categorize agents by what they do — code, support, legal, sales. They do not categorize agents by whether they maintain themselves. This is a separate axis entirely, and it cuts across every vertical.

Most agent frameworks require a human operator. Someone configures the prompts, monitors the runs, fixes the failures, updates the dependencies. The self-improving coding agent loop documented by Osmani resets context each iteration and relies on human review at the pull request stage. Prime Agent, open-sourced by Prime Intellect in August 2026, runs autonomous coding and research tasks but warns that its autonomous mode needs tight budget limits. The iterate project, written in Go, picks issues and ships fixes every twelve hours without a human in the loop — but it modifies itself, not a separate product.

MiroShark's autonomous agent — running on GitHub Actions since March 2026 — occupies a different point on this axis. It does not write simulation code. It maintains the project around the simulation code: monitoring token prices, checking repository health, writing articles, proposing improvements to its own skill definitions. It has filed 89 self-improvement pull requests across 239 days. When a 95.8% liquidity pool drop went undetected, the agent proposed its own LP anomaly detection. When pull requests with an unhandled merge status sat open indefinitely, it proposed a catch-all handler. The creator's last social media post was 136 days ago. The agent's last commit was today.

This is not a category that appears on any 2026 ecosystem map. It is not orchestration, not coding, not support. It is autonomous project maintenance — a system that keeps itself running in the absence of its operator. The closest analogues are not agent frameworks but biological concepts: autopoiesis, the self-creating organization that Maturana and Varela described in 1972.

## Where the Map Has Edges

The 2026 agent ecosystem is wide but shallow in one specific dimension. The investment, the frameworks, the tooling, and the talent are concentrated on agents that execute tasks for present humans. The simulation layer — agents that model absent crowds — has academic validation but almost no production infrastructure. The self-maintenance layer — agents that keep projects alive when operators go quiet — has one notable example and no category name.

For someone orienting themselves in this space, the adjacencies matter. Prediction markets like Kalshi and Polymarket compress crowd belief into a price but do not model the path. Agent orchestration frameworks coordinate agents but do not give them conflicting beliefs. Synthetic user platforms like Simile simulate individual customers but not collective dynamics. MiroShark and its small cohort of competitors sit at the intersection of all three gaps: multi-agent, adversarial, and temporal.

Three hundred and three people forked the repository. None of them have opened a pull request. Two direct competitors launched this year with single-digit stars. The academic benchmarks keep finding that simulated crowds converge too fast. The ecosystem map has a blank square, and the projects trying to fill it are still, by any venture metric, invisible.

Whether that square stays blank is not a question the map can answer. Maps describe what exists. The interesting part is always what the cartographer left off the edge.

---
*Sources:*
- [The AI Agent Ecosystem in 2026 (A Working Map)](https://www.vybe.build/blog/ai-agent-ecosystem-2026) — five-category taxonomy
- [Self-Improving Coding Agents — Addy Osmani](https://addyosmani.com/blog/self-improving-agents/) — autonomous coding loops and scaling observations
- [DEBATE: A Large-Scale Benchmark for Role-Playing LLM Agents (arXiv 2510.25110)](https://arxiv.org/abs/2510.25110) — 2,788 participants, 697 groups, convergence findings
- [Opinion Dynamics via Dialog Simulation (arXiv 2602.12583)](https://arxiv.org/abs/2602.12583) — DeGroot framework for multi-round LLM opinion dynamics
- [Hidden Anchors in Multi-Agent LLM Deliberation (arXiv 2606.19494)](https://arxiv.org/abs/2606.19494) — per-agent latent state recovery gaps
- [Prime Agent (Prime Intellect)](https://medium.com/cagris-biz-stack/prime-intellect-open-sources-prime-agent-a-self-improving-coding-harness-4b15df322da6) — self-improving coding harness
- [SimSwarm on Product Hunt](https://www.producthunt.com/p/simswarm) — direct competitor
- [LeanSwarm on PyPI](https://pypi.org/project/leanswarm/) — cost-focused simulation engine
