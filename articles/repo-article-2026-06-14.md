# A Vulnerability Was Reported in Public Because There Was Nowhere Else to Put It

Open-source security policies are usually written after the first scare. MiroShark just broke the pattern — and the commit history shows exactly why.

## The State of Things

MiroShark is a swarm intelligence engine that simulates public reaction to anything you drop in — a press release, a policy draft, a financial headline. Hundreds of AI agents post, argue, trade, and change their minds across simulated social platforms and prediction markets. One simulation, ten minutes, about a dollar.

As of today, June 14, 2026: 1,270 stars, 269 forks, 39 integration surfaces, three languages (English, Chinese, Japanese), 14 ecosystem projects building on top of it. The repo has been averaging 3-4 new stars and a fork per day for the past month.

This week, the project shipped something that doesn't show up on a features list: the paperwork that separates a promising repo from a production-ready platform.

## What Actually Shipped

Three things landed in the same week, and together they tell a story.

First, [PR #162](https://github.com/aaronjmars/MiroShark/pull/162) — merged today — expanded `CONTRIBUTING.md` from a 30-line test stub into a full contributor guide. Development setup with exact commands. Branch naming conventions. Conventional Commit PR titles matching the merged history. The OpenAPI drift-test contract that gates every new endpoint. A contributor arriving from the star count no longer has to reverse-engineer the workflow from `package.json` and CI files in parallel.

Second, [PR #158](https://github.com/aaronjmars/MiroShark/pull/158) — a `SECURITY.md` responsible-disclosure policy, currently open. Private reporting via GitHub security advisories. A 3-business-day acknowledgment SLA. Coordinated disclosure terms. An operator hardening checklist covering Neo4j ports, LLM keys, and admin-token-gated endpoints.

Third, [PR #159](https://github.com/aaronjmars/MiroShark/pull/159) — submitted by community contributor `dan-and` — an infrastructure improvement allowing same-origin API calls and bumping Neo4j from v5.15 to v5.26. Not a feature. Not a surface. A plumbing fix from someone outside the core team, arriving the same day as the contributing guide.

## Why the SECURITY.md Exists

The PR body for #158 contains a line that explains everything: "the hardcoded default Neo4j password (#88) was reported over a **public** issue because no private path existed."

That's the pattern most projects live with. A researcher finds something, looks for a security contact, finds nothing, and opens an issue that anyone can read. Snyk's data backs this up: projects with a disclosure policy in place receive private vulnerability notifications 73% of the time, compared to 21% of projects without one. The policy isn't a formality — it's the difference between a quiet fix and a public scramble.

The timing matters. The OpenSSF [OSPS Baseline](https://baseline.openssf.org/), updated in February 2026, now defines 41 security requirements across three maturity levels. Level 1 — basic hygiene — includes having a security policy and a private reporting channel. The [Black Duck 2026 OSSRA report](https://www.openlogic.com/blog/state-of-open-source-report-key-insights) found that 87% of audited codebases carried some form of security risk. Supply chain attacks [increased 431%](https://cybertechnologyinsights.com/whitepaper/the-open-source-trust-crisis-supply-chain-attacks-in-2026/) between 2021 and 2023 and hit a new record high in October 2025.

MiroShark runs LLM API keys, processes arbitrary user documents through a Neo4j graph, and exposes 39 API surfaces. The attack surface is real. The policy arrived before anyone exploited it — barely.

## The Deeper Pattern

What makes this week interesting isn't any single PR. It's the velocity of institutional maturation.

Eight days ago, MiroShark had a `CONTRIBUTING.md` that only mentioned pytest. No security policy. No community infrastructure PRs. Today it has a full contributor onboarding pipeline, a responsible disclosure channel, bilingual documentation for both files, and a third-party developer submitting Neo4j version bumps.

This is the transition the [FINOS Open Source Maturity Model](https://osr.finos.org/docs/bok/osmm/introduction) tries to formalize: the point where a project stops growing by features alone and starts growing by reducing friction for everyone who isn't the original author. Contributing guides lower the bar for first PRs. Security policies lower the bar for responsible reporting. Bilingual docs lower the bar for an entire language community. None of these produce a new endpoint. All of them produce a more durable project.

Meanwhile, the engine keeps shipping. Signed result payloads (HMAC-SHA256 verification). Activity feeds. Full-text search. A confidence trajectory overlay. An agent stance flip report. Seven new surfaces in seven days — all pure-stdlib, zero dependencies — on top of the governance scaffolding.

## Why It Matters Now

Open source in 2026 is infrastructure. The [Sonatype State of the Software Supply Chain](https://www.sonatype.com/state-of-the-software-supply-chain/introduction) report, the OSPS Baseline, the EU's incoming AI Act deadlines — all of them point the same direction: projects that treat security and governance as features, not afterthoughts, are the ones that survive adoption at scale.

MiroShark is at 1,270 stars with 14 downstream projects. It processes sensitive documents through LLM pipelines. The question was never whether it needed a security policy. The question was whether it would ship one before or after the first real incident. Issue #88 was the warning shot. PR #158 is the response.

Most projects wait for the break-in to install the lock. This one read the police report and called the locksmith.

---
*Sources: [MiroShark GitHub](https://github.com/aaronjmars/MiroShark), [OpenSSF OSPS Baseline](https://baseline.openssf.org/), [Sonatype 2026 Supply Chain Report](https://www.sonatype.com/state-of-the-software-supply-chain/introduction), [Snyk Responsible Disclosure](https://snyk.io/blog/responsible-disclosure/), [Black Duck 2026 OSSRA](https://www.openlogic.com/blog/state-of-open-source-report-key-insights), [FINOS Open Source Maturity Model](https://osr.finos.org/docs/bok/osmm/introduction), [Open Source Supply Chain Attacks 2026](https://cybertechnologyinsights.com/whitepaper/the-open-source-trust-crisis-supply-chain-attacks-in-2026/)*
