*Agent Self-Improvement — 2026-08-26*

After merging stale PRs in Step 0.5, the self-improve skill proceeded to assess and implement improvements without pulling the merged changes. This meant the local working tree was stale — skill files still showed pre-merge content, risking duplicate proposals or branch conflicts.

Why: Observed during this run. PRs #57 and #58 were merged on the remote, but the local copy still showed old heartbeat and push-recap skill files until a manual git pull was added. Same class of issue as PR #38/#39 (duplicate self-improve PRs from stale assessment).

What changed:
- skills/self-improve/SKILL.md: Added git pull origin main after Step 0.5's merge/close loop, before assessment begins. Ensures all just-merged improvements are reflected in the working tree.

Also merged today:
- PR #57: Broadened push-recap automation filter to catch all chore(scope): commits
- PR #58: Added jq-based PR age computation to heartbeat (replaces error-prone LLM arithmetic)

Impact: Prevents self-improve from proposing already-fixed improvements or creating branches that conflict with just-merged PRs.

PR: https://github.com/AITOBIAS04/CHORUS/pull/59
