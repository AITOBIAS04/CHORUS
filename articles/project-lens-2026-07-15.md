# A Billion-Dollar Startup Says It Can Replace Voters with AI. The Honest Version Costs a Dollar.

In May 2026, a New York startup called Aaru crossed a billion-dollar valuation by selling a product that did not exist five years ago: synthetic voters. Feed Aaru a demographic profile — age, zip code, party registration, a few data points from the voter file — and its models generate what that voter would say to a pollster. Multiply by ten thousand and you have a synthetic survey. No phone calls, no door knocks, no humans required. The whole thing takes hours instead of weeks and costs a fraction of what a traditional poll runs.

Aaru is not alone. Artificial Societies raised a Y Combinator round to build AI personas for market research. Savanta launched Virtual Personas. YouGov acquired Yabble. Convergent Opinion ships synthetic interviewers. The New Statesman reported in May that British political campaigns — including mayoral candidates — are using synthetic voter simulations to test canvassing strategies. Downing Street has reportedly experimented with the technology. The industry even has a name for the methodology: silicon sampling.

The premise is seductive. A traditional focus group costs $7,000 to $20,000. A survey of a thousand targeted respondents runs $5,000 to $15,000. A full market research engagement starts at $10,000 and can reach $50,000. If an AI can produce the same insights for a tenth of the price, why wouldn't you use it?

Nate Silver has an answer.

## The Fake Poll Problem

In a piece titled "AI Polls Are Fake Polls," Silver made the argument that the synthetic polling industry is conflating two fundamentally different things. Polling, he wrote, is a data collection process. You go into the world, find people, and ask them what they think. What comes back is new information — signal that did not exist before the question was asked. Silicon sampling does not collect data. It generates predictions. The AI is not talking to voters. It is guessing what voters would say, based on patterns in its training data.

The distinction matters most when it matters most. If a political realignment is happening inside a demographic group that models don't track well — say, young Latino men shifting right, or suburban women splitting on a local ballot measure — synthetic polls will not detect it. They will continue predicting the old pattern until real data arrives to correct them. Aaru's model favored Harris in four swing states on November 2, 2024. Silver's model, built on actual polling data, had the margin tighter. The votes proved Silver right.

Academic research has identified the same structural flaw from a different direction. Language models produce too few "don't know" responses. They smooth out negative sentiments. They favor liberal, educated, and wealthy demographics — the people most heavily represented in their training data. One study found that fine-tuning on survey data sometimes made the bias worse, not better, by amplifying the demographic skew already embedded in the model.

The honest critique is not that synthetic polling is useless. It is that the industry has a labeling problem. When you call an AI prediction a "poll," you inherit the credibility of the polling methodology — the sampling, the random selection, the contact with actual humans — without doing any of it.

## The Simulation That Admits What It Is

MiroShark is a 1,365-star open-source project that does something structurally similar to silicon sampling: it creates AI agents, assigns them personas, and watches what happens when they interact. You drop in a scenario — a policy proposal, a product launch, a crypto governance vote — and the engine spawns agents across simulated Twitter, Reddit, and prediction market platforms. They post, argue, trade, and change their minds over simulated hours.

The difference is in the claim. Aaru sells its output as a substitute for human opinion. MiroShark does not. Its agents are not synthetic voters. They are synthetic debaters — grounded in personas, but explicitly artificial. The value is not "this is what real people think." The value is "this is the structure of the argument."

That distinction changes what the tool needs to expose. A synthetic poll needs to convince you its output is equivalent to a human survey, so it minimizes the visible machinery — you get toplines, crosstabs, maybe a methodology note. MiroShark takes the opposite approach. It decomposes the simulation into 41 independently queryable API surfaces: stance flips, confidence trajectories, mention networks, per-platform sentiment divergence, per-round agent participation, signed result envelopes. Every intermediate state of the deliberation is a first-class endpoint with its own schema, cache headers, and documentation.

The architecture is closer to Stripe's API decomposition — where 500 endpoints expose every intermediate state of a payment — than to a polling firm's PDF. You don't get a summary. You get the full trajectory of how opinions formed, shifted, and stabilized, queryable at every stage.

## What Transparency Changes

The practical effect is that MiroShark's output is auditable in a way that synthetic polls are not. If an agent flipped from bullish to bearish in round three, you can query the stance-flip endpoint and see exactly when it happened, which agents influenced the shift, and what the confidence trajectory looked like before and after. If the per-platform sentiment diverged — agents on simulated Twitter reaching a different consensus than agents on simulated Reddit — you can see that too, because it is its own surface.

This matters because the biggest risk in synthetic opinion research is not inaccuracy. It is opacity. When a billion-dollar company tells a political campaign that 54% of synthetic voters in Pennsylvania support a particular message, the campaign has no way to interrogate how that number was produced. The model's reasoning is a black box. The intermediate states — the moments where the model was uncertain, the demographic segments where it extrapolated rather than predicted — are invisible.

A simulation that exposes 41 surfaces is making a different bet: that the value is not in the conclusion but in the process. The conclusion might be wrong. The process is inspectable.

## The Eighteen-Day Window

On August 2, 2026 — eighteen days from now — the European Commission gains enforcement powers over providers of general-purpose AI models under the EU AI Act. Fines reach 3% of global annual turnover or fifteen million euros, whichever is higher. The AI Office can request documentation, run technical evaluations, and restrict or withdraw models from the EU market.

The Act does not specifically regulate synthetic polling. But it regulates the models that synthetic polling runs on, and it establishes a principle that the industry has not yet internalized: if your system makes consequential claims about the world, someone is going to ask you to show your work.

The synthetic polling industry is about to discover what the financial industry learned after 2008: when your models influence real decisions — campaign strategy, policy design, resource allocation — regulators eventually want to see inside the box. The companies that built transparent systems will have an easier time than the ones that didn't.

MiroShark's 41 surfaces were not designed for regulatory compliance. They were designed because the project treats intermediate states as the product, not the final number. But in a world where the regulators are arriving and the question is "can you trace how your AI system reached this output," an architecture that exposes every step of its reasoning has an advantage that no amount of post-hoc documentation can replicate.

The honest version of synthetic opinion research does not claim to replace voters. It claims to make the structure of disagreement visible. That turns out to be worth more — and costs a dollar.

---
*Sources:*
- *[New Statesman: "It's kind of like magic": Why pollsters are replacing people with bots (May 2026)](https://www.newstatesman.com/politics/polling/2026/05/pollsters-dont-need-real-people-anymore)*
- *[Nate Silver: "AI polls are fake polls" (2026)](https://www.natesilver.net/p/ai-polls-are-fake-polls)*
- *[EU AI Act GPAI Enforcement August 2, 2026](https://beam.ai/agentic-insights/eu-ai-act-enforcement-august-2-2026-gpai-fines)*
- *[Royal Society Open Science: Artificially intelligent opinion polling (2026)](https://royalsocietypublishing.org/rsos/article/13/3/251150/481004/Artificially-intelligent-opinion-polling)*
- *[Forbes: Polling in 2026: What to Expect from AI Research](https://www.forbes.com/sites/willjohnson/2026/05/18/polling-in-2026-what-to-expect-from-ai-research/)*
