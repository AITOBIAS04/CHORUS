# Ninety-Three Percent of Your Dependencies Haven't Been Touched in Two Years.

The 2026 Black Duck Open Source Security and Risk Analysis report audited 947 commercial codebases across seventeen industries. The headline finding: 93% contained at least one component with no development activity in the past two years. Not deprecated. Not archived. Not deleted. Just silent — still listed in package manifests, still imported on every build, still running in production. Black Duck calls them zombie components.

The jump is steep. In 2024, the same report put the figure at 49%. In two years, the share of codebases carrying unmaintained dependencies nearly doubled. The average commercial application now depends on 1,180 open-source components, up from 911. Only 7% are running the latest version. Forty-one percent are ten or more versions behind.

When a vulnerability is discovered in one of these projects, there is often no maintainer left to fix it.

## The AI Paradox

A January 2026 preprint — "Vibe Coding Kills Open Source" by Koren, Békés, Hinz, and Lohmann — argues that AI-assisted development is accelerating the crisis. Their model shows that when AI agents select and assemble packages without reading documentation, filing bugs, or engaging with maintainers, the engagement loop that sustains open source breaks. Maintainers who monetize through documentation traffic, consulting, and reputation lose those signals. Tailwind CSS's creator reported documentation traffic down roughly 40% since early 2023, with revenue falling nearly 80%.

A May 2026 LeadDev analysis extends the argument: GitHub Octoverse counted 230 new repositories per minute and 4.3 million AI-related repos, a 178% year-over-year rise. Eighty percent of new developers use Copilot in their first week. The volume of created software is rising. The volume of maintained software isn't.

Daniel Stenberg, the maintainer of curl — used by virtually every internet-connected device on Earth — counted AI-generated vulnerability reports submitted to his project: 2 in 2023, 6 in 2024, 37 in 2025. "We still have not seen a single valid security report done with AI help," he said. The submissions cost nothing to generate and everything to review.

The pattern is clear: AI makes it cheaper to start projects, cheaper to submit code, and cheaper to abandon both. The expensive part — reading, understanding, maintaining — stays human-paced.

## Nine Hours

On October 8, 2026, a user named twt-rudi filed three bug reports against MiroShark, an open-source simulation engine on Base with 1,467 stars and 302 forks. The bugs were real. Issue #321: the NER pipeline in claude-code mode silently crashed on an unexpected keyword argument, producing a graph with zero nodes and reporting success. Issue #322: resuming a simulation on an existing database crashed because twenty-six SQL schema files used `CREATE TABLE` without `IF NOT EXISTS` — and a failed resume could corrupt state, silently wiping platform data on the next attempt. Issue #323: the report API returned the wrong report when a regeneration created a new folder alongside the old one, because `os.listdir` order is arbitrary.

All three were filed between 1:57 PM and 1:58 PM UTC. All three were closed by 10:45 PM. Nine hours. Three fixes spanning 36 files, 537 lines added, 47 removed. Each fix shipped with a dedicated test suite: 8 tests for report lookup ordering, a signature-parity test ensuring two LLM clients never diverge again, and a 184-line resume idempotency suite that verifies schemas survive double-application.

In the 93% of codebases carrying zombie dependencies, those three issues would have joined the backlog. An arXiv study of 30,340 bug reports across 500 heavily depended-upon npm packages found a median project-level response rate of 70% — meaning 30% of bug reports get no substantive reply at all.

MiroShark has had substantive commits every day for over two hundred consecutive days. Ninety-four of those days, nobody tweeted. The social channels went dark on July 7. The code didn't.

## The Maintenance Question

What the zombie-component crisis really exposes isn't a shortage of code. It's a shortage of attention. The Black Duck numbers describe the gap between software that exists and software someone is watching. The AI-slop problem compounds it — more code, more submissions, more dependencies, all generated faster than anyone can review them.

The conventional answer is "fund your maintainers." The Vibe Coding paper argues that without structural changes to how maintainers earn returns, the ecosystem can't sustain itself under widespread AI-assisted development. Charles Humble, writing in LeadDev, put it simply: "When everyone can build, the scarce resource becomes maintainers."

But there's a less-discussed possibility: what if AI can maintain, not just create?

MiroShark runs a second repository — miroshark-aeon — where an autonomous agent has been operating for over two hundred days. It files self-improvement PRs, patches vulnerabilities, runs daily health checks. The human founder builds features. The agent keeps the lights on. The engagement loop that the Vibe Coding paper says AI is breaking, this project is partially replacing — not through documentation traffic or community management, but through the grind of daily maintenance that no star count or fork count captures.

It's one project. It proves nothing at ecosystem scale. But the question it raises applies to the 93%: what would it look like if the thing that makes software cheap to abandon also made it cheap to maintain?

---
*Sources: [Black Duck 2026 OSSRA Report](https://www.blackduck.com/ossra); [AI-Generated Abandonware Is Hollowing Out Open Source](https://leaddev.com/software-quality/ai-generated-abandonware-is-hollowing-out-open-source) (LeadDev, May 2026); [Vibe Coding Kills Open Source](https://arxiv.org/abs/2601.15494v1) (Koren, Békés, Hinz & Lohmann, arXiv, Jan 2026); [What About Our Bug? A Study on the Responsiveness of NPM Package Maintainers](https://arxiv.org/html/2511.04986v1) (arXiv, Nov 2025)*
