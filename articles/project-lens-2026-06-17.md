# Everybody Spent More on AI This Year. Almost Nobody Knows Where It Went.

The average enterprise AI budget grew from $1.2 million in 2024 to $7 million in 2026 — a 483% increase in two years. Per-token inference costs dropped 280x in the same period, from $30 per million tokens to $0.10. The math should be simple: cheaper units, lower bills. Instead, total enterprise AI spending rose 320%. The units got cheaper. Companies bought astronomically more of them.

This is not a mystery. It is a visibility problem. And it is the most expensive one in software right now.

## The Bill Nobody Can Read

Inference — the cost of actually running a model, as opposed to training it — now accounts for 85% of the enterprise AI budget, up from 40% in 2023. The shift happened because companies moved from experimental chatbots to production agentic workflows that run continuously. A simple chatbot query costs a baseline amount of tokens. A RAG-enhanced query costs three to five times that. An agentic multi-step workflow — the kind that plans, executes, retries, and self-corrects — burns ten to twenty times the baseline per task. Always-on monitoring agents consume tokens continuously, with no natural stopping point.

The problem is that almost nobody can trace those costs back to the work that generated them. Only 43% of organizations track AI spend by customer. Only 22% track it by transaction. Finout's analysis of enterprise AI budgets in 2026 put it bluntly: "If you can't answer 'who spent what on which AI workload,' you can't build a reliable forecast." Hidden costs from embeddings, retries, logging, and rate-limit management add 20 to 40% on top of raw API fees — costs that most teams discover only when the invoice arrives.

A whole industry has sprung up to address this. Finout, CloudZero, Maxim, Holori, and at least a dozen other vendors now sell "AI cost observability" — dashboards and instrumentation layers that sit between your application and its LLM providers, tagging every API call with metadata so you can attribute spend after the fact. The tools are useful. But they address the problem from the outside: bolting observability onto a system that was not designed to report its own costs.

What if cost was not something you observed from outside the system, but something the system told you — the same way it tells you any other result?

## A Number That Ships With the Answer

MiroShark is an open-source crowd simulation engine — 1,304 stars, 272 forks — that models how opinions propagate through networks of AI agents. You upload a document, the engine generates hundreds of AI personas grounded in census demographics, and those agents interact across simulated social platforms over multiple rounds. The output is a trajectory: how opinion moved, who moved it, where coalitions formed.

On June 16, the project merged PR #179: a new endpoint at `GET /api/simulation/<id>/cost.json`. It is the project's 40th integration surface — and possibly the most consequential one that has nothing to do with simulation results.

The endpoint returns a structured JSON envelope with the simulation's estimated cost in USD, total token counts for input and output, the number of LLM calls, latency percentiles (p50, p90, max), wall-clock start and end times, and two breakdowns: cost by model and cost by phase. Every simulation that runs on MiroShark now carries its own price tag as machine-readable data, queryable by any consumer the same way they would query the simulation's belief trajectories or coalition structures.

The implementation is characteristically minimal. A pure-stdlib Python service reads the simulation's event log, aggregates token counts per model against an OpenRouter pricing table, and returns the envelope. No new dependencies. No external cost-tracking service. No dashboard. The cost data shares the same event reader as the human-readable run summary that already existed — extracted into a shared function so the two outputs can never drift apart. A 60-second cache lets the endpoint serve mid-simulation queries as cost accrues round by round.

The detail that matters most is the honesty posture. The envelope includes `"is_estimate": true` and a `pricing_basis` field that states, in plain language, that models absent from the pricing table are counted as $0 — making the reported figure an explicit lower bound, not an invoice. The system does not pretend to know what it does not know. It tells you precisely how confident it is in its own cost figure, using the same pattern the project uses for its simulation confidence score.

## Why an Endpoint Is Not a Dashboard

The distinction between MiroShark's approach and the observability industry's approach is architectural, not cosmetic. An observability dashboard ingests costs from the outside. It intercepts API calls, tags them, stores them, and presents them in a UI that a human reads. The cost information lives in a separate system from the work it describes. It requires setup, configuration, and a subscription. It is a tool for operators, not for the output's consumers.

An API endpoint that ships cost data alongside results treats cost as a first-class property of the output itself. The simulation's cost travels with the simulation — in the same JSON format, behind the same authentication, cached by the same infrastructure, gated by the same publish controls. An ecosystem partner who queries MiroShark's results can query the cost in the same request pattern. A researcher evaluating whether to trust a simulation can check what it cost the same way they check the confidence score. A trading bot that subscribes to filtered webhooks could, in principle, factor cost into its weighting of signal reliability.

This is the difference between a nutrition label printed on the package and a third-party testing lab you have to visit separately. Both give you the information. One travels with the product.

The 40th surface also makes MiroShark's central marketing claim — "simulate anything for $1" — programmatically verifiable. Before cost.json, that claim lived in the repository description and the landing page. Now it lives in structured data that any consumer can audit per simulation. The claim either holds or it does not, and the endpoint will tell you which, with token-level granularity, for every run.

## The Number That Should Travel With Every AI Output

Gartner projects $2.5 trillion in global AI spending in 2026. That spending is distributed across millions of API calls, thousands of models, and an unknowable number of agentic workflows — most of which cannot tell you what they cost at the level of a single task. The industry response has been to build better meters outside the pipe. More dashboards. More tagging layers. More observability vendors.

The alternative — the one a 40-surface simulation engine just demonstrated — is to put the meter inside the output. Not as an afterthought. Not as an admin feature. As a surface: a structured, versioned, cached, schema-documented API endpoint that any consumer can query without installing anything, without configuring anything, without subscribing to anything.

Every AI system knows what it spent. The tokens are counted. The models are logged. The pricing tables are public. The information exists. The question is whether it stays locked inside operator dashboards or whether it ships with the result, the way a cost.json ships with a simulation — honestly flagged, explicitly bounded, and available to anyone who asks.

The $7 million question is not how much enterprises are spending on AI. It is why the AI itself does not tell them.

---
*Sources: [AI Inference Cost Crisis 2026 (Oplexa)](https://oplexa.com/ai-inference-cost-crisis-2026/) · [Predicting AI Spending in 2026 (Finout)](https://www.finout.io/blog/predicting-ai-spending-in-2026-what-the-data-actually-tells-us) · [Best AI Cost Observability Tools in 2026 (Finout)](https://www.finout.io/blog/best-ai-cost-observability-tools-in-2026) · [Best LLM Cost Tracking Tools in 2026 (Maxim)](https://www.getmaxim.ai/articles/best-llm-cost-tracking-tools-in-2026/) · [MiroShark PR #179 — Per-Simulation Cost Surface](https://github.com/aaronjmars/MiroShark/pull/179) · [MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)*
