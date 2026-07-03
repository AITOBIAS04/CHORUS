# Seventy-Nine Percent of Organizations Cannot Trace What Their AI Agent Did. The Fix Is Not Another Dashboard.

PwC's 2026 Agent Survey landed with a number that should have alarmed more people than it did: 79% of organizations that have adopted AI agents cannot trace failures through multi-step workflows or measure quality systematically. Not "find it difficult." Cannot. The agent takes an input, runs through a chain of steps — retrieving documents, calling tools, reasoning, calling more tools, synthesizing — and produces an output. When the output is wrong, most teams cannot reconstruct which step broke.

This is not a tooling gap. The AI observability market hit $2.69 billion in 2026, up 36% from the prior year, driven almost entirely by enterprise teams realizing they cannot ship autonomous systems without visibility into what those systems are doing between question and answer. Langfuse, Braintrust, Arize, AgentOps — the vendor landscape has tripled in eighteen months. Every platform offers the same basic primitive: traces. Capture what the agent did, after it did it, and make it searchable.

The question nobody is asking loudly enough is whether the problem started earlier — not at the monitoring layer, but at the architectural one.

## The Black Box Was a Design Choice

A June 2026 paper on arXiv surveyed AI observability across five layers — model internals, confidence calibration, behavioral monitoring, operational intelligence, and infrastructure tracing — and identified four unresolved gaps. The most fundamental: no existing system connects signals across layers. A confidence calibration anomaly at layer two does not automatically surface as an alert at layer four. Each layer watches its own slice. The system as a whole remains opaque.

IBM Research, presenting at AAAI 2026, formalized the problem differently. Agentic systems, they argued, exhibit emergent capabilities that cannot be inferred from studying individual agents alone. The observability challenge is not that individual steps are hard to log — it is that the interactions between steps produce behaviors that no single log captures. A system, they wrote, can be more than the sum of its parts. Monitoring the parts is necessary but not sufficient.

Both papers describe the same structural issue from different angles: AI systems are built to produce outputs, and observability is retrofitted afterward. The intermediate states — the reasoning, the tool calls, the shifts in confidence, the branching decisions — are ephemeral. They happen inside the agent's execution loop and vanish when the loop completes. The observability stack's job is to catch them before they disappear.

What if they were never designed to disappear?

## Forty-One Surfaces Instead of One Answer

MiroShark, the open-source opinion simulation engine with 1,355 GitHub stars, made an architectural decision early in its development that looks unremarkable in a feature list but is structurally unusual in practice: every intermediate state of a simulation is a separately queryable API endpoint.

A simulation runs twelve AI agents with distinct professional personas debating a topic across multiple rounds on simulated social platforms. The conventional approach would be to run the simulation and return the result — a summary, a verdict, a confidence score. One endpoint, one payload. MiroShark does this (the signal endpoint collapses final-state numbers into a direction, confidence percentage, and risk tier). But it also exposes forty other endpoints, each serving a different dimension of the simulation's intermediate state.

The confidence trajectory endpoint returns how certainty evolved round by round — not just the final confidence, but the path that produced it. The stance flip report identifies which agents changed their positions and at which round, distinguishing genuine persuasion from noise. The per-platform sentiment divergence endpoint breaks out how the same argument landed differently on different simulated platforms. The mention network maps which agents influenced which others through direct engagement. The signed result wraps every output in an HMAC-SHA256 envelope for cryptographic provenance.

Each of these is a pure derivation — no new computation, just a different structured view of the same underlying simulation data. Each is independently cacheable, independently queryable, and independently consumable by a downstream system. A researcher can hit the trajectory endpoint without touching the mention network. A trading bot can consume the signal endpoint and ignore everything else. An auditor can verify the signed result without understanding the simulation's mechanics.

## Why Forty-One Is Not Forty-One Times the Work

The instinctive objection is that building forty-one endpoints is forty-one times the engineering effort of building one. In practice, the opposite is closer to true. MiroShark's services are pure standard library Python — no framework, no ORM, no external dependencies. The surfaces catalog, itself one of the forty-one surfaces, documents every endpoint in a machine-readable format with route, method, type category, description, and a copy-pasteable curl example. A new surface ships in three files: the service module, the route handler, and a catalog entry. A drift test guards that the catalog stays in sync with the actual route map.

The design has a name in distributed systems: it is a read-model decomposition. Instead of one monolithic endpoint that computes and formats everything a consumer might want, the system pre-computes each dimension into its own cached, typed, versioned surface. The write side (running the simulation) happens once. The read side (querying the results) fans out across as many surfaces as there are questions worth asking.

This is the architectural insight the AI observability industry is circling without quite reaching. The $2.69 billion market exists because most AI systems treat intermediate states as implementation details — transient data that lives inside the execution loop and must be captured by external instrumentation before it vanishes. MiroShark treats intermediate states as products. They are not logged after the fact. They are computed, cached, and served as first-class API responses with their own schemas, their own cache headers, and their own provenance envelopes.

## What This Means Beyond One Project

McKinsey's 2026 State of AI report names lack of trace-level visibility as one of the top reasons agent rollouts stall. Gartner warns that 40% of agentic AI projects risk cancellation by 2027 if governance and observability are not established. The industry response has been to build better instrumentation — more traces, more spans, more dashboards. That work is necessary. But it is also, structurally, a patch on a design decision that was made before the first line of monitoring code was written: the decision to treat intermediate states as ephemeral.

The alternative is not revolutionary. It does not require new infrastructure or a new monitoring platform. It requires designing the system so that the intermediate states are addressable outputs from the beginning — so that "what happened between input and output" is not a forensic question answered by traces, but a product question answered by an API call.

Forty-one surfaces is not a feature count. It is an architectural position: the process is the product.

---
*Sources: [PwC Agent Survey 2026 / AI Agent Adoption Statistics](https://paul-okhrem.com/enterprise-ai-agents-statistics-2026/) · [AI Observability for LLM Systems: Multi-Layer Analysis (arXiv)](https://arxiv.org/html/2604.26152v1) · [IBM Research: Formalizing Observability in Agentic AI Systems, AAAI 2026](https://research.ibm.com/publications/formalizing-observability-in-agentic-ai-systems) · [AI Observability Market Growth, 2026](https://www.braintrust.dev/articles/best-ai-observability-tools-2026) · [Gartner: 40% of Enterprise Apps to Feature AI Agents by 2026](https://www.gartner.com/en/newsroom/press-releases/2025-08-26-gartner-predicts-40-percent-of-enterprise-apps-will-feature-task-specific-ai-agents-by-2026-up-from-less-than-5-percent-in-2025) · [MiroShark GitHub](https://github.com/aaronjmars/MiroShark)*
