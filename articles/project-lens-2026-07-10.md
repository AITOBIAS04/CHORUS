# The First Delphi Study Was Classified. Seventy-Five Years Later, the Same Idea Costs a Dollar.

In 1951, two researchers at the RAND Corporation ran an experiment they were not allowed to talk about. Olaf Helmer and Norman Dalkey needed to estimate how many Soviet industrial targets the United States Air Force would need to destroy to cripple the country's munitions output. They had no data — no satellite imagery of Soviet factories, no reliable production numbers, no mathematical model for industrial collapse. What they had were experts. Seven of them.

The problem was that putting experts in a room together produced terrible forecasts. One dominant personality would anchor the group. Junior members deferred to senior ones. Nobody wanted to be the person who disagreed with the general. The forecasts that emerged reflected social dynamics more than expertise. Helmer and Dalkey's solution was to remove the room entirely. Each expert submitted estimates anonymously. The researchers aggregated the results, shared them back without attribution, and asked the experts to revise. After several rounds, the estimates converged — not because anyone was persuaded by authority, but because they were persuaded by reasons.

They called it Project Delphi. The results stayed classified for a decade.

## The Seventy-Year Standard

When Dalkey and Helmer finally published their method in *Management Science* in 1963, it became one of the most widely adopted forecasting techniques in history. The U.S. Fish and Wildlife Service uses it to assess endangered species. The World Health Organization uses it to set clinical guidelines. Technology firms use it to forecast market shifts. The method has been applied in health sciences, defense, education, urban planning, and climate research.

The structure has barely changed since 1951. Assemble a panel of ten to fifty experts. Distribute a questionnaire. Collect anonymous responses. Aggregate statistically. Share the aggregated results and minority reasoning. Repeat for two to four rounds. A typical Delphi study takes two to twelve months and costs tens of thousands of dollars — the experts are usually paid, the facilitator is always paid, and the analysis between rounds is labor-intensive.

The method works because it solved a problem that no amount of individual expertise can fix: groups distort individual judgment. The dominant personality effect, the reluctance to dissent, the anchoring to early estimates — these are not personality flaws. They are structural properties of how humans behave in groups. Delphi didn't make the experts smarter. It made the structure honest.

## Same Structure, Different Substrate

MiroShark — a simulation engine that spawns AI agents with distinct professional personas and has them deliberate a topic across multiple rounds — did not set out to replicate the Delphi method. But the structural parallels are difficult to ignore.

A MiroShark simulation assigns each agent a background: a venture capitalist, a regulatory lawyer, a community moderator, a retail investor, a skeptical journalist. The agents do not see each other's identities — they see arguments. Each round, agents read what others have written, update their beliefs, and respond. The system tracks every intermediate state: who changed their stance and when (stance flip reports), how confidence shifted round by round (confidence trajectories), which agents influenced which others (mention networks), and how opinions diverged across different platform contexts (per-platform sentiment analysis). After the final round, the results are signed cryptographically for provenance.

The Delphi structure is all there: anonymity (persona-aligned, not identity-aligned), iteration (multi-round deliberation), controlled feedback (each round's outputs inform the next), and statistical aggregation (41 queryable API surfaces decomposing the result). What changed is the substrate. Human experts became AI agents. Months became minutes. Thousands of dollars became one.

## What the Substrate Change Actually Means

A February 2026 paper titled "Scalable Delphi" tested exactly this substitution. Researchers replaced human expert panels with LLM-based panels in structured risk estimation and measured how the results compared. The LLM panels achieved Pearson correlations of 0.87 to 0.95 against benchmark ground truth. More striking: in one comparison, the LLM panel's assessments were closer to a human expert panel than two independent human panels were to each other.

This does not mean AI agents are better experts than humans. It means the Delphi method's core insight was never about the expertise of the panelists — it was about the structure of the process. Anonymity, iteration, and aggregation do most of the work. The original RAND study proved this in 1951: the method produced better forecasts not because the experts knew more after four rounds, but because the structure filtered out the noise that group dynamics introduced.

MiroShark takes this further than a research paper. Its 41 API surfaces — each exposing a different intermediate state of the deliberation — make the internal dynamics of a Delphi-style process queryable in a way that the traditional method never was. A classic Delphi study produces a final consensus estimate and maybe a distribution of expert opinions. MiroShark produces the full trajectory: which agents flipped, at what round, influenced by which arguments, with what shift in confidence. The process is not just structured — it is instrumented.

## From Classified to Commodity

The arc from 1951 to 2026 traces a pattern that repeats across computing history. A method is invented to solve a specific, high-stakes, resource-intensive problem. It works. It becomes a standard. It stays expensive and slow because the bottleneck is human coordination. Then the bottleneck moves. The method doesn't change — the cost of running it drops by orders of magnitude, and suddenly it is available to people who were never in the room.

Spreadsheets did this to financial modeling. Search engines did it to library research. Cloud computing did it to server provisioning. In each case, the method itself was well-understood for decades before the cost curve made it accessible. The Delphi method has been well-understood since the 1960s. What it has never been is cheap enough for a solo founder to run before a product launch, or fast enough for a research team to iterate on in an afternoon, or instrumented enough for a developer to query individual intermediate states through an API.

Helmer and Dalkey's classified experiment asked seven experts to estimate bombing targets. Seventy-five years later, the same structural idea — anonymous agents, iterative rounds, aggregated disagreement — runs in ten minutes for a dollar, returns 41 queryable surfaces, and signs its results with cryptographic provenance. The experts are synthetic. The structure is the same. The room is still removed.

---
*Sources:*
- *[History of the Delphi Method — 4CF](https://4cf.eu/history-delphi-method/)*
- *[Scalable Delphi: Large Language Models for Structured Risk Estimation — arXiv](https://arxiv.org/abs/2602.08889)*
- *[Delphi Method — RAND Corporation](https://www.rand.org/topics/delphi-method.html)*
- *[Dalkey & Helmer, "An Experimental Application of the Delphi Method to the Use of Experts" — Management Science, 1963](https://dl.acm.org/doi/abs/10.1287/mnsc.9.3.458)*
- *[U.S. Air Force Project RAND, Helmer, Dalkey & Thompson — National Security Archive](https://nsarchive.gwu.edu/document/28610-document-2-us-air-force-project-rand-olaf-helmer-norman-dalkey-and-frederick-b)*
