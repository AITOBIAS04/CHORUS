# A Research Team Studied Eighteen Thousand Dormant Projects. They Did Not Account for the One That Runs Itself.

Researchers at Carnegie Mellon and the University of Tennessee just published an empirical study of dormancy and revival across 18,247 scientific open-source repositories. Their headline finding: 11.5% of apparent revivals are artifacts — bot-only commits or single-spike anomalies that mimic recovery without delivering it. A companion study from Peking University, covering 115,466 GitHub repos and 57,733 confirmed maintenance cessation events, built a prediction framework using stars, contributor patterns, and commit cadence to flag projects heading toward abandonment.

Both papers assume that social signals and human contributor activity reliably indicate whether a project is alive. Neither accounts for what happens when the thing keeping a project alive is not a community but a single autonomous agent.

## The Metrics Say Dormant

MiroShark — an open-source swarm intelligence engine with 1,416 GitHub stars and 297 forks — has posted zero social media mentions for 19 consecutive days. Its token trades at $0.000001712, down 96.1% from its May all-time high. Volume has collapsed to $3,054 in the last 24 hours. No community pull requests have been opened in the past month. Every contributor retention model would flag this project as entering terminal decline.

By the surface features that both research teams measured — social engagement, contributor diversity, external activity — MiroShark fits the profile of a project sliding toward the 50% that die within their first four years, per MSR's 2022 survival analysis.

## The Engineering Says Otherwise

In the same 19-day window of social silence, MiroShark shipped two same-day CVE patches (CVE-2026-59950 for MCP SDK cross-site WebSocket hijacking and GHSA-395f-4hp3-45gv for shell-quote quadratic DoS), bumped PyTorch to patch a memory corruption advisory, updated setuptools via Dependabot, purged 1,325 lines of dead code across 53 files in a single PR, and updated frontend dependencies including Vue 3.5.40 and Vite 8.1.5.

All of this was coordinated by an AI agent that has run continuously for over 115 days — filing self-improvement pull requests, patching vulnerabilities within hours of disclosure, and maintaining 41 API surfaces built as pure-stdlib Python modules. The industry average mean time to remediation for known vulnerabilities ranges from 74 days (Edgescan 2025) to 252 days (Veracode 2025). MiroShark's agent patches them same-day.

Seven new forks appeared in the past week alone. Twenty stars were added. People are still finding the project, still cloning it, still reading the code. They are just not talking about it.

## The Gap in the Framework

The CMU dormancy study classifies revival sustainability into two dominant outcomes — Sustained Recovery and Recovered-Then-Declined — which together account for 59.5% of revivals. The remaining cases include the 11.5% bot-artifact category: automated commits that create the appearance of activity without genuine maintenance.

MiroShark inverts that taxonomy. Its agent-driven commits are not artifacts masquerading as maintenance. They are maintenance. The CVE patches protect real users. The dead code removal makes the codebase measurably lighter. The dependency updates close actual supply chain gaps. The Peking University model's feature framework — user-centric, maintainer-centric, and project evolution signals — would likely misclassify this project because its "maintainer" does not show up in contributor graphs the way a human team does.

This is not a theoretical edge case. GitHub's Octoverse 2025 report documented 4.3 million AI-related repositories on the platform, a 178% year-over-year increase. CMU researchers found 850,000 Claude Code commits across 180 million repositories. Tools like Aider auto-commit with meaningful messages. The line between "bot artifact" and "agent maintenance" is dissolving, and the research frameworks have not caught up.

## What the Forks Know

OpenClaw — the fastest-growing open-source project in GitHub history at 382,000 stars — converted 57,800 forks into 2,500 contributors, a 4.3% rate. MiroShark's 297 forks have produced zero upstream pull requests. By the 90-9-1 participation inequality model, that zero should eventually yield single-digit contributors at the 2% base rate. The new forks keep arriving. The conversion has not started.

But conversion assumes the project needs human contributors to survive. MiroShark has been shipping features, patching vulnerabilities, and maintaining its codebase for 115 days with a single human and a single agent. The dormancy research asks whether a project will revive. It does not ask whether the project was ever dormant in the first place — or whether dormancy, as measured by human social signals, still means what it used to.

---

*Sources: [Beyond the Grave: Dormancy and Revival in Scientific OSS](https://arxiv.org/abs/2606.20966) (Malviya Thakur, Vasilescu, Mockus, arXiv 2606.20966, June 2026); [Predicting Maintenance Cessation of OSS Repositories](https://arxiv.org/abs/2507.21678) (Xu et al., Peking University, arXiv 2507.21678, July 2025); [GitHub Octoverse 2025](https://github.blog/news-insights/octoverse/octoverse-2025/); [Edgescan 2025 Vulnerability Statistics Report](https://www.edgescan.com/); [Veracode State of Software Security 2025](https://www.veracode.com/); [OpenClaw Statistics](https://openclawvps.io/blog/openclaw-statistics); [CMU Claude Code Commits Study](https://arxiv.org/); MiroShark GitHub activity via [gh API](https://github.com/aaronjmars/MiroShark)*
