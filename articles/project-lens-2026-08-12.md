# In 1950, the Air Force Asked a Roomful of Experts How Many Bombs the Soviets Had. Then It Took Away the Room.

The question was impossibly specific: how many atomic bombs would the Soviet Union need to deploy to reduce U.S. munitions output by a defined percentage? It was 1950 and nobody knew the answer — not the generals, not the intelligence analysts, not the physicists. The RAND Corporation, the Air Force's civilian think tank in Santa Monica, assigned two researchers named Olaf Helmer and Norman Dalkey to find out. Not by building a better spy network. By building a better way to ask.

Their method had four rules. First, the experts would never meet face-to-face. Each one answered independently, in writing, without knowing who the others were. Second, after the first round, every expert received a summary of all responses — the range, the median, the outlier reasoning — but no names attached to any of it. Third, each expert revised their answer in light of what the group had said. Fourth, the process repeated until the answers converged or the disagreements stabilized. The first round produced estimates ranging from 50 to 5,000 bombs. By the final round, the group had narrowed to a range of 167 to 360.

They called it the Delphi method, after the oracle. It was not an oracle. It was something more useful: a structured process for extracting signal from a room full of people who disagreed.

## Seventy Years of Slow Consensus

The Delphi method worked well enough to escape the military. By the 1970s it was standard practice in technology forecasting, public health, education policy, and urban planning. The World Health Organization used it to set clinical guidelines. Pharmaceutical companies used it to prioritize drug development pipelines. Government agencies used it to forecast energy demand. A 2024 scoping review of Delphi studies in aging research alone cataloged hundreds of applications across six years.

The method's power was its constraints. Anonymity prevented dominant personalities from hijacking the group. Iteration forced experts to confront disagreement rather than retreat to their priors. Structured feedback turned a collection of individual opinions into something closer to collective intelligence. When the sociologist James Surowiecki popularized the "wisdom of crowds" concept in 2004, the Delphi method was his most rigorous example.

But Delphi had a cost structure that never improved. A traditional study requires recruiting ten to eighty domain experts, running two to four rounds of structured questionnaires, synthesizing feedback between each round, and managing the inevitable dropout — experts who agree to participate in round one and vanish by round three. Timeline: four to twelve weeks. Budget: comparable to a mid-range consulting engagement. The ICON plc 2025 methodology guide notes the persistent trade-off between cost, timeline, and rigor that limits who can run these studies. A community development director with an eleven-thousand-dollar annual engagement budget — the median figure from the Granicus 2026 Civic Engagement report — cannot afford a single Delphi panel.

The method that democratized expert opinion among researchers remained inaccessible to the people who needed it most.

## The 2026 Shortcut and Its Mirage

This year, researchers tried the obvious fix: replace the experts with language models.

A study published in the International Journal of Surgery ran eight LLMs through a modified Delphi protocol, evaluating 135 medical statements from a bariatric surgery consensus study. The LLMs independently assessed each statement in round one, revised based on group feedback in round two, and debated in pairs in round three. The result: LLMs achieved a 93.3 percent consensus rate, compared to 81.5 percent for the human expert panel that had originally evaluated the same statements.

The number sounds like progress. A letter to the editor in the same journal called it "the mirage of consensus." The concern was precise: LLMs trained on overlapping corpora converge not because they have independently evaluated evidence, but because they share the same statistical priors. Their agreement is an artifact of shared training data, not a signal of deliberative convergence. Consensus without genuine disagreement is not consensus. It is an echo.

Separately, Harvard psychologist Ashwini Ashokkumar led a study published in Nature analyzing seventy experiments involving roughly 120,000 participants. GPT-4 was good at ranking which interventions would be more or less effective — the relative ordering was sound. But the model systematically estimated effects at roughly twice their actual magnitude. It knew which direction things would move. It did not know how far. The researchers also found demographic bias: the model performed better for white and Republican samples than for others. Accurate ranking, unreliable magnitude, uneven coverage. A useful supplement to pilot research. A dangerous replacement for it.

## The Lineage Nobody Noticed

MiroShark is an open-source opinion simulation engine — 1,428 stars, 298 forks on GitHub — that does not cite the Delphi method anywhere in its documentation. But the architectural fingerprints are unmistakable.

Agents are anonymous. Each one carries a profession, a set of concerns, and a cognitive profile, but no agent knows which other agents are in the simulation. This is Helmer and Dalkey's first principle: remove the room. Remove eye contact, body language, deference to authority, the performative confidence of the loudest voice.

Deliberation happens in rounds. Agents do not produce a single response and stop. They read what other agents have said, revise their positions, and respond again. The simulation tracks each agent's stance across every round — the confidence trajectory — producing exactly the convergence curve that a Delphi facilitator would have drawn by hand in 1955.

The critical difference is what MiroShark measures that Delphi never could. A traditional Delphi study records each expert's position at each round. It does not record when a position changed, what argument triggered the change, or which expert's reasoning propagated to which other experts. MiroShark's stance flip report identifies the exact round and the specific argument that caused each agent to shift. Its mention network maps which agents influenced which others, producing a directed graph of persuasion that no human facilitator could reconstruct from a stack of anonymous questionnaires. Its per-platform sentiment analysis breaks down how opinion dynamics differ across simulated Twitter, Reddit, and forum environments — something the original Delphi designers could not have imagined, because in 1950 there was only one platform: the written questionnaire.

The result is a Delphi study that runs in under ten minutes and costs a dollar. Not because it skips the method's constraints — anonymity, iteration, structured feedback — but because it automates them.

## What Changes at a Dollar

The Delphi method spent seventy years as a tool for institutions that could afford it. RAND, the WHO, Fortune 500 pharmaceutical companies, government agencies with dedicated forecasting divisions. The method was powerful precisely because it was expensive: the anonymity, the iteration, the structured feedback loop all required a facilitator with time and budget. When Surowiecki wrote about the wisdom of crowds, the implicit caveat was that extracting that wisdom required infrastructure.

MiroShark does not make the Delphi method cheaper. It makes the *question* cheaper. The community development director who cannot afford a single expert panel can run twelve simulations exploring twelve different framings of the same zoning question before the public hearing. The startup founder who would never commission a focus group can test how a product-market narrative plays across six different professional archetypes. The researcher who can run one Delphi study per grant cycle can run a hundred in an afternoon as a pilot filter — using the simulated disagreement to identify which questions are worth spending real expert time on.

The pattern is familiar from other domains. When sequencing a genome dropped from $100 million to $1,000, the change was not that genomics got cheaper. It was that entirely new questions became askable. When satellite imagery went from classified to commercial to free, the change was not that pictures of Earth got cheaper. It was that monitoring became continuous.

When structured opinion aggregation drops from $100,000 and twelve weeks to $1 and ten minutes, the change is not that consensus gets cheaper. It is that disagreement becomes visible — its structure, its fault lines, the conditions under which it moves — to people who could never previously afford to look.

Helmer and Dalkey removed the room because the room was distorting the signal. Seventy-six years later, the room is gone entirely. The signal is what remains.

---
*Sources: [RAND Corporation Delphi Method overview](https://www.rand.org/topics/delphi-method.html), [Dalkey & Helmer, "An Experimental Application of the DELPHI Method to the Use of Experts," Management Science (1963)](https://pubsonline.informs.org/doi/10.1287/mnsc.9.3.458), [Ashokkumar et al., "AI can predict how you'll respond to a survey — but that's not the same as understanding you," Nature / Phys.org (July 2026)](https://phys.org/news/2026-07-ai-youll-survey.html), [ICON plc, "Designing Delphi panels" (2025)](https://www.iconplc.com/insights/blog/2025/08/07/designing-delphi-panels-useful-non-standardised-tool-patient-centric), ["The mirage of consensus: rethinking AI-driven Delphi simulations in surgical expert panels," International Journal of Surgery (2026)](https://doi.org/10.1097/JS9.0000000000004069), ["How does AI compare to the experts in a Delphi setting," International Journal of Surgery (2026)](https://journals.lww.com/international-journal-of-surgery/fulltext/2026/02000/how_does_ai_compare_to_the_experts_in_a_delphi.19.aspx)*
