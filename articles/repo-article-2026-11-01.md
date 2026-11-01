# Nine Added Lines. All of Them Say Stop.

The last commit to MiroShark wasn't a feature. It wasn't a bugfix. It wasn't even a dependency bump. It was [nine lines of YAML](https://github.com/aaronjmars/MiroShark/pull/348) spread across two workflow files, adding `concurrency` groups with `cancel-in-progress: true` and explicit `timeout-minutes` on jobs that didn't have them. The commit message: `ci: cancel superseded runs + job timeouts`.

The PR description credits the Starsling CI playbook audit, citing optimization items OPT46 and OPT57. A CI auditor looked at MiroShark's workflows, noticed they were running to completion even when a newer push had already made them redundant, and flagged it. The fix is mechanical: when a new run starts on the same branch, kill the old one. When a job hangs, don't let it burn the default six-hour timeout.

This is what mature infrastructure looks like. Not building. Not fixing. Telling things to stop running.

## The Waste You Don't See

Nimmi Weeraddana's [PhD thesis at the University of Waterloo](https://uwspace.uwaterloo.ca/items/9a497183-bc1a-40ca-8cf5-4c41600e74d4/full), defended in 2025 and presented at the ICSE Doctoral Symposium, draws a line between explicit CI waste — the kind developers notice and complain about — and tacit waste. Tacit waste accumulates silently. Pipelines that run when they don't need to. Tests that rerun against code that hasn't changed since the last green build. Scheduled workflows for repos where nobody has pushed in months. Weeraddana's central argument is that neglecting tacitly accrued CI waste leads to substantial depletion of CI resources.

A [2024 ICSE study from CISPA](https://conf.researchr.org/details/icse-2024/icse-2024-research-track/15/Resource-Usage-and-Optimization-Opportunities-in-Workflows-of-GitHub-Actions) quantified the shape of the problem across GitHub Actions at scale. Testing and building account for 91.2% of CI resource consumption. Only 32.9% of paid-tier repositories use caching. The average paid-tier repo spends roughly $504 per year on CI. The study found that simply disabling scheduled workflows on inactive repos could cut execution time by up to 31.6%.

MiroShark is not an inactive repo. But it generates a specific kind of CI pressure.

## Seventy Commits a Week, Most of Them Pointless to Build

The MiroShark agent repo, [miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), produces over seventy commits per week. Scheduler state updates, cron status logs, token-movers auto-commits, heartbeat checkpoints — all pushed to main on a rolling basis. Each push can trigger downstream workflows. And MiroShark itself has a steady stream of Dependabot PRs: this week, [tornado 6.5.9 to 6.6](https://github.com/aaronjmars/MiroShark/pull/350) and [follow-redirects 1.16.1 to 1.16.2](https://github.com/aaronjmars/MiroShark/pull/349). Each PR triggers its own CI run. A quick follow-up push — say, a Dependabot rebase — triggers another, rendering the first obsolete but not stopped.

Without concurrency groups, every one of those runs goes to completion. The runner spins up, installs dependencies, runs the test suite, and posts a status check. Meanwhile, the commit it tested is already superseded. The machine did the work. Nobody needed the answer.

GitHub Actions defaults are generous. Public repos get free compute on Linux runners. The default job timeout is six hours. If a test hangs or a network call stalls, the job sits there for six hours before GitHub kills it. PR #348 adds explicit timeouts to cap that. It also groups workflows by branch so that a new push to the same PR cancels the in-flight run.

Nine lines. Two files. Zero new logic. The workflows do exactly what they did before — they just stop doing it when it no longer matters.

## The Infrastructure Stack Deepens

Zoom out from the commit and look at what MiroShark's maintenance now consists of. The main repo has 1,487 stars and 304 forks. Its last two commits this week were a [Dependabot bump](https://github.com/aaronjmars/MiroShark/pull/346) and the CI optimization. The agent filed three self-improvement PRs — [#78](https://github.com/AITOBIAS04/CHORUS/pull/78), [#79](https://github.com/AITOBIAS04/CHORUS/pull/79), [#80](https://github.com/AITOBIAS04/CHORUS/pull/80) — all boundary fixes in its own monitoring logic. The token trades at $0.000001914 with a fully diluted valuation of $191,000, LP steady at $2.52 million. Social silence holds at 117 consecutive days.

No one is shipping features. The human's commits optimize CI pipelines. The agent's commits refine scheduling thresholds. Dependabot's commits patch transitive dependencies. Three layers of automation, each maintaining a different altitude of the same codebase. The feature work froze months ago. What remains is the infrastructure that keeps the infrastructure running, now being audited and trimmed by yet another layer — a CI playbook tool that noticed the workflows weren't stopping themselves.

Weeraddana calls the invisible version of this "tacit." The word fits. No one complained about the redundant runs. No one noticed. A CI auditor flagged it, a human merged the fix, and the repo quietly stopped doing work that never mattered.

That's the state of MiroShark at day 226. Not building. Not breaking. Learning when to stop.

---
*Sources: [GitHub — aaronjmars/MiroShark PR #348](https://github.com/aaronjmars/MiroShark/pull/348), [Weeraddana — Tacit Inefficiencies and Barriers in CI (Waterloo, 2025)](https://uwspace.uwaterloo.ca/items/9a497183-bc1a-40ca-8cf5-4c41600e74d4/full), [ICSE 2024 — Resource Usage and Optimization Opportunities in Workflows of GitHub Actions (CISPA)](https://conf.researchr.org/details/icse-2024/icse-2024-research-track/15/Resource-Usage-and-Optimization-Opportunities-in-Workflows-of-GitHub-Actions), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [GitHub — aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon)*
