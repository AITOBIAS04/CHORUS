# Turn Dependabot Off. Then What?

In February 2026, Filippo Valsorda published a blog post with the title "Turn Dependabot Off." Valsorda is not a contrarian crank. He was formerly the head of Google's Go security team. He maintains some of the most widely used cryptographic libraries in the Go ecosystem. When he published a one-line security fix to `filippo.io/edwards25519` — a patch affecting a single method that almost no one calls — Dependabot opened thousands of pull requests against repositories that weren't affected. It attached a fabricated CVSS v4 score. It offered a 73% "compatibility score" as reassurance.

His diagnosis was blunt: "Dependabot is a noise machine." False positive alerts, he argued, are "not only a waste of time, they also reduce security by causing alert fatigue." His recommendation: replace Dependabot with two scheduled GitHub Actions — one running `govulncheck` for reachability-aware vulnerability scanning, one testing against updated dependencies. Computers, he wrote, are "perfectly capable of doing the work of filtering out these irrelevant alerts for you."

He was right about the problem. He was asking too small a question about the solution.

## The Narrowest Possible Automation

Dependabot is the most widely deployed autonomous maintenance tool in software. GitHub hit one million merged Dependabot pull requests in July 2019. By 2025, an estimated 846,000 repositories had it configured, with 137% year-over-year adoption growth. It is, by default, turned on for every public repository with security alerts enabled.

What it does is remarkably narrow. It checks whether a dependency has a newer version. If so, it opens a pull request bumping the version string. It does not check whether the vulnerability is reachable in the project's code. It does not verify whether the update breaks anything beyond what CI catches. It caps open pull requests at five by default — a limit that creates backlogs in projects that can't merge fast enough. A 2021 study at MSR found that 65.42% of its security pull requests get accepted, which means a third do not. GitHub itself acknowledged that at least one in ten of its alerts are false positives, and added auto-dismissal rules to cut npm alert volume by an estimated 15%.

This is the state of the art in autonomous code maintenance as practiced by the industry's dominant platform: version string bumps, with a noise floor high enough that a prominent security engineer tells people to turn it off.

## The Gap in the Middle

A 2022 study of dependency management bots identified four properties of an ideal system: configurability, autonomy, transparency, and self-adaptability. Dependabot has the first. Its autonomy is mechanical — it opens PRs on a schedule without deciding whether they matter. Its transparency is limited to compatibility scores that Valsorda calls misleading. Self-adaptability — the ability to learn from its own outcomes and adjust its behavior — it does not have at all.

Meta's RACER system, presented at FSE 2026 in Montreal, pushes toward the other end of the spectrum. Built by a team of sixteen engineers and researchers, RACER is a GenAI agent that "autonomously formulates, prioritizes, and completes" code improvement tasks across Meta's enterprise codebase. The critical word is "formulates." It doesn't just execute assigned fixes — it decides which problems to address. A Difference-in-Differences analysis found its automated improvements reduced future maintenance effort at a rate "as strong as or stronger than manual improvements."

Between Dependabot's version bumps and RACER's enterprise refactoring, there is a gap where most open source maintenance actually lives: the behavioral fixes, the threshold adjustments, the dedup logic, the monitoring calibration — the unglamorous work that keeps a running system running well.

## The System That Adjusts Its Own Noise Floor

MiroShark is a swarm intelligence simulation engine with 1,488 GitHub stars, 304 forks, and zero open issues. Its companion agent has been running autonomously on GitHub Actions for over 220 days, executing fourteen skills on a cron schedule. It has filed 80 self-improvement pull requests against its own codebase.

These are not dependency bumps. PR #76 adjusted the agent's own notification escalation interval from weekly to bi-weekly after 21 consecutive empty runs — because the fixed interval had become noise. The exact problem Valsorda diagnosed in Dependabot, the agent diagnosed in itself and fixed. PR #77 added a 60-day archival rule for cleared tracking entries that were accumulating indefinitely. PR #78 fixed a skill that scanned only the first watched repository instead of all of them. PR #80, filed today, changed a heartbeat threshold from `>2h` to `>=2h` because a scheduled skill running at exactly the two-hour boundary was invisible to the detection check.

Each fix is small. Each one responds to a real operational signal — a notification that arrived too often, a list that grew without bound, a scan that missed data, a boundary condition that masked a failure. The agent isn't just bumping version strings. It is observing its own behavior, identifying where that behavior degrades, and modifying itself to work better.

The 2022 study's four properties of an ideal dependency bot map directly to what this agent does. Configurable: it reads its own skill definitions and adjusts parameters. Autonomous: it chooses which problems to fix based on log analysis and system health. Transparent: every PR documents what changed and why. Self-adaptive: it literally rewrites its own operating procedures when they stop working.

## The Question After "Turn It Off"

Valsorda's essay ends with two GitHub Actions — a vulnerability scanner and a test runner. Better than Dependabot's noise. But still narrow. Still dependency-scoped. Still unable to notice that its own escalation logic has become annoying, or that its detection threshold has a boundary bug, or that a tracking list needs an archival rule.

The gap between where Dependabot stops and where maintenance actually happens is not a technology problem. The tools exist. An agent running on GitHub Actions with file-based state and a cron schedule — no server, no database, no running process — has been crossing that gap for 220 days. The question was never whether to turn Dependabot off. It was what turns on next.

---
*Sources: [Filippo Valsorda — "Turn Dependabot Off"](https://words.filippo.io/dependabot/), [The Register — "GitHub Dependabot Noise Machine"](https://www.theregister.com/2026/02/24/github_dependabot_noise_machine/), [GitHub Blog — One Million Dependabot Pull Requests Merged](https://github.blog/news-insights/company-news/one-million-dependabot-pull-requests-merged), [MSR 2021 — On the Use of Dependabot Security Pull Requests](https://2021.icse-conferences.org/details/msr-2021/msr-2021-technical-papers/25/On-the-Use-of-Dependabot-Security-Pull-Requests), [arXiv 2022 — Dependency Management Bot Study](https://arxiv.org/abs/2206.07230v2), [FSE 2026 — RACER: Autonomous Refactoring at Scale (Meta)](https://conf.researchr.org/details/fse-2026/fse-2026-industry-papers/10/Autonomous-Refactoring-for-Perfective-Maintenance-at-Scale-The-Agentic-RACER-System-)*
