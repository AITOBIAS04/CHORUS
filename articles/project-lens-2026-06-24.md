# Thirty Projects Simulate Societies Now. Almost None Ship a Result You Can Query.

In June 2026, Daniel Rosehill published a resource list on GitHub cataloging every open-source project he could find that simulates AI societies — agents with personalities, opinions, memories, and social dynamics interacting in virtual worlds. The count exceeded thirty. Stanford's Generative Agents. Google DeepMind's Concordia. CAMEL-AI's OASIS, which scales to one million agents on simulated social platforms. AgentTorch from MIT, GPU-accelerated to model millions of agents for pandemic and economic simulation. AIvilization, where agents build civilizations from scratch. WarAgent, which replays geopolitical conflicts. Hive, where AI beings are born, age, die, form relationships, and create culture.

The field has a name now — synthetic societies — and it has its own satellite conference with abstract deadlines this month. The Journal of Artificial Societies and Social Simulation has been publishing since 1998, but the LLM-powered wave that started with Stanford's 2023 paper has turned a niche academic pursuit into something that looks increasingly like a category.

But browse the list carefully and a pattern emerges. Almost every project stops at the simulation.

## The Research-Application Gap

The taxonomy of synthetic society projects has crystallized into three layers. At the bottom sit research frameworks — Concordia, Sotopia, ChatArena — libraries that give researchers primitives for building experiments. Above those sit simulation engines — OASIS, AgentTorch, AgentSociety — platforms that can run agents at scale but whose output is a dataset, a log file, a research artifact. At the top, in theory, would sit applications — systems where a non-researcher inputs a question and receives a structured, queryable answer.

That top layer is nearly empty.

A March 2026 paper from Tsinghua University introduced POSIM, a multi-agent framework for simulating how public opinion evolves on social media. It integrates LLM-driven agents with a Belief-Desire-Intention cognitive architecture, places them in virtual social networks with recommendation algorithms, and drives temporal dynamics through a Hawkes point process engine. The research is sophisticated. The output is a paper. To use POSIM, you clone a repository, configure a cognitive model, provision API keys, write orchestration scripts, and interpret raw simulation logs.

This is the default in synthetic societies: the simulation itself is the deliverable. The twenty-three social actions OASIS models, the personality fidelity benchmarks Human-Simulacra validates, the emergent civilizations AIvilization grows — all of these produce raw simulation state. Turning that state into something a product team, a researcher, or an API consumer can use is left as an exercise for whoever clones the repo.

## Forty-One Ways to Read One Simulation

MiroShark is a swarm intelligence engine — 1,333 stars, 279 forks — that runs opinion simulations for roughly a dollar in under ten minutes. That description places it in the same category as the projects above. What separates it is what happens after the simulation finishes.

A single MiroShark simulation exposes forty-one queryable surfaces. Not forty-one features bolted on over time — forty-one distinct consumption modes for the same underlying result. An oEmbed endpoint auto-unfurls simulation previews in Notion, Slack, and any platform that supports the protocol. A signed-result endpoint produces HMAC-SHA256 envelopes for offline verification. A confidence trajectory endpoint traces how the system's certainty evolved round by round. A stance-flip report identifies which agents changed their minds, when, and how often. A full-text search endpoint lets you find simulations by content across the entire corpus. A pre-run estimator tells you how long a simulation with your parameters will take and what it will cost before you commit.

Each surface has its own API route, its own cache strategy, its own OpenAPI schema. MCP tools expose five of them to LLM agents without requiring a browser. RSS feeds, webhooks, SVG badges, GraphML exports, embeddable visualizations — every one is a different way to ask the same simulation a question and get a structured answer.

The ecosystem map puts this in relief. OASIS can run a million agents. AgentTorch can model pandemic dynamics at population scale. Concordia offers the cleanest research primitives. But if you want to drop in a document, run a simulation, and get a result that a dashboard, an API consumer, a compliance team, and an LLM agent can all query independently — the map has a gap, and MiroShark sits in it.

## Where the Landscape Is Heading

The StackOne landscape report for 2026 maps 120-plus agentic AI tools across eleven categories. Agent frameworks, observability platforms, memory systems, browser automation, enterprise platforms — the infrastructure for building agents has never been richer. But the report's own gap analysis notes that multi-agent coordination remains "nascent" and cost management tools for agent workflows are conspicuously absent.

Synthetic society projects face the same gap from the opposite direction. They have coordination — that is the entire point of the simulation. What they lack is the last mile: the translation layer between raw simulation state and the structured outputs that the rest of the agentic ecosystem expects. When Salesforce Agentforce ($540M+ ARR, 18,500 customers) or n8n (150,000+ GitHub stars) need to consume the output of a multi-agent opinion simulation, they need an API endpoint, a schema, a cache header, an ETag — not a Jupyter notebook.

The academic community is moving in this direction. The Simulated Societies satellite conference, ScioMind's cognitively grounded belief dynamics, IntervenSim's intervention-aware opinion modeling — all published in 2026, all pushing the research frontier. But the gap between research artifact and queryable surface remains the defining bottleneck for the field.

The thirty projects on Rosehill's list prove that simulating a society is a solved problem — or at least a problem with thirty independent attempts at a solution. What is not solved is making the result legible to the systems that would actually use it. The agent frameworks want structured inputs. The enterprise platforms want API contracts. The compliance teams want signed provenance. The dashboards want embeddable components. The LLMs want tool-callable endpoints.

The ecosystem map has plenty of simulations. It has almost no simulation products.

---
*Sources: [AI Synthetic Society Experiments — GitHub resource list](https://github.com/danielrosehill/AI-Synthetic-Society-Experiments), [POSIM: Multi-Agent Simulation Framework for Social Media Opinion — arXiv](https://arxiv.org/abs/2603.23884), [120+ Agentic AI Tools Mapped Across 11 Categories — StackOne](https://www.stackone.com/blog/ai-agent-tools-landscape-2026/), [OASIS: Open Agent Social Interaction Simulations — GitHub](https://github.com/camel-ai/oasis), [Simulated Societies Conference](https://simulatedsocieties.github.io/)*
