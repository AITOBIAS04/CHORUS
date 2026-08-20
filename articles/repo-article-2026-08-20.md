# Two Hundred and Forty-Seven Organizations Are Building the Future of AI Agents. They Forgot to Simulate the Humans.

On August 13, the Agentic AI Foundation announced 57 new members, bringing its total to 247 organizations. Alibaba, Visa, Wells Fargo. The foundation, stewarded by the Linux Foundation with founding contributions from Anthropic (Model Context Protocol), OpenAI (AGENTS.md), and Block (goose), released a Momentum Report tracking 116 open-source projects across five layers of the agentic AI stack.

Every project on the list does the same thing: it helps an AI agent write code, search the web, use tools, or coordinate with other AI agents.

Not one of them asks what happens when AI agents simulate what humans would do.

## The Stack That Nobody Built

The AAIF's five-layer stack covers models, orchestration, tool use, protocols, and evaluation. It's a reasonable map of how to build agents that automate tasks. But there's a use case that falls between every layer: simulating human social behavior — how a population of people might react to a product launch, a policy draft, a financial shock.

MiroShark has been building in that gap since March 2026. The open-source project (1,432 stars, 297 forks, AGPL-3.0) ingests a document — a press release, a regulation, a news story — and spins up 100+ AI agents grounded in real-world context. Those agents post on simulated Twitter, argue on simulated Reddit, and trade on a simulated prediction market. The whole thing costs a dollar and takes less than ten minutes.

It is not in the AAIF's 116-project report. No one at the foundation has mentioned it.

## What's Been Shipping

This past week was MiroShark's quietest in months. Three commits, all maintenance: a Dependabot httpx update (#289), an explicit httpx dependency declaration to survive the OpenAI 3.0 SDK swap (#288), and an OrcaRouter cloud preset from Marc-oss-hub (#287) — only the second community contribution since the project launched five months ago.

Zero open pull requests. One open issue (#240, requesting offline HuggingFace model support for air-gapped deployments — open 45 days). No releases.

Behind the scenes, the project's autonomous agent Aeon continues running — 79 consecutive days of hitting a push-access block because a single GitHub secret isn't configured. Forty-plus feature branches sit fully built and ready to merge. Aeon has now filed 56 self-improvement PRs to its own automation repo, more than every human contributor to MiroShark combined except the founder.

The project has ten total contributors. Ever. In the same week, AAIF gained 57 member organizations.

## The Paper That Validated the Problem

In mid-2026, researchers from the University of Illinois published "MiroBench" on arXiv — a benchmark for measuring whether LLM agents can realistically simulate human discussions. They built a dataset of 4,292 real Reddit threads and tested five models across five domains.

The conclusion: current simulators remain distributionally mismatched with real Reddit threads. AI agents are still too repetitive, too uniform in sentiment, and too structurally simple compared to actual human conversation.

The paper doesn't cite MiroShark. But it validates MiroShark's core premise — that simulating human social dynamics is a hard, measurable problem worth solving. MiroShark's approach (grounded personas, cross-platform dynamics, Neo4j knowledge graphs, stance-tracking over rounds) is one architecture for closing the realism gap that MiroBench quantified.

## Why It Matters

The agentic AI ecosystem is consolidating fast. Two hundred and forty-seven organizations. A $199 billion projected market by 2034. GitHub now hosts 4.3 million AI-related repositories, nearly doubling in under two years. The AAIF tracks 116 projects across its five-layer stack.

But the stack has a blind spot. Every tracked project helps machines act. None of them help machines predict how humans will react. That's MiroShark's category — and despite 1,432 stars, 41 API surfaces, four languages in the UI, and five months of continuous autonomous maintenance, the project remains invisible to the institutions defining the field.

The token ($MIROSHARK on Base) surged 26.8% in the past 24 hours to $0.000002483, its biggest daily move in weeks. The social channels have been silent for 44 consecutive days. No tweets. No Discord activity. No Reddit mentions.

A project that simulates how humans talk hasn't had a human talk about it in six weeks.

---
*Sources: [Agentic AI Foundation Welcomes 57 New Members](https://www.linuxfoundation.org/press/agentic-ai-foundation-welcomes-57-new-members-gaining-major-financial-services-players-and-apac-leaders), [MiroBench: Benchmarking Realism in Agentic Simulation](https://arxiv.org/abs/2606.14715), [Global Agentic AI Landscape Report 2026](https://www.raysolute.com/agentic-ai-report.html), [GitHub AI Repository Growth](https://blog.bytebytego.com/p/top-ai-github-repositories-in-2026), [aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
