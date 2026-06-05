# Ferrari Spent Four Years Building an Electric Car. It Spent Zero Minutes Simulating the Crowd.

On May 26, 2026, Ferrari unveiled the Luce — its first fully electric vehicle. A $640,000 five-seater with a 122 kWh battery, 323 miles of range, and 0-62 in 2.5 seconds. The car took four years to develop. Within hours, it was being compared to a vacuum cleaner.

Former chairman Luca di Montezemolo told Italian television he was so appalled he could not say what he thought: "If I say what I think, I'd cause harm to Ferrari. We're risking the destruction of a myth." He suggested removing the prancing horse logo. Italy's Deputy Prime Minister Matteo Salvini called it "electric, outrageously expensive, and it speaks for itself." Collectors called it ugly. Social media overlaid the Luce next to a Nissan Leaf, an Apple Mouse, and a camping trailer. Ferrari's stock dropped 8% on the Milan exchange the following Tuesday — what an Oddo BHF analyst called "by far the sharpest reaction we've seen for a car design."

CEO Benedetto Vigna's response landed with the weight of a corporate prayer: innovation "does not look for immediate consensus."

He was right. But it does look for survival.

## The Gap Nobody Fills

The crisis communications industry has noticed the problem. In April, FINN Partners launched CANARY FOR CRISIS, an AI-powered platform that simulates media environments — breaking news, reporter calls, social media pressure, narrative manipulation — so communications teams can drill their response at crisis speed. BCG's 2026 report on corporate communications found that nearly 70% of chief communications officers describe their function as an AI laggard. Only one in ten have systematically integrated AI into workflows. The gap between the speed at which narratives form and the speed at which teams respond is widening.

But the tools filling that gap simulate the wrong side of the equation. CANARY drills the team's response. It pressure-tests the playbook. It does not simulate the crowd — the thousands of people who will actually encounter the announcement, react, argue, amplify, and decide what the story is. Ferrari's communications team could have run crisis drills for months. They still would not have seen the coalition of brand purists, price critics, and design skeptics converging into a single narrative — "the destruction of a myth" — within forty-eight hours.

The drill tests whether the team can respond. It does not test what the crowd will do.

## A Day Without the Room

Imagine a communications director at a consumer brand preparing a product launch that will split the audience. A legacy company entering a new category. A premium brand making an accessible product. A beloved name making a choice that some customers will read as betrayal.

Without crowd simulation, the preparation looks like this: internal focus groups, message testing with a panel of thirty people, sentiment analysis of past launches in the same category, a social listening dashboard queued to go live the moment the embargo lifts. The team has prepared holding statements. They have a war room booked. They have a social media response matrix with pre-approved language for six predicted objections.

Then the announcement drops. Within ninety minutes, a former executive's criticism racks up millions of views. A politician weighs in. A meme format emerges that compresses the criticism into a shareable image. The six predicted objections are the wrong six. The real objection — the one that resonates — is an emotional argument about identity that no one on the team anticipated because no one on the team thinks like the audience that cares most.

The war room activates. The social listening dashboard lights up. The holding statements do not hold. The stock drops before the team agrees on a response. The CEO issues a statement about innovation not seeking consensus, which is true, accurate, and completely useless for stopping a narrative that has already left the building.

This is not a failure of preparation. It is a failure of medium. Focus groups test individual reactions. Message testing tests language. Neither tests what happens when a crowd encounters your announcement and starts arguing about it in public.

## A Day With the Room

Now add a simulation engine. Two weeks before the launch, the same communications director uploads the draft announcement into MiroShark — an open-source crowd simulation platform at 1,235 stars — and runs a simulation for under a dollar in less than ten minutes. The engine generates hundreds of AI agents with distinct personas grounded in census demographics: age, education, occupation, geography, ethnicity. These agents do not fill out a survey. They interact — posting, arguing, amplifying, pushing back — across simulated social platforms over multiple rounds.

The simulation does not return a number. It returns a trajectory. Consensus starts at 58% positive. By round four, a coalition of legacy enthusiasts — agents whose personas map to long-time brand loyalists — reframes the product as a capitulation. A second coalition of price-sensitive observers amplifies the reframe. By round seven, positive sentiment has dropped to 34%. Coalition detection identifies the two clusters and their interaction pattern. Peak-round analytics flags round four as the inflection point — the exact moment the narrative turned.

The director runs it again with the announcement rewritten to lead with the engineering story instead of the price. Positive sentiment stabilizes at 51%. The brand-loyalist coalition still forms, but it stays smaller — the engineering frame gives moderate agents a counter-narrative to anchor on. The inflection point shifts to round six, buying two extra rounds of positive momentum.

She exports the agent interaction graph as GraphML and opens it in Gephi to show the executive team where the coalitions form and how they connect. She pulls the confidence score — 78 out of 100, derived from stability, convergence, participation, and robustness — to anchor the recommendation: this framing is more resilient, and the simulation's output is measurably stable.

Three simulations. Under three dollars. Under thirty minutes. Before a single customer has seen the announcement.

## The Difference Between Testing Messages and Testing Crowds

The crisis communications industry is building tools that make teams faster at reacting. That is valuable. But the structural problem is not reaction speed. It is that the reaction comes after the crowd has already decided what the story is. By the time Ferrari's war room convened, the "destruction of a myth" narrative had already formed, found its coalition, and gone viral. No amount of drill speed changes that timeline.

The missing capability is not faster response. It is upstream simulation — running the crowd before the crowd runs you. Testing not whether the team is ready for the objection, but whether the objection will form at all, and if it does, what shape it takes, who amplifies it, and at which moment it becomes the dominant story.

BCG's finding that 70% of communications functions are AI laggards reflects a specific blind spot: the industry adopted AI for content generation and monitoring, but not for the harder problem of modeling social dynamics. A tool that writes press releases faster does not help when the press release is not the problem. A tool that monitors sentiment in real time does not help when real time is already too late.

The simulation is the room where the crowd argues before the crowd argues. Ferrari did not need a better press release. It needed to hear what Montezemolo would say before Montezemolo said it.

---
*Sources: [Ferrari's $640,000 electric car is getting roasted online (Fortune, May 2026)](https://fortune.com/2026/05/29/ferrari-electric-car-ev-luce-bad-reviews/) · [Ferrari shares fall after luxury carmaker launches first EV (CNBC, May 2026)](https://www.cnbc.com/2026/05/26/ferrari-stock-shares-luce-electric-vehicle-ev-launch.html) · [Ferrari Luce shows how brands control the product but not the conversation (Media Marketing, May 2026)](https://www.media-marketing.com/en/news/ferrari-luce-shows-how-brands-today-control-the-product-but-not-the-conversation-around-it/) · [Corporate Comms Is Playing Catch Up on AI (BCG, 2026)](https://www.bcg.com/publications/2026/corporate-comms-catch-up-on-ai-leaders-show-the-way) · [FINN Partners introduces CANARY FOR CRISIS (FINN Partners, 2026)](https://www.finnpartners.com/news-insights/finn-partners-introduces-new-ai-powered-crisis-training-platform-to-counter-narrative-manipulation-and-coordinated-reputational-attacks-in-real-time/) · [MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)*