# On July 27, GitHub Told Every Robot to Wait Three Days Before Upgrading a Dependency. One Project Had Already Built a Different Throttle.

Last Sunday, GitHub shipped a change that reversed years of its own philosophy. Dependabot — the automation that opens pull requests to bump dependency versions — now waits 72 hours before proposing non-security updates. Security patches still ship immediately. Everything else gets a mandatory cooling-off period.

The reason is blunt: malware packaged as legitimate version bumps had become frequent enough to warrant slowing the machine down. GitHub's Advisory Database logged more than 6,500 npm malware advisories in the year ending May 2026. The 3-day cooldown gives community scanners time to flag poisoned releases before Dependabot funnels them into thousands of repositories.

It is a reasonable response. It is also a concession that full-speed automation without governance creates risk.

## The Velocity Problem

The maintenance burden on open-source projects is well-documented. Microsoft's GCToolkit repository — a mid-sized Java project — had 92 of its 578 total commits come from Dependabot version bumps. One in six commits was not written by a human. On some days, multiple Dependabot PRs landed in the same afternoon.

The pattern scales. Active repositories can receive five, ten, or a dozen automated pull requests on a Monday morning, each bumping a single dependency by a single patch version. GitHub's own February 2026 update — grouping updates for the same dependency across directories into a single PR — acknowledged the noise. The July cooldown goes further: it acknowledges the danger.

But the cooldown is a blunt instrument. It applies the same 72-hour delay to every repository, every dependency, every context. A project with zero third-party dependencies in its critical path gets the same throttle as one pulling from 200 npm packages.

## A Different Throttle

[MiroShark](https://github.com/aaronjmars/MiroShark) — a 1,413-star swarm intelligence engine that simulates public discourse using hundreds of AI agents — has been running a different experiment. Since March 2026, an autonomous agent called [aeon](https://github.com/aaronjmars/miroshark-aeon) has maintained the project continuously for over 130 days. It runs 60+ automated tasks per week: security patches, dependency updates, repository health checks, token monitoring, community pulse tracking.

The agent ships security fixes immediately. In the last week alone, it processed patches for setuptools (bumped to 83.0.0) and PyTorch (GHSA-rrmf-rvhw-rf47). It handles the same class of work Dependabot does — but it also writes articles, monitors GitHub forks, tracks the project's Base-chain token, and files self-improvement PRs against its own skill definitions.

The throttle is not a timer. It is the project's human operator.

On July 26, the operator committed a configuration change (#118) reducing the shiplog and changelog skills from daily to weekly cadence. The day before, commit #119 silenced changelog notifications entirely. These are not emergency interventions. They are tuning decisions — the operator deciding that some automated output had crossed from useful to noise, and dialing it back.

## Who Sets the Speed Limit

GitHub's cooldown is centralized governance: one policy, every repository, enforced at the platform level. MiroShark's model is local governance: an agent running at machine speed, with a human who adjusts the frequency per-skill based on what is actually useful.

Neither approach is wrong. They solve different problems. The cooldown protects the long tail of repositories whose maintainers do not review Dependabot PRs before merging. The operator-as-throttle model works when someone is watching — when the human treats the agent's output as a signal feed they can tune rather than a firehose they endure.

What makes MiroShark's case instructive is the data. The aeon agent has filed 15+ self-improvement PRs since May, each one fixing a pattern it identified in its own execution: duplicate notifications, wasted API calls, stale PR accumulation, memory file bloat. The agent is not just doing maintenance — it is maintaining the maintenance system. And the human's role has shifted from writing code to governing velocity.

This is the pattern GitHub is groping toward with the cooldown. The April 2026 changelog entry — "Dependabot alerts are now assignable to AI agents for remediation" — points in the same direction. The question is not whether machines should do maintenance. It is who decides how fast.

## The Quiet Side

MiroShark is currently in its 24th consecutive day of social silence on X/Twitter. Its token trades at $0.000001656, down 96% from its May all-time high. The project has 298 forks and near-zero community pull requests.

The agent does not care about any of this. It shipped two security patches this week, cleaned 709 lines of leaked scratch files from the output root, and merged two of its own stale self-improvement PRs. The lights are on. The question is not whether the machine is doing the work. The question is whether the right human is watching.

---
*Sources: [GitHub Dependabot 3-day cooldown](https://thehackernews.com/2026/07/github-adds-3-day-dependabot-cooldown.html), [GitHub Advisory Database statistics](https://www.helpnetsecurity.com/2026/07/27/github-dependabot-cooldown/), [Dependabot alerts assignable to AI agents](https://github.blog/changelog/2026-04-07-dependabot-alerts-are-now-assignable-to-ai-agents-for-remediation/), [GitHub grouped Dependabot updates](https://github.blog/security/supply-chain-security/tame-dependabot-group-your-updates-slow-the-cadence-keep-security-fast/), [Supply chain security in the agentic era](https://www.augmentcode.com/guides/supply-chain-security-agentic-era), [MiroShark](https://github.com/aaronjmars/MiroShark), [miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon)*
