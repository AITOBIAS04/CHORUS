# The Choice Was Never Whether to Simulate. It Was Whether to Write the Model Down.

In 2008, the computational social scientist Joshua Epstein published a paper titled "Why Model?" that asked a question most people in his field thought had an obvious answer. The standard justification for building agent-based models was prediction — you build a model to forecast what will happen. Epstein's argument was different. The choice, he wrote, is not whether to build models. "When you close your eyes and imagine an epidemic spreading, or any other social dynamic, you are running some model or other. It is just an implicit model that you haven't written down."

This distinction — between implicit models and explicit ones — turns out to be the most important idea in computational social science. And it is quietly becoming the most important idea in a category of software that did not exist two years ago.

## Twenty-Four Centuries of Mental Simulation

The thought experiment is philosophy's oldest and most productive tool. Plato's Cave, the Ship of Theseus, Galileo's falling bodies, Newton's cannonball, Einstein's elevator, Schrödinger's cat, the Trolley Problem — for twenty-four centuries, the method has been the same. Construct a scenario in your mind. Populate it with actors, constraints, initial conditions. Run it forward. Observe what happens. Draw conclusions.

The method works. It works so well that it produced the theory of relativity, the foundations of quantum mechanics, and most of modern ethics. But it has a structural limitation that its practitioners rarely acknowledge: the simulation runs on a single processor — the thinker's own mind — and the parameters, assumptions, and intermediate states are never externalized. You cannot rerun Schrödinger's cat with different initial conditions. You cannot query the intermediate states of the Trolley Problem. You cannot ask a third party to verify that Plato's Cave produces the same conclusions when a different philosopher runs it with the same inputs.

In 2021, the philosophers Conor Mayo-Wilson and Kevin Zollman published a paper in *Synthese* making an argument that would have been heretical a generation earlier: computational simulations should be considered a core philosophical method, and they are superior to thought experiments for five of the six purposes thought experiments traditionally serve. The exception was eliciting normative intuitions — asking "what feels right." For everything else — justifying counterfactual claims, exploring logical relationships, illustrating conceptual possibilities, distinguishing explanatory reasons, and exploring the dynamics of social and physical systems — simulations won.

The reason is not speed or scale. It is the property Epstein identified: explicitness. A simulation forces the modeler to write down every assumption. What do the agents believe? How do they update? What information do they have access to? A thought experiment lets these details stay vague. A simulation cannot.

## The Schelling Moment

The most cited example of why this matters is Thomas Schelling's segregation model from 1971. Schelling asked a simple question: what happens when individual agents have modest preferences about their neighbors — not hostility, just a mild preference for having some neighbors who resemble them? The thought experiment version of this question produces an intuitive answer: mild preferences produce mild sorting.

The simulation produced a wildly different answer. Mild individual preferences generated large-scale segregation. Complete sorting emerged from incomplete bias. No thought experiment could have predicted this, because the emergent behavior was not contained in the assumptions — it arose from the interaction of assumptions across thousands of agents over hundreds of timesteps. The human mind cannot track that many interactions. Simulation can.

This is not a failure of thought experiments. It is a boundary condition. When the system you are reasoning about involves multiple agents with different information, different priors, and the ability to influence each other — when you are reasoning about opinion dynamics — the thought experiment fails precisely where it matters most. Humans, as Mayo-Wilson and Zollman put it, "lack reliable implicit knowledge of social dynamics."

## From Gedanken to CLI

MiroShark, the open-source opinion simulation engine with 1,353 GitHub stars, operationalizes the thought experiment. Not metaphorically — literally. The scenario that a founder, researcher, or DAO operator used to run in their head — "what would twelve people from different professional backgrounds think about this?" — is now four shell commands: `simulate`, `wait`, `stop`, `cost`. The implicit model becomes explicit. The assumptions become parameters. The results become queryable.

The forty-one API surfaces that MiroShark exposes are the externalized intermediate states that thought experiments never had. A confidence trajectory tracks how certain the simulated population becomes over time. Stance flip reports show which agents changed their minds and when. Per-platform sentiment divergence reveals how the same argument plays differently across different social contexts. The mention network maps who influenced whom. Each surface answers a question that a thought experiment would handle with "and then everyone formed an opinion" — compressing the most interesting part of the process into a black box.

The pre-run estimator tells you the cost before you commit: a dollar and ten minutes for a hundred agents. Philosophy's thought experiments were free but unverifiable. Laboratory experiments were verifiable but expensive. Simulation occupies the middle — cheap enough to run speculatively, explicit enough to interrogate.

## What Changes When You Write It Down

Epstein's list of reasons to model extended well beyond prediction. Explanation. Illumination of core dynamics. Discovering new questions. Bounding outcomes. Training intuition. He argued that the most important function of a model is not to get the right answer but to expose the assumptions that produce it. A model that gives a wrong answer for an interesting reason is more valuable than a correct intuition whose reasoning is invisible.

This is the philosophical argument for opinion simulation. The point is not that twelve AI agents produce the definitive reaction to your product launch. The point is that the simulation forces you to declare who is in the room, what they know, how they reason, and what channels they communicate through — then shows you what those assumptions produce, and lets you change them and run again. The Gedankenexperiment gets a save button.

Twenty-four centuries of philosophers ran simulations on wetware and never exported the results. The question was never whether people simulate — they do, every time they predict how an audience will react. The question is whether the simulation is implicit or explicit, intuitive or queryable, a one-time flash of insight or a rerunnable process. For the first time, writing it down costs a dollar.

---
*Sources: [Joshua Epstein, "Why Model?" (2008)](https://jasss.org/11/4/12.html) · [Mayo-Wilson & Zollman, "The Computational Philosophy: Simulation as a Core Philosophical Method," Synthese (2021)](https://pmc.ncbi.nlm.nih.gov/articles/PMC7944252/) · [AI Agents Are Not (Yet) a Panacea for Social Simulation (arXiv, March 2026)](https://arxiv.org/html/2603.00113v1) · [MiroShark GitHub](https://github.com/aaronjmars/MiroShark)*
