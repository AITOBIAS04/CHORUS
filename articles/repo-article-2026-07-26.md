# For Four Months, Two Hundred Ninety-Seven Forks Contributed Nothing. The Two Hundred Ninety-Eighth Added an Entire Cloud Provider.

A CHI 2026 research team spent months building the first empirical framework for measuring whether a project's forks actually feed code back to the source. They called the metric convergence entropy. The idea: track not just how many forks exist, but how effectively the commits distributed across those forks get integrated into the main repository. High convergence entropy means contributions flow back. Low means forks diverge and die.

The paper landed in April. Three months later, a project with 297 forks and near-zero upstream pull requests got its first data point.

## What Happened

On July 26, a developer using the handle binyangzhu000-sudo forked MiroShark — an open-source AI simulation engine with 1,415 GitHub stars — and opened pull request #259 within the same minute. The PR adds Atlas Cloud as a provider preset, wiring a new inference platform into MiroShark's settings API and frontend. Five files changed. A hundred and thirty-one lines added. Seventy-three of those lines are tests.

This is not a typo fix. It is a full-stack integration: backend API routes, OpenAPI spec, frontend settings panel, and a new test suite. Someone looked at MiroShark, decided they wanted to run simulations on Atlas Cloud's 400-model inference platform, and built the wiring to make it work.

It arrived during the twentieth consecutive day of zero social mentions for the project. The token sits at $0.000001809, down 96% from its all-time high.

## What the Research Says

The fork-and-pull model is how most open-source contribution works, but the overwhelming majority of forks never contribute back. The Linux Foundation's 2025 data puts it at roughly 80% of forks that never merge upstream. A PLOS ONE study of Apache projects found the top 1% of contributors produce the majority of code. The 1-9-90 rule — 1% create, 9% interact, 90% watch — has held across open-source communities for over a decade.

MiroShark's numbers are more extreme. Two hundred ninety-seven forks existed before today. Community pull requests in the last month: zero. The project's autonomous agent (aeon, running continuously for 120-plus days) has filed more self-improvement PRs than the entire forker base combined.

The CHI 2026 convergence entropy paper, authored by Shen, Wang, Zhang and colleagues, offers a framework for understanding this pattern. Their key finding: fork integration effectiveness — how well distributed commits across forks get merged back — correlates significantly with a project's external productivity, pull request acceptance rate, and bug discovery. A related line of research on fork entropy, using Rao's quadratic entropy to measure the diversity of modifications across forks, found that projects with more diverse fork activity tend to receive more contributions and discover more bugs.

The implication is that the type of contribution matters as much as the count. A single fork that adds a provider integration signals something different than ten forks that fix README formatting.

## What PR #259 Signals

Atlas Cloud is a multi-model inference platform offering 400-plus models through an OpenAI-compatible API — DeepSeek, GPT, Claude, LLaMA, Mistral, Kimi, and others. Their Photon engine uses FP4 quantization for high-throughput, low-latency inference. Adding it as a MiroShark preset means someone is deploying simulations on infrastructure that was not part of the original design.

This is a platform-extension contribution, not a maintenance contribution. The contributor did not fix an existing bug or clean up dead code. They extended where MiroShark can run. In the convergence entropy framework, this is precisely the kind of fork activity that correlates with project productivity growth — a modification that diversifies the project's capabilities rather than duplicating existing work.

The PR includes proper validation: a dedicated test file with 73 lines covering the preset configuration. The backend changes prevent stale custom form values from overwriting a selected preset. Web enrichment stays on the existing SearXNG fallback rather than assuming Atlas Cloud provides browsing. These are choices that suggest the contributor read the codebase, not just the README.

## Why It Matters

MiroShark has spent the last month doing nothing but maintenance. Dead code purge: 53 files, minus 1,325 lines. Four security patches in a week — MCP SDK, shell-quote, PyTorch, setuptools. CI actions bumped. Frontend dependencies updated. Zero new features shipped. The agent kept the lights on while the community was silent.

Then the 298th fork arrived and contributed something the agent never would have built: a third-party provider integration chosen by an external user based on their own deployment needs. GitHub's Q1 2026 Innovation Graph shows outbound collaboration growing 16% quarter-over-quarter. Forty percent of contributions come from first-time contributors. The question for projects like MiroShark is not whether forks will eventually contribute — the research suggests most will not — but whether the ones that do will extend the platform in directions the maintainer never planned.

One fork out of 298 is a 0.34% conversion rate. The research says that is roughly normal. What is not normal is the contribution arriving fully formed, with tests, during a period of total social silence, extending the project to infrastructure the maintainer has never mentioned.

Convergence entropy measures whether forks feed code back. For MiroShark, the first real measurement just landed. It is a small sample. But the direction of the signal — platform extension, not maintenance — is the one the research says matters most.

---
*Sources: [CHI 2026: Convergence Entropy in OSS Fork Integration](https://doi.org/10.1145/3772318.3791405) | [Fork Entropy and Project Productivity (Empirical Software Engineering)](https://link.springer.com/article/10.1007/s10664-025-10668-4) | [GitHub Q1 2026 Innovation Graph](https://github.blog/news-insights/policy-news-and-insights/q1-2026-innovation-graph-update-open-source-collaboration-is-accelerating-worldwide/) | [Atlas Cloud](https://www.atlascloud.ai/) | [MiroShark PR #259](https://github.com/aaronjmars/MiroShark/pull/259)*
