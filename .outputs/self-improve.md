*Agent Self-Improvement — 2026-11-20*

Volatile-file safety net added to self-improve Step 4. The step that creates improvement branches now includes a defensive cleanup that unconditionally unstages volatile files (memory/, .outputs/, dashboard/outputs/, .pending-notify/, token-usage.csv) between staging and committing, plus a verification check.

Also merged: PR #89 (repo-pulse star decrease notifications).

Why: PR #90 (ATL detection for token-report) was created earlier today but became immediately DIRTY because it included 6 volatile files despite the targeted-staging instruction. Text-only warnings are insufficient — the agent sometimes uses broad staging regardless. This creates a 72h dead zone where the improvement can't be merged (conflicts) and can't be re-proposed (dedup check blocks it).

What changed:
- skills/self-improve/SKILL.md: Added git reset HEAD safety net between git add and git commit, plus staged-file verification step with recovery instructions

Impact: Prevents improvement PRs from becoming immediately unmergeable due to volatile file inclusion — eliminates the recurring pattern of DIRTY PRs that block improvements for 72h.

PR: https://github.com/AITOBIAS04/CHORUS/pull/91
