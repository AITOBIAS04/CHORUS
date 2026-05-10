# Every Simulation Deserves a Citation Key

Two workshops at CHI 2026 in Barcelona just spent a day debating whether LLM agent simulations belong in policy research. A paper presented at one of them put it bluntly: "We Need Strong Preconditions For Using Simulations In Policy." Meanwhile, an open-source project with 1,127 GitHub stars quietly shipped the infrastructure that makes those preconditions real.

## The Academic Moment

Something shifted in the last two weeks. At CHI 2026, the PoliSim workshop convened HCI researchers, NLP engineers, and policymakers around a single question: how can LLM agent simulations move beyond technical demonstrations to become practical tools for governance? The workshop's framing was honest — emergent behaviors like coalition formation and information cascading are scientifically interesting, but policymakers need more than interesting. They need reproducible, traceable, and verifiable.

A second CHI workshop, "From Generation to Simulation," tackled the ethics of AI personas in human-centered research, warning that synthetic agents can systematically overestimate intervention effects — a problem that gets worse, not better, when you can't reproduce the run that generated the estimate.

Stanford's Center for Open and Reproducible Science announced its 2026 symposium theme: AI and Scientific Reproducibility. The keynotes will cover agentic reproducibility systems and benchmark frameworks. The message from the research establishment is clear: if simulation is going to matter, it needs the same rigor infrastructure that experimental science spent decades building.

## What MiroShark Shipped This Week

Eight commits landed on MiroShark's main branch in seven days. The two that matter most aren't the flashiest — they're plumbing.

PR #75 introduced `reproduce.json`, a v1-schema export that captures every parameter needed to rerun a simulation: scenario text, agent count, round count, platform toggles, time-configuration knobs, director-mode events, and fork lineage. The critical detail: identical exports of a finished simulation are bytewise-identical. That means the file hash is a stable citation key. You can reference a MiroShark simulation the way you reference a dataset — by its hash.

PR #76 followed with the Lineage Navigator, a `GET /lineage` endpoint that turns the `parent_simulation_id` pointer into a bidirectional graph. Fork a simulation, inject a counterfactual event, and the lineage endpoint traces the full ancestry — parent, children, siblings. It's a citation graph for simulations, built from the same data model that already powers counterfactual branching.

These two PRs sit on top of a distribution stack that's been growing for weeks: share cards, animated belief replays, Markdown transcripts, CSV trajectories, tweet thread exports, a live watch page, RSS feeds, and a public gallery with full-text search. With reproduce.json and lineage, that stack crosses a threshold. A simulation is no longer just viewable and shareable — it's citable and traceable.

## The Citation Primitive

The idea is deceptively simple. Every simulation already stores its parameters internally. What reproduce.json does is externalize them in a schema that's stable across versions, so a second operator — or a reviewer, or a future graduate student — can regenerate the same run. The bytewise-identical guarantee means two people who export the same simulation get the same file. No floating-point drift, no timestamp jitter. One hash, one simulation.

Pair that with the lineage navigator, and you get something that looks like a lightweight DOI system for simulation experiments. "This simulation extends simulation X, which itself forked from Y after injecting event Z at round 24." That sentence, which currently lives in lab notebooks and Slack threads, is now machine-readable and API-addressable.

The surface-stats endpoint (PR #74) adds one more layer: per-share-surface request counters. An operator can see which surfaces — transcript, trajectory, watch page, RSS — are actually being consumed. It's altmetrics for simulations.

## Why It Matters Now

The PoliSim workshop asked for preconditions. Here they are: reproducibility (reproduce.json), traceability (lineage navigator), verifiability (the existing verified-predictions system at `/verified`), and transparency (surface-stats usage analytics). MiroShark didn't wait for a standards body to define these primitives. It shipped them as API endpoints on a project that runs locally for a dollar.

At 1,127 stars and 224 forks — with a 17-PR streak of zero new dependencies — MiroShark is open infrastructure, not a walled garden. The reproduce.json spec is documented, the lineage endpoint is in the OpenAPI schema, and every share surface has a public URL.

The gap between "demo" and "research instrument" has always been reproducibility. This week, one project closed it.

---
*Sources: [PoliSim@CHI 2026: LLM Agent Simulation for Policy](https://dl.acm.org/doi/10.1145/3772363.3778738) · [From Generation to Simulation — CHI 2026](https://dl.acm.org/doi/full/10.1145/3772363.3778745) · [We Need Strong Preconditions For Using Simulations In Policy](https://arxiv.org/abs/2604.07838) · [Stanford CORES Symposium 2026: AI and Scientific Reproducibility](https://datascience.stanford.edu/events/open-science-center/cores-annual-symposium-2026-ai-and-scientific-reproducibility) · [Computational Reproducibility in Computational Social Science — EPJ Data Science](https://epjdatascience.springeropen.com/articles/10.1140/epjds/s13688-024-00514-w) · [MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)*
