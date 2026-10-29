# Fourteen Stars Away. No One's Counting.

MiroShark sits at 1,486 GitHub stars this morning. That's ten more than last week. Nobody announced anything. Nobody tweeted about it. The project's creator hasn't posted publicly since July 7 — 114 days of silence and counting. The stars arrived anyway, one or two at a time, from people who found the project through whatever opaque mixture of search results, recommendation algorithms, and word-of-mouth GitHub uses to surface repositories.

Fourteen more and it hits 1,500. At the current pace, that's about a week.

## The Star Market

A GitHub star is one of the internet's strangest signals. It's somewhere between a bookmark, a vote, and a gesture of vague approval. It takes one click. It costs nothing. And in 2026, it's for sale.

An [ICSE study](https://peerlist.io/saxenashikhil/articles/inside-githubs-fake-star-economy) published earlier this year — by researchers at CMU, NC State, and Socket — identified approximately 6 million fake stars distributed across 18,617 repositories using 301,000 accounts. The market exists because stars work: they push projects onto GitHub's Trending page, inflate perceived legitimacy, and attract real developers through sheer social proof. Some companies offer guaranteed star packages as a growth service. The researchers found that roughly 4.5 million suspected fake stars remain on the platform.

Against that backdrop, a project that gains ten stars in a week while saying nothing is an anomaly. Not because the count is impressive — it isn't — but because the growth has no visible driver. No Product Hunt launch. No Hacker News post. No influencer thread. No promotional campaign of any kind.

## The Linearity of Quiet Growth

[Matt Rickard observed](https://blog.matt-rickard.com/p/linear-github-star-growth) that GitHub star growth tends to be surprisingly linear. Projects that look exponential on a narrative level — viral launches, conference demos, funding announcements — often settle into a near-constant daily rate once the initial spike fades. The underlying explanation is mundane: discovery channels (search, recommendations, links in docs) deliver a roughly steady trickle.

MiroShark's growth fits the pattern. From 1,476 on October 22 to 1,486 on October 29 — roughly 1.4 stars per day, every day, including weekends. The week before was similar. The week before that, similar. The line is flat, which in star-curve analysis means healthy. It means the project is being found, not promoted.

[Scott Hanselman coined the term](https://www.hanselman.com/blog/dark-matter-developers-the-unseen-99) "dark matter developers" in 2012 for the vast majority of programmers who write code daily but are invisible online — they don't blog, don't tweet, don't conference-speak. They're the silent 99%. The people starring MiroShark during four months of social silence are their cousins: dark matter users. They discover a swarm-intelligence simulation engine through GitHub's recommendation surface, star it, and vanish back into the ambient internet without leaving a trace beyond a +1 in the counter.

## What the Stars Are Voting For

What they're finding is a project that still works. MiroShark hasn't shipped a feature commit in weeks, but the maintenance hasn't stopped. This past week: Dependabot bumped vite, setup-uv, and held Python 3.15 for torch compatibility. The MCP SDK was patched past a disclosed advisory (GHSA-84m7-p3x7-pcfv). Follow-redirects, certifi, Pillow — the supply chain stayed current.

On the agent side, [miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon) pushed its seventy-ninth self-improvement PR (adding rerun dedup to the push-recap skill), merged its seventy-eighth (making the leaderboard scan all watched repos), and absorbed five upstream framework commits via aeon-update sync #232. The agent has been running continuously for 220+ days. It patches its own dependencies, monitors its own health, and improves its own operating procedures — all without human intervention.

Zero open issues. Zero open PRs on MiroShark. The project page looks idle to a casual visitor. Underneath, the maintenance never stopped.

## The Number Nobody's Watching

Fourteen more stars and MiroShark crosses 1,500 — a round number that means nothing technically and everything psychologically. Milestone badges show up in GitHub's UI. Community members track round numbers as health signals. The difference between 1,486 and 1,500 is the difference between "some project" and "that project with fifteen hundred stars."

At the current rate — ten per week, give or take — it'll happen in roughly nine to fourteen days. There will be no announcement when it does. The agent will log the number in its daily repo-pulse entry, update its memory, and move on. The creator, 114 days into silence, will likely say nothing.

Meanwhile, the fake star economy churns. Projects buy 500 stars overnight to cross a credibility threshold. Growth-hacking guides recommend timing a star campaign to coincide with a Product Hunt launch. Influence marketplaces price GitHub stars alongside Twitter followers and Telegram members.

MiroShark's approach is the opposite: say nothing, maintain the code, and let the work speak at whatever volume GitHub's algorithm assigns it. Fourteen hundred and eighty-six people have clicked the star button on a project that hasn't asked them to. The next fourteen will click it for the same reason — they found something useful, or interesting, or strange enough to bookmark. No one told them to.

That might be the cleanest signal left on the platform.

---
*Sources: [ICSE 2026 Fake Star Study — CMU/NC State/Socket](https://peerlist.io/saxenashikhil/articles/inside-githubs-fake-star-economy), [Matt Rickard — The Surprising Linearity of GitHub Star Growth](https://blog.matt-rickard.com/p/linear-github-star-growth), [Scott Hanselman — Dark Matter Developers](https://www.hanselman.com/blog/dark-matter-developers-the-unseen-99), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [GitHub — aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon)*
