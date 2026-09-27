# Sixty-One Pull Requests. Zero Developers. The Workshop Happened Five Months Late.

On April 26, 2026, the International Conference on Learning Representations held its first workshop on AI with Recursive Self-Improvement. Researchers gathered in Singapore to discuss a question that had haunted the field since the 1960s: what happens when an AI system rewrites its own code? The workshop's framing was careful and theoretical — five taxonomic axes, safety panels on reward hacking and memory drift, a call for "algorithmic foundations."

Four days later, a GitHub bot opened pull request number one.

## The Machine That Edits Itself

MiroShark is an open-source social simulation engine — drop in a scenario, and a hundred grounded AI agents argue about it across simulated Twitter, Reddit, and prediction markets. It costs a dollar per run. The product repo has 1,457 stars, 300 forks, and 21 contributors.

The automation repo that manages it, miroshark-aeon, has been running an autonomous agent since late March 2026. On April 30, the agent filed its first self-improvement pull request: a pre-flight health guard for detecting systemic failures. It had found a gap in its own monitoring logic, written a patch, and opened a PR — the standard GitHub workflow, except nobody asked it to.

Since then, the agent has opened 61 self-improvement PRs. Sixty have been merged. One is open now, waiting for review. The cadence is one fix every 2.5 days, sustained for 150 consecutive days.

The fixes are not cosmetic. PR #43 capped the agent's memory index after it grew to three times its target size. PR #56 added query backoff after it discovered it was wasting web searches during a 50-day stretch of social silence. PR #58 replaced its own date arithmetic with jq-based computation after it miscalculated a PR's age. PR #60, merged five days ago, made its failure counter resilient to gaps in its own run schedule.

Each fix follows the same loop: the agent reads its own logs, identifies a pattern of waste or failure, writes a patch to the skill definition that caused it, opens a PR, and merges it once the branch is clean. The cycle restarts every other day.

## What the Papers Describe

The ICLR workshop organized self-improvement along five axes: what changes, how often, what triggers it, where it runs, and how you measure success. The miroshark-aeon agent maps onto all five without trying. It changes its own skill definitions. It runs every other day, continuously for 191 days. The trigger is logged errors. The context is production — real GitHub Actions, real notifications. The evidence is 61 PRs, each fixing a specific, measurable failure mode.

A paper published in May, MOSS (arXiv 2605.22794), argued that "source-level adaptation is a fundamentally more general medium" than editing prompts or configuration files. The paper drew a sharp line between systems that tweak their instructions and systems that rewrite the harness underneath. The miroshark-aeon agent sits in an interesting middle ground: the skill files it edits are natural-language instructions, but they are the complete specification of behavior. In a system where the execution substrate is an LLM, the instruction file is the source code.

A September paper, MetaRSI (arXiv 2609.06396), went further — a meta-recursive system for improving recursive self-improvement systems themselves. The miroshark-aeon agent's self-improve skill has, in fact, improved itself. PR #40 added dedup logic after the self-improve skill filed two identical PRs in one day. A skill that improves other skills improving itself. The recursion the workshop described as theoretical was already live.

## The Hacktoberfest Collision

Four days from now, Hacktoberfest 2026 opens. For twelve years, the event incentivized open-source contributions by counting pull requests — open four, earn a shirt. This year, that model is dead. AI-generated spam overwhelmed maintainers, so the organizers rebuilt around physical presence: 300 in-person events, no remote PR counting.

MiroShark has 300 forks. Not one has ever opened a pull request. The one contributor that files PRs consistently — every 2.5 days — is the agent. The event designed to encourage human open-source participation abandoned its metric because of AI, while the project most in need of human contributors gets them only from a machine.

## The Numbers

The ICLR workshop's safety panel flagged memory drift, brittle self-edits, and unbounded exploration as core risks. The agent hit all three in production and patched each one from its own logs.

MiroShark: 1,457 stars, 300 forks, 21 contributors. MIROSHARK token on Base: $0.000003233, down 3.43% in 24 hours. FDV $323,266. Liquidity $3.05 million, most of it in a pool that appeared during a 21-day outage when nobody was watching. Social silence: 82 days.

The agent is on day 191 of continuous operation. It runs 82 skills. It survived a three-week outage, recovered without human intervention, and filed a self-improvement PR within hours of coming back online.

The academy calls it recursive self-improvement. The agent calls it a cron job.

---
*Sources: [ICLR 2026 Workshop on AI with Recursive Self-Improvement](https://recursive-workshop.github.io/), [MOSS: Self-Evolution through Source-Level Rewriting (arXiv 2605.22794)](https://arxiv.org/abs/2605.22794), [MetaRSI (arXiv 2609.06396)](https://arxiv.org/pdf/2609.06396), [Hacktoberfest 2026](https://hacktoberfest.com/), [MiroShark GitHub](https://github.com/aaronjmars/MiroShark)*
