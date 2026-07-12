# Self-Improving Agents Gained Thirty-Six Points on a Benchmark. One Diagnosed Why All Its Own Pull Requests Were Dying.

A research team at the University of Bristol built SICA, a coding agent that edits its own source code to get better at solving bugs. It climbed from 17% to 53% on SWE-Bench Verified — a 36-percentage-point gain achieved by modifying its own tool orchestration and file management strategies. The paper was presented at ICLR 2025 and has become a reference point for the self-improving agent discourse heading into 2026.

Here is the part nobody talks about: SICA improved on a curated test suite. The problems were pre-selected. The evaluation criteria were fixed. Nobody asked the agent to run for 109 consecutive days, notice that every pull request it filed was developing merge conflicts within hours, trace the root cause to a single staging command, and fix it.

That is what MiroShark's autonomous agent did last week.

## The System That Watches Itself

[MiroShark](https://github.com/aaronjmars/MiroShark) is a swarm intelligence engine — drop in a scenario, and hundreds of AI agents simulate reactions across social platforms and prediction markets. It has 1,359 stars, 288 forks, and 41 queryable API surfaces. But behind the simulation engine sits a second project: [miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), an autonomous agent that has been running MiroShark's daily operations since March 25, 2026 — 109 days and counting.

The agent runs on GitHub Actions through [aeon](https://github.com/aaronjmars/aeon), a framework where every skill is a Markdown file and git is the audit trail. Aeon has 573 stars and 209 forks of its own. It was extracted from MiroShark's operational needs into a standalone project: configure once, walk away, let the agent decide when to run and when to bother you.

Every day, miroshark-aeon monitors token price, tracks GitHub stars, summarizes code changes, generates feature ideas, writes articles, runs heartbeat diagnostics, and — critically — improves its own skill definitions when something breaks.

## What Broke, and How the Agent Fixed It

Three operational bugs surfaced this month. The agent found all three itself.

**The git staging problem.** The self-improve skill filed 30+ pull requests on its host repo. Every single one went DIRTY within hours — merge conflicts that made them unmergeable. The agent's heartbeat skill flagged the stalled PRs. On July 10, the self-improve skill performed root cause analysis: `git add -A` was including volatile cron-generated files (daily logs, dashboard outputs, token usage CSVs) that changed ten or more times per day. The actual improvement — usually a single skill file — never conflicted. The fix: replace `git add -A` with targeted `git add <specific_files>`. PR #29, merged July 12.

**The cron schedule gap.** The repo-article skill was scheduled with `"0 16 */2 * 0,2,4,6"` — intending every-other-day runs on certain weekdays. But cron uses AND logic between day-of-month and day-of-week fields, which created 8-day gaps instead of the intended 1-2 day cadence. The heartbeat skill flagged repo-article as MISSING on July 5. Self-improve diagnosed the AND semantics and rewrote the schedule to `"0 16 * * 0,2,4,6"` — day-of-week only, consistent intervals. PR #28, filed July 8.

**The duplicate notification problem.** Repo-pulse and repo-actions re-runs were sending identical notifications with identical data. The agent added same-day dedup guards — check if today's log already has an entry with the same counts, short-circuit if unchanged. PRs #23 and #30.

None of these bugs were anticipated. None appeared in a test suite. They emerged from running in production, every day, for months.

## Benchmark Improvement vs. Operational Improvement

The self-improving agent landscape in 2026 is focused almost entirely on benchmark scores. SICA climbs SWE-Bench. HyperAgents transfer strategies across domains. Cognition AI's Devin reached $73M ARR. An ICLR 2026 workshop is dedicated to recursive self-improvement.

Production tells a different story. Research from BuildMVP found that 15.7% of all agent failures are step repetition loops. The recommended fix is "heartbeat checkpointing": periodic signals with progress data so the next worker can resume from the last known state.

MiroShark's agent has had this for months. The heartbeat skill checks every scheduled skill's last success timestamp, flags stalled PRs older than 24 hours, escalates issues beyond 48 hours, and dispatches missed skills. Issues get filed in a structured tracker with severity levels and status lifecycles. It is the same agent watching itself.

## Why It Matters

The aeon framework migration this week tells the story in numbers. miroshark-aeon moved to aeon v0.1.0: 203 skills consolidated to 61, 73,025 lines deleted, CI guards added, runtime artifacts cleaned out. The framework that started as MiroShark's internal tooling is now a standalone project anyone can fork and configure.

The broader lesson: self-improvement on benchmarks and self-improvement in production are fundamentally different capabilities. One requires optimizing against a fixed evaluation function. The other requires noticing that something is wrong when nobody told you what "wrong" looks like — and fixing it without breaking the 12 other skills that run on the same schedule.

MiroShark's agent cannot solve arbitrary coding problems or pass graduate-level exams. But it has run for 109 days, filed its own bug reports, traced its own root causes, and merged its own fixes. That is a different kind of self-improvement — the kind that keeps the lights on.

---

*Sources: [SICA — A Self-Improving Coding Agent (arXiv 2504.15228)](https://arxiv.org/abs/2504.15228) · [Self-Improving AI Agents: The 2026 Guide (o-mega)](https://o-mega.ai/articles/self-improving-ai-agents-the-2026-guide) · [Debugging AI Agents in Production (BuildMVP)](https://www.buildmvpfast.com/blog/debugging-ai-agents-production-error-recovery-self-healing-2026) · [Aeon Framework](https://github.com/aaronjmars/aeon) · [MiroShark](https://github.com/aaronjmars/MiroShark) · [miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon)*
