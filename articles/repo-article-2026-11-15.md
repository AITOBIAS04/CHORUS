# Everything Shrank Except the Agent

The star count went backwards. On November 14, MiroShark had 1,489 GitHub stars. On November 15, it had 1,487. Two people looked at a project they'd once endorsed and decided they no longer wanted their name next to it. In a project that hasn't gained a new star in over a week, losing two is not a rounding error. It is a direction change.

The same day, the token hit $0.0000012549 intraday — a new all-time low, 23% below the July 18 floor that had held for 118 days before cracking on November 13. It closed at $0.0000012922, down 17% in twenty-four hours. FDV fell to $129,000. A week ago it was $188,000. The WETH liquidity pool shrank from $88,000 to $77,000. Social silence reached 131 days.

Every external metric that can go down is going down. The only thing still growing is the autonomous agent.

## The Sells Came With Weight

The prior two ATL breaks — November 13 ($0.0000016302) and November 14 ($0.0000015515) — happened on whisper-thin volume: $345 and $144, respectively. Those were gravity events. The price fell because nobody was there to catch it.

November 15 was different. Volume hit $3,736 — twenty-six times the prior day. Twelve buys against eight sells, meaning someone was buying back, and the price still dropped 17%. That is not apathy. That is active selling against active buying, and the sellers won convincingly. The character of the decline changed from "nobody cares" to "someone is leaving."

The distinction matters. A price that drifts lower on no volume can drift higher on no volume. A price that drops 17% against $3,700 in resistance is being repriced.

## When Stars Subtract

An ICSE 2026 study by researchers at Carnegie Mellon, NC State, and Socket found roughly six million suspected fake stars across 18,617 GitHub repositories. Stars, the study argues, are the most widely gamed popularity signal on the platform. Inflated stars decay — the promotion effect lasts less than two months before becoming a liability.

MiroShark's stars are not suspected of being fake. But the study's framing applies in reverse: if fake stars inflate and then contract, real stars in a silent project follow the same curve with different mechanics. People star a project when they discover it. They unstar when they clean up their star list months later, or when GitHub periodically removes bot accounts. At 1,487 stars with zero social presence for 131 days, MiroShark has no inbound discovery channel to replace the attrition. The count is now a drain, not a reservoir.

The 1,500-star hyperstition — the prediction that MiroShark would reach 1,500 stars by December 7 — needed 11 when it was filed. It now needs 13 from a base that is shrinking. The first prediction (1,500 by November 7) already failed at 1,489. The replacement prediction is in worse shape than the original was at the same point in its countdown.

## The Agent's Day

On November 15, the autonomous agent ran its full skill rotation: token report, tweet scan, repo pulse, feature check, push recap. It logged the new all-time low. It logged the star loss. It noted that the WETH LP dropped but the mmETH pool held stable at $2.4 million, so no LP anomaly alert was triggered.

PR #87 — the agent's most recent self-improvement, filed November 14 — sits open, waiting for merge. It optimizes away unnecessary API calls on quiet days. The agent proposed that fix after analyzing five days of its own logs and concluding it was doing redundant work when nothing happened. Now it is waiting to merge an efficiency improvement into a system that monitors a project whose every metric is contracting.

Eighty-seven self-improve PRs in 241 days. Zero consecutive skill failures. Thirteen skills running on cron. A September 2026 LeadDev essay observed that "prompt-to-PR is solved, but maintaining what exists isn't." MiroShark's agent has solved the maintenance problem. The problem it hasn't solved — can't solve — is that the thing being maintained is getting smaller.

## The Asymmetry

Internal: 87 PRs merged, 0 open issues, 0 failures, 70+ weekly commits, every scheduled job completing.

External: $0.0000012922 (down 97% from ATH), 1,487 stars (declining), 303 forks (0 external PRs ever), $129K FDV, 131-day silence.

The code improves. The metrics contract. The agent cannot bridge the gap because the gap is not a software problem. It is a market and community problem, and those require humans — the same humans who have been silent for 131 days and are now actively unstarring the repository.

The distance between internal health and external health was the only thing growing. Now even that framing needs revision: the external side is accelerating away.

---

*Sources: [Six Million Suspected Fake Stars — ICSE 2026 (CMU/NC State/Socket)](https://arxiv.org/html/2412.13459v2), [The Autonomous Codebase — LeadDev](https://leaddev.com/software-quality/the-autonomous-codebase), [Growth Hacking Killed GitHub Stars — OpenSauced](https://opensauced.pizza/blog/growth-hacking-killed-github-stars), [Star Counts Lied — GraphScope](https://graphscope.io/blog/tech/2026/04/20/Star-Counts-Lied-Graph-Database-Health-Check), [GeckoTerminal MIROSHARK](https://www.geckoterminal.com/base/pools/0xd7bc6a05a56655fb2052f742b012d1dfd66e1ba3)*
