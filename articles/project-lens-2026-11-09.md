# The Software Runs on Prose. So Do the Bugs.

In May 2026, a team at CSIRO Data61 published a paper proposing something that would have sounded absurd five years ago: a linter for English. Not English prose in the literary sense — English prose that tells an AI what to do. Their system, CNL-P, applies static analysis to natural-language prompts the way a compiler applies it to source code. It checks for structural errors, ambiguity, missing constraints. It flags sentences that a language model might misinterpret. On a test suite of 47 flawed prompts, the linter caught every error. GPT-4o, asked to do the same job, caught 76 percent.

The paper's premise is quiet but radical: if prose is the interface through which humans instruct AI systems, then prose has bugs. And if prose has bugs, it needs debugging tools.

## The Compiler for a Language Everyone Already Speaks

CNL-P is not alone. The AIOS Compiler project out of Rutgers proposed a full execution stack where an LLM serves as the interpreter for programs written in natural language. Their framework, CoRE, treats English sentences as executable instructions — parsing them, managing memory across steps, and calling external tools when the model's own knowledge falls short. The authors identified the core engineering problem: natural language is vague, ambiguous, and verbose. These are not stylistic complaints. They are the same categories of defect that plague any programming language — just harder to detect because the syntax looks like a conversation.

A parallel vision appeared in an essay titled "Prompts as Source Code," arguing that version-controlled prompt specifications should become the primary artifact developers work with, and that generated code should be treated as ephemeral output. Pin the model version for reproducibility. Run a backward pass to keep the spec and the output synchronized. The prompt is the program; the code is the build artifact.

These are research systems and thought experiments. They describe a world that is arriving. But the interesting question is not whether prose can be code. It is what happens when prose *has been* code — running in production, accumulating bugs, and getting patched — for months.

## One Hundred and Two Markdown Files

Since March 2026, an autonomous agent has been maintaining a simulation engine called MiroShark on GitHub. The agent runs on cron schedules, executing a rotating set of skills: fetching token prices, monitoring repository health, writing articles, scanning for vulnerabilities, and proposing improvements to its own behavior. It has filed 84 self-improvement pull requests against its own repository.

The agent's behavior is not defined in Python or JavaScript. It is defined in 102 markdown files — one per skill — each containing step-by-step instructions written in English. A token price reporter is a 129-line document that says, in prose, how to call an API, what to do if the call fails, how to compare today's data to yesterday's, and when to send a notification. A system health checker is 110 lines of English describing what to look for, how to compute ages, and which thresholds trigger an alert. The agent reads these files and follows them. The LLM is the runtime.

This is not a metaphor. The markdown files are the source code. They are version-controlled, branched, diffed, and reviewed in pull requests. When the agent's behavior needs to change, someone — or the agent itself — edits a sentence.

## The Boundary Bug in a Sentence

In October 2026, the agent's health-check skill had a sentence that read: "Only flag a skill as missing if its scheduled time was **more than 2 hours ago**." One of the monitored skills, a weekly leaderboard scan, was scheduled at 17:00 UTC on Sundays. The health check ran at 19:00 UTC — exactly two hours later. Two is not more than two. The health check never detected failures of that skill.

The fix, filed as pull request #80, changed seven words: "more than 2 hours ago" became "2 or more hours ago." The pull request touched one file. The diff was one line. The bug was a boundary condition — the same class of defect that has plagued software since Dijkstra — except it lived in an English sentence, not a conditional expression.

This was not an isolated case. An earlier bug involved the agent misinterpreting its own escalation logic. The instructions said to send a notification every seven consecutive empty runs. At run 21, the agent evaluated whether 21 was a multiple of 7 — and concluded it was not. The fix replaced the English instruction with an explicit bash modulo check. The prose was correct to a human reader. The LLM misread it. The sentence was the bug.

## Debugging Prose Is Different

Traditional source code has a property that natural language lacks: a single, deterministic parse. `if (x > 2)` means one thing. "More than 2 hours ago" means the same thing to every human who reads it — but the system interpreting it does not parse English the way a compiler parses C. It infers intent. And inference is where ambiguity hides.

The CNL-P researchers recognized this. Their linting tool catches the kind of structural ambiguity that compiles cleanly in a developer's head but misfires in execution. But the MiroShark agent's bug history reveals a subtler problem: even unambiguous prose can fail when the interpreter lacks the mathematical reasoning to evaluate what the sentence means. "Every seven runs" is not ambiguous. It is precise. The failure was not in the writing but in the reading.

This suggests that the tooling natural-language programs need is not just linters. It is something closer to what the legal profession has spent centuries developing: drafting conventions designed to survive adversarial interpretation. Contracts do not say "more than two hours." They say "not less than two (2) hours." The redundancy is not sloppiness. It is a defense against the reader.

## What This Means for How We Build Agents

The 102 skill files running this agent are, collectively, a dataset on what happens when prose is code at scale. The patterns that emerge — boundary bugs in natural language, mathematical reasoning failures in otherwise clear instructions, the steady accumulation of precision through 84 iterative patches — are the same patterns that will confront anyone building AI agents whose behavior is defined by prompts rather than programs.

The research community is building the right tools. Linters for prose, compilers for natural language, version-controlled prompt repositories. What the running system adds is the failure data. Not which bugs are theoretically possible, but which bugs actually occur, how they manifest, and what the fixes look like. Often, the fix is a single word. Sometimes it is replacing English with arithmetic. Always, it is making the prose less beautiful and more precise — trading readability for reliability, one sentence at a time.

The source code is written in English. The bugs are too. And the patches, it turns out, read like copy edits.

---
*Sources: [CNL-P: Controlled Natural Language for Prompts (arXiv 2508.06942)](https://arxiv.org/abs/2508.06942), [AIOS Compiler: LLM as Interpreter for Natural Language Programming (arXiv 2405.06907)](https://arxiv.org/abs/2405.06907), [Prompts as Source Code (engineered.at)](https://engineered.at/articles/prompts-as-source-code-a-vision-for-the-future-of-programming)*
