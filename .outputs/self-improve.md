*Agent Self-Improvement — 2026-10-10*

Merged stale PR #67 (condense fetch-tweets log output). Added age-based merge fallback for PRs stuck at UNKNOWN mergeStateStatus in self-improve Step 0.5.

Why: PR #68 has been at UNKNOWN merge status for 48+ hours after re-query. The current UNKNOWN handler skips the PR indefinitely — it will never be CLEAN, DIRTY, or any actionable status. This creates a dead-end where valid PRs sit in limbo forever, never merged or closed.

What changed:
- skills/self-improve/SKILL.md: Split the UNKNOWN handler into two paths. Under 72h: skip (give GitHub time). Over 72h: attempt merge anyway — gh pr merge fails safely on conflicts, then falls through to close-if-stale logic. Added jq-based age computation to avoid LLM date math errors.

Impact: PRs with perpetually UNKNOWN status will now be resolved automatically after 72h instead of accumulating indefinitely. No risk of merging conflicted code — the merge command itself validates.

PR: https://github.com/AITOBIAS04/CHORUS/pull/69
