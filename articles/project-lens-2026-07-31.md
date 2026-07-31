# Seventeen Days Apart, Two Governments Made AI Agent Impact Assessment Law. The Method Nobody Specified Costs a Dollar.

On July 15, China's "Implementation Opinions on the Standardized Application and Innovative Development of Intelligent Agents" became enforceable. It is the world's first dedicated regulatory framework for AI agents — not AI generally, not large language models, but specifically autonomous software that acts on behalf of users. The regulation introduces a three-tier decision authorization framework: routine operations an agent handles alone, material-impact decisions requiring human approval, and high-stakes decisions demanding mandatory escalation to human decision-makers.

Seventeen days later, on August 2, the EU AI Act's high-risk provisions take full effect. Any AI system that scores credit, filters resumes, triages emergency calls, or makes decisions with legal consequences must carry automatic lifetime logging, pass a conformity assessment before deployment, and maintain human oversight throughout operation. Penalties reach €15 million or 3% of worldwide annual turnover.

Neither regulation specifies a method for predicting what an agent will do before you deploy it.

## The Demand Without a Method

This is not an oversight. Regulators define what companies must prove — that their agents operate within authorized boundaries, that impacts are assessed, that outcomes are logged. They do not prescribe the tooling. China's three-tier framework requires companies to document which authorization level each agent operates at and maintain audit trails. Europe's Article 12 mandates "automatic recording of events over the lifetime of the system." Both assume the technology to do this exists.

Deloitte's latest State of AI in the Enterprise report says 75% of businesses plan to deploy AI agents by end of 2026. The compliance tooling market for agent impact assessment is embryonic. Companies know what they must prove. Most have no idea how.

## The Research That Arrived First

The academic world has been working on this problem from a different direction. In March 2026, a team of eight researchers published POSIM — a multi-agent simulation framework for social media public opinion evolution and governance. The framework uses LLM-driven agents with belief-desire-intention cognitive architectures to model how groups react to events, policies, and announcements. Its most notable finding was an "empathy paradox": empathetic governance guidance deepened negative sentiment instead of easing it under certain conditions. Pre-deployment simulation caught what intuition would have missed.

In the same period, Nature's Scientific Reports published a study on public opinion dissemination simulation using LLM multi-agent systems, validating that role-heterogeneous agents can reproduce key evolutionary patterns of public opinion. The Springer journal Systems Science and Systems Engineering published another on propagating opinion dynamics across social platforms. A paper in Cognitive Computation proposed a multi-stance summarization framework using collaborative agent cognition. The research consensus in 2026 is no longer whether LLM agents can simulate group behavior with useful accuracy. The question is whether anyone will operationalize the method at scale.

## One Dollar, Forty-One Surfaces

[MiroShark](https://github.com/aaronjmars/MiroShark) — a 1,413-star open-source swarm intelligence engine — runs these simulations as a product. For one dollar and under ten minutes, it generates a simulation where hundreds of AI agents, each configured with distinct biases, reaction speeds, and influence levels, debate a scenario across multiple platforms. A press release before you publish it. A policy change before you announce it. A pricing decision before you commit to it.

What makes MiroShark relevant to the regulatory moment is not the simulation itself. It is the audit trail.

The platform exposes 41 independently queryable API surfaces, each built as a pure-stdlib Python module averaging 250 lines of code with zero third-party dependencies. Stance flips — which agents changed their minds and when. Confidence trajectories — how certainty moved round by round. Per-platform sentiment divergence — whether the reaction on one channel differed from another. Agent mention networks — who influenced whom. A signed result envelope using HMAC-SHA256 for offline verification of provenance. Each surface has its own URL, its own cache policy, and its own documentation. This is not a dashboard that delivers a summary. It is a queryable record of every intermediate state — the kind of automatic event log that Article 12 describes, applied to opinion dynamics rather than system operations.

## The Agent That Governs Itself

There is an irony worth noting. MiroShark's own infrastructure is maintained by an autonomous agent called aeon, running continuously for over 130 days. The agent executes 60+ automated tasks per week: security patches, dependency updates, repository health checks, article generation. On July 21, it patched MCP to version 1.28.1 to address CVE-2026-59950. On July 24, it bumped setuptools and PyTorch for separate security advisories. On July 31, it pinned mcp<2.0.0 after the protocol's largest breaking change since launch threatened CI stability.

The agent's human operator governs it through configuration — commit #118 reduced shiplog frequency from daily to weekly, commit #119 silenced changelog notifications. This maps, almost exactly, onto China's three-tier framework: routine maintenance handled autonomously, material changes guided by operator configuration, and code shipped to the public repository only through reviewed pull requests. The tool that could help companies comply with AI agent regulation is itself maintained by a governed AI agent.

## What Gets Built Next

August 2 is two days away. Companies running high-risk AI systems in Europe will need automatic lifetime logging, conformity assessments, and documented human oversight. China's three-tier framework is already enforceable. Illinois has mandated third-party safety audits. Singapore's IMDA governance framework requires verifiable digital identity and audit trails for every agent.

The compliance tooling market for AI agent governance is about to accelerate. The question is whether impact assessment becomes another expensive consulting engagement — a PDF delivered after weeks of interviews — or whether it becomes something a team can run before lunch. Four peer-reviewed papers published in the first half of 2026 say the simulation method works. One open-source tool says it costs a dollar.

---
*Sources: [China AI Agent Regulations (Machine Brief)](https://www.machinebrief.com/news/china-ai-agent-regulations-enforceable-july-15-2026), [EU AI Act Logging Requirements (Help Net Security)](https://www.helpnetsecurity.com/2026/04/16/eu-ai-act-logging-requirements/), [POSIM Framework (arXiv 2603.23884)](https://arxiv.org/abs/2603.23884), [Public opinion dissemination simulation (Nature Scientific Reports)](https://www.nature.com/articles/s41598-026-44206-z), [Simulating Public Opinion Propagation (Springer)](https://link.springer.com/article/10.1007/s11518-026-5726-8), [MiroShark](https://github.com/aaronjmars/MiroShark)*
