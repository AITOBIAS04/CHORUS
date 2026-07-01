# A Billion-Dollar Industry Tests What Users Click. Nobody Tests What They Think.

In March, OpenAI acquired Statsig for $1.1 billion in stock — the largest deal in the history of experimentation platforms. Two months later, VWO and AB Tasty merged into a combined entity with $100 million in annual recurring revenue and 4,000 enterprise customers. Datadog bought Eppo for $220 million. Braze acquired OfferFit for $325 million. In the span of a single quarter, the A/B testing industry consolidated more aggressively than at any point in its two-decade history.

The reason, according to VWO's own CEO, is blunt: "The total addressable market for web experimentation is largely tapped." The $1 billion A/B testing market — growing at 11.2% annually — has saturated its original use case. Everyone who needs to test button colors and checkout flows already has a tool. The industry's next move is not to find new customers for the same question. It is to find new questions.

## The Twenty-Year Question

A/B testing asks one thing: what does the user do? Click or ignore. Convert or bounce. Complete or abandon. The methodology is elegant in its simplicity and brutal in its requirements. A standard test needs at least 30,000 visitors per variant with 3,000 conversions to reach statistical significance. It runs for a minimum of two weeks, ideally six to eight. It requires live traffic — real users, in a real product, making real decisions.

This means A/B testing is structurally post-launch. You cannot test what users think about your idea before you build it. You cannot test how a community will react to a policy before you announce it. You cannot test whether a message will polarize an audience before you publish it. You can only test whether a change you already shipped performs better than what was already there. The question is narrow by design.

For twenty years, this was fine. The internet was a machine for measuring clicks, and A/B testing was the best tool for the job. But the decisions that companies and founders now agonize over are not about clicks. They are about reception. About opinion. About whether a hundred different people with a hundred different professional backgrounds would support, resist, or ignore what you are about to do.

## The Synthetic Wave — Same Question, Faster Answer

A new generation of startups noticed the gap and is raising extraordinary money to close it. Aaru, which provides near-instant customer research using AI to simulate user behavior, raised a Series A at a reported $1 billion headline valuation from Redpoint Ventures. Simile announced $100 million in funding in February 2026. Synthetic Users, recognized by Gartner as a leader in AI-powered research, charges $2 to $27 per synthetic respondent — a fraction of the $5,000 to $15,000 cost of a traditional focus group. Pure-play synthetic platforms now number over a dozen, including Ditto, Evidenza, SYMAR, Lakmoos, and Artificial Societies.

These platforms are fast. Where a traditional usability study takes three to six weeks, synthetic user tools deliver results in minutes. They eliminate recruitment, scheduling, no-shows, and observer bias. They scale to thousands of synthetic respondents overnight.

But look closely at what they test. Aaru simulates user behavior. Synthetic Users evaluates concepts and messaging. Evidenza's Synthetic CMOs advise on market positioning. Almost every synthetic research platform inherits the same frame as the A/B test it is replacing: does the user engage with this? Will they click, sign up, purchase? The users are synthetic. The question is still behavioral.

Nobody in the billion-dollar experimentation industry — traditional or synthetic — is testing what a population actually thinks.

## The Category That Doesn't Have a Name Yet

MiroShark, an open-source simulation engine sitting at 1,353 GitHub stars, does not test clicks. It simulates opinions. You describe a scenario — a product launch, a policy change, a controversial statement — and a swarm of AI agents with distinct professional backgrounds, personality traits, and reasoning styles debate it across simulated social platforms. The output is not a conversion rate. It is a structured map of how opinion forms, shifts, clusters, and fractures across a population.

The difference is not cosmetic. A/B testing tells you that 4.2% more users clicked the green button. A synthetic UX platform tells you that users found the onboarding confusing. MiroShark tells you that twelve agents simulated a public reaction to your announcement, and seven shifted from neutral to skeptical after the third round of discussion because the financial journalists in the group found a contradiction in your claims that the marketing-oriented agents had overlooked.

The architectural difference runs deeper. MiroShark ships 41 queryable API surfaces — confidence trajectories, stance flip reports, per-platform sentiment divergence, agent mention networks, signed result envelopes with HMAC-SHA256 provenance. A simulation produces not a report but a data structure. Every output is an endpoint. Every opinion shift is queryable. When the CLI lifecycle completed last week — `simulate`, `wait`, `stop`, `cost` — the tool became something an automated pipeline can call, the same way a CI pipeline calls a test suite.

A pre-run estimator tells you the cost before you commit: typically one dollar and ten minutes for a hundred-agent simulation. Compare that to the A/B test's requirement of 30,000 real visitors over two to eight weeks, or the synthetic research platform's $2 to $27 per respondent. The economics operate in a different category because the question operates in a different category.

## What Experimentation Misses When It Only Measures Action

The consolidation of the A/B testing market is not a sign of decline. It is a sign that behavior-testing has matured into infrastructure — reliable, essential, and insufficient. Braze is already replacing manual A/B test workflows with AI agents that autonomously decide what to send each customer. The behavioral question is being automated away.

What remains is the question that no amount of click data answers: how will people feel about this? Not a single user completing a task. A population encountering an idea. The synthetic research startups raising hundreds of millions understand that real users are the bottleneck — but they are building faster versions of the same behavioral test. The structural gap is not speed. It is scope.

Opinion simulation is not a replacement for A/B testing. It is not a replacement for synthetic UX research. It is the test you run before either of those tests makes sense — when the question is not "does this convert?" but "should we even ship this?" Until that question has its own category, tools like MiroShark will keep sitting in the gap between experimentation and research, answering the question that a billion-dollar industry spent twenty years not asking.

---
*Sources: [Convert — State of A/B Testing Tools in 2026](https://www.convert.com/blog/a-b-testing/state-of-ab-testing-tools-2026/) · [TechCrunch — Aaru Series A at $1B Valuation](https://techcrunch.com/2025/12/05/ai-synthetic-research-startup-aaru-raised-a-series-a-at-a-1b-headline-valuation/) · [Synthetic Users](https://www.syntheticusers.com/) · [Future Market Insights — A/B Testing Market](https://www.futuremarketinsights.com/reports/ab-testing-software-market) · [MiroShark GitHub](https://github.com/aaronjmars/MiroShark)*
