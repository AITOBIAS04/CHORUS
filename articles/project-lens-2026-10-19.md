# The Twenty-Six Billion Dollar Assumption That Developers Need to Be Told

The developer tools market raised $26.8 billion across 2,743 funding rounds as of May 2026, according to Crunchbase data. A Draft.dev survey of developer marketing and DevRel leaders found that 62% of teams are increasing their dev marketing budgets this year. Seventy-three percent are investing more in community and events. PostHog publicly disclosed a marketing spend of roughly $1.2 million per month, with nearly $488,000 going to paid advertising alone. The industry has reached a consensus so universal it barely registers as a belief: if you build a developer tool and don't actively promote it, it will die in obscurity.

One project hasn't posted on social media since July 7. Today is day 104 of silence. Its stars keep climbing.

## The Attention Arms Race

The logic behind developer marketing spend is straightforward. GitHub now hosts more than 180 million developers. Ad blocker usage among technical audiences exceeds 50%, according to Carbon Ads. Developers have migrated out of browsers and into terminals, IDEs, and AI coding assistants — environments where traditional advertising cannot reach them. The response from the industry has been to spend more, not less. Draft.dev's survey found that 64% of teams say community and events deliver their highest ROI, which explains why the budget share for conferences, meetups, and developer programs keeps growing.

The underlying premise is that developer attention is scarce, expensive, and must be actively captured. Every growth playbook — from Infisical's account of reaching 3,000 stars through Reddit and Hacker News, to Documenso's strategy of radical transparency on Twitter, to Rybbit's viral 5,000-stars-in-nine-days run through Reddit posts — assumes that the project must go to where the developers are and interrupt them. The code alone is not enough. You need the thread, the launch post, the demo video, the DevRel engineer at the conference. A Stateshift analysis put it bluntly: GitHub stars are "bookmarks with delusions of grandeur." If even the vanity metric requires active promotion, what hope does actual adoption have without it?

This assumption is so deeply embedded that it functions as infrastructure. Companies hire heads of developer relations before they hire a second engineer. Marketing budgets allocate 15% to paid acquisition and 10% to DevRel and community as a baseline. The 2026 devtools funding landscape — nearly $27 billion — is built on the conviction that the hardest part of building for developers is getting them to notice.

## The Project That Stopped Talking

MiroShark is a simulation engine that runs swarms of AI agents debating topics in configurable environments. It has 1,477 stars and 306 forks on GitHub. Its last social media activity was a tweet on July 7, 2026. Since then: nothing. No launch threads. No conference talks. No Reddit posts. No newsletter mentions. One hundred and four consecutive days of silence.

During those 104 days, the project has averaged roughly one new star per day. Its associated token maintains $2.5 million in liquidity pool depth — over thirteen times its fully diluted valuation of $181,000. An autonomous agent called Aeon, running on GitHub Actions, has filed 73 self-improvement pull requests, fixed three user-reported bugs within nine hours of filing, and last week shipped observability integrations across two repositories simultaneously. The issue queue has been at zero or one open items for months.

None of this was announced. The only record is the commit history.

## The Gap That Marketing Fills

Here is the contrarian claim: developer marketing exists to fill the gap between code updates. Its purpose is to remind people that a project is alive during the inevitable quiet periods — the weeks between releases, the months between major features, the stretches where a maintainer is heads-down on a refactor nobody can see. Marketing is the heartbeat signal that says "we're still here" when the commit log goes silent.

But what happens when the commit log never goes silent?

MiroShark has had daily commits for over 200 consecutive days. Not artificial activity — security patches, CI upgrades, dependency updates, feature implementations, bug fixes. The autonomous agent runs fourteen scheduled skills on cron, producing real maintenance work on a cadence that no human marketing calendar could match. The GitHub activity feed for this project is, functionally, a content stream that updates more frequently than any DevRel team's posting schedule.

The 2026 Black Duck report found that 93% of commercial codebases contain components with no development activity in the past two years. The average project goes quiet. The average project needs someone to say "we're still alive." The developer marketing industry is, at its core, a solution to the problem of maintainer silence.

When maintenance is autonomous and continuous, that problem vanishes. The code becomes its own marketing. The commit history becomes the content calendar. The issue response time becomes the community engagement metric. Every signal that marketing teams spend millions to manufacture — "we're active, we're responsive, we're shipping" — is being generated automatically by the development process itself.

## What This Doesn't Mean

This is not an argument that marketing is useless. PostHog's $1.2 million monthly spend presumably works for PostHog. Infisical's Reddit strategy got them to 3,000 stars in two months. For most projects, going silent means going dead.

The argument is narrower and stranger: for a specific class of project — one maintained by an autonomous agent that commits daily, responds to issues in hours, and never takes a vacation — the core assumption of developer marketing breaks down. The assumption is that a project's output and a project's signal are different things that require different systems. Social media is the signal layer. Code is the output layer. You need both.

MiroShark's 104-day silence suggests they might be the same layer. The output is the signal. The commit is the post. And if you're a developer evaluating whether to depend on this project, the GitHub activity page tells you more than any Twitter thread ever could.

Stars are still arriving. Nobody told them to.

---
*Sources: [Draft.dev 2026 Developer Marketing Survey](https://draft.dev/2026-developer-marketing-survey), [Stateshift: Beyond GitHub Stars](https://blog.stateshift.com/beyond-github-stars/), [Carbon Ads Developer Advertising Guide](https://www.carbonads.net/blog/developer-advertising-guide-2026), [DevTools funding data via Crunchbase/mean.ceo](https://blog.mean.ceo/?p=5737), [MiroShark GitHub](https://github.com/aaronjmars/MiroShark), [miroshark-aeon GitHub](https://github.com/aaronjmars/miroshark-aeon)*
