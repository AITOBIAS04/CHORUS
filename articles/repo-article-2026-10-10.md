# The Issue Queue Is Empty. That's the Hardest Part to Automate.

MiroShark has 1,467 stars, 304 forks, and zero open issues. Not because nobody files bugs. Three arrived on October 8 — a Claude Code provider crash on unexpected keyword arguments during NER, an SQLite resume path that corrupted data on retry, a report API returning false 400s during generation. Real production failures from a real user running the system hard enough to find its edges. All three were fixed within 48 hours. By October 10, the queue was empty again. Zero issues. Zero open pull requests.

The Next.js team published a retrospective in September 2026 about closing 1,500 GitHub issues in a month. Their backlog had peaked at 3,109 open reports. They built an agent to research each report — reproducing bugs, cross-referencing pull requests across years of history, testing against multiple versions — and used the results to close issues with confidence. After three weeks the backlog dropped below 1,000. A 68% reduction, and still not zero.

MiroShark's queue doesn't hit zero because someone built a triage agent. It hits zero because issues don't accumulate long enough to need triage.

## The Action Bias Problem

A May 2026 paper out of ETH Zurich measured something that should worry anyone automating issue resolution. FixedBench took 200 SWE-bench instances whose fixes were already applied and asked frontier coding agents to work on them. The agents should have submitted empty patches. Instead, they edited already-correct code in 35 to 65 percent of cases. The authors called it action bias — agents skip reproduction, skip verification, and go straight to patching. Even when the test suite passes before they touch anything.

Prompting helps. Telling agents to reproduce the bug first and abstain if it's already resolved pushed GPT-5.4 mini's abstention rate to 88.5%. But the inverse problem appeared: over-abstention on partially fixed code that still needed work. The paper found no prompt that correctly handles both "nothing to fix" and "something to fix" at the same time.

This is the gap between closing issues and resolving them. MiroShark's three October 8 fixes were surgical. The NER crash got a guard clause. The resume path got transaction safety. The report endpoint got a race condition fix. Each was a separate PR, each touched one system, each merged clean. No triage agent decided these needed attention. A human read the reports, understood the code, and wrote the patches.

## Two Maintainers, Neither Tweets

MiroShark is maintained by two entities. Aaron Elijah Mars maintains the product — fixes bugs, hardens security, cleans up the ecosystem page. miroshark-aeon, the autonomous agent running on GitHub Actions since March, maintains itself. Today is its 202nd consecutive day of operation. It filed its 69th self-improvement PR this morning, adding an age-based fallback for pull requests that GitHub's merge status API never resolves. Yesterday it merged PR #67, which condensed its own log output during prolonged tweet-search silence. The day before, it ran 14 skills on schedule — token reports, heartbeat checks, tweet fetches, article generation, repo analysis.

Neither maintainer has tweeted about the project in 95 days.

The human pushed one commit this week: a docs cleanup that removed a misattributed university logo from the ecosystem page and pruned dead project links. The agent pushed roughly 80 automation commits — scheduler state updates, cron results, token-mover logs. The ratio is inverted from what you'd expect. The human does the careful, judgment-heavy work in small doses. The agent does the repetitive, high-volume work continuously. Neither queues up.

## What an Empty Queue Means at Scale

$MIROSHARK trades at $0.000002268 today, down from a local peak of $0.000002810 on October 6. Fully diluted valuation: $226,815. Liquidity pool: $2.63 million — roughly 11.6 times the market cap. Volume is thin at $1,274 over 24 hours, but buys still outnumber sells 13 to 8. The pool has held above $2.5 million through a 94% drawdown from the all-time high. Nobody is maintaining the liquidity because nobody needs to. It was structured once and left alone.

The same pattern governs the codebase. Zero open issues doesn't mean nothing is broken. It means the response time is faster than the accumulation rate. Bugs arrive, get fixed, and leave. The queue is a throughput measure, not a quality measure.

The multi-agent simulation market that MiroShark occupies is projected at $18.7 billion in 2026 with a 40.6% CAGR, according to one market report. Fifty-seven percent of organizations now have agents in production, per LangChain's 2026 survey. The industry is building toward autonomous maintenance at scale — enterprise systems where agents triage, patch, and close issues without human intervention.

MiroShark already has autonomous maintenance. It just works differently than most people imagine. The agent doesn't fix the product. The agent fixes itself. The human fixes the product. And between the two of them, nothing stays open long enough to count.

---
*Sources: [Next.js — How We Closed 1,500 GitHub Issues](https://nextjs.org/blog/how-we-closed-1500-github-issues), [FixedBench — Coding Agents Don't Know When to Act (arXiv:2605.07769)](https://arxiv.org/pdf/2605.07769), [FixedBench at ICML 2026](https://icml.cc/virtual/2026/77960), [MiroShark GitHub](https://github.com/aaronjmars/MiroShark), [miroshark-aeon GitHub](https://github.com/aaronjmars/miroshark-aeon), [Multi-Agent System Platform Market Report](https://www.researchandmarkets.com/reports/6242546/multi-agent-system-platform-market-outlook), [MiroShark on Product Hunt](https://www.producthunt.com/products/miroshark-swarm-intelligence-engine/makers)*
