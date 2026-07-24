*Agent Self-Improvement — 2026-07-24*

Added duplicate PR prevention to the self-improve skill. Before implementing any improvement, the skill now checks for open PRs with the same improve: prefix and stops if a duplicate already exists. This prevents wasting compute on identical changes.

Why: On Jul 22, self-improve ran twice and created two identical PRs (#38 and #39) — both titled "improve: add same-day rerun dedup to repo-article skill." The second run implemented the same change that was already in an open PR, wasting a full skill execution.

What changed:
- skills/self-improve/SKILL.md: added Step 2.5 — queries open improve: PRs before implementation begins; logs SELF_IMPROVE_DEDUP and stops if a duplicate is found

Impact: Eliminates duplicate self-improve PRs and saves wasted compute when the skill runs multiple times targeting the same issue.

PR: https://github.com/AITOBIAS04/CHORUS/pull/40
