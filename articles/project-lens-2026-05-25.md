# Pollsters Replaced People with Bots. They Forgot to Let Them Talk to Each Other.

In May 2026, Pew Research published a warning that read like an obituary for its own industry. AI-generated respondents were flooding opt-in surveys. Bad actors were running five bot accounts simultaneously, completing 200 surveys a day at a dollar each — $30,000 a month in fraudulent responses. Retracted news stories about Americans drinking bleach and denying the Holocaust had traced back to polluted panels. Global response rates, which topped 30% in the 1990s, had fallen below 5%. The economics of asking real people what they think had collapsed.

The industry's response was to replace the people with better bots.

## The Silicon Sampling Bet

A billion-dollar New York startup called Aaru now generates election predictions by asking AI personas what voters would say — no humans surveyed. Savanta launched "Virtual Personas." YouGov acquired Yabble. Convergent Opinion claims synthetic respondents "triple the richness of text data." Ipsos uses AI respondents in market research, though it draws the line at political polling. Dominic Cummings promoted the approach at No. 10 Downing Street; Morgan McSweeney reportedly experimented with synthetic voters.

The method, called silicon sampling, works like this: draw a synthetic cohort by randomly sampling demographics — age, gender, race, education, geography — to match a target population's distribution. Prompt a language model with those demographics plus a survey question. Collect the answers. A Princeton researcher described blending synthetic and real respondents as "kind of like magic" — 5,000 responses in under an hour for less than a dollar.

The critics are loud and specific. Shibani Santurkar's research found language models are systematically misaligned with U.S. populations, with certain groups — Mormons, widows, rural communities — poorly represented across every model tested. Verian Group's analysis concluded that LLMs "do not represent a sample from any real population. They represent patterns in training data." Fintan Smith of Convergent Opinion warned his own method "might fail to account for anything novel." The New Statesman's headline captured the mood: "Pollsters Don't Need Real People Anymore."

But the debate over whether silicon respondents are accurate enough misses a structural problem. Both traditional polling and silicon sampling do the same thing: they ask isolated individuals for their opinion, one at a time, in a vacuum. The respondent never encounters the argument that would change their mind. They never watch a persuasive voice shift the room. They never experience the social pressure that makes a privately-held belief collapse into public conformity.

They answer. They do not interact.

## The Missing Dimension

Opinions do not form in survey boxes. They form in conversations, arguments, social feeds, group chats, and comment sections — environments where what your neighbor believes changes what you believe. The Asch conformity experiments demonstrated this in the 1950s. The spiral of silence theory formalized it in the 1970s. Every social psychologist since has confirmed it: stated preferences under isolation are structurally different from expressed preferences under social influence.

A poll — whether answered by a human or a synthetic persona — captures a snapshot of a population that has not yet been exposed to the thing you are asking about. It measures pre-interaction opinion. But the question a policy analyst, a governance coordinator, or a campaign strategist actually needs answered is: what happens *after* the crowd encounters this idea and starts arguing about it?

That question requires simulation, not sampling.

## Letting the Crowd Argue

MiroShark, an open-source simulation engine at 1,196 stars, does not ask synthetic personas what they think. It lets them interact. Upload a document — a policy proposal, a product announcement, a governance vote — and the engine generates hundreds of agents with distinct personas who then post, argue, amplify, challenge, and shift their stances across simulated social platforms over multiple rounds. The output is not a percentage. It is a trajectory: how opinion moved, who moved it, where the fractures formed, and what the crowd looked like after it was done arguing.

The distinction is not cosmetic. A silicon sampling poll might report "62% of synthetic respondents support this policy." MiroShark might show that support starts at 62% but collapses to 41% after round four, when a specific agent archetype reframes the proposal as a power grab and three coalition clusters form around opposing narratives. The poll gives you a number. The simulation gives you the story of how that number changes under social pressure.

The credibility problem that plagues silicon sampling — "these aren't real people" — has a different shape here. MiroShark's recent integration of NVIDIA's Nemotron-Personas dataset (PR #103, merged May 23) grounds agent demographics in U.S. Census distributions across age, education, ethnicity, occupation, and geography. The agents are still synthetic, but the population they compose is census-faithful. A Simulation Confidence Score, shipping the same week, provides a 0–100 trust signal derived from four components: stability, convergence, participation, and robustness. The system does not claim its synthetic crowd is real. It claims the dynamics are stable, the composition is representative, and the results are reproducible — a different kind of credibility than "these responses came from humans."

## What Gallup Measures vs. What Actually Happens

The polling industry's fundamental product is a static distribution: X% believe Y at time T. This was transformative in 1936 when George Gallup predicted Roosevelt's landslide. It remains useful for tracking broad sentiment shifts over months and years. But it has never captured the mechanism — the *how* of opinion change, the specific arguments and social dynamics that turn a 60/40 split into a 40/60 split over a week.

Silicon sampling preserves this limitation exactly. It makes static distributions cheaper and faster to produce, but it does not make them more predictive. A billion-dollar startup generating instant poll results is still producing the same product Gallup produced in 1936 — a photograph of a room where nobody is talking.

The simulation approach asks a different question entirely. Not "what does the crowd think?" but "what happens when the crowd thinks together?" The distinction matters most precisely when it matters most: before a governance vote, before a product launch, before a policy announcement — the moments when a static snapshot is already stale by the time it arrives.

Pollsters spent ninety years perfecting the art of asking people questions. Now they are spending billions teaching machines to answer those questions instead. Neither approach accounts for the fact that the answer changes the moment you put people in a room together. The room is what matters. The room is what nobody built — until someone did.

---
*Sources: [Do AI and bogus respondents threaten polling's future? (Pew Research Center, May 2026)](https://www.pewresearch.org/short-reads/2026/05/12/qa-do-ai-and-bogus-respondents-threaten-pollings-future/) · [Pollsters don't need real people anymore (New Statesman, May 2026)](https://www.newstatesman.com/politics/polling/2026/05/pollsters-dont-need-real-people-anymore) · [AI polls: Silicon sampling (Futurism)](https://futurism.com/artificial-intelligence/ai-polls-silicon-sampling) · [NVIDIA Nemotron-Personas (Hugging Face)](https://huggingface.co/blog/nvidia/nemotron-personas) · [MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)*
