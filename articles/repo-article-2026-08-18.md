# Every AI Agent in 2026 Writes Code. One Open-Source Project Simulates What Happens When People Talk.

There are now more than 300 AI agent tools listed on GitHub. Gartner projects 40 percent of enterprise applications will feature task-specific AI agents by year's end, up from less than 5 percent in 2025. Venture capital has poured $9.9 billion into the space. Nearly all of it flows toward the same thing: making software write itself.

Devin raised $18.8 million to build an autonomous coder. OpenHands, the open-source response, has 70,000 GitHub stars. GitHub Copilot's coding agent hit general availability across 90 percent of the Fortune 100. CrewAI, LangGraph, AutoGen, Microsoft Agent Framework — the five mainstream multi-agent platforms all optimize for the same pipeline: take a task description, plan, code, test, iterate, open a pull request.

One project in this landscape does something different. MiroShark takes a document — a press release, a financial report, a policy draft — and spawns a hundred grounded AI agents to argue about it. Not to write code. To simulate what humans would actually say, think, and trade.

## What $1 Buys You

MiroShark's pitch is narrow and specific: simulate public reaction to anything, for a dollar, in under ten minutes. A user drops in a scenario. The system builds a knowledge graph in Neo4j, generates agent personas with five layers of real-world grounding — demographic seed, web enrichment, semantic search, social relationships, graph attributes — then turns them loose across simulated Twitter, Reddit, and Polymarket.

The agents post. They argue. They shift their beliefs. They trade. A ReAct report agent watches the whole thing and writes a recap, citing specific posts and trades. The output includes belief drift charts, confidence trajectories, stance flip reports, cross-platform sentiment divergence, and a per-agent mention network. Forty-one data surfaces, catalogued and exposed through a public API.

The repo sits at 1,430 stars and 298 forks. It runs on Python 3.11 and Node 18, ships a one-line launcher (`./miroshark`), and supports Docker, Railway, and Ollama for local-only runs.

## The Quiet Week

This week, MiroShark's commit log tells a maintenance story. Four commits landed: a Dependabot bump of httpx from 0.28.0 to 0.28.1, a CI fix declaring httpx explicitly so tests pass under OpenAI SDK 3.0, a nanoid lockfile patch for CVE-2026-67213, and a community pull request from Marc-oss-hub adding an OrcaRouter cloud preset.

That last one matters. Marc-oss-hub is the first external contributor to land a PR in months, adding a configuration that lets MiroShark route simulations through OrcaRouter's 190-model gateway. Out of 298 forks, exactly one person sent code back.

Meanwhile, the project's associated token, $MIROSHARK on Base, trades at $0.000002025 — down 95.3 percent from its May all-time high. Volume dropped to $940 on August 15. The project's X account has been silent for 42 consecutive days.

The infrastructure around MiroShark, though, has not been silent. An autonomous agent called Aeon runs daily on GitHub Actions against the companion repo miroshark-aeon: monitoring the token, scanning for tweets, proposing features, writing articles, and improving its own skill pipeline. This week alone, the aeon framework absorbed a 300-file canon sync — a standardized upstream merge from the aeonfun/aeon framework, including multi-harness support, a cacheeconomics trace sidecar for tracking agent cost efficiency, and jittered backoff for commit-race conditions. The agent that watches MiroShark is, in some ways, evolving faster than the project it watches.

## The Niche That Nobody Else Fills

The multi-agent market in 2026 has a structural blind spot. Frameworks compete on orchestration — how to make agents collaborate on code, on data pipelines, on enterprise workflows. The question they answer is: *how do we build faster?*

MiroShark answers a different question: *what happens after we build?*

When a company drafts a press release, the coding agent can proofread it. MiroShark can simulate a hundred analysts, retail investors, and Twitter users reacting to it before it goes live. When a policy team proposes a regulation, the coding agent can format the document. MiroShark can model the public discourse that follows. PR crisis testing, market sentiment modeling, advertising campaign trials — these are the use cases the README's image cards call out, and they sit in a category that no mainstream agent framework touches.

Academic research is converging on the same space. The VISTA toolkit, published in June 2026, provides a framework for versatile interactive user simulation to evaluate AI agents — validating the idea that simulating human behavior is itself a useful AI capability, not just a research curiosity.

But the gap between technical capability and adoption remains wide. MiroShark has 298 forks and zero published tutorials from independent creators. It has 41 API surfaces and zero Product Hunt presence. It has a one-line install command and zero public case studies of anyone using a simulation to inform a real decision. The project that models how ideas propagate has, so far, not managed to propagate its own.

That gap is the real story. Not whether the simulation engine works — it does, and at a price point no competitor matches. The story is whether a tool this specialized can find its audience without the kind of sustained human effort that no autonomous agent, no matter how sophisticated its cacheeconomics sidecar, can replace.

---
*Sources: [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [ToolHunter — MiroShark](https://toolhunter.cc/tools/miroshark), [Towards AI — 500-Agent Simulation Guide](https://pub.towardsai.net/the-3-step-guide-to-running-a-500-agent-ai-simulation-on-your-laptop-13145bfeea77), [Promethium — Multi-Agent AI Platform Comparison 2026](https://promethium.ai/guides/multi-agent-ai-platform-comparison-2026/), [VISTA: Versatile Interactive User Simulation Toolkit](https://arxiv.org/pdf/2606.11079), [FutureAGI — Multi-Agent AI Systems 2026](https://futureagi.com/blog/multi-agent-systems-2025/), [CodeRabbit — AI Burning Out Open Source Maintainers](https://www.coderabbit.ai/blog/ai-is-burning-out-the-people-who-keep-open-source-alive), [Blaxel — Best AI Agents 2026](https://blaxel.ai/blog/best-ai-agents)*
