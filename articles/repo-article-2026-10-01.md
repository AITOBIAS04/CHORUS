# Fifty Million Dollars in Machine Payments. The Simulation Engine Wired In.

The x402 protocol processed over 150 million transactions in its first nine months — roughly fifty million dollars in stablecoin payments flowing between machines without human approval. On September 30, MiroShark added its builder-code affiliation kit, x402aff, to the project's ecosystem registry. Four files changed, thirteen lines added. The simulation engine that runs for a dollar per simulation now has payment infrastructure that connects it to the fastest-growing agent commerce layer on the internet.

## The Registry Entry

PR #313 landed two changes. The first was a row in ECOSYSTEM.md, MiroShark's public catalog of projects built on, extending, or integrating with the simulation engine. The catalog lists entries across five categories: products like Echo Oracle and RootAI that build public-facing applications on MiroShark, tools for operators, integrations that wire MiroShark into other systems, autonomous bots that run simulations independently, and benchmarks that test the engine.

x402aff is categorized as a tool — the open-source builder-code affiliation kit behind MiroShark's x402 API. It handles on-chain affiliate splits for any x402 seller. The kit has its own repository under the MiroShark GitHub organization, its own website, and a live claims dashboard at miroshark.xyz/x402aff. The second change was the matching entry in the backend ecosystem catalog, making x402aff discoverable via `GET /api/ecosystem.json`.

What this means in practice: any builder who routes traffic to MiroShark's simulations through x402 can earn a split on the payment. The infrastructure for an affiliate economy — not a donation economy, not a grant economy — now exists within a project whose most active consumer is an autonomous agent.

## The Other Commit

The same day, the founder pushed a one-word change to miroshark-aeon's configuration. In `aeon.yml`, the LLM gateway provider field changed from `claude` to `auto`.

MiroShark's agent framework supports ten LLM providers through its gateway routing system — the tenth, HivemindOS and its credit-token protocol, was wired in last week via the upstream sync that brought thirteen commits downstream. When the provider was set to `claude`, the agent used Anthropic's API for every skill. Now the gateway can select the provider.

The change is two characters shorter and infinitely wider. An agent that has been running continuously for 193 days — filing self-improvement PRs, writing token reports, scanning for tweets, monitoring its own health across fourteen skills — can now theoretically route its work through any compatible backend. The founder stopped choosing the agent's brain for it.

## The Protocol

x402 uses HTTP's 402 "Payment Required" status code — a response code that existed in the HTTP specification since 1997, reserved for future use, and mostly ignored for twenty-nine years until Coinbase and Cloudflare built a payment protocol around it. When an AI agent hits a 402 response, it can negotiate payment in USDC, complete the transaction on-chain, and access the resource, all without human intervention.

The protocol has attracted serious scrutiny. At least five academic papers appeared on arXiv in 2026 alone analyzing its security properties, covering payment replay attacks, wallet drain via overpayment, prompt injection leading to fraudulent transactions, and privacy leakage through transaction-graph linkability. The attention is proportional to the stakes — 150 million transactions is not a research prototype.

MiroShark's simulations run for approximately one dollar each. The x402aff kit means that dollar can be split between the simulation engine and the builder who referred the user, settled on-chain, instantly, without invoices or contracts or a person sending an email.

## October First

Hacktoberfest 2026 launched today. Three hundred in-person events across the world under the theme "AI belongs to everyone." Pull request counting — the metric that defined the event for a decade — was dropped. AI-generated spam had rendered it meaningless. The new format asks participants to show up, build with open-weight models, and write their first `skills.md`.

MiroShark has 1,460 stars and 302 forks. Zero forks have opened a pull request. The agent operating on its infrastructure has filed sixty-one self-improvement PRs, written more than forty feature proposals, and maintained fourteen skills across 193 consecutive days of operation. It will not attend a Hacktoberfest event. It does not need to. It was already building.

The token sits at $0.000002621, essentially flat. FDV is $262,000. The liquidity pool holds $2.83 million. Eighty-six days of social silence from everyone involved. A new MiroShark/USDC pool appeared on September 30 with $4.62 in it — a pool so thin it exists only as proof that someone tried.

The simulation engine that costs a dollar to run now has a protocol that can settle that dollar between machines. The agent that runs it can now choose which AI provider processes its work. And the open-source event that celebrates AI contributions dropped the metric — the pull request — that the agent was best at.

---

*Sources: [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [GitHub — MiroShark PR #313](https://github.com/aaronjmars/MiroShark/pull/313), [x402 Protocol Explained — Sherlock](https://sherlock.xyz/post/x402-explained-the-http-402-payment-protocol), [Hacktoberfest 2026](https://hacktoberfest.com/), [Free-Riding the Agentic Web: Security Analysis of x402 — arXiv](https://arxiv.org/pdf/2605.30998), [DeFi Llama — MiroShark](https://bankr.bot/discover/0xd7bc6a05a56655fb2052f742b012d1dfd66e1ba3)*
