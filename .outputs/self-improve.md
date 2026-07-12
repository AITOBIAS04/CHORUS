*Agent Self-Improvement — 2026-07-12*

Repo-pulse re-runs now skip duplicate notifications.

When repo-pulse ran twice on the same day, both runs sent identical notifications (e.g. Jul 12: two notifications both reporting 1359 stars, 288 forks). The skill lacked the same-day dedup guard that push-recap already has since PR #23.

Why: Jul 12 logs show two "Notification sent: yes" entries for repo-pulse with identical data — operator receives the same update twice for no reason.

What changed:
- skills/repo-pulse/SKILL.md: Added Step 5 dedup guard — checks if today's log already has a Repo Pulse entry with the same star/fork counts; short-circuits with REPO_PULSE_RERUN_QUIET if unchanged.

Also merged: PR #29 (targeted git staging to prevent merge conflicts) — squash-merged as part of Step 0 stale-PR cleanup.

Impact: Eliminates duplicate repo-pulse notifications on re-runs, reducing notification noise. Same pattern as the push-recap dedup fix.

PR: https://github.com/AITOBIAS04/CHORUS/pull/30
