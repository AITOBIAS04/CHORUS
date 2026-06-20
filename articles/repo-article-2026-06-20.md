# Five Billion People Don't Speak English. Most AI Agents Don't Either.

MiroShark just shipped something most AI projects never attempt: agents that think, argue, and post in the user's language — not a translation layer on top of English, but native multilingual reasoning inside the simulation itself.

## Four Languages in One Week

Between June 14 and June 20, MiroShark went from an English-first simulation engine with translated READMEs to a fully multilingual system across four languages. The scope of what shipped tells the story:

The UI already supported English, Chinese, and French. This week added German — not just interface strings but full agent-description and communication translations ([PR #189](https://github.com/aaronjmars/MiroShark/pull/189)). French prompt locales landed with a CI coverage gate to prevent regression ([PR #186](https://github.com/aaronjmars/MiroShark/pull/186)). A French README went live ([PR #185](https://github.com/aaronjmars/MiroShark/pull/185)). Generalized locale helpers replaced per-language hardcoding with a system that scales to any language ([PR #184](https://github.com/aaronjmars/MiroShark/pull/184)).

Then came the deepest change: a locale registry that wires every agent prompt through a language system with English constant fallback ([PR #194](https://github.com/aaronjmars/MiroShark/pull/194)). The agents themselves now produce output in the user's chosen language. When a German user runs a crisis simulation, the simulated Twitter accounts post in German. The Reddit threads argue in German. The final report reads in German.

MiroShark sits at 1,317 stars and 276 forks. Three open issues. Forty-one API surfaces. Four UI languages. And now, agents that speak all of them.

## The Engineering Problem Nobody Warns You About

Here is why most AI projects stop at translating the interface: non-English LLM output breaks things.

Stanford research found that over 90% of training data for major LLMs is English. Performance drops 3–7% in non-English languages during longer conversations. For underrepresented languages, accuracy can fall by 50%. The structural scarcity of non-English training data means models produce longer token sequences, more fragile JSON, and slower completions when working outside English.

MiroShark hit exactly these problems. PR [#188](https://github.com/aaronjmars/MiroShark/pull/188) raised suggest-scenarios timeout and token limits specifically for non-English and local LLMs — because German and French scenario generation was timing out before completion. PR [#191](https://github.com/aaronjmars/MiroShark/pull/191) and [#192](https://github.com/aaronjmars/MiroShark/pull/192) added JSON salvage logic for truncated suggest_scenarios output — because non-English models produce longer responses that hit token ceilings and emit broken JSON.

These are not exotic edge cases. They are the default experience for anyone running a multilingual LLM application at scale. The multilingual LLM market is projected to grow from $6.49 billion in 2026 to $57 billion by 2035, but most of that growth will collide with exactly these failure modes. Few projects are solving them yet.

## A Community Contributor Built the Architecture

The most telling detail: the locale registry — the piece that makes agents multilingual — was not built by MiroShark's maintainer. It was built by Daniel Andersen, a community contributor who also shipped the German translation and the SearXNG/Firecrawl integration that lets any LLM (including local Ollama models) ground agent research with live web results.

Andersen has shipped six merged PRs since June 14: same-origin API and Neo4j 5.26 bump ([#159](https://github.com/aaronjmars/MiroShark/pull/159)), SearXNG/Firecrawl ([#178](https://github.com/aaronjmars/MiroShark/pull/178)), non-English LLM timeout fixes ([#188](https://github.com/aaronjmars/MiroShark/pull/188)), German translation ([#189](https://github.com/aaronjmars/MiroShark/pull/189)), and the locale registry ([#194](https://github.com/aaronjmars/MiroShark/pull/194)). This is not peripheral contribution — it is core infrastructure that changes how the engine works.

The expanded [CONTRIBUTING.md](https://github.com/aaronjmars/MiroShark/blob/main/CONTRIBUTING.md) that shipped June 14, with full setup instructions, PR conventions, and an API endpoint tutorial, appears to be doing what it was designed to do: turning interested developers into core contributors.

## Why It Matters

Five billion people worldwide do not speak English. Stanford's research calls this AI's digital divide — entire communities excluded from the AI revolution because the tools were not built for them. As the global AI agents market crosses $10.9 billion in 2026, with 80% of Fortune 500 companies running active agents, the gap between English-language AI capability and everything else is becoming a structural economic inequality.

Most projects respond by translating the interface and calling it done. The agent prompts stay English. The reasoning stays English. The output gets run through a translation API as an afterthought. MiroShark took the harder path: make the agents native speakers. The timeout fixes, the JSON salvage, the locale registry with fallback — that is the engineering tax for doing it properly. And the fact that a community contributor built the hardest piece suggests the project has reached the kind of maturity where outside developers trust it enough to invest serious work.

Simulate anything, for $1, in your language. That last part is new, and it changes who the tool is for.

---
*Sources: [Stanford HAI — How AI is leaving non-English speakers behind](https://news.stanford.edu/stories/2025/05/digital-divide-ai-llms-exclusion-non-english-speakers-research), [Precedence Research — Multilingual LLM Market](https://www.precedenceresearch.com/multilingual-llm-market), [LILT — Why LLM Performance Drops in Non-English Languages](https://lilt.com/blog/multilingual-llm-performance-gap-analysis), [Aisera — Multilingual AI Agents 2026](https://aisera.com/blog/multilingual-ai-agent/), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
