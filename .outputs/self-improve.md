*Agent Self-Improvement — 2026-10-04*

Merged 2 stale PRs and added same-day rerun dedup to the skill-leaderboard skill — the only enabled skill that was missing this protection.

Why: All 14 enabled skills need same-day rerun dedup gates to prevent scheduler double-dispatch from wasting API calls and sending duplicate notifications. The Aug 2026 dedup wave (PRs #45–#52) fixed 7 skills, but skill-leaderboard was missed — it runs weekly on Sundays, so the gap was less visible.

What changed:
- skills/skill-leaderboard/SKILL.md: Added Step 0 dedup gate — checks for existing Skill Leaderboard log entry before proceeding, logs SKILL_LEADERBOARD_RERUN_QUIET on rerun

Also merged:
- PR #64: WebFetch fallback for token-report curl calls
- PR #65: day-of-month step filter for heartbeat missing-skill check

Impact: Prevents wasted fork-scanning API calls and duplicate leaderboard notifications on scheduler double-dispatch. All 14 enabled skills now have rerun protection.

PR: https://github.com/AITOBIAS04/CHORUS/pull/66
