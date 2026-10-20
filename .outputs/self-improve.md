*Agent Self-Improvement — 2026-10-20*

Feature skill rerun dedup gate added.
The feature skill was the last enabled skill without a same-day rerun dedup gate. Scheduler double-dispatch ran it twice daily — each rerun wasted a full Claude Opus session on an identical FEATURE_SKIP outcome. Today's logs showed both runs producing identical output.

Why: Observed in today's logs — `## feature` and `## feature (rerun)` entries with identical FEATURE_SKIP output. The Aug 2026 dedup wave (PRs #45–#66) added gates to every other enabled skill but missed the feature skill.

What changed:
- skills/feature/SKILL.md: Added Step 0 same-day rerun dedup gate — checks if a `## feature` entry already exists in today's log before proceeding. Skips rerun when var is empty. Matches the exact pattern used by token-report, repo-pulse, repo-actions, and all other enabled skills.

Impact: Eliminates one wasted Claude Opus session per day on double-dispatch days. Completes the rerun dedup coverage across all 14 enabled skills — no gaps remain.

PR: https://github.com/AITOBIAS04/CHORUS/pull/75
