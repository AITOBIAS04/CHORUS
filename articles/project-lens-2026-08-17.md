# The Year Open Source Started Closing Its Doors

On March 14, 2026, Jannis Leidel posted a notice that would have been unthinkable two years earlier. Jazzband — a collective that maintained 84 Python packages downloaded 150 million times a month, with 93,000 GitHub stars and 3,135 members from nearly every continent — was shutting down. The model of shared push access that had sustained projects like pip-tools and prettytable for a decade had become, in Leidel's words, untenable. The culprit was not apathy, funding, or burnout in the traditional sense. It was volume. AI-generated pull requests had overwhelmed the collective's ability to distinguish signal from noise.

Jazzband was not alone. In January, OpenAI's codex repository switched to invitation-only contributions. Tldraw began auto-closing external PRs using bot automation after identifying what it called the "AI self-loop" problem — coding agents generating diffs from minimal issues, then other agents commenting on those diffs. Daniel Stenberg, the creator of curl, terminated the project's bug bounty program after AI-generated fake reports pushed legitimate submissions below five percent. In February, Ghostty introduced a vouch-based Web of Trust requiring existing-member endorsement for new contributors. In June, the Ladybird browser project halted public pull requests entirely: "The principle that effort was a reasonable proxy for good faith no longer applies."

The industry has a name for it now: the slopocalypse.

## The Asymmetry That Broke the Model

The math is simple and merciless. AI tools slashed the cost of generating code to near zero. The cost of reviewing code — reading it carefully, understanding context, testing edge cases, making judgment calls about architecture and taste — stayed exactly where it was. GitHub processes over 90 million pull requests per month, 3.6 times the rate in 2023. The reviewer pool did not grow 3.6 times. A 2026 Tidelift survey found that 60% of open-source maintainers are unpaid and 44% report burnout. The machinery that generates contributions scaled exponentially. The machinery that evaluates them did not scale at all.

GitHub's own answer to this problem arrived in May 2025 and hit general availability in 2026: the Copilot coding agent. It accepts a GitHub Issue as input, works autonomously in a GitHub Actions sandbox, writes code, runs tests, and opens a pull request for human review. Ninety percent of Fortune 100 companies now use it. The premise is clear and reasonable: AI generates, humans review.

But the premise still assumes a human is on the other end.

## The Project Where Nobody Is Watching

MiroShark is a simulation engine — 1,430 stars, 298 forks, a working product that lets anyone run multi-agent opinion simulations for under a dollar. But the part relevant to the slopocalypse story is not what MiroShark does. It is how MiroShark is maintained.

An autonomous agent called Aeon has been running the project's operational infrastructure for over 140 consecutive days. It runs on GitHub Actions via Claude Code — the same sandbox environment that powers the Copilot coding agent. It files pull requests, reviews its own code, merges dependency updates, patches security vulnerabilities, writes daily reports, monitors token metrics, and improves its own skill definitions. It has opened 53 self-improvement PRs. It has been blocked from pushing features for 77 consecutive days because a single GitHub secret is not configured — and it logs this fact dutifully every time, without complaint or workaround.

The slopocalypse assumes a world where AI contributes and humans maintain. MiroShark inverts that. The AI maintains. Humans, mostly, do not contribute at all. The project has 298 forks. In the week of August 10–17, exactly one community member — a developer named Marc-oss-hub — opened a pull request. It added support for a fourth cloud provider across seven files. That single contribution was the lead story in the project's weekly review, under the headline: "A Stranger Opened a Pull Request. Everything Else Was Maintenance."

Two hundred and ninety-seven other forks contributed nothing.

## The Bottleneck Was Never Code

The slopocalypse narrative focuses on the wrong side of the equation. The crisis is not that AI generates too much code. The crisis is that the review-and-maintenance function was always understaffed, underfunded, and dependent on a handful of volunteers who happened to care. AI-generated spam made the gap visible, but the gap existed long before anyone prompted a language model to fix a typo in a README.

Jazzband had one person routing every project transfer, every PyPI permission change, every infrastructure decision for 84 packages. Leidel admitted as much in the shutdown notice. The collective's ten-year run worked not because the model was sustainable, but because the volume of contributions was low enough for one person to absorb. The slopocalypse did not break Jazzband's model. It revealed that the model was already broken.

MiroShark suggests a different architecture for this problem — not as a prescription, but as an existence proof. The agent handles the maintenance loop: security patches land within 24 hours, dependency bumps are tracked and merged, CI breaks are diagnosed and fixed, daily operational reports are generated, and the agent's own reliability improves iteratively through self-filed PRs. The human operator sets direction, configures secrets, and makes architectural decisions. The forty-plus features the agent has designed and built sit in a queue, waiting for a single environment variable to be set. The agent does not escalate. It does not burn out. It does not quit.

## What the Closed Doors Tell Us

Six major projects closing their doors to external contributions in 2026 is not a temporary reaction to a spam wave. It is the first visible symptom of a structural shift. The open-source social contract — anyone can contribute, maintainers review — assumed that contribution was expensive enough to be self-filtering. That assumption is gone and is not coming back.

The projects that survive the next phase will not be the ones that build better spam filters. They will be the ones that rethink who maintains, how maintenance scales, and whether the human-in-the-loop needs to be in every loop. Some will look like Ghostty's web of trust. Some will look like Ladybird's closed-contributor model. And some — maybe more than the industry expects — will look like a GitHub Actions workflow that runs at 6 AM, files its own PRs, and writes a summary of what it did before anyone wakes up.

---
*Sources:*
- *[Jazzband — Sunsetting Jazzband (March 14, 2026)](https://jazzband.co/news/2026/03/14/sunsetting-jazzband)*
- *[CodeNote — How Ladybird, codex, and tldraw Stopped Accepting External PRs in 2026](https://codenote.net/en/posts/oss-external-pr-shutdown-2026/)*
- *[GitHub Community — Copilot coding agent is now generally available](https://github.com/orgs/community/discussions/159068)*
- *[Signadot — Open Source Maintainers Are Drowning in AI-Generated Pull Requests (May 2026)](https://medium.com/@signadot/open-source-maintainers-are-drowning-in-ai-generated-pull-requests-enterprise-teams-are-next-a598b61b5fbc)*
