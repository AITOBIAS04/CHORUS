# What If You Treated Every AI Agent's Opinion Like Grafana Treats a Server Metric?

On December 5, 2013, a platform engineer at eBay Sweden named Torkel Ödegaard made his first commit to a side project. He was building dashboards for Graphite, the open-source metrics database, and he was frustrated. Not with Graphite itself — with the fact that his team used four different monitoring tools and none of them could talk to each other. Each tool had its own dashboard, its own query language, its own way of presenting what was happening inside the servers. If you wanted a single view of your infrastructure, you had to build it yourself, by hand, every time.

Ödegaard's insight was that the dashboard should not care where the data comes from. Write a plugin for each data source, let users compose queries from any of them, and render the results in a single pane. He called the approach "big tent." Within a year, community members had contributed integrations for Prometheus, InfluxDB, and Elasticsearch. Today that side project is Grafana Labs — valued at $9 billion as of February 2026, with over $400 million in annual recurring revenue and 70% of the Fortune 50 as customers.

## The Insight That Scales

The conventional reading of Grafana's success is that it built great dashboards. That reading is wrong. Plenty of tools build great dashboards. What Grafana got right was something more structural: it treated every metric as a queryable surface.

Before Grafana, monitoring was a reporting problem. You configured alerts, you looked at pre-built dashboards, you got summaries. The data existed inside the monitoring tool, but you interacted with it through the tool's opinions about what mattered. Grafana inverted this. It said: the data is yours, the query is yours, the visualization is yours. We just provide the connective tissue.

This is the composable observability pattern. It now supports over 170 data sources and 120 visualization panels. Grafana Labs' 2026 Observability Survey, based on 1,363 responses across 76 countries, found that 77% of organizations lean on open source and open standards for observability — not because open source is cheaper, but because composability is more powerful than any single vendor's pre-built view.

The observability tools market hit $3.4 billion in 2026 and is projected to reach $6.9 billion by 2031. Half of surveyed organizations plan to spend more on observability next year, driven not by price increases but by broader adoption and higher expected ROI. The architectural bet — make everything queryable — won.

## The Same Pattern, Applied to Opinions

Now look at what happens when you apply this thinking to a completely different domain: understanding how groups of people react to things.

The traditional approach to opinion research — focus groups, surveys, polls — is a reporting problem. You hire a firm, they run the study, you get a PDF. The intermediate states are invisible. You cannot query what the third participant thought in the second hour. You cannot ask how sentiment shifted between question seven and question eight. You get the summary, and you trust the methodology.

MiroShark, a swarm intelligence engine with 1,413 GitHub stars and 297 forks, took the Grafana approach instead. It runs simulations where hundreds of AI agents — each with distinct biases, reaction speeds, and influence levels — post, argue, and change their minds about a given scenario. A press release, a policy draft, a market event. The simulation runs for $1 and finishes in under ten minutes.

But the simulation itself is not the product. The query layer is.

MiroShark exposes 41 independently queryable API surfaces. Not 41 features bundled into a dashboard — 41 separate endpoints, each returning a different intermediate state of the simulation. Stance flips. Confidence trajectories. Per-platform sentiment divergence. Agent mention networks. Full-text search across all simulation content. A signed result envelope for offline verification. Each surface has its own URL, its own cache policy, its own documentation.

This is Grafana's architectural pattern translated from infrastructure metrics to agent behavior. Instead of "what is the CPU load on server 47 at 14:32," the query becomes "which agents changed their stance between round 3 and round 5, and what post triggered it."

## Where the Parallel Goes Deeper

The structural similarities are not superficial. Consider how each project handles extensibility.

Grafana's plugin system lets anyone add a new data source — Ödegaard wrote the first few himself, then the community took over. The key constraint: each plugin speaks to its own backend but returns data in a common format that the visualization layer understands. The data source does not need to know about the dashboard. The dashboard does not need to know about the data source.

MiroShark's 41 surfaces follow the same decoupling. Each is implemented as a pure Python stdlib module — roughly 250 lines of code, importing only `json`, `os`, `re`, and `time` from the standard library. Zero third-party dependencies in the analytical layer. Each surface reads from the simulation's output files independently, maintains its own mtime-based cache, and returns data through its own REST endpoint. The confidence trajectory surface does not know about the mention network surface. The stance flip report does not know about the platform sentiment breakdown. They compose at the consumer's level, not at the source.

This is not an accident. It is the same design decision Grafana made in 2013: decouple the query from the view, and let the consumer decide what matters. In a 2026 interview, Ödegaard reflected that the plugin system he created was the key to Grafana's early traction — not the dashboards themselves, but the fact that anyone could connect their data without asking permission.

MiroShark's solo developer made an equivalent bet. Instead of building a polished simulation dashboard that presents a curated story, the project exposes every intermediate state as a first-class queryable object. A researcher can pull confidence trajectories. A developer can integrate stance flips into their own pipeline. An embed consumer can grab one surface without touching the others. The simulation is the data source. The 41 endpoints are the plugin system. The consumer builds the dashboard.

## What This Means Beyond Either Project

The deeper question is whether the composable observability pattern — make the intermediate states queryable, let consumers compose their own views — applies to domains beyond infrastructure and simulation.

The evidence suggests it does. PostHog applied it to product analytics. Weights & Biases applied it to machine learning experiments. Prometheus applied it to time-series metrics before Grafana existed. In each case, the project that won was not the one with the best pre-built dashboard. It was the one that made the raw data most accessible.

AI simulation is early. The 37 open-source projects in the space — from AutoGen's 42,000 stars to academic sandboxes that ship papers but not products — mostly treat the simulation as a black box that produces a final answer. Run the agents, get the result, read the report. The intermediate states exist, technically, in log files and debug output. But they are not queryable. They are not composable. They are not surfaces.

If observability taught infrastructure teams anything, it is that the summary is never enough. The value is in the query you have not thought of yet — the one that surfaces the anomaly that the pre-built dashboard was not designed to catch. Grafana did not predict which metrics would matter. It just made all of them available and let engineers compose the question.

The same logic applies to understanding how groups of people form opinions. The simulation that lets you query any intermediate state is not just a better simulation. It is a different kind of tool — one that treats collective behavior the way Grafana treats server metrics. Not as something to summarize, but as something to observe.

---
*Sources: [Grafana Labs 2026 Observability Survey](https://grafana.com/press/2026/03/18/grafana-labs-4th-annual-observability-survey-reveals-a-field-at-a-crossroads-ai-economics-complexity-and-the-enduring-power-of-open-source/), [Grafana Labs $9B Valuation](https://siliconangle.com/2026/02/13/grafana-labs-reportedly-raising-funding-9b-valuation/), [Grafana Labs Breakout Year](https://grafana.com/press/2026/02/03/grafana-labs-caps-a-breakout-year-of-growth-and-product-innovation/), [The Story of Grafana Documentary](https://grafana.com/blog/the-story-of-grafana-documentary-from-one-developers-dream-to-20-million-users-worldwide/), [Grafana's Big Tent with Tom Wilkie](https://changelog.com/shipit/12), [Observability Market Size 2026-2031](https://www.mordorintelligence.com/industry-reports/observability-market), [Grafana 13 at GrafanaCON 2026](https://grafana.com/press/2026/04/21/grafana-labs-launches-grafana-13-at-grafanacon-2026-makes-open-observability-easier-to-run-at-scale/)*
