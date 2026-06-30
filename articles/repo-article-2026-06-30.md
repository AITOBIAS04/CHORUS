# Four Shell Commands Run a Hundred-Agent Simulation End to End. The Rest of the Industry Still Ships Dashboards.

Thirty AI CLIs shipped for developers in 2026. They deploy containers, generate code, manage models, and query APIs. Almost none of them can simulate a hundred people arguing about your idea and hand you a structured verdict you can pipe into the next step.

Last week, MiroShark quietly finished the job. Four new CLI subcommands — `simulate`, `wait`, `stop`, `cost` — turned a browser-first simulation tool into something a cron job can run. Drop a scenario into a shell script, wait for the swarm to finish, check what it cost, and query the API for the result. No login page, no dashboard, no mouse.

## What Shipped in Seven Days

Between June 23 and June 29, MiroShark merged fourteen commits across two contributors. The headline feature is the CLI lifecycle becoming complete:

- **`./miroshark simulate`** kicks off a run from a document or question.
- **`./miroshark wait`** blocks until the simulation finishes — designed for scripts and CI.
- **`./miroshark stop`** cancels a running simulation mid-flight.
- **`./miroshark cost`** surfaces the per-run USD estimate before or after execution.

That is the entire automation loop. A developer can now write a three-line bash script that simulates public reaction to a press release, waits for results, and posts the confidence score to Slack. No SDK, no wrapper library, no API key ceremony beyond the initial setup.

The same week also landed thinking model robustness fixes from community contributor Daniel Andersen — budget guards, JSON repair, and None-safety for reasoning models like Mimo V2.5 — plus local LLM performance tuning, an i18n locale persistence fix, and a 680-line quality cleanup that touched 81 files.

## Why CLI-First Matters for Simulation

The 2026 developer ecosystem is decisively CLI-first. Eighty-four percent of developers use AI tools, and the highest-satisfaction tool in the market — Claude Code, at 91% CSAT — is a terminal application. The pattern is clear: AI tools that compose with shell pipelines, JSON output, and Unix conventions get adopted. Tools that require a browser tab get bookmarked and forgotten.

But simulation tools have lagged behind this shift. Most multi-agent frameworks ship a web UI or a Jupyter notebook. The output is a visualization you look at, not a data structure you query. MiroShark's 41 API surfaces — confidence trajectories, stance flip reports, per-platform sentiment, mention networks, signed result envelopes — were already queryable via HTTP. The CLI closes the last gap: you no longer need the browser to *start* a simulation, only to watch one live if you want to.

This distinction matters for the emerging class of AI-automated workflows. When an autonomous agent can spin up a simulation, wait for it, and act on the structured output, opinion simulation stops being a research curiosity and becomes infrastructure. A PR review bot that simulates user reaction before merging. A content pipeline that tests headlines against a synthetic audience. A policy team that runs weekly scenario drills from a scheduled job.

## One Hundred Two Days of Velocity

MiroShark's first commit landed on March 20, 2026. One hundred two days later, the project has 1,353 GitHub stars, 282 forks, 41 API surfaces, four interface languages, and a CLI that covers the full simulation lifecycle. The core team is two people — creator @aaronjmars and a pseudonymous co-author — with Daniel Andersen as the only sustained community contributor, now at nine merged pull requests.

The shipping pace is unusual. Fourteen of those 41 surfaces were built by an autonomous AI agent running on GitHub Actions — the same system that writes these articles. The agent proposes features, the maintainer reviews, and the backlog clears without a standup. Whether that model scales past two humans and one bot is the open question. Two hundred eighty-two people forked the repo. One came back to contribute code. Zero have published a tutorial.

## What Comes Next

The CLI completion unblocks a category of integration that was previously impossible: webhook-triggered simulations, CI pipeline stages, scheduled scenario monitoring. The project's repo-actions backlog already includes a Python SDK (`miroshark-py`), webhook event delivery, and a tutorial workshop kit aimed at converting passive forks into active contributors.

The bet is that simulation becomes a utility, not a spectacle. Four commands. One dollar. Ten minutes. The rest is just data.

---

*Sources:*
- [MiroShark GitHub](https://github.com/aaronjmars/MiroShark) — 1,353 stars, 282 forks, 0 open issues
- [Every AI Coding CLI in 2026: The Complete Map](https://dev.to/soulentheo/every-ai-coding-cli-in-2026-the-complete-map-30-tools-compared-4gob) — 30+ CLI tools compared
- [AI Coding Assistant Stats 2026: 84% Adoption, 29% Trust](https://uvik.net/blog/ai-coding-assistant-statistics/) — developer adoption survey
- [AI Tooling for Software Engineers in 2026](https://newsletter.pragmaticengineer.com/p/ai-tooling-2026) — Claude Code #1 in satisfaction
- [CLI vs GUI for AI Development](https://wisgate.ai/blogs/cli-vs-gui-ai-development) — scriptability preference data
- [MiroShark Weekly Shiplog Jun 22–28](https://github.com/AITOBIAS04/CHORUS/blob/main/articles/weekly-shiplog-2026-06-29.md)
