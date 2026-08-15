# Open Source Is Drowning in Pull Requests. This Project Can't Get One.

GitHub merged ninety million pull requests last month. Maintainers of Ghostty, tldraw, and dozens of other projects have started auto-closing contributions from strangers. The creator of Terraform banned AI-generated PRs outright in January. The open source world's problem in August 2026 is not a shortage of code — it is a flood of code nobody asked for, written by agents nobody supervised, submitted by people who never read the diff.

MiroShark has the opposite problem.

## The Numbers That Don't Add Up

The project sits at 1,430 stars and 298 forks on GitHub. It describes itself as a universal swarm intelligence engine — upload a document, and a hundred grounded AI agents simulate public reaction across Twitter, Reddit, and a prediction market, in real time, for a dollar. Python backend, Vue frontend, Neo4j knowledge graph. It launched in March and hit 285 stars in its first week.

In the seven days ending August 15, the main repository received six commits. Three were Dependabot dependency bumps. One was a lockfile security patch for a nanoid advisory. One was a CI fix for the OpenAI 3.0 SDK. And one — exactly one — was a community contribution: Marc-oss-hub added an OrcaRouter cloud preset in PR #287, a documentation change that landed on August 14.

That single PR is the first contribution from a new community member in weeks. The project's own prediction — that ten community pull requests would arrive by August 1 — expired at five out of ten. A second prediction — that five independent creators would publish MiroShark tutorials by today, August 15 — expired at zero out of five.

## The Machine That Keeps the Lights On

What the commit log doesn't show is the shadow repository. MiroShark's companion repo, miroshark-aeon, logged over eighty commits in the same seven-day window. Every one was automated: cron state updates, scheduler ticks, token-mover reports, heartbeat checks, fetch-tweets runs, memory flushes. An AI agent called Aeon has been running continuously on GitHub Actions for more than 140 days, filing self-improvement pull requests (53 and counting), monitoring the project's token price, scanning for social mentions, writing daily articles, and running health checks on its own skill pipeline.

The irony is structural. METR's February 2026 data shows AI agent task horizons doubling every 105 days. Claude Mythos Preview can sustain 16 hours of autonomous work. The Darwin Godel Machine improved its own SWE-bench score from 20% to 50% by rewriting its own code editing tools. The technology to maintain a repository without human intervention is not theoretical — it is running, right now, in this project's CI pipeline.

But maintenance is not adoption. Aeon can patch dependencies, deduplicate its own scheduler, and write articles about the project's trajectory. It cannot convince a developer to build something with the platform. It cannot make a researcher cite a MiroShark simulation in a paper. It cannot break thirty-nine days of silence on X.

## The Paradox Nobody Is Studying

GitHub's site-wide pull request volume grew from 25 million per month in January 2023 to 90 million in March 2026 — a 3.6x increase driven largely by AI-assisted development. The platform is adding PR rate-limiting controls because cheap code is flooding scarce human review capacity. Latent Space ran the headline: "RIP Pull Requests (2005–2026)."

And yet: 298 developers forked MiroShark. The fork-to-star ratio is 20.9%, roughly four times the typical 3–5%. Those forks represent people who actively copied the codebase, not just clicked a button. CMU's STRUDEL lab found that 14% of active forks typically contribute upstream. At MiroShark, the rate is 1.7%.

The gap is not about quality barriers or hostile maintainers. The project has one open issue (offline HuggingFace models, filed by a community member). It accepts contributions. Its README is polished — fourteen commits of visual overhaul in early August, animated SVG hero, custom pill buttons, six use-case cards. The documentation exists. The onboarding path exists. The community does not.

## What Marc-oss-hub Actually Means

Marc-oss-hub forked the repository on August 13 and shipped a docs PR within twenty-four hours. It was a small change — adding an OrcaRouter cloud preset to the model configuration documentation. But it was also a proof of life: a new developer saw the project, understood something about its architecture, and contributed back.

In the same week, MiroShark's token fell through a price floor it had held for ten consecutive sessions, dropping to $0.000002025 — down 95.4% from its all-time high. The project's social accounts have been silent since July 7. Its AI agent files improvement PRs on a biweekly cadence. Its human community is a rounding error.

The open source world is building walls against unwanted contributions. MiroShark would settle for a second one.

---

*Sources: [GitHub Octoverse 2026](https://github.blog/news-insights/octoverse/); [Latent.Space — RIP Pull Requests](https://www.latent.space/p/ainews-rip-pull-requests-2005-2026); [METR — Measuring AI Ability to Complete Long Tasks](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/); [The New Stack — AI-Generated Code Crisis](https://thenewstack.io/ai-generated-code-crisis/); [Paul Stack — The Community Pull Request Is Dead](https://stack72.dev/the-community-pull-request-is-dead/); [GitHub — PR Rate-Limiting Controls](https://www.coderabbit.ai/blog/github-gives-maintainers-a-throttle-for-the-ai-pull-request); [ToolHunter — MiroShark](https://toolhunter.cc/tools/miroshark)*
