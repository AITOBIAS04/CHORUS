# AI's Reproducibility Crisis Isn't Technical. It's a Choice.

On May 4, 2026, the NeurIPS conference announced that the Machine Learning Reproducibility Challenge would become an official track for the first time in its eight-year history. Not a workshop. Not a satellite event. A full track, with papers published in TMLR, the field's premier open-access journal. The organizers framed it as a signal: "Reproducibility has become a scientific question worthy of its own rigorous study."

The signal was overdue. Nearly 70% of AI researchers have admitted they cannot reproduce each other's results. Roughly 5% share their source code. Less than a third share test data. These numbers have been known for years, cited in conferences, tut-tutted in editorials, and mostly ignored in practice. The AI industry ships demos, not receipts.

The common defense is that reproducibility in AI is technically impossible — that large language models are inherently non-deterministic, that stochastic sampling makes identical runs a contradiction in terms, that the whole point of generative AI is that it generates something different each time. This defense is comfortable. It is also wrong.

## The Myth of Inherent Non-Determinism

A team at Thinking Machines Lab recently published a detailed investigation into what actually causes non-determinism in LLM inference. The results challenged the standard explanation. The conventional wisdom — that GPU parallelism and floating-point arithmetic make deterministic outputs impossible — turns out to be incomplete. The primary culprit is something more mundane: batch-invariance loss. Most inference kernels produce different results when batch sizes change. Since server load fluctuates unpredictably, the same query at the same temperature returns different outputs depending on how many other queries happen to be running at the same moment.

The scale of the problem is striking. In one experiment, 1,000 identical requests to Qwen3-235B at temperature zero — theoretically deterministic — produced 80 unique completions. The divergence started at token 103, where 992 completions generated "Queens, New York" and eight generated "New York City." The system was not being creative. It was being inconsistent, and nobody was designed to notice.

The Thinking Machines team demonstrated that batch-invariant kernels can solve this problem. Their implementation on vLLM achieved bitwise-identical outputs regardless of concurrent load. The performance overhead was roughly 60%. That cost is why the feature does not ship by default: determinism is achievable, but it is slower, and speed sells.

This is the crux of the contrarian argument. Reproducibility in AI is not technically impossible. It is economically inconvenient. The industry has chosen speed and novelty over traceability and verification, not because the alternative does not exist, but because nobody has made reproducibility the product.

## What Reproducibility Looks Like When You Build For It

MiroShark, an open-source simulation engine at 1,117 GitHub stars and 222 forks, runs hundreds of AI agents through simulated social environments — Twitter, Reddit, Polymarket — to model how populations react to documents, policies, and events. A simulation costs about a dollar and takes under ten minutes. The outputs include belief drift charts, influence leaderboards, trace interviews, and a verified prediction ledger that records real-world outcomes against simulation forecasts.

Last week, the project shipped PR #75: a Reproducibility Config Export. The feature is a single endpoint — `GET /api/simulation/<id>/reproduce.json` — that returns every parameter that shaped a simulation run: scenario text, agent count, round count, platform toggles, time-configuration knobs, director events, and fork-or-counterfactual lineage. The output is bytewise-stable. The JSON is sorted by keys, pretty-printed with consistent indentation, and locked behind a `SCHEMA_VERSION` constant and a `REQUIRED_KEYS` frozenset that prevents any future refactor from silently dropping a field.

The design decision that matters most is the stability guarantee. Two downloads of the same finished simulation produce identical files. The file hash itself serves as a citation key. A researcher who references a MiroShark simulation can point to a specific hash, and anyone with the reproduce.json file can verify that the parameters match — or run the simulation again with the same inputs and compare results.

This is not a novel computer science insight. It is what laboratory notebooks have done for centuries: record the conditions of the experiment so someone else can attempt it. The fact that this is unusual in AI tooling says more about the industry's priorities than about any technical barrier.

## The Audit Trail as Architecture

The reproducibility export did not arrive in a vacuum. MiroShark's architecture treats traceability as a structural requirement, not an afterthought. A trace interview system lets users select any agent after a simulation and ask it why it shifted stance in a specific round. The responses are grounded in the agent's actual logged behavior — every post, every trade, every belief update — rather than generated from scratch. A transcript export renders every round as structured JSON and Markdown with YAML frontmatter. Langfuse integration tags every LLM call with model, latency, cost, and simulation context.

Each of these features exists because simulation without an audit trail is worthless. You cannot learn from a simulation you cannot reconstruct. You cannot cite a result you cannot reproduce. You cannot build on a finding you cannot verify. These are not product features in the conventional sense — they do not make the demo flashier or the output more surprising. They make the output trustworthy, which is a harder sell in an industry addicted to surprise.

## The Market That Doesn't Exist Yet

NeurIPS granting reproducibility its own track is a lagging indicator. The leading indicator is where AI tools are failing to gain traction: regulated industries, academic research, policy analysis, legal proceedings — anywhere the question is not "what did the AI say?" but "can you prove it said that, and can someone else get the same answer?"

The AI agent ecosystem in 2026, now spanning over 120 tools, is overwhelmingly optimized for execution. Frameworks help agents act. Observability platforms help agents be monitored. Enterprise deployments help agents scale. Almost none of these tools ship with a reproducibility primitive — a way to capture the full input state of a run and guarantee that the same inputs produce comparable outputs.

The assumption is that AI's value lies in what it produces. The contrarian bet is that AI's value, in the contexts that actually matter, will increasingly lie in what it can prove. A simulation that cannot be reproduced is an anecdote. A simulation with a bytewise-stable parameter export, a schema-versioned data contract, and a citation hash is evidence. The gap between those two words — anecdote and evidence — is where the next generation of serious AI tooling will be built.

Joelle Pineau launched the first reproducibility challenge at ICLR in 2018. Eight years later, it became an official NeurIPS track. The question is whether the agent ecosystem will take another eight years to learn the same lesson, or whether the tools that build for reproducibility now will simply be the ones still standing when the market catches up.

---
*Sources: [MLRC 2026: Reproducibility as an Official Track at NeurIPS](https://blog.neurips.cc/2026/05/04/mlrc-2026-reproducibility-as-an-official-track-at-neurips/) · [Defeating Nondeterminism in LLM Inference (Thinking Machines Lab)](https://thinkingmachines.ai/blog/defeating-nondeterminism-in-llm-inference/) · [Reproducible AI: Why it Matters (AIMultiple)](https://research.aimultiple.com/reproducible-ai/) · [CORES 2026 Symposium: AI and Scientific Reproducibility (Stanford)](https://datascience.stanford.edu/events/open-science-center/cores-annual-symposium-2026-ai-and-scientific-reproducibility) · [aaronjmars/MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)*
