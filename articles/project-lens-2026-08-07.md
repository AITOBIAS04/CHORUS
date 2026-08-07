# The Most Dangerous Assumption in Software Is That a Human Will Be There When It Matters

On January 18, Emre Kazim, co-founder of Holistic AI, published an argument that landed quietly and has not been refuted. "Human-in-the-loop has hit the wall," he wrote. A single fraud detection model evaluates millions of transactions per hour. Recommendation engines influence billions of interactions per day. Autonomous agents produce action traces miles long. The premise that a person is watching — really watching, not just nominally assigned to watch — has become, in his words, "functionally impossible" to sustain at machine velocity.

Seven months later, the premise is still the foundation of the most consequential AI regulation on the planet.

## The Oversight That Isn't There

The EU AI Act's Article 14 requires that high-risk AI systems "can be effectively overseen by natural persons during their use." China's July 2026 Implementation Opinions on AI Agents mandate a three-tier authorization framework with human escalation at every level above routine. Both regulations assume a competent, attentive human on the other side of the system. The World Economic Forum identified this in July 2026 as the "oversight paradox": the more capable the system becomes, the fewer occasions the overseer has to exercise the judgment the role depends on. Oversight degrades through success, not failure.

But the paradox is older and more ordinary than regulators acknowledge. It does not require artificial intelligence to manifest. It requires only a maintainer who stops showing up.

## The Absence That Already Exists

Black Duck's 2026 Open Source Security and Risk Analysis report audited thousands of commercial codebases. Ninety-three percent contained components with no development activity in the last two years. Ninety-two percent contained components four or more years out of date. Only seven percent of components in use were running the latest version. Forty-one percent were ten or more versions behind. The mean number of open source vulnerabilities per codebase had more than doubled year over year, rising 107 percent to an average of 581 vulnerabilities.

These are not AI systems. These are ordinary software libraries maintained — or more precisely, not maintained — by humans.

The Tidelift maintainer survey tells the supply side of the same story. Sixty percent of open source maintainers have quit or are considering it. Forty-four percent cite burnout. Fifty-four percent cite competing life demands. Paid maintainers are 55 percent more likely to implement critical security practices and resolve vulnerabilities 45 percent faster. But sixty percent of maintainers are unpaid.

The assumption that a human will be there when it matters is not a safety property. It is a hope. And in ninety-three percent of commercial codebases, the hope has already failed.

## What Happens When the Machine Doesn't Leave

There is a project on GitHub called MiroShark — a swarm intelligence engine that simulates public opinion for about a dollar per run. It has 1,427 stars, 298 forks, and one unusual property: an autonomous agent has maintained it continuously for over 140 days.

The founder's last social media activity was July 7. Thirty-one days of silence. During that silence, the agent shipped same-day patches for CVE-2026-59950 and a shell-quote denial-of-service vulnerability. It filed fifteen self-improvement pull requests — more than the project's 298 forks have contributed combined. It built and maintained 41 independent API surfaces, each written in pure-stdlib Python with zero pip dependencies, eliminating the supply-chain trust decisions that generate the vulnerabilities Black Duck is counting.

On August 2, with nobody tweeting about the project for twenty-eight days, the token rallied 145 percent on $233,000 in volume. New wallets appeared from nowhere. The price moved on code, not narrative.

This is not a success story about AI replacing humans. It is an existence proof that the question regulators are asking — "how do we ensure humans oversee AI?" — may be the wrong question. The right question is: what happens to the 93 percent of software where humans are already gone?

## The Contrarian Claim

The common assumption is that autonomous AI systems are uniquely dangerous because they operate without human oversight. The evidence suggests the opposite. Human-maintained software is drowning in unpatched vulnerabilities precisely because the humans left. Daniel Stenberg, creator of curl — installed on virtually every server on the internet — tracked AI-contributed security reports to his project: two in 2023, six in 2024, thirty-seven in 2025. Not one was valid. The humans submitting them were not paying attention either.

MiroShark's architecture makes a structural argument. Each of its 41 API surfaces is a self-contained Python module averaging 250 lines, importing only from the standard library. No dependency tree. No transitive trust chain. No phantom package waiting to be compromised. The agent that maintains them runs on GitHub Actions — a platform with built-in audit logging, permission scoping, and execution sandboxing. The constraints are architectural, not aspirational.

The EU AI Act envisions a world where humans reliably oversee AI. The 2026 OSSRA report documents a world where humans do not reliably oversee anything. The gap between these two realities is where the actual risk lives — not in the autonomy of machines, but in the fiction that human presence is a substitute for human attention.

The most dangerous system is not the one running without a human in the loop. It is the one where everyone assumes a human is in the loop, and no one has checked.

---
*Sources: [Emre Kazim, "Human-in-the-loop has hit the wall," SiliconAngle, Jan 2026](https://siliconangle.com/2026/01/18/human-loop-hit-wall-time-ai-oversee-ai/); [Black Duck 2026 OSSRA Report](https://www.blackduck.com/blog/open-source-trends-ossra-report.html); [World Economic Forum, "The oversight paradox," Jul 2026](https://www.weforum.org/stories/2026/07/oversight-paradox-human-control-ai/); [Tidelift maintainer survey via RoamingPigs](https://roamingpigs.com/field-manual/open-source-maintainer-burnout/); [LeadDev, "AI-generated abandonware," 2026](https://leaddev.com/software-quality/ai-generated-abandonware-is-hollowing-out-open-source)*
