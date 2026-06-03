# Argentina Built a Digital Twin of Its Citizens. It Forgot to Show Them the Code.

On May 22, 2026, President Javier Milei announced that Argentina had built an AI system to simulate its population. The "Gemelo Digital Social" — Social Digital Twin — would aggregate government and private data to model poverty, track subsidies, and test social policies before implementing them. The state, Milei declared, was transforming from "reactive" to "predictive."

The promotional video contained misspelled words, an AI-generated deepfake of Minister Sandra Pettovello, a Singaporean flag where an Argentine one should have been, and a visible Amazon AWS logo. Tech commentator Maximiliano Firtman summarized: "Grammar and spelling errors, a fake minister presenting with holograms, Singaporean flags, Amazon AWS logo, a terrible speech." Opposition Senator Agustín Rossi filed a formal information request. "The future," he warned, "cannot become surveillance over citizens."

The farce was easy to mock. The question underneath was not.

## The 136-Year Problem

The need to understand a population faster than it changes has driven every major revolution in computing. This is not a metaphor. It is literal history.

In 1880, the United States Census Bureau counted 50 million Americans. Tabulating the results by hand took eight years — so long that by the time the count was published, the data described a country that no longer existed. Herman Hollerith, a Census Bureau engineer, built a machine to fix this. His electromechanical punch card tabulator encoded demographic data on perforated cards and used electrical contacts to sort and count them. In the 1888 competition for the 1890 census contract, Hollerith's system processed test records in 72.5 hours — less than a third of his nearest competitor's time. Countries around the world adopted the technology. Hollerith's company merged with two firms in 1911 and was renamed IBM in 1924.

The punch card asked a simple question: *how many?* The answer shaped taxation, representation, and resource allocation. But it could only describe a population at rest.

In 1936, George Gallup introduced a second revolution — statistical sampling. Ask a representative subset, weight the answers, predict the whole. Polling became the twentieth century's dominant technology for understanding populations. For seventy years, it mostly worked.

Then response rates collapsed below 5%, as Pew Research reported in May 2026. The industry's answer was silicon sampling: replace human respondents with AI personas prompted with demographics. But silicon sampling, like traditional polling, asks isolated individuals for their opinion in a vacuum. It produces the same product Gallup produced in 1936: a photograph of a room where nobody is talking.

## From Asking to Simulating

Argentina's Gemelo Digital Social represents a third step. Not counting, not asking — simulating. A paper published in AI & Society in 2026 explored digital twins as "computational testing grounds for deliberative systems," allowing policymakers to test what-if scenarios without societal disruption. The Journal of Deliberative Democracy published a companion argument for using generative AI to run hypothetical deliberations during crises. The global digital twin market is projected to reach $150 billion by 2030.

But Argentina's implementation revealed the structural problem with government-built population simulators: they are closed systems. No published methodology. No public audit. No way for a researcher or a citizen to examine whether the model's assumptions are correct or whether the simulation's predictions would survive contact with an actual crowd. The Ministry has not elaborated on its data governance framework.

A simulation you cannot inspect is not a tool for understanding. It is a tool for justification.

## The Simulation You Can Read

MiroShark is an open-source simulation engine — 1,226 stars, 264 forks — that runs crowd opinion simulations for under a dollar in less than ten minutes. Upload a document and the engine generates hundreds of AI agents with distinct personas who interact across simulated social platforms over multiple rounds. The output is not a number. It is a trajectory: how opinion moved, who moved it, where coalitions formed, and at which round the crowd fractured.

The distinction from Argentina's approach is architectural. Every component is inspectable. A Confidence Score provides a 0–100 trust signal from four measurable components: stability, convergence, participation, and robustness. Agent demographics are grounded in NVIDIA's Nemotron-Personas dataset, drawn from U.S. Census distributions. An agent persona export — the project's 27th share surface, added last week — exposes every agent as machine-readable JSON: name, bio, demographics, stance, and trajectory. A GraphML export lets a network scientist open the interaction graph in Gephi and verify coalition structure independently.

The simulation data is exposed through 27 independent integration points — JSON, CSV, SVG, RSS, GraphML, oEmbed, webhooks, MCP tools — so any consumer can verify results in whatever format they already use. Ten downstream projects now build on MiroShark's outputs, four of which submitted ecosystem listing pull requests within hours of each other, without coordination.

Hollerith's punch card was a transparency technology. Anyone could hold a card up to the light and see where the holes were. When that medium moved from paper to magnetic tape to databases to proprietary cloud platforms, the auditability disappeared. Argentina's digital twin is the endpoint of that trajectory: a simulation of citizens running on Amazon's servers, with no holes to hold up to the light.

## The Question Each Era Could Ask

Each revolution in population understanding expanded what was possible to ask. The census asked *how many.* Polling asked *what do they think.* Simulation asks *what happens when they interact.*

That third question is the one that matters for governance — for understanding how a crowd will react to a proposal before it ships. But the answer is only as trustworthy as the model is transparent. The Journal of Deliberative Democracy's authors put it directly: using AI to simulate deliberation without transparency constitutes "an anti-democratic shortcut."

A simulation engine that anyone can run, whose agent roster is exportable, whose confidence metrics are decomposable, whose interaction graph is downloadable, and whose downstream ecosystem serves as independent verification — that is not a shortcut. It is the census you can hold up to the light.

---
*Sources: [Argentina Launched an AI to Predict the Future. It Couldn't Predict a Typo (Decrypt, May 2026)](https://decrypt.co/368860/argentina-ai-predict-future) · [Argentina launches AI 'Digital Twin' system for social policy simulations (Digital Watch Observatory)](https://dig.watch/updates/argentina-predictive-ai-social-policy-planning) · [The Case for Using Generative AI to Run Deliberation Simulations (Journal of Deliberative Democracy, 2026)](https://delibdemjournal.org/article/id/1625/) · [A replica for our democracies? (AI & Society, Springer, 2026)](https://link.springer.com/article/10.1007/s00146-025-02511-7) · [From Herman Hollerith to IBM (Smithsonian National Museum of American History)](https://americanhistory.si.edu/collections/object-groups/tabulating-equipment/from-herman-hollerith-to-ibm) · [Do AI and bogus respondents threaten polling's future? (Pew Research Center, May 2026)](https://www.pewresearch.org/short-reads/2026/05/12/qa-do-ai-and-bogus-respondents-threaten-pollings-future/) · [MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)*
