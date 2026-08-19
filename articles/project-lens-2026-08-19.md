# LiteLLM Had Three Million Downloads a Day. Then Someone Else Logged In.

On March 26, 2026, security researchers at Zscaler's ThreatLabz disclosed that someone had stolen the PyPI publishing credentials for LiteLLM, a Python library used by AI developers to route calls across language models. The library was downloaded roughly 3.4 million times per day. The attackers — a group tracked as TeamPCP — used the stolen credentials to publish two malicious versions, 1.82.7 and 1.82.8, that were virtually indistinguishable from legitimate releases. The payload was designed to harvest AWS, GCP, and Azure tokens, SSH keys, and Kubernetes credentials. Because the malicious code was published with the real maintainer's credentials, it passed pip's hash verification and every standard integrity check.

The poisoned versions were live for about three hours before PyPI quarantined them. Three hours, 3.4 million downloads per day. Do the math and move on, because LiteLLM was not an anomaly. It was a data point in a trend that has stopped looking like a trend and started looking like the weather.

## The Year the Supply Chain Became the Attack Surface

In the first half of 2026 alone, researchers at Phoenix Security documented 37 supply chain campaigns distributing 497 malicious packages — 4.5 times the total package volume of all of 2025. May set a record: 14 campaigns and 346 poisoned packages in 31 days, more than the previous four months combined. Across all 59 campaigns tracked since mid-2024, the number of CVEs assigned during active exploitation was zero. Every single one. The detection infrastructure that most organizations rely on — CVE feeds, vulnerability scanners, SCA tools — was blind to 100 percent of documented campaigns while they were happening.

The numbers compound. ReversingLabs reported a 73 percent year-over-year increase in malicious open-source package detections in 2025. Sonatype counted 454,600 new malicious packages that year, bringing the cumulative total past 1.2 million. The IBM 2025 Cost of a Data Breach report found that a supply chain compromise now costs $4.91 million on average and takes 267 days to identify and contain — the longest lifecycle of any breach vector they track.

And here is the detail that makes the rest of the statistics load-bearing: 95 percent of vulnerabilities are found in transitive dependencies, not the packages a project deliberately chose to install. The danger is not in the library you evaluated and selected. It is in the library that library depends on, three levels down, maintained by someone you have never heard of and cannot contact.

## One Project Built Forty-One Services Without Installing Anything

MiroShark is an open-source simulation engine — drop in a scenario, and it spawns a hundred AI agents to argue about it across simulated social platforms. The core simulation needs external dependencies: OpenAI's SDK for agent cognition, Neo4j for knowledge graphs, httpx for HTTP calls. Those are deliberate choices with understood trade-offs.

But layered on top of the simulation engine are forty-one analytical services that process, index, and expose the results. Belief drift charts. Confidence trajectories that track how agent convictions shift across deliberation rounds. Stance flip reports. Cross-platform sentiment divergence. A mention network mapping who influenced whom. Full-text search. A pre-run cost estimator built from historical simulation data.

Every one of these services is written in pure Python standard library. Zero pip packages. Zero transitive dependencies. The modules import `json`, `os`, `re`, `pathlib`, `datetime`, `hashlib`. They implement their own file scanning, their own mtime-based caching, their own response serialization. Each service typically runs 120 to 270 lines of code — compact enough to audit in a sitting, self-contained enough that nothing outside the Python runtime can break them.

This is not accidental minimalism. It is an architectural decision with a specific consequence: the analytical layer of MiroShark has no supply chain.

## The Firewall That Proved Itself

On August 12, OpenAI published version 3.0 of its Python SDK, which swapped its HTTP transport from `httpx` to `httpx2`. MiroShark's `oracle_seed.py` imported `httpx` directly but had never declared it as a dependency — it arrived as a transitive passenger through the OpenAI SDK. When the SDK dropped `httpx`, the import failed silently. A test broke. CI went red. The five-line fix — declaring the dependency explicitly in `requirements.txt` — merged within an hour.

The core engine broke from a transitive dependency change. But the forty-one analytical services were untouched. They could not be affected by the httpx migration, or by the LiteLLM credential theft, or by any of the 497 malicious packages published in the first half of 2026, because they do not participate in the dependency graph. The Python standard library ships with the runtime. It does not get compromised by a stolen PyPI credential. It does not silently swap out a transport layer in a minor version bump. It does not appear in a Sonatype report.

The httpx incident was a small, fast, well-handled failure. It was also a live demonstration that the architectural decision to build the analytical layer without dependencies was not theoretical caution. It was a firewall, and it held.

## The Trade-Off Most Projects Refuse to Make

Building with the standard library means writing more code. You implement your own JSON response formatting instead of importing Flask-JSONIFY. You write your own file-scanning logic instead of pulling in watchdog. You roll your own caching with mtime checks instead of reaching for cachetools. Each of MiroShark's forty-one services represents a choice to spend engineering time on code that a library could have provided in a single import.

In 2024, that choice looked conservative. In 2026, with 497 poisoned packages in six months and an average breach lifecycle of 267 days, it looks like foresight. The cost of writing 200 lines of stdlib Python is a few hours of work. The cost of a supply chain compromise is $4.91 million and nine months of your security team's attention. The safest dependency is the one you never installed.

This does not mean every project should abandon pip. MiroShark's simulation engine uses external packages because it must — you cannot talk to OpenAI's API or Neo4j's graph database with the standard library alone. The insight is narrower and more actionable: for the analytical, observational, and data-processing layers that sit downstream of your core logic, the standard library is almost always sufficient. And in 2026, sufficient is a security posture.

---
*Sources: [Zscaler ThreatLabz — LiteLLM Supply Chain Attack](https://www.zscaler.com/blogs/security-research/supply-chain-attacks-surge-march-2026), [Phoenix Security — Supply Chain Attacks 2024–2026](https://phoenix.security/accelerating-supply-chain-attacks-npm-pypi-vsx-ai-enabled-2026/), [ReversingLabs — 73% Rise in Malicious Open Source](https://www.reversinglabs.com/press-releases/reversinglabs-2026-software-supply-chain-security-report-identifies-73-increase-in-malicious-open-source-packages), [AppSec Santa — Supply Chain Attack Statistics 2026](https://appsecsanta.com/research/supply-chain-attack-statistics), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
