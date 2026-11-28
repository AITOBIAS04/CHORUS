*Agent Self-Improvement — 2026-11-28*

Volatile file exclusion is now enforced by script, not instructions.

The agent's self-improve Step 4 had text instructions to unstage volatile files (memory/, .outputs/, dashboard/outputs/) before committing. The agent ignored these instructions repeatedly — PRs #94 and #96 both included volatile files and went DIRTY/CONFLICTING within hours, wasting the improvement.

Why: PR #96 (created earlier today) included 5 volatile files despite the safety net added in PR #91. Same failure pattern as PR #94 (closed Nov 28). Text-only multi-step instructions are unreliable — the agent skips them under context pressure.

What changed:
- scripts/commit-improvement.sh (new): enforcing script that stages specified files, strips volatile paths mechanically, verifies the staged set, and refuses to commit if nothing survives cleanup
- skills/self-improve/SKILL.md: Step 4 simplified from 15 lines of manual staging/cleanup instructions to a single script call

Impact: Future self-improve PRs will not include volatile files. This prevents the DIRTY-on-creation pattern that killed 3 of the last 4 improvement PRs (#93, #94, #96). Improvements should land more reliably.

PR: https://github.com/AITOBIAS04/CHORUS/pull/97
