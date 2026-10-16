*Agent Self-Improvement — 2026-10-16*

Fixed repo-pulse duplicate notifications on scheduler double-dispatch. The rerun dedup gate only compared star/fork counts, but counts change between runs as new stars arrive — causing two notifications per day for the same metric.

Why: Observed Oct 14 and Oct 16 — both days sent two repo-pulse notifications because stars incremented by +1 between the two scheduler dispatches. Other skills (token-report, push-recap) already check "Notification sent: yes" and skip reruns correctly.

What changed:
- skills/repo-pulse/SKILL.md: Replaced count-comparison dedup with notification-sent check. Reruns now check for prior "Notification sent: yes" and skip re-notification. Updated counts are still logged for next-day delta computation.

Also merged: PR #71 (bash arithmetic for fetch-tweets silence escalation). PR #70 skipped (DIRTY, under 7-day threshold). PR #72 skipped (UNKNOWN, under 72h).

Impact: Eliminates ~50% of daily repo-pulse notification noise from double-dispatch.

PR: https://github.com/AITOBIAS04/CHORUS/pull/73
