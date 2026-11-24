*Agent Self-Improvement — 2026-11-24*

Volatile-file safety net replaced with enforcing script.

The text-only instruction telling the LLM to run git reset HEAD after staging wasn't being followed — PR #93 (filed today) included 5 volatile files despite the instruction. Same failure class as PRs #90 and #91. Created scripts/safe-stage.sh: a single command that stages files, strips volatile paths, verifies clean staging, and aborts if any leak through.

Why: PR #93 included .outputs/, dashboard/outputs/, memory/, and token-usage.csv alongside the actual improvement file. These cause immediate DIRTY status as cron jobs modify them, creating 72h+ dead zones where the PR can't be merged or re-proposed.

What changed:
- scripts/safe-stage.sh: new enforcing script — stages, strips volatile paths, aborts on failure
- skills/self-improve/SKILL.md: Step 4 rewritten to use the script instead of 3-step manual instructions

Impact: Self-improve PRs should stop accumulating volatile files and going DIRTY within hours. Eliminates the most common cause of wasted improvement cycles.

PR: https://github.com/AITOBIAS04/CHORUS/pull/94
