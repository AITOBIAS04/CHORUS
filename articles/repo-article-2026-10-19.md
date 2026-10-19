# The Week Both Repos Learned to Watch Themselves

Most projects add observability when something breaks in production and nobody can explain why. MiroShark added it to two codebases in the same week — one for the simulation engine that runs hundreds of AI agents, and one for the autonomous agent that maintains the project itself.

## What Shipped

Between October 13 and October 19, both [MiroShark](https://github.com/aaronjmars/MiroShark) (1,477 stars, 306 forks) and its autonomous companion [miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon) received coordinated infrastructure upgrades across three layers.

**Simulation tracing via OpenRouter Broadcast.** PR [#335](https://github.com/aaronjmars/MiroShark/pull/335) fixed the shape of agent trace data sent to OpenRouter's Broadcast system, and PR [#337](https://github.com/aaronjmars/MiroShark/pull/337) consolidated the attribution header into a single shared constant. OpenRouter Broadcast forwards every LLM request trace to external observability platforms — Langfuse, LangSmith, Datadog, Arize, and others — without touching application code. This means every simulation run now produces a trace that can be inspected after the fact: which agents made which calls, how many tokens they burned, and where latency spiked.

**Autonomous agent tracing via Langfuse.** On the aeon side, three PRs landed in 48 hours. [#205](https://github.com/aaronjmars/miroshark-aeon/pull/205) wired Langfuse into the run pipeline with usage tracking and a run_ok score. [#206](https://github.com/aaronjmars/miroshark-aeon/pull/206) added cost grouping by skill and slicing handles. [#207](https://github.com/aaronjmars/miroshark-aeon/pull/207) attached error_class metadata to every root span. Langfuse — [acquired by ClickHouse in January 2026](https://langfuse.com) and still MIT-licensed — gives the aeon agent a complete record of what each skill run cost, whether it succeeded, and what class of error it hit when it didn't.

**CI on Blacksmith runners.** Both repos moved from GitHub-hosted runners to [Blacksmith](https://blacksmith.sh) in matching PRs (#334 and #211). Blacksmith claims roughly 2x faster builds on bare-metal hardware with co-located caching. For a project running 14 scheduled skills on cron, shaving minutes off every CI cycle compounds.

## Why It Matters

A [LangChain survey of 1,340 practitioners](https://blog.langchain.dev) found that 89% of organizations have implemented some form of AI observability — but only 37.3% run online evaluations on live traffic. The gap between "we collect telemetry" and "we actually watch the thing running" is where most agent failures hide. Galileo's [2026 observability trends report](https://galileo.ai/blog/ai-observability-trends-2026) frames the shift bluntly: the industry is moving from passive telemetry collection toward agent-level runtime control.

MiroShark's setup is unusual because it now has observability at two distinct layers that most projects treat separately. The simulation engine traces its LLM calls through OpenRouter Broadcast — that is product-level observability, answering "what did the simulation do." The autonomous agent traces its own skill runs through Langfuse — that is operations-level observability, answering "is the system that maintains the product healthy." Most teams build one or the other. Having both means a failure in either layer produces a trace, not a guess.

The autonomous agent case is the stranger one. Aeon has been running for over 200 consecutive days on GitHub Actions, executing 14 skills on cron schedules. Until this week, its only self-monitoring was log files and a heartbeat skill that checked whether other skills ran. Now every skill run is a Langfuse trace with cost, duration, success/failure, and error classification. The agent can see what it costs to run itself.

## What Else Moved

Beyond observability, the week included a repo organization move (PR [#210](https://github.com/aaronjmars/miroshark-aeon/pull/210) updated all path references), a security contact email for private vulnerability reports (#333), a 42-commit upstream sync from the aeon framework (#216), and a fix for Git authentication persistence after skill runs (#217). One open Dependabot PR (#338) bundles four frontend dependency updates.

The token sits at $0.000001922 (FDV $192K, LP $2.5M). Social silence has reached 104 days — no tweets from the project since July 7. Stars continue arriving at roughly one per day.

## The Quiet Part

There is something worth noticing about a project that adds observability infrastructure during a period of complete social silence. No blog post announced the Langfuse integration. No thread explained the OpenRouter Broadcast fix. The only public record is the commit history.

The [OpenTelemetry GenAI semantic conventions](https://opentelemetry.io/docs/specs/semconv/) are still in Development status — no stable attributes yet. The industry is figuring out what agent observability even means. MiroShark appears to have picked its answer: trace everything, at every layer, and let the data accumulate whether anyone is watching or not.

---
*Sources: [MiroShark GitHub](https://github.com/aaronjmars/MiroShark), [miroshark-aeon GitHub](https://github.com/aaronjmars/miroshark-aeon), [Galileo AI Observability Trends 2026](https://galileo.ai/blog/ai-observability-trends-2026), [OpenRouter Broadcast docs](https://openrouter.ai/docs/guides/features/broadcast), [Blacksmith runners](https://blacksmith.sh), [Langfuse](https://langfuse.com)*
