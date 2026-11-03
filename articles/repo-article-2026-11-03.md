# Two Websites Stopped Answering. The Row Stayed.

On November 2, Aaron Mars ran an SEO audit on MiroShark's ECOSYSTEM.md — the curated registry of projects built on or extending the simulation engine. Two URLs came back dead. sparkleware.fun returned HTTP 402: Vercel had disabled the deployment. mnemedb.dev returned HTTP 530: Cloudflare couldn't reach the origin server. The fix was a one-line diff. The website links were removed. The X handles stayed. The rows in the table stayed. The projects were not deleted from the ecosystem — they were downgraded from "has a website" to "has a social account."

PR #355 landed the same afternoon. One addition, one deletion, one file changed.

## The Ecosystem Table as Census

MiroShark's ECOSYSTEM.md lists thirteen projects: agents, benchmarks, integrations, and products that publicly identify as building on the simulation engine. AntFleet runs benchmarks. Capacitr has an integration spec. Xerg has a live product at xerg.ai. Blue Agent, Echo Oracle, HivemindOS, Monitor, RootAI, Signa, x402aff, ZER0 — each at a different stage of existence, each with a different surface area of public presence.

Some have a website, a GitHub repo, and an X handle. Others have only an X handle. Sparkleware, after the pruning, falls into the latter category. The website is gone. The account persists. Whether the project behind it does is an open question.

The table does not measure activity. It measures disclosure. A project stays as long as it publicly claims to build on MiroShark. A dead website is not sufficient cause for removal — the row stays, because the project might still be operating behind the handle. But the contraction is visible: fewer links per row means less surface area, and less surface area correlates with decay.

## What the Research Says About Decay

Link rot in open source is well-documented. A study of 9.6 million links embedded in source code comments found roughly 10% were dead at the time of measurement. Guix package source URLs showed 96.4% availability after one year, falling to 91.5% after five — steady, compounding attrition.

Project abandonment compounds it. Miller et al. at ICSE 2025 examined 28,100 widely-used npm packages and found abandonment common among them, with most downstream projects never removing or replacing the abandoned dependency. The Maven ecosystem tells a starker story: a 2025 MSR mining challenge study found first-year abandonment at 6.8% for a 2014 cohort, rising to 49.7% within three years. The Synopsys OSSRA report went further — 91% of audited open-source components showed no maintenance activity in the prior two years.

These numbers describe the dependency layer. The ecosystem layer — the ring of independent projects that build on a platform — has no equivalent census. Nobody measures how many projects in an ECOSYSTEM.md file go dark. But the dynamics are the same: projects spin up, maintainers lose interest or funding, websites lapse, domains expire, and what remains is an X handle posting into silence.

## What Stays Alive

MiroShark itself, at 1,489 stars and 304 forks, continues its pattern of quiet maintenance. Four commits landed this week: a CI hardening PR adding cancel-superseded-runs and job timeouts, two Dependabot dependency bundles, and the dead-link cleanup. No features. No releases. The autonomous agent in miroshark-aeon pushed its 81st self-improvement PR, fixed a push-recap rerun dedup bug, and synced 32 upstream commits from the Aeon framework — 69 files, +2,080/-662 lines, two new skills added.

The token sits at $0.000001894. Day 119 of social silence.

The pattern is consistent across the last several weeks: the core project and its autonomous layer keep producing commits. The ecosystem fringe decays. Sparkleware's Vercel account ran out of runway. MnemeDB's Cloudflare origin stopped responding. The engine they built on continues to tick.

## The Asymmetry

The interesting structural question is not why ecosystem partners die — that's the default outcome for most software projects. The question is what happens to an ecosystem table when the core project outlives its own periphery.

In traditional open source, ecosystem death often precedes or coincides with core project decline. When Rails slowed, many gems went unmaintained. When Angular 1 was deprecated, its ecosystem fragmented. The core and the periphery decay together because both depend on the same community energy.

MiroShark inverts this. The core project's maintenance is partially automated. It does not depend on community energy for day-to-day upkeep. But the ecosystem projects do — they are human-maintained, human-funded, human-motivated. When that motivation dissipates, the project dies in the usual way: the website stops answering, the commits stop, the domain expires. The core keeps going because its maintenance layer operates on a different lifecycle.

Thirteen rows in a table. Two fewer websites than last week. One diff to record it.

---
*Sources: [MiroShark ECOSYSTEM.md](https://github.com/aaronjmars/MiroShark/blob/main/ECOSYSTEM.md), [PR #355](https://github.com/aaronjmars/MiroShark/pull/355), [Links in source code comments (ICSE 2019)](https://digital.library.adelaide.edu.au/items/66fcf74e-5bd8-4030-8423-3827d7aeaf94/full), [Guix source archiving (arXiv 2405.15516)](https://arxiv.org/pdf/2405.15516), [npm dependency abandonment (ICSE 2025)](https://conf.researchr.org/details/icse-2025/icse-2025-research-track/16/Understanding-the-Response-to-Open-Source-Dependency-Abandonment-in-the-npm-Ecosystem), [Maven abandonment dynamics (MSR 2025)](https://arxiv.org/html/2502.00615v2), [OSSRA 2026 report](https://www.blackducksoftware.com/open-source-security-risk-analysis)*
