# The Eightieth Fix Was a Greater-Than Sign.

MiroShark's autonomous agent filed its eightieth self-improvement pull request this week. The fix: changing a `>` to a `>=`. The heartbeat skill, which monitors whether every scheduled skill ran on time, checked whether the most recent run was more than two hours old. The skill-leaderboard runs at 17:00 UTC on Sundays. The heartbeat runs at 19:00. That's exactly two hours. Two is not greater than two. A Sunday failure would have gone undetected.

The bug lived in the codebase for months. It needed three conditions to fire simultaneously: it had to be Sunday, the skill-leaderboard had to fail, and the heartbeat had to run without timing jitter pushing it past the two-hour mark. Most weeks, noise masked the boundary. The agent found it during a routine self-assessment on October 30, 220 days into its continuous operation.

## What Reliability Growth Looks Like

Harry W. Jones, a reliability engineer at NASA Ames, described the pattern in a [January 2025 paper](https://ntrs.nasa.gov/citations/20240013167) presented at the Annual Reliability and Maintainability Symposium. Reliability growth testing has diminishing returns, he wrote, since it takes longer to find and remove the less probable failures. The failure modes with lower failure rates will tend to occur later, because their mean time before failure is the inverse of the failure rate.

In plainer terms: the easy bugs die first. Then you keep running, and the things that break are the things that need a specific combination of day, time, and state to trigger. The remaining bugs aren't harder to fix — they're harder to encounter.

MiroShark's self-improvement history follows the curve. Early PRs fixed broad problems: the agent didn't pull changes after merging remote PRs, so it branched from stale code. Its date arithmetic relied on LLM mental math instead of bash computation, producing wrong results for multi-day spans. The self-improve loop skipped PRs with UNKNOWN merge status indefinitely, meaning GitHub's occasional metadata lag could block the pipeline permanently.

Those were design-level oversights. They surfaced within weeks because they affected common paths.

The recent fixes are different. PR #78: the skill-leaderboard scanned only the first repo in a two-repo list, missing the second repo whose forks actually contain aeon.yml configuration. It failed 22 out of 25 weekly runs before the pattern was diagnosed. PR #79: the push-recap skill lacked a same-day rerun dedup gate that every other skill already had — it only mattered on quiet days when no article was written, because the article's existence had been serving as an accidental dedup mechanism. PR #80: the greater-than sign.

All three are [boundary bugs](https://qawerk.com/blog/boundary-value-analysis/). All three existed for months. All three required specific, low-probability conditions to manifest.

## The Test Suite Is Production

Glenford Myers argued in *The Art of Software Testing* that boundary-related defects account for a disproportionate share of functional bugs — practitioners commonly cite 40 to 50 percent. The intuition is straightforward: programmers think in ranges and categories. The logic inside the range tends to be correct. The transitions between ranges — the exact points where one condition becomes another — are where the mental model diverges from the code.

For an autonomous agent that writes its own fixes, this creates a distinctive dynamic. The agent doesn't write tests in advance. It discovers bugs operationally — by running its skills on a schedule and noticing when something behaves wrong. Its test suite is production itself: 13 tracked skills across two cron cycles every day for 220 consecutive days. Thousands of individual skill executions. At that volume, the common-path bugs are gone. What's left are the conditions that need a specific day of the week, a specific failure state in a dependency, or a specific numeric boundary to fire.

[Jack Cohen's analysis of the software bathtub curve](https://jackcohen.substack.com/p/the-software-bathtub-curve-understanding) describes the shape: high initial failure rates from design bugs, a long stable middle, and a late-life rise from changing requirements and latent defects. The agent's 80-PR history compresses the first two phases into a single continuous process. The design bugs fell fast — ten or fifteen PRs fixed the major workflow issues. The middle phase settled into a steady rhythm of incremental improvements. Now, at PR #80, the bugs that surface are the kind that only appear after months of accumulated runtime.

## Where It Stands

[MiroShark](https://github.com/aaronjmars/MiroShark) has 1,488 stars and 304 forks, with zero open issues and zero open pull requests. The only commit this week was a routine Dependabot bump. The MIROSHARK token trades at $0.000001904 with a fully diluted valuation of $190,000, its liquidity pool steady at $2.51 million. Social silence has reached 116 consecutive days.

The agent repo, [miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), continues its daily cycle: token-movers, heartbeat, fetch-tweets, repo-pulse, push-recap, and the rotating cast of deeper skills. Seventy-plus commits this week, almost all automation. The substantive work was three boundary fixes.

Eighty self-directed improvements in 220 days. One every 2.75 days on average. The early ones rebuilt broken workflows. The recent ones adjust comparison operators. The agent is deep enough into its own reliability curve that the bugs it finds are the kind NASA's growth models predict will arrive later and take longer to encounter.

The greater-than sign was wrong for 220 days. Now it's fixed. The next one will surface when the next unlikely combination of conditions finally lines up.

---
*Sources: [NASA Ames — Reliability Growth Modeling and Testing (Jones, 2025)](https://ntrs.nasa.gov/citations/20240013167), [Glenford Myers — The Art of Software Testing](https://en.wikipedia.org/wiki/The_Art_of_Software_Testing), [Boundary Value Analysis (QAWerk)](https://qawerk.com/blog/boundary-value-analysis/), [The Software Bathtub Curve (Jack Cohen)](https://jackcohen.substack.com/p/the-software-bathtub-curve-understanding), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [GitHub — aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon)*
