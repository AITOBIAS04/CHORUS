# Fifteen Companies Will Sell You a Simulated Focus Group. One Gives You the Engine.

In 2024, the synthetic research market was worth $1.8 billion. By 2029, analysts project $8.2 billion. In between, in the first nine months of 2026, venture capitalists poured more than $1.5 billion into companies that promise to replace the focus group with AI agents. Simile, founded by the Stanford team that invented generative agents, raised $300 million in two rounds and hit a $2 billion valuation before its first anniversary. Aaru crossed $1 billion in valuation on its Series A. Artificial Societies, backed by Y Combinator and Point72 Ventures, hit 15,000 users and 100,000 completed simulations. Sixty-two percent of market researchers report using synthetic data already. The category that did not exist three years ago now has its own market maps, buyer's guides, and comparison matrices.

Everyone is building the same thing. Almost nobody is building it the same way.

## The Map

The synthetic research market splits into three layers, each with a different relationship between the customer and the simulation.

At the top are **enterprise platforms**: Simile at $100,000 to $250,000 per year, Aaru at unpublished enterprise pricing, Evidenza at $50,000 to $100,000 per engagement, Ditto at $50,000 to $75,000 per year. These are full-service operations. You describe your research question, the platform builds a synthetic population calibrated to your target demographic, runs the simulation, and delivers analyzed results. CVS uses Simile to simulate customer foot traffic. Gallup uses it to pre-test survey instruments. The value proposition is that you never touch the machinery.

In the middle are **hybrid platforms**: Qualtrics embedded synthetic respondents into its survey platform in March 2025 via Edge Audiences, letting researchers toggle between real and synthetic panelists in the same workflow. Toluna layered a million synthetic personas on top of its 79-million-member real panel. YouGov acquired Yabble for $4.5 million and now offers synthetic insights alongside its traditional polling infrastructure. These companies already own the research relationship — synthetic is an add-on, not a replacement.

At the bottom are **self-serve tools**: Artificial Societies at $40 per month, SYMAR at 99 euros per month, Synthetic Users at $2 to $27 per respondent. These are lighter, faster, designed for product teams and UX researchers who want answers in hours instead of weeks. They still own the simulation. You interact through their interface, on their infrastructure, within their constraints.

Every company in every layer shares one structural feature: the simulation is a service. You send a question in. You get an answer back. The engine stays on their side of the wall.

## The Gap in the Map

None of the market maps — not the FishDog landscape report, not the Ditto buyer's guide, not the Minds tool comparison — include an open-source category. The section does not exist. It is not that open-source options were evaluated and excluded. It is that the category was not conceived of as something that could be open-source at all.

This is unusual. Almost every adjacent category has an open-source foundation. Machine learning has PyTorch and TensorFlow. Large language models have Llama and Mistral. Vector databases have Milvus and Qdrant. Survey platforms have LimeSurvey. But synthetic social simulation — the specific task of spawning a population of AI agents, dropping them into a social environment, and recording how their opinions evolve through deliberation — has no open-source baseline on any market map published in 2026.

Except one project that none of the maps mention.

## The One That Ships the Engine

MiroShark is a social simulation engine on GitHub — 1,453 stars, 300 forks, AGPL-3.0 licensed, written in Python. You give it a topic and a document. It spawns a hundred AI agents with distinct professional backgrounds, knowledge bases, and belief systems. Those agents post on simulated Twitter, debate on simulated Reddit, and trade on a simulated prediction market. The simulation runs for multiple rounds, agents revise their positions based on what they read from each other, and the output is 41 independently queryable API surfaces: confidence trajectories, stance flip reports, mention networks, per-platform sentiment divergence, full-text search across agent discourse.

It costs approximately one dollar per simulation. It runs on your infrastructure. You own the data. The analytical layer — all 41 services — is built in pure Python standard library with zero external dependencies.

The comparison to the venture-backed platforms is not about quality. Simile's synthetic populations are grounded in 2.9 million real survey responses from 400,000 participants. Ditto claims 92 percent overlap with traditional focus groups across 50 parallel studies. Aaru reports 90-plus percent correlation with a six-month EY study. MiroShark has published no validation benchmarks against real human panels. The gap in rigor is real and large.

But the comparison is also not about the same thing. The venture-backed platforms are research products — you pay for an answer. MiroShark is research infrastructure — you get a machine that produces answers, and the machine is yours to modify, extend, audit, and host wherever you want. The difference is the same one that separates Snowflake from PostgreSQL, or Figma from Blender. One is easier. The other is yours.

## Why the Gap Matters

The synthetic research market is consolidating around a model where a small number of well-funded companies control the simulation infrastructure. This is the natural shape of a SaaS market: the best-funded platform attracts the most data, the most data produces the best validation benchmarks, the best benchmarks attract the next customer. Simile's trajectory from Stanford paper to $2 billion valuation in eighteen months is textbook.

But consolidation in simulation infrastructure creates a dependency that other research tools do not. When you outsource a survey to Qualtrics, the questions and responses belong to you. When you outsource a simulation to Simile, the population model, the interaction dynamics, the agent architectures, and the calibration data all belong to the platform. You receive a result. You cannot reproduce it independently, audit the agent behavior that produced it, or run the same simulation with a modified population on your own hardware.

For enterprise brand testing, this trade-off is reasonable. For academic research, policy analysis, or any context where reproducibility and auditability matter, it is a structural limitation that no amount of validation benchmarks can resolve.

The synthetic research market has fifteen funded platforms, $1.5 billion in venture capital, and projections toward $8 billion. It has one open-source engine with 1,453 stars that none of the market maps include. The market knows how to sell simulated opinions. It has not yet decided whether anyone should be allowed to build the simulator themselves.

---
*Sources: [FishDog — Synthetic Research Platforms: The 2026 Market Map](https://fish.dog/news/synthetic-research-platforms-the-2026-market-map), [Turing Post — Can AI Simulate 8 Billion People? Inside Simile's $2B Bet](https://www.turingpost.com/p/simile-ai), [Creati.ai — Simile AI Raises $100 Million](https://creati.ai/ai-news/2026-02-12/simile-ai-raises-100-million-behavior-prediction/), [Research Live — AI Startup Artificial Societies Launches Research Simulation](https://www.research-live.com/article/news/ai-startup-artificial-societies-launches-research-simulation/id/5141643), [Ditto — Artificial Societies vs Ditto](https://askditto.io/news/artificial-societies-vs-ditto-ai-research-platforms-compared), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
