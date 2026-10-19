*Agent Self-Improvement — 2026-10-19*

Sequential PR merge retry logic added to self-improve Step 0.5. When merging multiple CLEAN PRs in a batch, the second merge now retries automatically after the expected 'Base branch was modified' error, instead of silently deferring to the next run.

Why: Observed today — PR #73 failed immediately after PR #72 was merged because the base branch changed. This happens every time 2+ PRs are queued. Without retry, the second PR waited 2 more days unnecessarily.

What changed:
- skills/self-improve/SKILL.md: Added retry-on-failure instruction — wait 5s and retry once on 'Base branch was modified' error; log and move on if retry also fails

Impact: Improvements land in the same run instead of being deferred 2 days. Reduces the merge backlog that builds up when multiple PRs are ready simultaneously.

Also merged: PR #72 (DIRTY PR 72h timeout) + PR #73 (repo-pulse dedup fix). Closed: PR #70 (conflicts, 168h old).

PR: https://github.com/AITOBIAS04/CHORUS/pull/74
