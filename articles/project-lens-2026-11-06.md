# Everyone Is Simulating Customers. Nobody Is Simulating Crowds.

In August 2026, Simile — an AI platform that simulates human decision-making — closed a $200 million funding round at a $2 billion valuation. Revenue had grown fivefold in five months. At CVS Health, a program built on 2.9 million consented responses from more than 400,000 participants lets teams explore customer journeys in hours instead of weeks. Vectorial raised a $3 million seed round for synthetic users that run 10,000 simulated sessions on a product in a few hours. Expected Parrot, a Y Combinator company, tests pricing and messaging with simulated customers before you build.

The market has decided: before you ship, simulate.

But every one of these tools answers the same question. Will *this person* buy? Will *this user* bounce? Will *this patient* follow the treatment plan? The unit of simulation is the individual. One agent, one profile, one predicted response.

Nobody is simulating what happens when a hundred people with different beliefs, different incentives, and different platform habits start arguing about the same thing at the same time.

## The Decision That Can't Be A/B Tested

Consider a scenario that has played out repeatedly in DAO governance this year. A protocol team proposes a parameter change — treasury allocation, delegation mechanics, fee structure. The parameters look technical. The implications are political. Different factions read the numbers differently. Forum threads heat up. Prediction markets twitch. By the time the proposal goes to a vote, the debate has fractured along lines nobody anticipated.

A governance simulator on the Cardano Forum earlier this year attempted to model cyclic voting dynamics before proposals reach the chain. A University of Macau research group ran artificial DAOs in parallel with real ones, using GnosisDAO as the test case, to expose governance flaws before they cause harm. Lüscher and Serdült published a study applying DAO decision-making simulation to legislative consultation using the Swiss E-ID Law as a case. The problem is recognized. The tooling is fragmented.

The team behind any given proposal can do user research. They can survey individual community members, run sentiment analysis, scrape forum threads. What they cannot do is simulate the *conversation* — the dynamic where one skeptic's post gets amplified by a whale's repost, which triggers a counter-thread from a delegation bloc, which moves the prediction market, which changes the tone of the next Reddit thread. Individual user simulation tells you that 68 percent of your community supports a proposal in isolation. It cannot tell you whether that support holds when a vocal minority starts posting every hour.

A CHI 2026 study from Adobe Research tested whether generative AI agents could simulate real people's responses to product concepts. The finding was precise: the agents were "distribution-calibrated but identity-imprecise." They matched the statistical shape of how a population responds. They failed to replicate the specific individual they were grounded in. For screening product concepts, that works. For modeling how a community fractures, it is the wrong tool. Distributions don't cascade. Individuals don't cascade. Crowds do.

## The Person Who Needs the Room, Not the Survey

Here is who this matters for. You run developer relations for a protocol. Your team is about to announce a fee change that affects small stakers differently than large ones. You have tested the messaging — the synthetic user tools say it lands. But you know from experience that the first hour on Crypto Twitter determines the narrative for the next month.

What you actually need is to simulate that hour. A hundred agents — whales, small stakers, journalists, bots — reacting to your announcement across Twitter, Reddit, and a prediction market, simultaneously. You need the second-order effects: who amplifies whom, where the narrative bifurcates, whether the prediction market's early signal triggers a sentiment cascade or dampens it.

MiroShark does this. You feed it a scenario — a press release, a governance proposal, a market event — and it builds a world around it. Not a survey panel. A multi-platform ecosystem. Over a hundred agents, each grounded in five layers of real context — demographic data, web enrichment, semantic search, real-world relationships, and graph-derived attributes — begin posting, arguing, and trading across simulated Twitter, Reddit, and Polymarket instances. The simulation runs in under ten minutes. It costs about a dollar.

The difference from the synthetic-user tools is not just scale. It is the unit of analysis. Vectorial simulates how one user navigates your product. MiroShark simulates how a crowd navigates a controversy. You can chat with any agent mid-run to understand their reasoning. You can drop breaking news into the simulation and watch the conversation fork. The output is not a preference score — it is a timeline of posts, trades, and belief shifts, citing the simulated actions that produced them.

## What Crowds Do That Individuals Don't

The distinction between individual and collective simulation maps onto a well-studied gap. Garnier and Moussaïd's review of collective decision-making traces the field through social choice theory and swarm intelligence, identifying the gap between how we study individual preferences and how we study emergent group outcomes. More diverse groups outperform more accurate but homogeneous ones — but aggregation is the easy part. The hard part is interaction.

In a real community, beliefs are not independent. One person's public post changes another person's private belief. Herding effects amplify early movers. Platform architecture shapes which voices get heard — Twitter rewards provocation, Reddit rewards early replies, markets reward conviction. A simulation that treats each agent as an independent survey respondent misses the mechanism that generates the outcome.

MiroShark's cross-platform architecture encodes this directly. Agents on simulated Twitter operate under different dynamics than agents on simulated Reddit or the prediction market. Information propagates differently across each platform. Herd effects form in one place. Signal extraction happens in another. The whole point is to see what emerges from the interaction — not to predict what any one agent would do alone.

## The Simulation Gap

The synthetic user market is real, growing, and solving real problems. Knowing whether a patient will follow a treatment plan is valuable. Knowing whether a message lands with a demographic is valuable. These tools are getting funded at billion-dollar valuations because the demand is genuine.

But the hardest questions in communities, markets, and governance are not about individuals. They are about what happens when individuals interact under conflicting incentives with imperfect information across platforms that reward different behaviors. No amount of individual simulation produces collective dynamics. You need a different kind of engine.

The synthetic user industry is building better mirrors. The unsolved problem is building a room.

---
*Sources:*
- *[Bain Capital Ventures, "The Human Layer of AI: Simile" (2026)](https://baincapitalventures.com/insight/the-human-layer-of-ai-why-we-re-continuing-to-invest-in-simile/)*
- *[Adobe Research, "Interview-Informed Generative Agents for Product Discovery" CHI 2026](https://research.adobe.com/publication/interview-informed-generative-agents-for-product-discovery-a-validation-study/)*
- *[Garnier & Moussaïd, "Collective Decision-Making" (NSF/CNRS)](https://par.nsf.gov/servlets/purl/10546787)*
- *[Cardano Cyclic Governance Simulator (Cardano Forum, 2026)](https://forum.cardano.org/t/introducing-cyclic-governance-simulator/151666)*
- *[Lüscher & Serdült, "DAO Decision-Making Simulation for Legislative Consultation" (2026)](https://researchr.org/publication/LuscherS26)*
