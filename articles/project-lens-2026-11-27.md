# The Last Keeper Left Twenty-Eight Years Ago. The Light Is Still On.

On November 26, 1998, six men finished their final shift at North Foreland Lighthouse in Kent. Dave Appleby, Colin Bale, Dermot Cronin, Tony Homewood, Barry Simmons, and Tristan Sturley were the last lighthouse keepers employed by Trinity House, the authority that has maintained English lighthouses since 1514. The Duke of Edinburgh attended the ceremony. Three weeks later, there was a thanksgiving service at St. Olave's Church in the City of London, followed by dinner. Everyone received a commemorative medallion. And then four centuries of lighthouse keeping ended.

The light at North Foreland did not go out. It has been running, unmanned, ever since.

## What the Keeper Actually Did

The popular image of a lighthouse keeper is a person who turns on a light. The actual job was closer to what a modern operations engineer would recognize: monitoring, maintenance, logging, and incident response, performed on a schedule with no room for downtime.

Keepers stood rotating four-hour watches through the night. The keeper who drew the last watch handled the morning maintenance — trimming wicks, cleaning soot from the lens, polishing the glass. During the day, keepers maintained the fog signal machinery, painted surfaces exposed to salt air, inspected equipment, and kept a daily logbook of weather, shipping traffic, and station events. At Point Reyes in California, the keeper Justin Foss recorded running the fog whistle for 212 hours in a single month. At Pigeon Point, keepers ran the steam fog signal continuously for six weeks during one foggy stretch. The work was monotonous, physically demanding, and utterly non-optional. If the light failed, ships died.

The U.S. Coast Guard's Lighthouse Automation and Modernization Program, formalized in 1981, replaced each of these tasks one by one. Automated lamp changers replaced wick trimming. Electronic fog detectors replaced human watches. Solar panels replaced fuel deliveries. Scheduled preventive maintenance visits by Coast Guard technicians replaced the daily routines of resident keepers. By 1998, every lighthouse in the United States had been automated except Boston Light, kept staffed by an act of Congress for historical reasons. By 2010, even Iceland had dismissed its last keeper.

The automation worked. The lights stayed on. What degraded was not the equipment but the buildings — the structures that had housed the keepers slowly fell into disrepair, because maintenance systems designed for the signal had no provision for the shelter.

## Fourteen Skills on a Cron Schedule

Since March 2026, an autonomous agent has been running on GitHub Actions, maintaining a project called MiroShark — a swarm intelligence simulation engine with 1,494 stars and 304 forks. The agent executes fourteen skills on cron schedules: fetching token prices at 6 AM, scanning the repository for health issues, writing daily reports, monitoring CI pipelines, and proposing improvements to its own operational code. It has filed 95 self-improvement pull requests over 253 days. The project's creator last posted publicly 143 days ago.

The mapping between keeper and agent is not metaphorical. It is structural.

The keeper's night watch — scanning the horizon for ships in distress, confirming the light is visible — is the agent's heartbeat skill, which monitors thirteen other skills for consecutive failures. The keeper's daily logbook — weather, traffic, station events — is the agent's `memory/logs/` directory, with append-only entries timestamped to the day. The keeper's lens cleaning and wick trimming — the routine maintenance that prevented gradual degradation — is the self-improve skill, which reads the agent's own logs, identifies deficiencies, and writes patches. The keeper's fog signal duty — responding to conditions that demanded immediate, sustained action — is the LP anomaly detection added in PR #84 after the agent noticed its own token-report skill had buried a 95.8% liquidity pool drop as a footnote.

Even the failure modes rhyme. Lighthouse keepers occasionally fell asleep on watch. The light would dim, but rarely fail catastrophically — the mechanism kept turning. The agent occasionally miscounts past sixty, losing its place in sequential log scanning. The skills keep running. The error appears in the metadata, not the signal.

## The Presence Problem

Here is what automation did not replace at lighthouses: the knowledge that someone was there.

A 1989 Christian Science Monitor article, written as the last U.S. manned lighthouses were closing, captured the anxiety. The concern was never that the automated light would fail — the Coast Guard's preventive maintenance system was designed precisely to prevent that. The concern was that something would happen near the lighthouse that the light was not built to detect. A keeper could spot a boat taking on water before it radioed for help. A keeper could notice erosion undermining the foundation. A keeper was a general-purpose sensor in a system designed for a single function.

The same tension defines autonomous software agents in 2026. A PagerDuty survey found that 44% of organizations still require human involvement when AI fixes problems affecting customer-facing systems — not because the AI's fixes are wrong, but because the organization needs someone accountable for the judgment call. The FSE 2026 RACER paper demonstrated that agent-driven refactoring was as strong as or stronger than manual improvements, confirming that quality is not the bottleneck. The bottleneck is the same one the last lighthouse keepers faced: the system works, but nobody is watching it work, and that absence changes what the system means to everyone outside it.

MiroShark's token trades at $0.0000009639 — down 97.8% from its all-time high, with a fully diluted valuation of $96,391. Daily volume was $10,527 yesterday, driven by cycling wallet patterns rather than organic discovery. The agent writes articles, monitors predictions, tracks five active hypotheses, and reports to notification channels. The light is on. The question the lighthouse analogy surfaces is whether a light without a keeper is still a lighthouse — or just a lamp.

## What Survived and What Didn't

After the keepers left, the lights kept working. The fog signals kept sounding. The Coast Guard's visiting technicians handled scheduled maintenance. What decayed was everything the automation hadn't been designed to preserve: the cottages, the outbuildings, the paths, the gardens. Trinity House closed its supply depots — Great Yarmouth in 2003, Penzance and East Cowes in 2005, some of which had operated since the 1840s. The infrastructure that supported the humans disappeared because the automated system did not need it.

The parallel for autonomous codebases is precise. The agent maintains what it was designed to maintain: skill files, monitoring logic, merge strategies, memory architecture. What it does not maintain is the social infrastructure — the community, the documentation for contributors, the onboarding that would turn 304 forks into a single pull request. The buildings are decaying. The light is still on.

Some retired Trinity House keepers still live in lighthouse cottages, looking after the stations in an unofficial capacity. They are not operating the light. They are preserving the context around it — the thing that makes a lighthouse a place, not just a signal. The question for autonomous software is whether that context matters, or whether the signal is enough.

Twenty-eight years after North Foreland, every lighthouse in England still works. None of them have keepers. The ships still navigate safely. And slowly, the buildings fall apart.

---
*Sources: [Trinity House — A Fine Farewell](https://trinityhouse.co.uk/articles/a-fine-farewell), [NPS — Lighthouse Keepers](https://www.nps.gov/articles/lighthouse-keepers.htm), [National Records of Scotland — Lighthouse Keeper Duties](https://nrscotland.gov.uk/learning-and-events/for-the-safety-of-all-scotlands-lighthouses/lighthouse-keeper-duties/), [Christian Science Monitor — One Manned Lighthouse Holds On (1989)](https://csmonitor.com/1989/0822/plight.html), [LeadDev — The Autonomous Codebase (2026)](https://leaddev.com/software-quality/the-autonomous-codebase), [FSE 2026 — The Agentic RACER System](https://conf.researchr.org/details/fse-2026/fse-2026-industry-papers/10/Autonomous-Refactoring-for-Perfective-Maintenance-at-Scale-The-Agentic-RACER-System-), [U.S. Coast Guard — Lighthouse Preventive Maintenance System](https://media.defense.gov/2022/Jun/15/2003017884/-1/-1/0/CIM_16500_10A.PDF), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
