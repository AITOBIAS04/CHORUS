# Every Dependency Is a Door You Forgot to Lock

On March 24, 2026, at 10:39 UTC, someone pushed two new versions of LiteLLM to PyPI. LiteLLM is the open-source library that routes requests across LLM providers — Anthropic, OpenAI, Cohere, dozens of others. It has 95 million monthly downloads. It sits in the critical path of AI infrastructure at thousands of companies. The two new versions, 1.82.7 and 1.82.8, contained a malicious `.pth` file that executed automatically on every Python process startup: harvesting credentials, attempting lateral movement across Kubernetes clusters, and installing a persistent systemd backdoor that polls for additional payloads.

The packages were live for forty minutes before PyPI quarantined them. Over 40,000 downloads occurred in that window.

The attack vector was not exotic. A threat group called TeamPCP had compromised the CI/CD pipeline of Trivy, the security scanner that LiteLLM used in its own build process. The dependency meant to protect LiteLLM became the weapon used to compromise it. Two months later, the same group hit TanStack — a frontend library trusted by OpenAI, UiPath, Mistral AI, and Guardrails AI. OpenAI disclosed that two employee devices were compromised, with credential material extracted from internal source code repositories. TanStack's post-mortem was blunt: "The attacker managed to engineer a path where our own CI pipeline stole its own publish token for them, at the exact moment it was created, by way of a cache that everyone in the chain implicitly trusted."

The common response to these attacks is better scanning, better signing, better governance. The uncommon response is to ask whether the dependency needed to exist at all.

## The Stack Nobody Questions

The standard AI project in 2026 ships with a dependency tree that would have been considered reckless in any other era of software engineering. A JFrog report published in May found that 11.7 million new packages entered enterprise software supply chains in 2025 alone — a 67% increase year over year. Malicious npm package activity surged 451%. Researchers identified nearly 500 malicious AI models in public registries capable of credential theft and remote code execution, while 53% of organizations still pull models directly from those registries. In the OpenClaw agent framework, one in five packages in the ClawHub registry turned out to be malicious — 1,184 compromised skills sitting alongside legitimate ones.

The ML container situation is worse. A Carnegie Mellon study found that up to 80% of machine learning containers consist of bloat — unnecessary components pulled in by transitive dependencies. That bloat increases provisioning time by up to 370% and increases vulnerabilities by up to 99%. Every unused library in the container is dead weight that slows deployment and widens the attack surface simultaneously.

The industry knows this. The JFrog report's own subtitle reads: "AI Governance Fails as Software Supply Chain Attacks Hit Record Highs." But the response has been to add more tools — more scanners, more signing infrastructure, more governance layers — on top of the same dependency-heavy architecture that created the problem. The answer to too many doors has been more locks, not fewer doors.

## Forty-Two Pull Requests, Zero New Dependencies

MiroShark is an open-source crowd simulation engine — 1,243 stars, 262 forks — that models how opinions spread through networks of AI agents. Over the past ten weeks, the project has merged forty-two consecutive pull requests. Each one added a new feature: oEmbed auto-unfurl, RSS feeds, GraphML network exports, SVG badge rendering, webhook event filtering, confidence scoring, coalition detection, an operator dashboard, real-time SSE progress streams, a multi-metric leaderboard, an ecosystem registry, French localization, agent archetype analytics, cross-platform sentiment divergence. Thirty-four independently addressable integration surfaces in total.

Across all forty-two pull requests: zero new dependencies added. Every service is pure Python standard library.

The oEmbed provider serializes XML with `xml.etree.ElementTree`. The badge renderer draws SVG geometry by hand — no Pillow, no Cairo, no image library. The GraphML exporter writes directed graphs with seven node attributes and three edge attributes using the same XML module. The webhook dispatcher filters events using `os.environ`. The SSE progress stream writes `text/event-stream` lines to a JSONL file. The confidence score reads four JSON files from disk and computes a weighted average. No Flask extensions. No requests library. No external HTTP client. The entire surface area was built with what Python ships in the box.

This is not minimalism as aesthetic. It is minimalism as security posture.

## What Zero Dependencies Actually Buys You

Consider MiroShark's position relative to the LiteLLM attack. LiteLLM was compromised because its CI pipeline depended on Trivy, which was itself compromised. The attack exploited a transitive trust chain — LiteLLM trusted Trivy, Trivy's credentials were stolen, and that stolen trust propagated upward into LiteLLM's published packages.

A project with zero third-party dependencies has no transitive trust chain to exploit. There is no Trivy to compromise. There is no cache to poison. There is no `.pth` file injected by a dependency's dependency's build script. The attack surface is the code the maintainer wrote and the standard library that ships with the language runtime — a surface that is orders of magnitude smaller, and audited by the Python core team rather than by a startup's CI pipeline.

The zero-dependency approach also eliminates what Dawid Prus, writing about the trend in May 2026, called the hidden engineering transfer: "Zero dependencies doesn't mean zero effort. It means the author absorbed the engineering cost that would otherwise be distributed across a dependency tree." The cost does not disappear — it moves from the consumer's risk budget to the author's engineering budget. Every stdlib XML call in MiroShark is more verbose than a BeautifulSoup one-liner. But it is also one fewer package that could be version-pinned to a compromised release.

The practical consequence is visible in the project's velocity. Each of the forty-two PRs is 200-400 lines. Each has its own unit tests — 24 for webhooks, 18 for oEmbed, 16 for platform sentiment, 14 for archetype analytics. Each reads the same simulation data directory and reuses the same stance-threshold constants. A new contributor can read any single surface file and understand it completely without tracing imports through a dependency graph. The codebase stays flat because there is no framework to build layers on top of.

## The Contrarian Bet

The prevailing assumption in AI development is that serious projects need serious stacks: LangChain for orchestration, FastAPI for serving, SQLAlchemy for persistence, Celery for task queues, Redis for caching, Docker images measured in gigabytes. The assumption is so deep that "production-ready" has become synonymous with "properly dependency-managed" — as if the quality of a project's lock file determines its maturity.

MiroShark's forty-two-PR streak suggests the opposite conclusion. A project that adds thirty-four integration surfaces without adding a single dependency is not under-engineered. It is engineered against a threat model that the rest of the industry is still learning to take seriously. When LiteLLM's Trivy dependency became a weapon, when TanStack's cache became a credential harvester, when one in five OpenClaw skills turned out to be malicious — the lesson was not that those projects needed better dependency management. The lesson was that every dependency is a door you chose to install in your building, and every door is a door someone else can walk through.

The safest door is the one that does not exist.

---
*Sources: [LiteLLM PyPI Supply Chain Attack (InfoQ, March 2026)](https://www.infoq.com/news/2026/03/litellm-supply-chain-attack/) · [TanStack Supply Chain Attack Hits Two OpenAI Employee Devices (The Hacker News, May 2026)](https://thehackernews.com/2026/05/tanstack-supply-chain-attack-hits-two.html) · [JFrog Report: AI Governance Fails as Software Supply Chain Attacks Hit Record Highs (BusinessWire, May 2026)](https://www.businesswire.com/news/home/20260520126325/en/New-JFrog-Report-Warns-AI-Governance-Fails-as-Software-Supply-Chain-Attacks-Hit-Record-Highs) · [Machine Learning Systems are Bloated and Vulnerable (Carnegie Mellon / arxiv)](https://arxiv.org/pdf/2212.09437) · [The Rise of Zero-Dependency Powerhouses (Dawid Prus, Medium, 2026)](https://medium.com/@zfoq/the-rise-of-zero-dependency-powerhouses-and-why-they-matter-more-in-the-age-of-ai-7baecaae3d8a) · [MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)*
