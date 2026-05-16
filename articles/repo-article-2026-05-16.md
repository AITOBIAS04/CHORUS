# The Simulation That Outlives Its Server

A simulation result is only as durable as the machine hosting it. Shut down the server, lose the domain, or fat-finger a database migration, and every conclusion drawn from the run disappears. MiroShark's latest commit changes that equation: simulation provenance now anchors to a decentralized knowledge graph that doesn't need MiroShark to exist.

## What's Running Right Now

MiroShark — 1,164 stars, 232 forks, 57 days old — is a multi-agent simulation engine where you drop in a document and hundreds of AI personas argue about it on simulated social platforms. The past seven days produced 10 commits on main, all from @aaronjmars, landing a density of infrastructure that would take most teams a quarter: OriginTrail DKG citation, Discord and Slack rich notifications, filtered RSS feeds, a search-engine sitemap, webhook HMAC signature verification, Jupyter notebook export, a simulation lineage navigator, trending gallery sort, and a model swap from Grok to Gemini Flash. One open PR — trajectory chart SVG rendering — sits in review.

The cadence is striking. Since early May, MiroShark has merged 10 consecutive PRs without adding a single new dependency. Every feature is pure stdlib Python and vanilla JavaScript.

## The DKG Commit

PR #84 — "OriginTrail DKG citation: on-chain provenance for finished sims" — is the one worth pausing on. Set two environment variables (`DKG_API_URL` and `DKG_AUTH_TOKEN`), and MiroShark's embed dialog grows a "Publish to DKG" button. One click anchors the scenario text, agent count, final consensus, quality score, lineage graph, and the SHA-256 hash of the reproduce.json file onto the OriginTrail Decentralized Knowledge Graph as a cryptographically verifiable Knowledge Asset.

What comes back is a UAL (Uniform Asset Locator), a Merkle root, and a transaction hash. That triple is a citation key that doesn't depend on MiroShark's uptime — or anyone's goodwill. The Knowledge Asset lives on OriginTrail's peer-to-peer network across NeuroWeb, Gnosis, and Base. If MiroShark goes dark tomorrow, the provenance record survives.

This matters because simulation results are notoriously ephemeral. Research teams run a model, screenshot the output, paste it into a slide deck, and the original run becomes unreproducible within weeks. MiroShark had already addressed part of this problem — `reproduce.json` (shipped in April) captures every parameter needed to rerun a simulation, and the Lineage Navigator (PR #76, merged May 9) traces fork-and-branch ancestry. But both of those artifacts live on MiroShark's own server. The DKG integration is the escape hatch: provenance that persists independent of the host.

## Why August 2026 Makes This Urgent

The EU AI Act's Annex III obligations take effect August 2, 2026. Article 12 requires high-risk AI systems to "technically allow for the automatic recording of events (logs) over the lifetime of the system." Article 19 sets a six-month minimum retention period. Non-compliance penalties run up to 15 million euros or 3% of worldwide annual turnover.

No finalized technical standard for Article 12 logging exists yet — two drafts (prEN 18229-1 and ISO/IEC DIS 24970) are in progress but neither is ratified. The regulatory clock is running ahead of the standards bodies.

MiroShark isn't a high-risk AI system under the Act's classification. But the pattern it demonstrates — cryptographic provenance, immutable logging, host-independent verification — is exactly the infrastructure that regulated AI operators will need in 77 days. A simulation engine that already publishes verifiable Knowledge Assets to a decentralized graph is a working prototype of what compliance teams are scrambling to design from scratch.

## The Distribution Stack Underneath

The DKG integration doesn't sit in isolation. Over the past two weeks, MiroShark has built what amounts to a full distribution stack for simulation results: RSS and Atom feeds with composable query filters (PR #81), a sitemaps.org-compliant XML sitemap (PR #82), Discord-native rich embeds and Slack Block Kit messages (PR #83), HMAC-signed webhooks (PR #79), and Jupyter notebook exports (PR #80). Each surface treats a finished simulation not as a ephemeral run but as a publishable, subscribable, citable, and now cryptographically permanent content artifact.

OriginTrail's own 2026 roadmap reinforces this direction. DKG V9 positions Knowledge Assets as the memory layer for multi-agent AI systems — agents publishing, querying, and verifying shared knowledge across a peer-to-peer network. MiroShark is one of the first non-OriginTrail projects to use that layer for something concrete: anchoring simulation provenance rather than supply chain or identity data.

## Why It Matters

The simulation tooling ecosystem — OASIS, AgentSociety, Concordia, and dozens of others — has no standard for result permanence. You run a simulation, you get output files. If the server goes away, the files go away. MiroShark's bet is that simulation results should be treated like scientific data: reproducible, citable, and verifiable long after the original experiment ends.

One commit doesn't make a standard. But 1,164 developers have now starred a project that ships cryptographic provenance alongside Discord webhooks and RSS feeds — treating permanence not as an enterprise add-on but as a checkbox in the same dialog where you copy a share link.

---

*Sources:*
- [MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)
- [OriginTrail DKG V9](https://github.com/OriginTrail/dkg-v9)
- [OriginTrail: Shared context graphs for AI agents](https://medium.com/origintrail/the-next-big-shift-in-ai-agents-shared-context-graphs-75584c38122e)
- [EU AI Act Article 12: Record-Keeping](https://artificialintelligenceact.eu/article/12/)
- [EU AI Act logging requirements for AI agents](https://www.helpnetsecurity.com/2026/04/16/eu-ai-act-logging-requirements/)
- [Framework for Cryptographic Verifiability of AI Pipelines](https://arxiv.org/html/2503.22573v1)
- [OriginTrail Network Growth in 2026](https://www.cryptonewsnavigator.com/academy/article/three-metrics-showing-origintrails-network-growth-in-2026)
