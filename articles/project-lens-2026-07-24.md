# Your Software Has a Thousand Authors You Have Never Met. That Is the Vulnerability Nobody Patches.

On March 31, 2026, a North Korean hacking group published two versions of Axios — the most popular HTTP client in the JavaScript ecosystem, installed over a hundred million times per week. They had compromised the lead maintainer's npm account. But they did not change a single line of Axios source code. Instead, they added one new entry to the package's dependency list: a package called `plain-crypto-js`, version 4.2.1. That package contained a cross-platform Remote Access Trojan capable of harvesting SSH keys, credentials, and environment variables from every machine that ran `npm install`.

The compromised versions were live for three hours. Microsoft attributed the attack to Sapphire Sleet. Google published a threat intelligence report. Snyk, Orca Security, Huntress, and Trend Micro all issued advisories. The industry mobilized. The breach was contained.

But the question the incident left behind is not about North Korea. It is about the architecture that made the attack possible in the first place.

## The Thousand-Stranger Problem

A modern React application has between 800 and 1,200 transitive dependencies. A Next.js project starts above 1,000 before a single line of application code is written. Each dependency is, functionally, a co-author of your software — a person or team you have never met, whose code runs with the same permissions as your own, whose publishing credentials are a single compromised password away from becoming an attack vector.

The ReversingLabs 2026 Software Supply Chain Security Report found a 73 percent year-over-year increase in malicious packages across npm, PyPI, and other registries — up from 49 percent in 2025 and 28 percent in 2024. The growth rate of malicious packages now exceeds the growth rate of the registries themselves. Attackers publish thousands of low-profile malicious packages daily. The risk is not linear. It is combinatorial. Every dependency you add multiplies the number of strangers who can ship code into your production environment.

The Axios attack was notable because the target was large. But the mechanism — a phantom dependency injected through a compromised maintainer account — works on any package, at any scale. The attacker's innovation was not technical sophistication. It was patience: they published a clean version of `plain-crypto-js` eighteen hours before the malicious one, giving it just enough registry history to bypass automated new-package detection.

## Forty-One Services, Zero Additional Dependencies

[MiroShark](https://github.com/aaronjmars/MiroShark), a 1,416-star open-source simulation engine, made an architectural decision that looks unremarkable until you understand what it prevents. The project has a standard backend — Flask, OpenAI SDK, Neo4j driver — but the forty-one API surfaces that make up its analytical layer are each built using only Python's standard library. No additional pip packages. No transitive dependencies. No strangers.

The stance flip service — 246 lines of code that tracks how simulated agents change positions during a deliberation — uses `json`, `os`, `re`, and `time`. The mention network service — 270 lines that extracts and graphs who references whom — uses the same set. The full-text search service, the confidence trajectory tracker, the platform sentiment analyzer, the signed result generator: each one is a self-contained module that imports nothing beyond what ships with Python itself.

This is not a trivial constraint. It means writing your own mtime-based caching instead of importing `cachetools`. It means parsing JSON with the stdlib `json` module instead of `orjson`. It means building HTTP response objects by hand instead of pulling in a utility library. Every service requires more code than the dependency-laden alternative. The median service runs about 250 lines. A developer using third-party libraries could likely write each one in 80.

But each of those saved lines would be a door. And every door has a lock that someone else holds the key to.

## The Research Catches Up

In May 2026, researchers Peng Ding and Rick Stevens published a paper on arXiv titled "Stdlib or Third-Party? Empirical Performance and Correctness of LLM-Assisted Zero-Dependency Python Libraries." They evaluated over forty modules across twelve categories — serialization, networking, cryptography, agent protocols, text processing — and found that stdlib-only implementations achieved performance parity with their third-party equivalents in the majority of cases. In several categories, the stdlib versions were five to 115 times faster, because they avoided the architectural overhead that monolithic libraries accumulate over years of feature accretion.

The primary performance cliff was C-extension-backed computation: image processing, binary serialization, low-level cryptography. For everything else — the kind of data wrangling, caching, text parsing, and JSON manipulation that makes up the analytical layer of a web application — the standard library was not a compromise. It was competitive.

The paper's framing was academic. But its implication is architectural: the dependency tax most projects pay is not buying performance. It is buying convenience. And that convenience has a price denominated in trust — trust in maintainers you have never met, publishing pipelines you have never audited, and transitive dependency trees you have never read.

## The Dependency Decision as a Design Decision

MiroShark's forty-one pure-stdlib services will never appear in a supply chain advisory. They cannot be compromised by a maintainer account takeover because there is no maintainer to compromise. They cannot introduce a phantom dependency because there are no dependencies to phantom. The attack surface of each service is bounded by the Python language specification itself — maintained by a foundation, audited by thousands, and shipped with every Python installation on earth.

This is not a universal prescription. Flask still runs the web server. The OpenAI SDK still handles LLM calls. Some dependencies are load-bearing and worth the trust. The decision MiroShark made was not to eliminate all dependencies. It was to draw a line: the core framework gets external libraries; the analytical surface — the forty-one services that touch simulation data, compute results, and serve them to users — gets none.

In a year when a hundred million weekly installs turned into a North Korean espionage tool in three hours, the architectural choice to write 250 lines instead of importing a package is not perfectionism. It is threat modeling.

---
*Sources: [Axios npm Supply Chain Attack — Google Cloud Threat Intelligence](https://cloud.google.com/blog/topics/threat-intelligence/north-korea-threat-actor-targets-axios-npm-package); [Microsoft Security Blog — Axios Compromise Mitigation](https://www.microsoft.com/en-us/security/blog/2026/04/01/mitigating-the-axios-npm-supply-chain-compromise/); [ReversingLabs 2026 Supply Chain Report — 73% Malicious Package Surge](https://pulse.adyog.com/insights/malicious-npm-packages-73-percent-surge); [Ding & Stevens, "Stdlib or Third-Party?" arXiv 2605.21405 (May 2026)](https://arxiv.org/abs/2605.21405); [GitHub MiroShark](https://github.com/aaronjmars/MiroShark)*
