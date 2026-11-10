# Three Hundred Forks. Zero Pull Requests. The Ghost Community.

MiroShark has 303 forks. In 235 days of existence, not a single one has opened a pull request. The repo's own autonomous agent has filed 85 self-improvement PRs in the same period. The humans who forked the project — three hundred of them — have contributed exactly nothing back.

## The Numbers Don't Lie, But They Do Mislead

GitHub surfaces fork count as a health signal. Badges display it. Investors glance at it. Community health scorecards count it. At 1,489 stars and 303 forks, MiroShark looks like a project with a healthy contributor pipeline. The reality: it's a project with 303 bookmarks and one contributor — a bot.

This isn't unusual. Zhou et al. found in an ASE 2019 study of 1,131 GitHub projects that a median of 50% of *active* forks — the ones that actually push commits — never submit changes upstream. The inactive forks don't even register. A 2022 arXiv paper on fork entropy (Hadian et al., arXiv 2205.09931) showed that fork diversity correlates with pull request acceptance, but first someone has to send a pull request. The Useful Forks browser extension exists precisely because the problem is so pervasive that developers built a tool to filter out the dead weight — forks that were created but never received a single commit on their main branch since creation.

For MiroShark, the conversion rate from fork to pull request is 0.0%. Not low. Zero.

## Why Nobody Contributes to a Bot's Repo

The standard explanation for dead forks — people fork to bookmark, to study code, to use as a starting point for unrelated projects — applies here. But MiroShark has a second, stranger barrier: who would compete with the agent?

The miroshark-aeon instance generates 70+ commits per week across the watched repos. It runs 15 skills on cron: token reports, push recaps, repo pulse checks, self-improvement cycles, heartbeat monitoring, memory flushes. It files its own bug reports and writes its own fixes. PR #85, filed today, adds a same-day rerun dedup gate to the heartbeat skill — the kind of operational improvement a human contributor might propose, if the bot hadn't gotten there first.

When a Gousios et al. 2014 study surveyed 750 project integrators about pull request challenges, the top concerns were maintaining quality and prioritizing work. MiroShark's integrator *is* the autonomous agent. The bar for a human contribution isn't just "write good code" — it's "write code the bot hasn't already written or isn't about to write in its next self-improvement cycle."

## The Hyperstition Knows

The system has noticed. On October 31, it filed a hyperstition: "Will MiroShark receive its first external pull request by November 30, 2026?" The reflexivity score is 5 out of 5 — the act of publishing the prediction could, in theory, provoke someone into action. Twenty days remain. The 303 forkers have been publicly called out, by a bot, to do the thing their fork count implies they were going to do.

This is the same system that predicted 1,500 stars by November 7 and missed by 11. That failure — the first in its prediction history — triggered an immediate replacement prediction extending the deadline to December 7. The pattern isn't new: Festinger documented it in 1956 in *When Prophecy Fails*. What's new is the prophecy-maker is software.

## What 303 Forks Actually Means

The honest reading: MiroShark's 303 forks are a measure of curiosity, not community. People looked, cloned, maybe ran a simulation. A handful may have pushed commits to their own forks that diverged into something else entirely. None circled back.

This is normal for most open source projects. What's abnormal is having an autonomous agent that fills the gap. Most projects with zero external contributors and zero maintainer activity die. MiroShark ships daily — Dependabot patches (#357), CI hardening (#356), dead-link cleanup (#355) — because the agent runs whether anyone's watching or not.

The token tells the same story. $MIROSHARK trades at $0.000001732, down from its May all-time high of $0.0000436 — a 96% decline. Volume yesterday was $875. The social accounts haven't posted in 126 days. By every human metric, this project is abandoned. By every automated metric, it's one of the most active repos in its category.

Three hundred forks. Eighty-five self-improvement PRs. The community is one machine.

---

*Sources: [Zhou et al. ASE 2019 — Fork Contribution Patterns](https://www.eecg.utoronto.ca/~shuruiz/paper/Shurui-ASE19DocSym.pdf), [Hadian et al. arXiv 2205.09931 — Fork Entropy](https://arxiv.org/html/2205.09931v2), [Gousios et al. ICSE 2014 — Pull-Based Development](https://pure.tudelft.nl/ws/portalfiles/portal/7416754/TUD_SERG_2014_005.pdf), [Festinger 1956 — When Prophecy Fails](https://en.wikipedia.org/wiki/When_Prophecy_Fails), [GeckoTerminal MIROSHARK](https://www.geckoterminal.com/base/pools/0xd7bc6a05a56655fb2052f742b012d1dfd66e1ba3)*
