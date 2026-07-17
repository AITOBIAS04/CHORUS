# Thirty-Seven Projects Simulate How People Think. They Occupy Four Different Worlds.

If you went looking for an open-source project that simulates how groups of people form opinions, you would find, as of this week, at least thirty-seven of them on GitHub alone. That number does not include the commercial platforms raising hundreds of millions of dollars to do the same thing behind closed doors. It does not include the academic papers that ship code but never maintain it. It does not include the forks.

The space is crowded enough that a developer named Daniel Rosehill published a curated resource list just to keep track of it. The list runs to seven categories and several dozen entries. And yet the projects it catalogs occupy what are effectively four separate worlds — different users, different assumptions, different definitions of what a simulation is for. If you are trying to orient yourself in this landscape, the star counts will not help you. The categories will.

## World One: The Orchestration Layer

The largest projects by stars are not simulation platforms at all. They are agent orchestration frameworks — tools for wiring up LLM-powered agents into workflows. AutoGen has crossed 42,000 GitHub stars. CrewAI hit 31,200, a 1,014% increase since January 2024. LangGraph reached 12,800, with the fastest enterprise adoption of the three.

These frameworks solve a plumbing problem: how do you get multiple agents to collaborate on a task, route information between them, and handle failures? LangGraph uses directed graphs with conditional edges. CrewAI assigns agents roles, backstories, and tools within a crew. AutoGen runs multi-party conversations in a group chat pattern.

None of them simulate opinion formation. None model belief dynamics. They are infrastructure, not experiments. But they matter to the map because they define how most developers in 2026 encounter the concept of "multi-agent systems" — as a production engineering pattern, not as a social science tool. When LangChain's 2026 State of AI Agents report says 57% of organizations have agents in production, those agents are doing data retrieval and customer service, not running Delphi panels.

## World Two: The Research Sandbox

The second world is academic. Stanford's Generative Agents paper — twenty-five agents in a Sims-like sandbox forming relationships and planning their days — remains the canonical reference for memory, reflection, and planning in multi-agent simulations. Google DeepMind's Concordia grounds agent behavior in physical, social, and digital space. CAMEL-AI's OASIS scales to one million agents on simulated Twitter and Reddit. Project Sid, from Fundamental Research Labs, dropped 500 agents into Minecraft and watched them develop taxation systems and cultural identities. Tsinghua's AgentSociety supports 10,000 agents with hundreds of daily interactions. ScioMind, published in May 2026, introduced cognitively grounded belief dynamics with memory-anchored updates and personality-dependent anchoring strength.

These projects produce papers, not products. Their output is a dataset, a log file, a research artifact. A typical run generates a JSON dump or a checkpoint directory that a researcher parses with custom scripts. The simulation's intermediate states — who changed their mind, when confidence shifted, which argument landed — are ephemeral unless the researcher thought to capture them. The code is open source, the interfaces are not.

## World Three: The Commercial Black Box

The third world is commercial and moving fast. Aaru crossed a billion-dollar valuation by selling synthetic voters — feed it demographic profiles and its models predict what those voters would say to a pollster. Savanta launched Virtual Personas. Gallup partnered with Simile to create 1,000 AI-generated digital twins. Ipsos is working with Stanford on synthetic data for market research. British political campaigns are using these tools to test canvassing strategies. The methodology has a name now: silicon sampling.

The output is a topline number. The machinery is proprietary. As Nate Silver argued in his critique of AI polls, these systems collect no new data — they generate predictions based on patterns in training data, then present those predictions in the format of a traditional poll. The intermediate reasoning is invisible by design. You get the result, not the argument.

## World Four: The Queryable Layer

MiroShark, at 1,368 stars and 290 forks, occupies a position that none of the other three worlds fill. It is a product, not a paper — the simulation runs from a CLI or API call, costs a dollar, and finishes in under ten minutes. It is open source, not a black box — every line of the engine and every agent prompt is inspectable. And unlike both the research sandboxes and the commercial platforms, its output is not a file or a topline. It is forty-one independently queryable API endpoints, each exposing a different intermediate state of the same simulation.

That last property is the architectural decision that defines its position on the map. The confidence trajectory endpoint returns how certainty evolved round by round. The stance flip report shows which agents changed positions and when. The mention network maps who influenced whom. The per-platform sentiment divergence reveals how the same argument played differently on simulated Twitter versus a governance forum. Each endpoint has its own schema, cache headers, and documentation. A downstream system can consume any surface without touching the others.

Thirteen projects have publicly identified as building on top of the engine — AntFleet benchmarks it, Capacitr integrates it into a product spec, Noelclaw wraps it in MCP tooling, Blue Agent runs it as an autonomous bot. The ecosystem is small but structurally distinct: these are not forks running the simulation as-is. They are products consuming specific surfaces.

## What the Map Tells You

If you are building agent workflows, you are in World One. If you are publishing research on emergent social behavior, you are in World Two. If you are selling synthetic survey data to political campaigns, you are in World Three. If you need to understand the structure of an argument — not just the conclusion but the trajectory, the dissent, the influence graph — and you need that structure as an API you can query, embed, and build on, the map has one entry.

The landscape is crowded. The overlap is thinner than it looks.

---
*Sources: [AI-Synthetic-Society-Experiments Resource List](https://github.com/danielrosehill/AI-Synthetic-Society-Experiments), [LangChain State of AI Agents 2026](https://www.langchain.com/stateofaiagents), [ScioMind: Cognitively Grounded Multi-Agent Social Simulation](https://arxiv.org/abs/2605.13725), [New Statesman — Why Pollsters Are Replacing People with Bots](https://www.newstatesman.com/politics/polling/2026/05/pollsters-dont-need-real-people-anymore), [Nate Silver — AI Polls Are Fake Polls](https://www.natesilver.net/p/ai-polls-are-fake-polls), [Multi-Agent Orchestration Frameworks 2026](https://presenc.ai/research/multi-agent-orchestration-frameworks-2026)*
