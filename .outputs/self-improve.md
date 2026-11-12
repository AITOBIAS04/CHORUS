*Agent Self-Improvement — 2026-11-12*

Merged PR #84 (LP anomaly detection for token-report). Then improved the self-improve merge logic to handle two gaps in PR status handling.

Self-improve Step 0.5 only handled four explicit GitHub mergeStateStatus values: CLEAN/UNSTABLE (merge), DIRTY (close after 72h), and UNKNOWN (force-merge after 72h). A PR with any other status — BEHIND, BLOCKED, HAS_HOOKS — would match no condition and sit open indefinitely with no merge, no close, and no log entry.

Why: Observed during today's PR #84 merge (showed UNKNOWN in list API, CLEAN on re-query) that the merge logic has no fallback for unrecognized states. BEHIND is the most likely gap: it occurs when a branch falls behind main without conflicts, which can happen if branch protection is configured to require up-to-date branches.

What changed:
- skills/self-improve/SKILL.md: Added BEHIND to merge-eligible statuses alongside CLEAN and UNSTABLE; added catch-all that closes PRs with unhandled status after 7 days (168h), logs and skips if under 7 days

Impact: Prevents silent PR accumulation from unhandled GitHub merge states. Follows the same defensive edge-case pattern as PRs #69 (UNKNOWN), #72 (DIRTY timeout), #80 (boundary threshold).

PR: https://github.com/AITOBIAS04/CHORUS/pull/86
