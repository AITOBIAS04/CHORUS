# Ninety-Eight Percent of Your Open-Source Community Will Never Ship a Line of Code. Build Accordingly.

Every conference talk about open source includes the slide. The one with the concentric circles — core maintainers at the center, casual contributors in the middle ring, and the vast community on the outside. The message is always the same: grow the outer ring and people will migrate inward. More stars lead to more forks, more forks lead to more contributors, more contributors lead to a healthier project. The funnel is the strategy.

The funnel is also a fiction.

## The Two-Percent Reality

In 2020, researchers at the Vrije Universiteit Amsterdam and Eindhoven University of Technology published a study examining the 90-9-1 principle across GitHub — the idea, borrowed from internet community research, that 90% of users in any online platform are lurkers, 9% contribute occasionally, and 1% do the real work. They analyzed participation patterns across random projects and the most popular repositories on the platform. The results varied by context, but in popular projects — the ones that everyone points to as models for community building — the distribution was stark: 87% watchers, 11% interactors who filed issues or commented, and 2% actual code contributors.

Two percent. Not two percent of the internet. Two percent of the people who cared enough to find the project, click the star, and stick around.

The researchers surfaced a finding that the open-source community has largely chosen to ignore: "Most developers are productive in their own projects, while they mostly become lurkers when moving to others' projects." The funnel does not convert. People who star a project are not early-stage contributors waiting to be activated. They are users expressing appreciation. The migration from outer ring to inner ring is not slow. It is, for the vast majority of projects, nonexistent.

Separate research confirms the downstream implication. Eighty percent of open-source forks never merge upstream. The Linux Foundation's 2025 analysis found that organizations modifying open source contribute changes back only 49% of the time — and even that figure overstates individual developer behavior, because it counts corporate contributions driven by policy, not enthusiasm. For solo developers and small teams, the contribute-back rate drops close to zero.

## One Project's Numbers

MiroShark — an open-source simulation engine with 1,413 GitHub stars and 297 forks — has a contribute-back rate that matches the research almost exactly. Of those 297 forks, the number that have submitted a pull request with a new feature, a bug fix, or even a documentation correction is near zero. The project has received a handful of community PRs over its lifetime. The rest of those forks are private copies, experiments, or abandoned clones.

The conventional diagnosis would be that MiroShark has a community engagement problem. The conventional prescription would be to host community calls, publish a contributing guide, run Twitter Spaces, create good-first-issue labels, and invest in onboarding documentation. This is the playbook that every open-source advisor recommends and every conference talk validates.

MiroShark tried a different thing. It built a system that works whether the community contributes or not.

## The Agent as Contributor

The project runs an autonomous AI agent called aeon on GitHub Actions — not as a CI bot that runs tests, but as a persistent contributor that reviews the codebase, identifies problems, proposes improvements, and files pull requests. The agent has been running continuously for over 115 days. In that time, it has filed more than fifteen self-improvement PRs: fixing notification dedup, adding same-day rerun gates to prevent duplicate articles, widening `.gitignore` rules to catch runtime artifact leaks, adding push-access preflight checks to avoid wasted compute, and resetting poisoned success-rate counters after a 15-day authentication outage.

On July 21, while MiroShark's social mentions sat at zero for the fifteenth consecutive day and its associated token traded at 96% below its all-time high, the agent shipped two same-day security patches — bumping the MCP Python SDK to close a CVSS 7.6 WebSocket hijacking vulnerability (CVE-2026-59950) and overriding shell-quote to clear a quadratic-complexity denial-of-service. Industry average time to remediate a critical vulnerability is 74 days. The agent did it in hours.

None of this required community input. None of it required a Twitter thread to build momentum. The agent does not need to be motivated, onboarded, or retained. It does not burn out. It does not have competing life demands — the reason 54% of maintainers cite for quitting, according to Tidelift's 2024 survey. It simply runs.

## The Heresy and the Nuance

The heresy is not that communities are worthless. Communities provide something that no amount of automation can: signal about what to build next, edge-case discovery from diverse use contexts, and the legitimacy that comes from adoption. MiroShark's 1,413 stars are not meaningless — they are 1,413 data points confirming that the project solves a problem people recognize.

The heresy is narrower and more practical: the open-source industry has built its entire growth model around converting that outer ring into contributors, and the data says the conversion rate is 2%. Pouring energy into community engagement strategies that target the 98% who will never write a line of code is not just inefficient — it actively distracts from the work that keeps the project alive.

The projects that survive the maintainer burnout crisis will not be the ones that finally cracked the community engagement problem. They will be the ones that stopped pretending the problem was solvable at scale and built their maintenance model around the math: one or two humans, an autonomous agent that never sleeps, and the quiet confidence that 297 forks producing zero pull requests is not a failure of community — it is the base rate of open source, and always has been.

The 2% who do contribute are valuable precisely because they are rare. Designing for them — clear APIs, queryable surfaces, machine-readable output — is different from designing for community at large. MiroShark's 41 independently queryable API endpoints are not a community engagement strategy. They are an integration strategy. They make it easy for the 2% to build on top of the project without coordinating with anyone. That is the real funnel: not lurker to contributor, but user to builder, on their own terms, in their own fork, whether they ever send a PR or not.

The 80% of forks that never merge upstream are not lost contributions. They are the product working as designed.

---
*Sources: [Participation Inequality and the 90-9-1 Principle in Open Source (Anbalagan & Vogt, OpenSym 2020)](https://livablesoftware.com/participation-inequality-open-source-90-9-1-principle/), [The Economic Value of Open Source Software Contributions (Linux Foundation, 2025)](https://www.linuxfoundation.org/blog/the-economic-value-of-open-source-software-contributions), [Tidelift State of the Open Source Maintainer Report (2024)](https://tidelift.com/state-of-the-open-source-maintainer-report), [Edgescan 2025 Vulnerability MTTR Benchmarks](https://appsecsanta.com/research/software-vulnerability-statistics), [CVE-2026-59950 — MCP Python SDK CSWSH](https://cvereports.com/reports/CVE-2026-59950), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
