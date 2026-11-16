# Prediction Markets Know What the Crowd Will Do. They Don't Know Why.

In April 2026, combined monthly trading volume on Kalshi and Polymarket reached $24 billion. For comparison, the entire U.S. legal sportsbook industry averaged $14 billion a month in 2025. By any measure, prediction markets have crossed from curiosity to infrastructure. Pew Research found that sports, politics, and cryptocurrency now sustain a continuous volume that dwarfs all prior-year totals. The Trump administration backs federal oversight. State attorneys general fight to regulate them as gambling. The CFTC issued emergency orders. Something that began as an academic argument about the wisdom of crowds became, in the space of two years, a regulated financial market with billions at stake every week.

The pitch is elegant: put real money behind real beliefs and let the price discover the truth. The result is a single number — the market's current consensus probability — updated continuously by the collective self-interest of every participant. On binary questions with clear resolution criteria, it works. Prediction markets consistently match or beat expert panels, polls, and editorial judgment. That much is settled.

What is less settled is what happens when you need more than a number.

## The Number and Its Limits

A Polymarket contract resolving at 72 cents tells you the crowd thinks an event has a 72 percent chance of happening. It does not tell you why. It does not tell you which faction shifted its position overnight, which argument gained traction on which platform, whether the move was driven by conviction or by one whale repositioning. The price compresses all of that into a scalar. That compression is the market's strength and its structural blindness.

The AI research community noticed. In 2026, three separate benchmarks emerged to test whether language models could match markets on forecasting accuracy. The University of Chicago's SIGMA Lab launched Prophet Arena, scoring models on live Kalshi and Polymarket questions — GPT-5 led the leaderboard. A team of researchers released Foresight Arena, a commit-reveal protocol on Polygon where AI agents submit probability estimates on binary Polymarket markets without trading. After 50 rounds and roughly 350 predictions per agent, their finding was precise: frontier models like Claude Opus and GPT-5 showed slightly positive alpha over the market mid-price, but the edge was not statistically significant. Detecting a real forecasting advantage of two percentage points at 80 percent power would require about 350 predictions. Detecting a one-point edge would require four times as many.

The convergence is real. AI models can now produce numbers that are roughly as good as the market's number. But they produce the same kind of output — a probability — through the same kind of compression. The models read the same news, process the same signals, and collapse them into a prediction. What neither the market nor the model offers is the path: how the crowd's beliefs formed, shifted, and fractured on the way to that number.

## Simulating the Conversation, Not Just the Outcome

MiroShark approaches the same problem from the opposite direction. Instead of aggregating real bets into a price, it generates synthetic agents — over a hundred of them — each grounded in demographic data, web enrichment, and platform-specific behavioral constraints. It drops them into a scenario and runs the conversation.

The agents do not simply vote. They post on simulated Twitter, argue on simulated Reddit, and trade on a simulated prediction market, all simultaneously. The dynamics differ across platforms: Twitter rewards provocation, Reddit rewards early replies, markets reward conviction with capital. Information propagates differently in each channel. Herd effects form in one place. Signal extraction happens in another. The output is not a probability. It is a transcript — a timeline of posts, trades, and belief shifts with the causal chain exposed.

This is the structural difference. Prediction markets are compressors: many inputs, one output, mechanism hidden. MiroShark is a decompressor: one input, many outputs, mechanism visible. A Polymarket contract tells a governance team that their proposal has a 68 percent chance of passing. A MiroShark simulation shows them *how* the narrative splits in the first hour — which faction posts first, whose repost changes the tone, whether the prediction market's early signal dampens the opposition or inflames it.

## Where Each Fails

The failures are complementary. Prediction markets fail when liquidity is thin, when the question is novel, and when the resolution criteria are ambiguous. Foresight Arena found that no AI agent beat the market on geopolitical questions — the domain where human context and classified information create an information asymmetry that neither models nor thin markets can overcome.

Simulation engines fail when the scenario has no precedent for calibrating agent behavior. A simulated crowd's response to a governance proposal is only as good as the behavioral model driving each agent. MiroShark mitigates this with five layers of real-world grounding per agent, but the output remains a plausible trajectory, not a verified forecast. The simulation tells you what *could* happen with internal consistency. The market tells you what people with money *believe* will happen.

The interesting question is whether the two converge. The Foresight Arena paper explicitly contrasts its approach with Prediction Arena, which had LLMs trade with real capital and reported average losses. The authors argue that profit and loss conflates forecasting skill with timing and position sizing. That same critique applies in the other direction: a good forecast conflates many possible paths into a single number, losing the information that simulation preserves.

## The Room and the Scoreboard

Prediction markets built the scoreboard. The price is visible, continuous, and incentive-aligned. Twenty-four billion dollars a month ensures that the number on the board reflects genuine belief. What the scoreboard cannot show is the game — the plays, the momentum shifts, the moments where the narrative could have gone either way. Simulation engines build the replay. For under a dollar and in under ten minutes, they decompose the number into the conversation that produced it.

Neither replaces the other. The market needs the crowd. The simulation needs the model. But the gap between them — between knowing the answer and understanding the argument — is where the next generation of collective intelligence tools will be built.

---
*Sources:*
- *[Pew Research Center, "Trading volume on prediction markets has soared in recent months" (May 2026)](https://www.pewresearch.org/short-reads/2026/05/27/trading-volume-on-prediction-markets-has-soared-in-recent-months/)*
- *[Foresight Arena: A Forecasting Benchmark for LLM Agents (arXiv 2605.00420, May 2026)](https://arxiv.org/html/2605.00420v1)*
- *[Decrypt, "AI Now Matches Prediction Markets in Forecasting Real Events, Study Finds" (2026)](https://decrypt.co/336298/ai-now-matches-prediction-markets-in-forecasting-real-events-study-finds)*
- *[Kalshi regulatory battles, state vs. federal regulation (Cointelegraph, Nov 2026)](https://cointelegraph.com/news/polymarket-us-trading-volume-jumps-regulatory-battles)*
