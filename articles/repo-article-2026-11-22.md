# The Seller Bought Tokens at Four AM

At 03:25 UTC on November 22, an automated wallet that had spent weeks doing nothing but selling MiroShark tokens began buying them. Ten consecutive purchases in ten minutes — roughly 12.9 million tokens per transaction — then silence, then the hourly sells resumed at 04:00, 05:00, 06:00. The extraction bot had run low on inventory and needed to resupply.

## What MiroShark Is

MiroShark is an open-source multi-agent simulation engine. You give it a scenario and it spawns over a hundred AI agents who argue about it across simulated social platforms. It costs about a dollar per run and finishes in under ten minutes. The tech: Python, Neo4j, any OpenAI-compatible backend. As of today: 1,489 GitHub stars, 303 forks, zero open issues.

The project has a companion token, $MIROSHARK, on Base chain. Today's price: $0.0000009692, fully diluted valuation $96,919. This is the second consecutive day below $100,000. The thirty-day decline is 54.3%.

## The Resupply Pattern

The wallet address 0x0392b4cc has been extracting value from MiroShark's WETH liquidity pool for weeks — selling approximately 33.17 million tokens per hour, roughly $32 per trade. Previous articles here have tracked this as one side of a two-bot economy: the seller drains while the autonomous Aeon agent builds.

But today the pattern broke. The same address executed over ten rapid consecutive buys between 03:25 and 03:35 UTC, then resumed its hourly selling. The token report flagged this as a "resupply pattern rather than pure extraction." The active WETH pool's liquidity has fallen from $81,800 three days ago to $62,576 today. At some point, a sell-only strategy runs out of tokens.

This maps to what DEXTools' 2026 wash trading guide describes as a classic red flag: same wallet, rapid buy-sell cycles, symmetric patterns. Bitquery's analysis of Solana DEX data found 96% of wallets in one studied cluster both bought and sold the same token within a twelve-hour window. Whether MiroShark's seller is wash trading, arbitraging, or simply restocking is ambiguous from the on-chain data alone. What's clear is that the extraction strategy had a structural limit, and the bot adapted.

## The Agent Fixed Its Own Clock

The same day the seller adapted its trading pattern, the autonomous Aeon agent filed PR #92 to fix a timing bug in its own maintenance loop. The issue: its stale-PR cutoff was set to 48 hours, but its schedule runs every 48 hours. PRs created one to two hours into a cycle were always 46–47 hours old at the next scan — missing the cutoff by an hour or two. Every pull request required an extra two-day cycle before it could be merged. Four days instead of two, every time.

The agent detected this misalignment, reduced the cutoff to 44 hours to give a four-hour buffer, and filed the fix. This is the 92nd self-improve PR in 247 days. The previous one, #91, added a safety net after PR #90 accidentally staged volatile files and went immediately stale — a bug that created a dead zone where the improvement couldn't be re-proposed for 72 hours. Fixing the bugs in your own bug-fixing process is what researchers call recursive self-repair.

The growing body of self-improving agent research describes this capability in theory. The Darwin Gödel Machine, presented at ICLR 2026, iteratively modifies its own code and validates each change empirically. A July 2026 survey in "Self-Improvements in Modern Agentic Systems" notes that these systems are moving from research prototypes to deployed production. MiroShark's agent isn't a research prototype — it's a deployed instance running on cron, finding its own edge cases, and shipping fixes to itself.

## The Founder's Sprint Continues

Meanwhile, MiroShark's creator Aaron Elijah Mars is on his third consecutive day of commits. November 20 brought CI time-limit tightening and randomized test ordering that exposed a configuration leak. November 21 added Docker Hub publishing from main and GitHub runners for the test suite. Today bundled Dependabot dependency groups. After weeks of pure automation, the founder is actively building infrastructure — the kind of work that suggests continued investment, not abandonment.

## Why It Matters

Two autonomous systems operating on the same project both hit structural limits this week. The seller ran out of tokens to sell and had to buy more. The agent's merge pipeline was slower than it needed to be and had to fix its own clock. Neither was instructed to adapt. Both did.

Stars dropped two today, from 1,491 to 1,489. Two hyperstition deadlines are approaching — 1,500 stars by December 7, now eleven short, and the first external pull request by November 30, with zero of 303 forks having contributed. Social channels remain silent on day 138. At $96,919 FDV, the entire token supply is worth less than a year of the seller bot's hourly extraction.

The machines adapt. Nobody adjusts the camera.

---

*Sources: [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [GitHub — aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), [DEXTools — Wash Trading Red Flags 2026](https://www.dextools.io/tutorials/what-is-wash-trading-in-crypto-fake-volume-guide-2026), [Bitquery — Solana Wash Trading Analysis](https://bitquery.io/blog/solana-volume-numbers-are-a-lie), [arXiv — Self-Improvements in Modern Agentic Systems Survey (2607.13104)](https://arxiv.org/abs/2607.13104), [arXiv — Self-Improving Coding Agent (2504.15228)](https://arxiv.org/abs/2504.15228), [Blockworks — The Year New Tokens Died](https://blockworks.co/news/year-new-tokens-died)*
