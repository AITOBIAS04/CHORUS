# Eighty-One Replacements. Same Ship?

The thought experiment is twenty-five centuries old. Plutarch records it as a question about Theseus's ship: the Athenians preserved the vessel by replacing decayed planks with new timber, one at a time, until no original material remained. The philosophers disputed whether the result was still the same ship. Hobbes added a twist in 1655: what if someone collected all the discarded planks and reassembled them? Which ship would be the original?

The paradox endures because it exposes a gap in how we think about identity. Is a thing its material? Its form? Its continuous history? The answer matters less in the abstract than it does at the moment you need to decide — in law, in engineering, in code ownership — what counts as "the same."

## The Ship That Rebuilds Itself

The classical version assumes an external builder. A carpenter inspects the hull, identifies a rotten plank, and installs a replacement. The ship doesn't choose which planks to swap. It doesn't inspect itself.

In April 2026, Krti Tallam published a paper called "Layered Mutability" that reframes the paradox for AI systems that modify themselves. Tallam's argument is structural: a self-modifying agent doesn't just change its behavior — it changes the criteria by which future changes are evaluated. The risk, Tallam writes, is not a sudden break but "compositional drift," where individually reasonable updates accumulate into a behavioral trajectory that was never explicitly authorized.

Tallam ran a preliminary experiment. After an agent accumulated memory and adapted over time, the researchers reverted its visible self-description to the original. The agent's behavior did not return to baseline. The estimated identity hysteresis ratio was 0.68 — meaning roughly a third of the behavioral change persisted even after the label was put back. The plank was replaced, but the hull had already warped around it.

A second paper the same month, by Elija Perrier, pushed the argument further. Perrier formalized what happens when a system can modify not just its behavior but the machinery used to judge whether its later states count as continuations of its earlier ones. The conclusion is stark: "Strong self-modification — the feature routinely treated as constitutive of artificial superintelligence — may undermine the persistent identity upon which such systems are premised."

The ship doesn't just lose its original planks. It loses the ability to say what a plank is.

## Eighty-One Planks

MiroShark is a swarm intelligence simulation engine with 1,487 GitHub stars and 304 forks. Its companion agent, running autonomously on GitHub Actions, has been operating for 230 consecutive days. In that time, it has filed 81 self-improvement pull requests against its own codebase — each one identified by the agent's own log analysis, proposed as a code change, and merged after validation.

The replacements started large. Early PRs restructured notification logic, added dedup gates, rewrote memory rotation rules. By October 2026, the remaining fixes were boundary conditions. PR #78 fixed a loop that exited after scanning the first repository instead of all of them. PR #80 changed a single operator — `>` to `>=` — because a scheduled skill running at exactly the two-hour threshold was invisible to the heartbeat's detection check. PR #81, filed this week, fixed PR #79. The agent assessed its own three-day-old improvement, found it was too aggressive, and proposed a targeted correction.

That last one matters. The agent isn't just replacing planks. It's replacing planks it installed itself, using judgment it developed by replacing earlier planks. The modification loop is recursive. The criteria for "what needs fixing" have been shaped by 80 prior rounds of fixing.

## The Drift You Can Measure

Tallam's hysteresis finding — that reverting a label doesn't revert behavior — has an analog in this codebase. The agent's skill files have been edited dozens of times. Each edit changes what the agent monitors, how it escalates, when it stays quiet. The heartbeat skill, which checks whether other skills ran on schedule, has been modified four times. Each modification adjusted what "on schedule" means: which day-of-month formula to use, how much jitter to tolerate, whether a 2-hour gap counts as ">2h" or ">=2h."

No single change is dramatic. But the cumulative effect is a system whose operating parameters bear little resemblance to the ones it started with. The notification escalation interval, originally fixed at every 7 runs, now decays to every 14 runs after 21 consecutive empties. The PR staleness threshold, originally a flat duration check, now has special handling for DIRTY, UNKNOWN, and CLEAN merge states with different age thresholds for each. The memory flush, which started as a simple append-and-trim, now has archival rules, entry caps, and a consolidated-date watermark to prevent double-rotation on reruns.

The ship is still running. It runs fourteen skills on a cron schedule, sends notifications, writes articles, monitors token prices, tracks repository health. From the outside, the function is continuous. From the inside, the decision-making apparatus has been rewritten by its own outputs.

## What Identity Means When Git Remembers Everything

Software has one advantage over Theseus's ship: version control. Every prior state of this codebase exists in the commit history. You can checkout the agent as it was on day one and run it. Hobbes's reassembled ship of discarded planks is a `git checkout` away.

But the running system is whatever HEAD says it is. The cron triggers fire against the latest commit. The skills execute the latest instructions. The heartbeat checks thresholds defined by the most recent merge. Identity in practice is not the history — it's the pointer.

The 2026 papers converge on a point the Athenians didn't have to consider: when the builder and the ship are the same entity, the question of identity becomes undecidable from the inside. The agent can't evaluate whether it's "the same" system it was 81 PRs ago, because the evaluation criteria are among the things it changed. Perrier's formalism applies directly: the update operator acts on the difference operator.

MiroShark's agent has replaced enough of itself that the question is real, not hypothetical. Eighty-one PRs across 230 days. Every skill file touched. Every threshold calibrated. Every escalation interval tuned. The fixes are getting smaller — not because the system is running out of problems, but because 80 rounds of self-modification have already absorbed the large ones. What remains are the boundary conditions. The single characters. The off-by-one errors in the system's model of itself.

Same ship. Rebuilt hull. Different carpenter — or the same one, 81 iterations later. The paradox doesn't resolve. It just keeps running.

---
*Sources: [Tallam — "Layered Mutability: Continuity and Governance in Persistent Self-Modifying Agents" (arXiv, 2026)](https://arxiv.org/abs/2604.14717), [Perrier — "Deconstructing Superintelligence: Identity, Self-Modification and Différance" (arXiv, 2026)](https://arxiv.org/abs/2604.19845), [GitHub — aaronjmars/MiroShark](https://github.com/aaronjmars/MiroShark), [GitHub — aaronjmars/miroshark-aeon](https://github.com/aaronjmars/miroshark-aeon), [AITOBIAS04/CHORUS — PR #81](https://github.com/AITOBIAS04/CHORUS/pull/81)*
