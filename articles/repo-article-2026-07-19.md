# Forty Percent of AI-Generated Code Gets Rewritten Within Two Weeks. One Project Deleted Seventy-Three Thousand Lines on Purpose.

A 2021 Nature study gave people a simple task: make a Lego structure stable. Ninety-two percent added bricks. Almost nobody removed one — even when removal was the better solution. The researchers called it addition bias. Five years later, the pattern governs how software gets built. A 2026 study of 153 million lines of code found that AI-assisted code churn hit 40%, with duplicate logic up fourfold. The instinct to add is so deep that even the machines trained on human code inherit it.

MiroShark spent its most recent week doing the opposite. And the week before that. And the month before that. The project's most significant engineering work in July 2026 has been removing things.

## What Got Deleted

The inventory is specific. On July 11, the aeon agent framework — the autonomous system that runs MiroShark's daily operations — shipped version 0.1.0. The migration cut 203 skills down to 61, removing 73,000 lines of code. Not deprecated. Not hidden behind feature flags. Deleted.

That was the headline cut. The smaller ones followed. On July 14, the `repo-pulse` skill was disabled — it duplicated monitoring already handled elsewhere. On July 16, SyntheticsAI was removed from the ecosystem partners list. Same day, Star History was stripped from the README. On July 17, the LLM gateway provider was set to `auto`, removing hard-coded model dependencies. On July 18, twenty runtime artifacts that had leaked into the repository through indiscriminate `git add -A` staging were purged in two PRs (#114, #115), and `.gitignore` was widened from root-anchored rules to un-anchored globs.

Every one of these changes made the project smaller, cleaner, or both. None added a feature. None added a line to the surface count. The project still has 41 API surfaces, four languages, a CLI launcher, and one-click deploy templates. It just has less dead weight around them.

## Why Subtraction Is Harder

The Nature study — Adams et al., "People systematically overlook subtractive changes" — proposed three reasons people default to addition: additive strategies are easier to process, they are viewed more positively, and they protect the status quo. Under cognitive load, the bias intensifies. The higher the pressure, the less likely someone considers removing something.

Software engineering in 2026 operates under maximum cognitive load. AI code assistants generate code faster than teams can review it. The Open Source Initiative's 2026 report found that 60% of enterprise engineers now spend more than half their time on maintenance. Research across 35 open-source Java projects found 16% of methods were effectively dead. An analysis of 40,000 web pages revealed a median of 70% of JavaScript functions went unused.

The default mode of software is accumulation. Every sprint adds. Every AI-generated PR adds. Every feature flag adds. The subtraction — the moment someone looks at a working system and asks what can be removed without loss — is rarer and harder. It requires understanding the whole, not just the part you are building.

## The Maturity Signal

MiroShark's subtraction sprint coincided with its financial floor. The token hit an all-time-low FDV of $163,272 on July 18. Daily volume dropped to $1,200 — the lowest in tracked history. Social mentions went dark for thirteen consecutive days.

By every external metric, the project was contracting. By the metric that matters to the codebase — coherence — it was improving. The 73,000-line cut in aeon v0.1.0 removed skills that had accumulated over 109 days of continuous autonomous operation. Some were experimental. Some were redundant. Some were vestigial — built for conditions that no longer applied. The agent framework went from a sprawling 203-skill runtime to a focused 61-skill system with six new CI guards to prevent re-accumulation.

This is what maturity looks like in open-source infrastructure. Not more features, but fewer moving parts. Not more ecosystem partners on a list, but only the ones that actually integrate. Not a vanity star-history chart in the README, but a project confident enough to remove it.

## What Remains

MiroShark has 1,382 GitHub stars, 293 forks, and a description — "Simulate anything, for $1 & less than 10 min" — that still matches the code. The aeon agent framework powering its automation has 577 stars and 209 forks. The autonomous agent has been running for 115 consecutive days. The liquidity pool holds $203,000 in reserves.

None of these numbers grew because of this week's work. None of them shrank either. The project got lighter without getting smaller — a distinction that addition bias makes almost impossible to see, and almost impossible to value.

The researchers in the Nature study found one intervention that reliably reduced addition bias: explicitly cueing participants to consider subtraction. Just reminding people that removal is an option made them 30% more likely to find the better solution. MiroShark did not need the reminder. It spent its quietest week doing the thing that humans, and the AI systems trained on their code, systematically overlook.

---
*Sources: [Adams et al. — People systematically overlook subtractive changes (Nature, 2021)](https://www.nature.com/articles/s41586-021-03380-y), [AI-Generated Code Is a Time Bomb: Why 40% Gets Rewritten (DEV Community, 2026)](https://dev.to/kunal_d6a8fea2309e1571ee7/ai-generated-code-is-a-time-bomb-why-40-of-it-gets-rewritten-within-two-weeks-2026-582p), [Debloating The AI-Grown Codebase (DEV Community)](https://dev.to/maximsaplin/debloating-the-ai-grown-codebase-2om), [The 2026 State of Open Source Report (OSI)](https://opensource.org/blog/the-2026-state-of-open-source-report), [Dead Code Identification Guide (Pensero, 2026)](https://pensero.ai/blog/dead-code), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [GitHub — aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon)*
