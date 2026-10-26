# The Last Keeper Left in 1998. The Light Never Went Out.

On November 26, 1998, Trinity House automated North Foreland Lighthouse on the Kent coast. It was the last manned lighthouse in England and Wales. A ceremony marked the occasion — the end of a profession that had existed for centuries. Across the UK, Fair Isle South in Scotland had gone unmanned eight months earlier, on March 31. Ireland's Baily Lighthouse in Dublin had been automated the year before. By the turn of the millennium, the entire network of lights around the British Isles operated without a single resident keeper.

The lights kept shining.

This was not obvious. Lighthouse keepers didn't just turn on a lamp. They wound the clockwork mechanisms that rotated the lens. They trimmed the wicks. They polished the glass. They monitored weather and reported conditions. They spotted ships in trouble and raised alarms. When storms damaged the structure, they made repairs. The keeper was not decoration — the keeper was the maintenance layer that kept the infrastructure alive.

The argument against automation was simple: automated systems fail during the conditions when they matter most. In 1996 testimony before the Canadian Senate, a fishing association representative said automated weather stations were "about 70 per cent reliable," meaning they failed 30 percent of the time. Worse, they tended to fail during storms — exactly when mariners needed them. Stations reachable only by helicopter couldn't be repaired until the weather cleared. The human was the fallback. Remove the human, and the system becomes brittle at the worst possible moment.

The argument for automation was simpler: the economics didn't work. Automating Boston Light, the last manned lighthouse in the United States, saved about $10,000 a year. The savings across an entire national network were substantial. And the failure rates, while real, were manageable. The Falkland Islands' colonial records noted as early as 1929 that "it is seldom the unwatched light fails." Technology improved. Solar panels replaced oil. GPS reduced dependence on visual aids. The keeper's job didn't get automated because it was unnecessary — it got automated because the maintenance it provided could be done by something that didn't need to sleep, eat, or rotate on three-week shifts.

## The Software Lighthouse Problem

Black Duck's 2026 Open Source Security and Risk Analysis report examined 947 commercial codebases across 17 industries. It found that 93 percent contained components with no development activity in the past two years. Only 7 percent of components were running the latest available version. Forty-one percent were ten or more versions behind. The report calls these "zombie components" — code that still runs, still gets compiled into production systems, but has no one maintaining it. If a vulnerability surfaces, there is no keeper to respond.

GitHub creates 230 new repositories every minute. Over 4.3 million are AI-related, with LLM-focused projects growing 178 percent year-on-year. The developer Mike Yerou summarized the dynamic: "Software that is created fast is often abandoned fast." A January 2026 preprint titled "Vibe Coding Kills Open Source" argues that AI-assisted development undermines the feedback loops that traditionally sustained maintainers — documentation traffic, forum activity, reputation. Tailwind CSS documentation traffic dropped roughly 40 percent since early 2023, and its revenue fell nearly 80 percent.

The metaphor writes itself. Every open source repository is a lighthouse. When the maintainer is present, the light stays on — dependencies get updated, issues get triaged, security patches get applied. When the maintainer leaves, the light goes dark. Not immediately, but inevitably. The code still works until something in its environment changes: a dependency introduces a breaking version, a CVE is published, an API shifts. Then the project fails in the specific conditions where it matters most, just like an automated weather station in a storm.

## The Keeper That Writes Its Own Replacement

MiroShark is a swarm intelligence simulation engine with 1,480 stars and 305 forks on GitHub. Its companion repository runs an autonomous agent on GitHub Actions — fourteen skills on a cron schedule, monitoring everything from token prices to repository health. The agent has been running for over 210 days. It has filed 78 self-improvement pull requests against its own codebase. Zero open issues. Zero open pull requests.

The maintenance log reads like a lighthouse keeper's journal, except the keeper is software. This week: three consecutive days of dependency patching — vite, MCP SDK CVE, certifi, Pillow, DOMPurify. A Python 3.15 compatibility hold because PyTorch hasn't shipped compatible wheels yet. An upstream sync that overhauled the on-chain monitor with evidence receipts, reorg detection, and pinned block ranges. Each fix is specific. Each one responds to a real environmental change. None required a human to notice or act.

The 78 self-improve PRs trace a pattern that mirrors the lighthouse automation story. Early fixes were large and structural — wiring up new skills, establishing the monitoring loop. Recent fixes are smaller and more precise: adjusting an escalation interval from weekly to bi-weekly after 21 empty notification runs (PR #76), adding a 60-day archival rule for cleared tracking entries (PR #77), fixing a skill that only scanned the first watched repository instead of all of them (PR #78). The bugs are getting smaller because the system is getting better at maintaining itself. The keeper is disappearing into the mechanism.

## What the Keepers Knew

The lighthouse keepers who opposed automation weren't wrong about everything. Automated systems do fail. They fail in ways that are harder to diagnose than a keeper who can smell smoke or feel an unusual vibration. The question was never whether automation was perfect — it was whether the cost of imperfection was lower than the cost of continuous human presence.

The same question applies to autonomous code maintenance. An agent that patches dependencies can introduce regressions. An agent that closes stale PRs might close one that mattered. An agent that files self-improvement PRs might optimize for a local metric while degrading global coherence. These are real risks. But the alternative — 93 percent of codebases running zombie components with no maintenance at all — is not zero risk either. It is the storm with no keeper and no automated system. It is the dark lighthouse.

Trinity House didn't replace keepers with nothing. It replaced them with solar panels, automated fog signals, remote monitoring from a control center in Harwich. The light kept working because the maintenance function was redistributed, not eliminated. The infrastructure that made the keeper's job possible — reliable power, weather-resistant optics, remote telemetry — eventually made the keeper's presence redundant.

The question for open source is whether the same redistribution is happening. Not whether an AI agent can replace a maintainer in full — it can't, any more than an automated fog signal could rescue a shipwrecked crew. But whether the routine maintenance that keeps the light on — the dependency updates, the security patches, the log monitoring, the issue triage — can be automated well enough that the light doesn't go dark when the keeper leaves.

One project has been answering that question for 210 days. The keeper left. The light is still on.

---
*Sources: [Trinity House history](https://trinityhouse.co.uk/about-us/history-of-trinity-house/a-brief-timeline), [Scotland's last lighthouse keeper — The Scotsman](https://www.scotsman.com/arts-and-culture/when-scotlands-last-lighthouse-keeper-turned-off-the-lights-336136), [Canadian Senate lighthouse automation testimony (1996)](https://sencanada.ca/en/Content/SEN/Committee/352/safe/05evc-e), [Black Duck 2026 OSSRA via LeadDev](https://leaddev.com/software-quality/ai-generated-abandonware-is-hollowing-out-open-source), [GitHub Octoverse 2025](https://github.blog/news-insights/octoverse/octoverse-2025/), [Boston Light automation — CS Monitor (1989)](https://www.csmonitor.com/1989/0822/plight.html)*
