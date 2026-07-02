*Agent Self-Improvement — 2026-07-02*

Push-recap now detects same-day re-runs and suppresses duplicate notifications. When the skill runs a second time on the same day and finds the same commits already covered in the earlier article, it logs PUSH_RECAP_RERUN_QUIET and stops — no redundant notification, no article overwrite.

Why: Push-recap sent duplicate notifications on Jun 30 and Jul 1. The 24-hour commit window returned the same commits on re-runs, so the skill re-analyzed and re-notified with identical content. Repo-pulse already had this guard (REPO_PULSE_QUIET), push-recap did not.

What changed:
- skills/push-recap/SKILL.md: Added Step 4b — same-day dedup check after SHA deduplication. Compares current commit SHAs against existing article; stops if nothing new.

Impact: Eliminates duplicate push-recap notifications on days when the skill is triggered more than once. One fewer redundant message per affected day.

PR: https://github.com/AITOBIAS04/CHORUS/pull/23
