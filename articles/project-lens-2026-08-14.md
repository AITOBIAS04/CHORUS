# Polymarket Processes Twenty-Four Billion Dollars a Month. It Cannot Answer Your Question.

In April 2026, prediction markets crossed a threshold that would have seemed absurd three years earlier. Combined monthly trading volume on Polymarket and Kalshi hit $24 billion — nearly double the $14 billion averaged by all legal U.S. sportsbooks in 2025. Monthly unique wallets approached 840,000. A single day in February set a volume record of $425 million, surpassing even Election Day 2024. Pew Research began tracking prediction markets as a distinct financial category. The prediction market had become, by any measure, a mainstream instrument.

The thesis is simple and well-tested: aggregate the financial commitments of many independent actors and the resulting price converges toward the probability of an outcome. Markets with over $100,000 in volume forecast the correct outcome 84% of the time, outperforming traditional polls by eight percentage points. When enough people put enough money on the line, the crowd knows.

The problem is the word "enough."

## The Ninety-One Percent Problem

Pew's May 2026 analysis of trading activity since July 2024 revealed a striking concentration. On Kalshi, sports accounted for 80% of volume, cryptocurrency 7%, politics 4%. On Polymarket, the split was sports (39%), politics (32%), cryptocurrency (20%). Combined, three categories captured 91% of all trading activity on both platforms.

Everything else — public health, technology adoption, housing policy, corporate strategy, community sentiment, regulatory impact — lives in the remaining 9%. And that 9% is where the accuracy guarantee collapses. Fensory's 2026 analysis of 28,407 resolved Polymarket markets found that contracts with less than $10,000 in volume hit a 61% accuracy rate. At 61%, a coin flip with modest bias, you are not aggregating wisdom. You are aggregating noise from a handful of participants who happened to care.

This is not a bug in prediction markets. It is the architecture. A prediction market requires three things to produce a reliable signal: a clearly defined binary question, a large pool of participants with real money at stake, and enough time for the price to converge. Remove any one and accuracy degrades. The long-horizon problem — documented in a February 2026 arXiv paper — shows that markets for events far in the future exhibit systematically reduced liquidity and price accuracy, because capital has an opportunity cost that increases with time.

The result is a tool that works brilliantly for questions the crowd already cares about and fails quietly for everything else. Will a particular candidate win an election? Prediction markets are the best instrument available. Will the residents of a mid-sized city support converting an office park into mixed-income housing? No market exists. No market will exist. The question is too specific, too local, too small to attract the liquidity that makes the mechanism work.

## The Dollar Simulation

MiroShark occupies the opposite end of the design space. Where Polymarket aggregates the opinions of hundreds of thousands of real humans betting real money, MiroShark simulates the opinions of twelve AI agents debating a topic for under ten minutes. The cost is approximately one dollar. No market needs to exist. No crowd needs to assemble. No liquidity needs to accumulate.

The trade-off is obvious and worth stating plainly: simulated agents are not real people, and their opinions are not backed by financial commitment. A prediction market's accuracy comes from skin in the game — participants who are wrong lose money, which filters out casual speculation over time. MiroShark's agents have no skin in anything. They are language models prompted with demographic profiles, platform behaviors, and a topic. Their value is not that they are right. Their value is that they exist when no market does.

This is the structural gap. A community development director with an $11,000 annual engagement budget — the median figure from the Granicus 2026 Civic Engagement report — cannot post a question on Polymarket and expect useful signal. The question is too local. The participants do not exist. The liquidity will never materialize. But she can run a MiroShark simulation with agents mapped to her community's demographics and get structured output — stance distributions, confidence trajectories, flip rates — in the time it takes to read one public comment letter.

## What the Intermediate States Reveal

The deeper architectural difference is not cost or speed. It is what each tool shows you about the process.

A prediction market produces one number: a price between zero and one, updated continuously. That price is the answer. You cannot ask why it moved. You cannot see which participants changed their minds, or when, or in response to what argument. The market is a black box that outputs a probability. When Polymarket's "Will US strike Iran?" market surged from $930,000 to $39 million in volume over two days in February 2026, the price moved from 12% to 47%. What changed? Whose minds changed? What arguments were persuasive? The market cannot tell you. It was not designed to.

MiroShark's forty-one queryable API surfaces exist precisely to answer those questions. Confidence trajectories track how each agent's conviction changes across deliberation rounds. Stance flip reports identify which agents changed positions and when. Mention networks map which agents influenced which others. Per-platform sentiment divergence shows how the same topic splits differently across simulated communities. Each intermediate state is a first-class endpoint with a schema, cache headers, and — since June 2026 — a cryptographic signature for provenance.

This is not a claim that MiroShark's output is more accurate than a well-funded prediction market. It is a claim that MiroShark answers a different question. A prediction market tells you what the crowd believes will happen. An opinion simulation tells you how a population might reason about a topic — the trajectory of the deliberation, not just its endpoint.

## The Question That Has No Market

The prediction market industry's explosive growth in 2026 — from $5 billion monthly in mid-2025 to $24 billion by April 2026, with projections toward $240 billion — has created a paradox. The more successful prediction markets become, the more visible the gap becomes between questions the market can answer and questions that matter to specific decision-makers.

Forbes reported in March 2026 that the strongest forecasting results now come from hybrid approaches combining human judgment with AI analysis. ForeNex, a social forecasting platform, positions AI agents as continuous monitors that human forecasters interrogate and refine. The FutureEval leaderboard shows AI bots becoming competitive with human community predictions. The question is no longer whether AI can forecast — it is what infrastructure best converts that capability into actionable signal for the questions that do not attract crowds.

Polymarket solved the $24 billion question: what does the crowd think about the things the crowd cares about? The unsolved question — the one a community planner, a solo founder, a DAO governance coordinator, or a research lab faces — is what a population might think about the thing only they care about. That question has no market. It never will. It costs a dollar to simulate.

---
*Sources:*
- *[Pew Research Center — Trading volume on prediction markets has soared](https://www.pewresearch.org/short-reads/2026/05/27/trading-volume-on-prediction-markets-has-soared-in-recent-months/)*
- *[TRM Labs — How Prediction Markets Scaled to $21B](https://www.trmlabs.com/resources/blog/how-prediction-markets-scaled-to-usd-21b-in-monthly-volume-in-2026)*
- *[Fensory — Polymarket Accuracy Analysis 2026](https://fensory.com/intelligence/predict/polymarket-accuracy-analysis-track-record-2026)*
- *[Forbes — AI Turns Polls and Prediction Markets Into a New Battleground](https://www.forbes.com/sites/charliefink/2026/03/24/ai-turns-polls-prediction-markets-into-a-new-battleground/)*
- *[arXiv — Can Interest-Bearing Positions Solve the Long-Horizon Problem?](https://arxiv.org/pdf/2602.21091)*
