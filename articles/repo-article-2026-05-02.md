# When Simulation Becomes a Spectator Sport: MiroShark's Bet on Live AI

Forty-three days ago, MiroShark didn't exist. Today it sits at 977 GitHub stars with 197 forks, an open PR for a live spectator watch page, and a feature list that reads less like a simulation engine and more like a broadcast platform. The question MiroShark is answering has quietly shifted: it's no longer just *can you simulate anything for a dollar?* It's *will people watch?*

## The Numbers Tell a Story

MiroShark was created on March 20, 2026 as a cleaned-up English fork of MiroFish, the Chinese swarm intelligence engine that hit 33,000 stars and secured $4.1 million in funding within weeks of launch. Where MiroFish proved the concept — hundreds of AI agents arguing, trading, and shifting opinions across simulated social platforms — MiroShark has been quietly building the infrastructure to make those simulations *visible*.

The pace is startling. In the last seven days alone: 22 commits, covering full Chinese localization (PRs #61-65), RSS/Atom feeds (#60), belief trajectory CSV/JSONL export (#66), transcript export (#57), 57% token compaction (#55), Langfuse observability hooks (#51, #54), animated belief-replay GIFs (#50), a verified predictions ledger (#47), and an OpenAPI 3.1 spec with Swagger UI (#45). The repo is gaining roughly 30 stars per day. One thousand is days away, not weeks.

## Seven Ways to Watch

The feature that crystallizes MiroShark's direction is PR #67, opened May 2: a live spectator watch page at `/watch/<sim_id>`. It's the seventh distinct surface for experiencing a simulation, joining:

1. **The simulation runner** — the original interface where you configure and launch
2. **The public gallery** at `/explore` — a card grid of every published simulation
3. **Embeddable widgets** — iframe URLs for dropping simulations into external sites
4. **Social share cards** — 1200x630 PNGs that auto-unfurl on Twitter, Discord, Slack
5. **Animated belief-replay GIFs** — one frame per round, belief bars sliding in real time
6. **RSS/Atom feeds** — subscribe in Feedly, n8n, or Zapier without anyone curating the stream
7. **The spectator page** — a dedicated read-only view for watching a simulation unfold live

This is a distribution stack disguised as a feature list. Each surface solves a different consumption pattern: passive discovery (gallery, RSS), social proof (share cards, GIFs), integration (embeds, webhooks), and now real-time observation. MiroShark isn't just building a simulation engine. It's building an audience funnel.

## The Research Pipeline Underneath

What makes MiroShark more than a novelty is the parallel investment in research-grade export. The trajectory CSV/JSONL export (PR #66) lands data directly into pandas with `read_csv()`. The transcript export (PR #57) outputs per-round agent posts in structured JSON suitable for LLM-as-judge evaluation pipelines, or as Markdown with YAML front matter for Obsidian and Substack. The Jupyter Notebook export (code-complete, awaiting push) generates pre-written analysis cells with matplotlib belief drift charts, networkx interaction graphs, and summary statistics.

This dual investment — spectacle on one end, research tooling on the other — maps to a real split in who's using multi-agent simulation in 2026. On one side: researchers running controlled experiments on opinion dynamics, narrative competition, and prediction accuracy. On the other: communities that want to watch AI agents argue about whether a CEO should resign, and share the results on Discord. MiroShark is building for both, and the spectator page is the clearest signal yet that the second audience might be larger.

## Why It Matters Now

The broader multi-agent simulation space is crowding fast. OpenAI's Swarm framework remains educational-only. CAMEL-AI's OASIS (which powers MiroShark's engine) focuses on the research layer. Swarms.ai targets enterprise orchestration. ClawTeam automates development workflows. None of them are building share cards and spectator pages.

MiroShark's thesis is that simulation is a medium, not just a method. A completed simulation is content: it has characters, a narrative arc, stakes, and a resolution. The verified predictions ledger at `/verified` even provides accountability — you can check whether the swarm called it right. With completion webhooks wiring into Slack, Discord, Zapier, and n8n, a simulation finishing becomes an event that propagates across communication channels automatically.

At 977 stars and accelerating, MiroShark is 23 stars from a round-number milestone that tends to trigger its own momentum on GitHub's trending algorithm. But the more interesting threshold is structural: MiroShark has assembled enough distribution surfaces that simulations can now find audiences without anyone manually sharing them. RSS feeds, embeds, webhooks, and soon live spectator links — the content distributes itself.

The simulation engine was the hard part. Making people watch might turn out to be the easy part.

---

*Sources: [aaronjmars/MiroShark on GitHub](https://github.com/aaronjmars/MiroShark), [MiroFish: 17,000 GitHub Stars in Two Weeks](https://medium.com/@tbelbek/mirofish-17-000-github-stars-in-two-weeks-and-a-prediction-engine-that-actually-works-58ccacc0e5d7), [MiroFish: Open Source Swarm Intelligence Engine](https://dev.to/beitroot/mirofish-the-open-source-swarm-intelligence-engine-that-simulates-the-future-2h21), [@aaronjmars on X](https://x.com/aaronjmars/status/2036175623622660114), [Top Agentic AI Frameworks in 2026](https://aimultiple.com/agentic-frameworks)*
