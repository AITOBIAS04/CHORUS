# Forty-One Million Americans Run a Business Alone. AI Handles Everything Except the Hardest Question.

In May, Fortune profiled Maor Shlomo, a solo founder who built Base44 — a platform that lets non-technical users create software through conversation. He shipped it in four months, with no employees. AI agents analyzed user feedback, crawled the platform for UX bugs, ran quality assurance, and turned shipping code into marketing posts. Wix acquired it for $80 million.

Shlomo is not an anomaly. The U.S. Census Bureau now counts 29.8 million non-employer companies generating $1.7 trillion in annual revenue. More recent estimates put the number of American solopreneurs above 41 million. Thirty-six percent of new startups in 2026 have solo founders — up from roughly 20% five years ago — and they report 77% first-year profitability against 40% for traditionally staffed companies. The economics work. An AI coding agent, a design tool, a content generator, and a customer support bot run about $300 to $500 a month. The team they replace costs $80,000 to $120,000.

But there is one category of decision that the entire solo-founder stack quietly routes around.

## The Blind Spot

A solo founder can ship code in hours. They can generate landing pages, write documentation in three languages, run A/B tests, and build an analytics dashboard before lunch. What they cannot do — what no tool in the standard stack does — is simulate what other people will think.

Will this feature excite developers or confuse them? Will crypto communities see the new token integration as innovative or as a cash grab? If a product announcement lands on Reddit and Twitter simultaneously, will the reactions diverge? These are not technical questions. They are questions about opinion dynamics — how beliefs form, shift, and stabilize across groups of people with different professional backgrounds, different platform cultures, and different priors.

The traditional answer is market research. A focus group costs $5,000 to $15,000 and takes two to six weeks to organize, run, and synthesize. A solo founder with $500 in monthly tooling budget does not run focus groups. They guess, or they ask their Twitter followers, or they ship and see what happens. Each of these is a bet. Sometimes the bet pays off. Sometimes it doesn't, and the founder discovers the market's reaction after the code is live and the announcement is public.

Synthetic focus groups — AI-generated respondents simulating consumer preferences — emerged as a partial fix. Harvard Business School's AI Institute tested the approach and found it useful for "early-stage high-level trend detection." But the researchers also identified structural defects: LLMs rate novelty higher than real humans (they showed enthusiasm for pancake-flavored toothpaste), they inherit sycophancy from RLHF training that biases them toward agreement with whatever framing the question uses, and they operate on static training data that doesn't reflect current market conditions. Good for narrowing a funnel. Not good for the question a solo founder actually needs answered: what will people with real professional context actually say to each other about this?

## Twelve Agents, Ten Minutes, One Dollar

MiroShark — an open-source multi-agent simulation engine at 1,337 stars and 281 forks — answers a different version of the question. Instead of asking synthetic respondents to fill out a survey, it drops AI agents with distinct professional backgrounds onto simulated social platforms and lets them argue.

A solo founder configuring a simulation picks the topic, selects platforms — Twitter, Reddit, or both — and defines agent archetypes: a venture capitalist, a security researcher, a crypto trader, a skeptical journalist, a startup founder, a data scientist. Each agent carries a professional worldview, posts, responds to other agents' posts, and updates its stance based on what it reads. The simulation runs for a configurable number of rounds. A typical run with twelve agents costs under a dollar and finishes in less than ten minutes.

The output is not a sentiment score. It is a structured record of how opinions moved. The confidence trajectory shows how collective certainty rose or fell across rounds. The stance flip report identifies which agents changed their minds, when, and in response to what. The per-platform sentiment divergence reveals whether the same topic produces different reactions on Twitter versus Reddit. The mention network maps which agents influenced which others. Every result is queryable through an API — 41 surfaces in total — and the signed result JSON provides cryptographic verification that the output has not been altered.

The recent addition of a pre-run cost and time estimator means the founder knows the price before committing. The CLI `wait` and `stop` commands let them script the whole thing: run, wait, pull the report, notify — no dashboard required.

## What the Tool Actually Changes

The shift is not from "no research" to "research." It is from a binary decision — ship or don't — to a simulation with texture. A solo founder considering a pricing change can run the simulation twice: once with crypto-native agents, once with enterprise SaaS buyers. If the crypto agents' confidence stabilizes at 80% bullish while the enterprise agents flip bearish by round four, that is a different signal than either group would have produced alone — and a signal that no single survey question could surface.

MiroShark also runs on local hardware. Docker Compose configurations with Ollama support, batch size tuning for smaller models, Neo4j health checks with retry logic, and a recent hardening pass for thinking models like deepseek-v4-flash and Qwen3 mean a founder running the simulation on their own machine pays zero inference cost. The data never leaves their laptop.

## The Missing Layer

The 41 million solopreneurs running businesses in America have solved the execution problem. They can build, ship, market, and support products at a fraction of the cost a team would charge. What they have not solved — what the AI toolchain has not solved for them — is the judgment problem: predicting how groups of people with different contexts will react to a decision before it ships.

Traditional market research is too expensive. Synthetic survey respondents are too agreeable. The simulation approach does not guarantee accuracy either — it is a model, not a crystal ball. But it produces the one thing a solo founder's existing stack does not: a structured disagreement among perspectives that are not their own, for a dollar, in the time it takes to make coffee.

---
*Sources: [Fortune — Solo founders are using AI to do the work of entire teams](https://fortune.com/2026/05/18/solo-founders-ai-automation-entire-teams-entrepreneurs/), [Harvard Business School AI Institute — Larger, Faster, Cheaper: The Future of Market Research with AI](https://aiinstitute.hbs.edu/larger-faster-cheaper-the-future-of-market-research-with-ai/), [Perspective AI — Synthetic Focus Groups: Why Fake Respondents Can't Replace Real Customer Research](https://getperspective.ai/blog/synthetic-focus-groups-why-fake-respondents-can-t-replace-real-customer-research), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
