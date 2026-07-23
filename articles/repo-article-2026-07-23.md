# Half of Open-Source AI Projects Never Reach Production. One Spent Last Week Doing Nothing But Maintenance.

Mozilla's inaugural State of Open Source AI report landed on July 20 with a number that should make every maintainer flinch: 79 percent of developers say they use open models, but only 51 percent have deployed one in production. Closed models sit at 63 percent. The gap is not capability — open weights now match proprietary systems on coding and instruction-following. The gap is everything that happens after the demo works.

## The Zombie Problem

Black Duck's 2026 OSSRA report puts a finer point on it. Ninety-three percent of audited codebases contain at least one component with no development activity in the past two years. Ninety-two percent contain components four or more major versions behind. And here is the mismatch that kills projects: 60 percent of organizations deploy code daily, but update their dependencies on cycles measured in months or years. They ship features on Monday and discover the CVE on Friday.

Stanford's AI Index counts 5.6 million AI-related projects on GitHub. Filter for even ten stars — a floor so low it barely registers as community interest — and the number drops to 206,880. That is 3.7 percent. The other 96.3 percent are abandoned experiments, tutorial forks, and README-only repos that never cleared the gap between "it runs on my machine" and "it runs in production."

## One Week in the Life of a Maintenance-First Project

[MiroShark](https://github.com/aaronjmars/MiroShark), a 1,415-star open-source simulation engine that lets you model public reaction to anything for a dollar, shipped zero new features last week. Here is what it shipped instead.

On July 21, CVE-2026-59950 dropped — a cross-site WebSocket hijacking vulnerability in the MCP SDK rated CVSS 7.6. MiroShark [patched it the same day](https://github.com/aaronjmars/MiroShark/pull/255), bumping from 1.27.2 to 1.28.1. Hours later, a quadratic denial-of-service in `shell-quote` (GHSA-395f-4hp3-45gv) got a scoped override in [PR #256](https://github.com/aaronjmars/MiroShark/pull/256). Industry average mean time to remediate a vulnerability ranges from 74 days (Edgescan 2026) to 252 days (Veracode). MiroShark's was measured in hours.

The same day, [PR #254](https://github.com/aaronjmars/MiroShark/pull/254) landed: an eight-dimension code audit that touched 53 files and removed 1,325 net lines of dead code, legacy paths, and duplicated logic. Three of the eight audit dimensions — defensive code, circular dependencies, and comment hygiene — produced zero commits because nothing in those categories passed the safety bar for removal. The project chose to leave six known bugs for separate PRs rather than bundle fixes with cleanup. Separation discipline over shipping velocity.

Dependabot swept the CI pipeline the day before: `actions/setup-node` and `actions/setup-python` both moved from v6 to v7. Frontend dependencies updated to Vue 3.5.40, Vue Router 5.2.0, and Vite 8.1.5. The MCP SDK had already been bumped from 1.24 to 1.27.2 before the CVE forced a second bump to 1.28.1.

Total new features: zero. Total lines removed: 1,325. Total CVEs patched same-day: two. Total stars added during this maintenance week: roughly 50.

## Why Maintenance Is the Moat

Mozilla's report names the three persistent obstacles to production deployment: infrastructure cost, security and compliance, and operational tooling. Not features. Not model quality. Not star count. The things that kill open-source AI projects in the gap between demo and deployment are the things that nobody wants to work on and nobody tweets about.

MiroShark already has 40-plus documented features — RSS feeds, Farcaster frames, tweet thread export, Jupyter notebook generation, IPFS archiving, webhook signatures, Discord and Slack and Telegram notifications, a verified predictions tracker, a public gallery with search and filtering. The project does not have a features problem. What it demonstrated last week is that it does not have a maintenance problem either.

The token tied to MiroShark sits at 96 percent below its all-time high. Social mentions have been silent for 17 consecutive days. Nobody is talking about the project. But somebody is patching its CVEs the same day they drop, removing its dead code before it rots, and keeping its dependency tree current while 93 percent of the industry lets theirs fossilize. That is the work that separates the 51 percent from the 79 percent.

The Mozilla report calls operational tooling a "persistent obstacle." The Black Duck report calls stale dependencies a "zombie component" crisis. The industry has names for the problem. What it lacks are examples of projects that treat the problem as the product. Last week, one project with 1,415 stars and zero social buzz quietly did exactly that.

---
*Sources: [Mozilla State of Open Source AI 2026](https://stateofopensource.ai/); [Black Duck 2026 OSSRA Report](https://www.blackduck.com/resources/analyst-reports/open-source-security-risk-analysis.html); [Stanford AI Index 2026](https://spectrum.ieee.org/state-of-ai-index-2026); [Edgescan 2026 Vulnerability Statistics](https://www.edgescan.com/); [Veracode State of Software Security 2026](https://www.veracode.com/); [GitHub MiroShark](https://github.com/aaronjmars/MiroShark)*
