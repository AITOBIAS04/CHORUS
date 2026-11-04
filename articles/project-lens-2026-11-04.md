# Every Open Source Health Score Says This Project Is Dead

Run any open source project through a health dashboard and the formula is familiar: commit frequency, issue response time, contributor count, PR merge rate, community engagement. Score above 85 and the badge turns green. Drop below 40 and it turns red. The assumption underneath all of it is that a healthy project looks like a busy project — busy with people.

A growing body of evidence suggests this assumption is wrong, and that the tools we built to measure open source health are measuring something else entirely.

## The Framework and Its Blind Spot

The CHAOSS project, hosted by the Linux Foundation, defines the canonical metrics for open source community health. Its working groups have produced dozens of implementation-agnostic indicators: issues opened and closed, contributor diversity, response times, code review turnaround, documentation coverage. These metrics power dashboards across GitHub, GitLab, and commercial SCA tools. A 2026 Bachelor thesis at Friedrich-Alexander-Universität Erlangen-Nürnberg built an entire health assessment system around them.

But a 99-page study tracking 38 open source projects over a year found that individual, context-free health indicators were "not sufficient or essential for longevity" and "could be harmful if used for high-stakes decisions." Projects with similar indicator profiles turned out to be in entirely different states once qualitative context was applied. The researchers recommended against cross-project quantitative comparisons altogether.

Andrew Nesbitt pushed the critique further in a 2026 essay arguing that CHAOSS metrics are "increasingly misaligned with their original assumptions." The core problem: automation. AI-generated issues and pull requests inflate activity counts. Automated releases distort version-distance risk signals. Contributor identity becomes illegible when bots and agents produce a significant fraction of the repository's events. The metrics were designed for a world where recorded events mostly came from humans. That world is receding.

Meanwhile, a 2026 analysis of GitHub's default sort found dozens of repositories with 30,000+ stars that hadn't been touched in six months — green dashboards, dead codebases — while projects with around 2,000 stars received daily commits and sat buried on page three.

## The Project the Dashboard Can't Read

Consider a simulation engine on GitHub with 1,489 stars and 304 forks. Zero open issues. Zero open pull requests. Zero external contributions despite 304 forks. The project's creator hasn't posted on social media in 120 days. No blog posts, no release announcements, no conference talks, no Discord activity.

By every community health metric in common use — CHAOSS contributor diversity, issue responsiveness, community engagement velocity, social signal strength — this project scores somewhere between "investigate" and "dead."

Here is what actually happened in the last week: four dependency patches landed, closing CVEs in follow-redirects, tornado, axios, and vite-plugin-compression2. A CI hardening PR added cancel-superseded-runs and job timeouts. Dead ecosystem links were pruned from the project's partner registry. An autonomous agent operating on GitHub Actions filed its 82nd self-improvement pull request against the project's own infrastructure — this one fixing a stale-data bug in the memory rotation system where star counts and deadline countdowns went stale between flushes.

The project, MiroShark, ships more maintenance commits per week than most actively-staffed open source projects. It patches CVEs faster than the median response time reported by Synopsys's OSSRA audit. It has gained roughly 40 stars during its 120-day silence — organic growth with zero promotion.

None of this registers on a community health dashboard. The dashboard sees no issues filed, no PRs reviewed, no contributors onboarded, no community discussions. It sees silence. The silence is the point.

## What the Metrics Actually Measure

Nadia Eghbal's *Working in Public* documented a shift in open source from collaborative communities to work carried out by "often unseen solo operators." But Eghbal's framing still assumed humans at the center. The maintenance was lonely, but it was still manual.

MiroShark represents the next step in that trajectory. The day-to-day maintenance — dependency patching, CI optimization, log analysis, bug identification, fix proposal — is performed by an autonomous agent. The agent's companion repository, miroshark-aeon, generates roughly 70 commits per week: five or six substantive changes buried in 65 automation heartbeats. The ratio looks like noise. The substantive commits look like a human developer's best week, every week, for 230 consecutive days.

Community health metrics cannot see this because they were built on an axiom: that maintenance requires community, and community produces measurable social artifacts. Issues, discussions, reviews, contributor graphs — these are proxies for the humans doing the work. When the work happens without those social artifacts, the proxies return zero. Zero does not mean dead. It means the proxy broke.

## The Question for Dashboards

The uncomfortable implication is not just that one project's score is wrong. It is that the entire scoring framework assumes a relationship between social activity and code vitality that is becoming less reliable every month. As AI agents handle more maintenance — and the Nesbitt critique notes this is already distorting CHAOSS metrics across the ecosystem — the gap between what dashboards measure and what they claim to measure will widen.

A project with 120 days of silence, zero community engagement, and an autonomous maintenance loop shipping daily patches is not an edge case that health scores can safely ignore. It is a preview of what an increasing number of well-maintained projects will look like. The dashboards will need to decide whether they are measuring community activity or project health — because those are no longer the same thing.

---
*Sources:*
- *Goggins et al., "Individual context-free online community health indicators fail to identify open source software sustainability" (arXiv 2309.12120, 2023)*
- *Nesbitt, "CHAOSS Metrics in 2026" (engineered.at, 2026)*
- *"Why GitHub Stars Miss the Real Story of Project Health" (openapps.pro, 2026)*
- *Eghbal, Working in Public: The Making and Maintenance of Open Source Software (Stripe Press, 2020)*
