# She Had Eleven Thousand Dollars for the Whole Year. The Focus Group Cost Fifteen.

The median community engagement budget in the United States is $11,000 per year. That figure comes from the Granicus 2026 Civic Engagement Report, and it covers everything: public meetings, surveys, outreach materials, translation services, software subscriptions. Eleven thousand dollars for a full year of listening to the people your decisions affect.

A single focus group costs $7,000 to $20,000. One session, one topic, eight to twelve people, one evening. The figure comes from Drive Research's 2026 pricing guide and has not meaningfully changed in a decade. Add participant incentives ($75–$150 per person), a moderator, a facility rental, and three to four weeks of synthesis, and the community development director has spent her entire annual budget to hear from twelve residents about one issue.

She has eleven more months of decisions to make. She will make them without data.

## The Research Gap Nobody Talks About

This is not a niche problem. It is the default condition for most organizations that make decisions affecting other people. Early-stage startups allocate $10,000 to $40,000 per year for user research, and many seed-stage teams operate on less than $100 per month. A 2024 Greenbook GRIT report found that 71% of insights professionals had piloted AI-moderated qualitative research — but those tools still cost $1,500 to $4,000 per run, require enterprise contracts, and assume a dedicated research team to interpret the output.

The result is that most decisions about communities, products, and policies are made by people who have never systematically asked the affected population what they think. Not because they do not want to. Because they cannot afford to.

The industry's answer in 2026 is synthetic research — AI-generated focus group participants trained on demographic and psychographic data. Google DeepMind and Stanford published a study showing AI agents could replicate real participants' survey responses with 85% accuracy. The Times tested a synthetic panel against 642,000 subscriber records and got results within one percentage point of traditional methods. The technology works, within limits.

But the cheapest synthetic research platforms still start at $1,500 per study. They are built for enterprise insights teams at consumer brands. They assume you know what a screener questionnaire is, what a conjoint analysis does, what "N=200 at 95% confidence" means. The community development director with the $11,000 budget is not their customer. The DAO governance lead is not their customer. The solo founder trying to understand whether anyone actually wants the thing they are building is not their customer.

## A Dollar and Ten Minutes

MiroShark is an open-source simulation engine that approaches the same problem from the opposite direction. Instead of generating synthetic survey respondents, it generates a population of AI agents — each with a distinct persona, knowledge base, and set of beliefs — and drops them into simulated social platforms to argue.

You give it a document. A proposed policy. A product announcement. A news story. It spawns a hundred agents grounded in real-world context: different professions, different political leanings, different levels of expertise. Those agents post on simulated Twitter, debate on simulated Reddit, and trade on a simulated prediction market. The simulation runs for multiple rounds, and the agents update their positions based on what they read from each other.

It costs a dollar. It takes less than ten minutes.

The community development director could run a simulation of her proposed zoning change every week for a year and spend less than she would on a single focus group. The DAO governance lead could simulate a token distribution proposal before posting it to Snapshot. The solo founder could simulate a product launch announcement and watch a hundred synthetic users argue about whether it solves a real problem — before writing a single line of marketing copy.

## What the Simulation Actually Tells You

The difference between MiroShark and a chatbot that says "here's what people might think" is the analytical layer. The simulation produces 41 distinct API surfaces — not a summary, but a structured dataset you can query.

Belief drift charts track how the population's stance shifts across rounds of discussion. Confidence trajectories show whether agents become more certain or less certain over time. A stance flip report identifies which agent archetypes changed their minds and why — was it the financial argument that moved the skeptics, or the regulatory risk angle? Cross-platform sentiment divergence reveals whether the conversation played out differently on simulated Twitter than on simulated Reddit — the same dynamic that happens with real public opinion on real platforms.

The mention network maps who influenced whom. The full-text search lets you find the specific argument that tipped a simulated community from opposition to support. The pre-run estimator, built from historical simulation data, tells you in advance how long it will take and what it will cost.

None of this requires a research team to interpret. The outputs are visual, queryable, and available through a browser. A person who has never run a focus group can read a belief drift chart. A person who has never written a survey can understand a stance flip report.

## The Honest Limitation

MiroShark is not a replacement for talking to real people. The Stanford HAI Institute found that LLM-simulated personas exhibit sycophancy bias and converge on majority opinions at rates that diverge from real respondents. Synthetic agents cannot surprise you the way a real resident at a real town hall can. They cannot tell you about the flooding on Elm Street that does not appear in any dataset, or the landlord who has been quietly buying up properties on the block you are about to rezone.

But here is the question the community development director actually faces: is it better to make the decision with no input at all, or to make it with a simulated input that is directionally useful but imperfect?

For the person with $11,000 and twelve months of decisions, the answer is not theoretical. A dollar simulation that surfaces the three strongest objections to your proposal — even if it misses the fourth — is infinitely more information than the nothing she currently has. The gap is not between perfect research and simulated research. The gap is between simulated research and no research at all.

Twelve hundred and thirty-two stars on GitHub. Two hundred and ninety-eight forks. Ten contributors. One dollar per simulation. The project is not trying to replace McKinsey's research practice. It is trying to make the basic act of asking "what would people think about this?" accessible to someone whose entire budget would not cover the moderator's fee.

---
*Sources: [Granicus 2026 Civic Engagement Report](https://granicus.com/reports/civic-engagement-report/), [Drive Research — How Much Does Market Research Cost? (2026)](https://www.driveresearch.com/market-research-company-blog/how-much-does-market-research-cost/), [Perspective AI — AI Focus Groups in 2026](https://getperspective.ai/blog/ai-focus-groups-in-2026-the-pillar-guide-to-replacing-the-8-person-conference-room), [Delve AI — Synthetic Focus Groups](https://www.delve.ai/blog/synthetic-focus-groups), [Greenbook GRIT Report 2024](https://www.greenbook.org/grit), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark)*
