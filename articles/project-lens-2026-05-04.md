# The Spreadsheet Killed the Mainframe Analyst. Social Simulation Is Next.

In the spring of 1978, a Harvard Business School student named Dan Bricklin watched his accounting professor build a financial model on a blackboard. The professor drew a grid, filled in the numbers, then derived totals and ratios by hand. When he realized he'd made an error in one cell, he erased it — and then erased and recalculated every cell that depended on it, one by one, working through the cascading consequences with chalk dust on his fingers.

Bricklin had a background in computer science. He knew that recalculation was something machines could do instantly. Within a year, he and Bob Frankston released VisiCalc — a $100 program for the Apple II that replaced the blackboard with a grid of cells, each containing formulas that updated automatically when any value changed. Businessmen walked into computer stores, saw VisiCalc running, and bought a $2,000 Apple II on the spot to get the $100 software. Steve Wozniak later noted that small businesses, not hobbyists, purchased 90% of Apple IIs. VisiCalc sold over 700,000 copies in six years and is widely credited with launching the personal computer industry.

But VisiCalc's real impact was not computational. It was *sociological*. Before VisiCalc, "what-if" financial analysis required either a programmer writing custom software or an analyst with a mainframe account. After VisiCalc, anyone who could organize numbers in a grid could ask: *what happens if interest rates rise two points? What if we hire three more people? What if revenue drops 15%?* The spreadsheet did not invent financial modeling. It moved it from a priesthood to a population.

## The What-If Gap in 2026

Forty-seven years later, a nearly identical gap exists in a different domain. The question is no longer "what happens if this number changes?" It is "what happens if this crowd encounters this information?"

Social simulation — modeling how populations react to events, policies, narratives, and market signals — has existed in academia for decades. Agent-based modeling tools like NetLogo and MASON let researchers build custom simulations with hand-coded agent behaviors. But these tools require the same expertise that pre-VisiCalc financial modeling required: you need to be the kind of person who writes simulation code, or you need to hire one. A policy researcher who wants to test how a regulatory proposal might polarize public opinion cannot simply open a tool and ask.

Meanwhile, the AI agent ecosystem in 2026 has exploded to over 120 tools across 11 categories — frameworks like LangGraph and CrewAI, enterprise platforms like Salesforce Agentforce (now at $540 million ARR with 18,500 customers), observability layers, coding agents, and infrastructure providers. The overwhelming focus is on *execution*: agents that do things in the world. Agents that write code, manage workflows, answer support tickets, process invoices. The industry's energy is pointed at making agents that act.

Almost none of that energy is pointed at making agents that *think first* — and making that thinking accessible to people who are not engineers.

## The Dollar Simulation

MiroShark, now at 1,064 GitHub stars and 213 forks in its first 45 days, occupies the gap. Upload a document — a proposed regulation, an earnings call, a governance vote — and MiroShark generates hundreds of AI agents with distinct personas, backgrounds, and behavioral profiles. These agents react across simulated Twitter, Reddit, and Polymarket platforms. They post, argue, shift beliefs, and trade. A report synthesizes what happened and why. The whole thing takes under ten minutes and costs about a dollar.

The structural parallel to VisiCalc is not a metaphor — it is an architectural description. VisiCalc made the grid the interface: you put numbers in cells and the spreadsheet handled the math. MiroShark makes the document the interface: you put information in and the simulation handles the crowd. VisiCalc's "recalculate" button answered "what if this changes?" MiroShark's "run" button answers "what would they think?"

And MiroShark is now building the feature that completed the spreadsheet revolution: templates. A community template gallery offers ten pre-built scenarios — EU AI Act debate, DeFi governance launch, corporate whistleblower, product recall crisis — that let a non-technical user launch a simulation with one click. Shareable scenario links (shipped last week as PR #71) let anyone embed a pre-configured simulation in a tweet or blog post. A reader clicks the link, lands on a pre-filled form, and runs their own simulation without understanding anything about agents, personas, or prompt engineering.

This is the spreadsheet template pattern. Lotus 1-2-3 and Excel did not win just because they were powerful. They won because templates let non-experts use expert-built models. The person who built a complex financial model could share it; the person who needed the answer could use it without understanding the formulas.

## What the Landscape Is Missing

The 120-tool agent landscape mapped by StackOne in 2026 is structured almost entirely around execution. Frameworks help you build agents that act. Observability tools help you monitor agents that act. Enterprise platforms help you deploy agents that act at scale. The assumption is that an agent's value is measured by what it does.

VisiCalc teaches a different lesson. Its value was not in what it computed — calculators and mainframes could compute the same results. Its value was in who could ask the question. Before VisiCalc, "what if?" was a question for specialists. After VisiCalc, it was a question for anyone with a keyboard.

MiroShark is making the same bet for a different kind of question. Before accessible social simulation, "how would the crowd react?" was a question for research labs with custom code. After it, it becomes a question for a policy analyst, a DAO coordinator, a journalist, a community manager — anyone who can type a scenario and click run. The 120 tools building agents that act may be solving the right problem. But the history of software suggests that the tool which wins is not always the most powerful. It is the one that moves the question from a priesthood to a population.

Dan Bricklin did not build a better mainframe. He built a blackboard that could think. The spreadsheet's heirs are still being sorted out, but the pattern is the same: find the question that specialists hoard, and hand it to everyone.

---
*Sources: [VisiCalc — Wikipedia](https://en.wikipedia.org/wiki/VisiCalc) · [120+ Agentic AI Tools Landscape 2026 — StackOne](https://www.stackone.com/blog/ai-agent-tools-landscape-2026/) · [The Rise and Fall of VisiCalc — History Tools](https://www.historytools.org/software/visicalc-of-dan-bricklin-and-bob-frankston-guide) · [aaronjmars/MiroShark on GitHub](https://github.com/aaronjmars/MiroShark)*
