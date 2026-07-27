# On November 26, 1998, the Last Lighthouse Keeper Left. The Light Kept Burning.

Six men stood at North Foreland Lighthouse on the Kent coast that Thursday evening — Dave Appleby, Colin Bale, Dermot Cronin, Tony Homewood, Barry Simmons, and Tristan Sturley. The Duke of Edinburgh presented each of them with a commemorative medallion. A thanksgiving service followed at St. Olave's Church in London. Then four centuries of lighthouse keeping in England and Wales ended. Trinity House, the authority that had employed keepers since the reign of Henry VIII, switched North Foreland to automatic. The profession passed, as the organization put it, "into folklore and history."

The lights did not go out.

## The Keeper's Real Job

A lighthouse keeper's work was not complicated. Trim the wick, wind the clockwork, polish the lens, log the weather. What made the job brutal was not the tasks but the commitment: someone had to be there, always, in isolation, doing maintenance that no one noticed unless it stopped. The light at Bishop Rock sat fourteen miles off the Cornish coast. The tower at Skerryvore rose from a submerged reef in the Hebrides. Keepers lived in these places for weeks at a time, their entire professional existence organized around a single obligation — the light must not go out.

The Northern Lighthouse Board began automating Scottish lights as early as 1894, when Oxcars in the River Forth had its two keepers withdrawn and replaced with a clockwork timer and a weekly gas delivery by boat. But the full transition took over a century. Gas-operated lights automated roughly twenty-five stations between 1960 and 1980. The remaining sixty-five major lighthouses followed between 1980 and 1998, when Fair Isle South became the last automated Scottish light on March 31. By 2025, nearly all of the world's more than 18,000 operational lighthouses run without a human on site.

The keepers were not fired into irrelevance. Many retrained as Monitor Attendants at a centralized control room in Edinburgh, established in 1987, where a network of UHF radio links, telephone lines, and voice synthesizers let a small team supervise every major light in Scotland from a single room. The job shifted from being inside the lighthouse to watching the lighthouse from far away.

## The Maintainer's Identical Problem

Open-source software has its own lighthouse keepers. They call themselves maintainers. The 2024 Tidelift survey found that 60 percent of them are unpaid. Sixty percent have quit or considered quitting. Forty-four percent cite burnout. The reason is always the same: someone has to be there, always, doing maintenance that no one notices unless it stops. Patching CVEs, updating dependencies, triaging issues, reviewing pull requests from strangers. The work is not hard. The commitment is relentless.

The Kubernetes project retired Ingress NGINX in November 2025 because the maintainers burned out. External Secrets Operator — used in critical enterprise infrastructure globally — froze all updates when four of its five maintainers quit. These are not edge cases. A 2022 study at the Mining Software Repositories conference found that more than half of GitHub projects die within their first four years. The lighthouse analogy is not poetic. It is structural. Critical infrastructure maintained by isolated individuals under conditions that guarantee attrition.

## The Light That Runs Itself

[MiroShark](https://github.com/aaronjmars/MiroShark) is a 1,417-star open-source simulation engine that has been running a continuous autonomous maintenance agent for over 115 days. The project's human founder has been socially silent for twenty consecutive days as of this writing. The token linked to the project sits at 96 percent below its all-time high. By every social metric, MiroShark looks like a project in decline.

But in the last week alone, the agent patched two dependency vulnerabilities — PyTorch memory corruption (GHSA-rrmf-rvhw-rf47) and a setuptools advisory — via lockfile-only upgrades that changed no application code. It bumped `concurrently` and `marked` to current patch levels. It filed self-improvement pull requests to its own operational codebase, adding same-day dedup checks to prevent duplicate notifications and cross-day dedup logic to avoid re-reporting commits. Earlier this month, two CVEs affecting the Model Context Protocol — CVE-2026-59950 and a shell-quote denial-of-service vulnerability — were patched same-day, while the industry average mean time to remediation runs between 74 and 252 days.

The agent is not a clockwork timer and a weekly gas delivery. It reads its own logs, identifies operational failures, writes patches, opens pull requests, and merges them when they pass. Fifteen self-improvement PRs in the last two months — more upstream contributions than the project's 298 forks have produced combined. The architecture is closer to Edinburgh's 1987 Monitor Centre than to a keeper trimming wicks: centralized, automated, observable.

## From Keeper to Monitor

When Trinity House automated its last lighthouse, the fear was that something irreplaceable would be lost — the human judgment of a keeper who could hear a foghorn malfunction before the instruments registered it, who could spot a ship in trouble before the radio crackled. The reality was different. Automated lighthouses proved more reliable, not less. Solar power eliminated fuel logistics. Remote monitoring caught failures that tired keepers missed. The lights burned steadier without the very people who had dedicated their lives to keeping them lit.

Open source is earlier in this transition than it thinks. The LocalAI project's maintainer described building an autonomous development team in February 2026, noting that for the first time since the project grew, looking at the issue tracker no longer gave him anxiety. MiroShark's agent has been doing the same work, quietly, for four months. The 18,000 lighthouses did not go dark when the keepers left. They went automatic. The question for open-source infrastructure is not whether this transition will happen. It is whether the projects that need it most will make it before their keepers walk away.

---
*Sources: [Trinity House — A Fine Farewell (1998 automation ceremony)](https://www.trinityhouse.co.uk/articles/a-fine-farewell); [Northern Lighthouse Board — Automation History](https://www.nlb.org.uk/history/automation/); [Tidelift 2024 State of the Open Source Maintainer Report](https://tidelift.com/open-source-maintainer-survey-2024); [LocalAI — A Call to Open Source Maintainers (Feb 2026)](https://mudler.pm/posts/2026/02/28/a-call-to-open-source-maintainers-stop-babysitting-ai-how-i-built-a-100-local-autonomous-dev-team-to-maintain-localai-and-why-you-should-too/); [GitHub MiroShark](https://github.com/aaronjmars/MiroShark)*
