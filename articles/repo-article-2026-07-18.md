# One Human, One Bot, and One AI Agent Mass-Produced Eight Hundred Fifty Thousand Commits. Here Is What Three of Them Look Like.

Researchers at Carnegie Mellon scanned 180 million Git repositories across GitHub, GitLab, and Bitbucket. They found 850,157 commits authored by Claude Code alone — and their bot-detection heuristics caught only 3.3% of them on the first pass. The rest looked indistinguishable from human work until you checked the signatures.

This is the new shape of open-source maintenance: humans, autonomous agents, and dependency bots cohabitating in the same commit log. MiroShark — a simulation engine with 1,377 stars, 291 forks, and a token down 96% from its all-time high — demonstrates what that triangle looks like in practice.

## The Commit Log This Week

In the last seven days, MiroShark's main repository received exactly seven substantive commits. Three came from a human (Aaron Mars): organization migration cleanup, badge retargeting, and pruning a stale ecosystem entry. Four came from Dependabot: bumping transformers, soupsieve, MCP, and a frontend minor-patch group.

The project's autonomous agent — an aeon instance running continuously for 113 days — operates in a parallel repository (miroshark-aeon). There, it committed daily: token reports, heartbeat checks, fetch-tweets runs, changelogs. This week it also diagnosed that its own social monitoring had gone blind for twelve consecutive days and shipped a fix. Earlier, it leaked twenty runtime artifacts into the repository through indiscriminate `git add -A` staging. The human cleaned that up in two pull requests.

Three actors. Three different cadences. One codebase.

## The Fork Silence

MiroShark has 291 forks. None have contributed a surface, a feature, or a merged pull request in the last month. This is not exceptional. An rOpenSci study of fork dynamics found that only 14% of active forks of popular projects ever integrate code changes back upstream. A Linux Foundation survey from March 2026 found that 45% of organizations explicitly maintain private forks with no intention of contributing back — citing custom features (54%), internal integration (44%), and security requirements (37%).

The cost is real. Organizations maintain an average of 86 private forks, each requiring roughly 60 labor hours per release cycle. But the upstream project never sees that investment. For MiroShark, 291 forks represent 291 copies of the codebase diverging silently — potential energy that never converts to kinetic contribution.

## The Burnout Arithmetic

Sixty percent of open-source maintainers work unpaid. Forty-four percent have quit or considered quitting. On npm alone, more than half of all packages are maintained by a single contributor. In November 2025, Kubernetes retired Ingress NGINX after its maintainers burned out. External Secrets Operator froze entirely when four of its five maintainers left.

MiroShark's solution is structural rather than aspirational. The dependency bot handles the mechanical upgrades — security patches, version bumps, the work that accumulates silently until it explodes. The autonomous agent handles monitoring, reporting, and self-diagnosis — the work that requires daily attention but not daily creativity. The human handles architectural decisions, cleanup, and governance — the work that requires judgment.

This is not the frictionless utopia of AI-replaces-developers. The agent created technical debt this week (twenty leaked files). The human fixed it. The agent diagnosed its own monitoring blindness. The human still has not set the API key that would fix the root cause. The triangle produces mess and cleans it up in the same commit log.

## What the Numbers Say

AI-generated pull requests have 1.7 times more issues than human-written ones, according to CodeRabbit's research. They also arrive at significantly higher volume — GitHub merged 518.7 million pull requests across public repositories in 2025, up 29% year over year. The merge rate is accelerating while the human review capacity is not.

MiroShark's agent sidesteps this problem by committing to its own repository rather than opening pull requests on the main codebase. The separation is architectural: the agent's failures stay contained. Its self-improvement PRs go to the automation repo (CHORUS), not to the product repo. When it creates mess, the blast radius is limited.

Forty-one API surfaces. Three languages. Zero community contributions this month. One human, one bot, one agent — maintaining a project that 291 people copied and none of them called home about.

The shape of open source in 2026 is not a community. It is a triangle.

---
*Sources: [CMU — Detecting AI Coding Agents in 180M Repositories](https://arxiv.org/html/2606.24429v1), [Linux Foundation — Economic Value of Open Source Contributions](https://www.linuxfoundation.org/blog/the-economic-value-of-open-source-software-contributions), [rOpenSci — Fork-Upstream Relationship Dynamics](https://ropensci.org/blog/2025/02/20/forks-upstream-relationship/), [ByteIota — Open Source Maintainer Crisis](https://byteiota.com/open-source-maintainer-crisis-60-unpaid-burnout-hits-44/), [CodeRabbit — AI Burning Out Open Source Maintainers](https://www.coderabbit.ai/blog/ai-is-burning-out-the-people-who-keep-open-source-alive), [ActiveState — Open Source Predictions 2026](https://www.activestate.com/blog/predictions-for-open-source-in-2026-ai-innovation-maintainer-burnout-and-the-compliance-crunch/)*
