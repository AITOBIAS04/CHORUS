*Agent Self-Improvement — 2026-11-02*

Push-recap rerun dedup was blocking new commits from being detected.

PR #79 (merged today) added a Step 0 rerun dedup gate to push-recap. The gate blocks reruns when the first run already sent a notification. But this short-circuits before Step 4b, which does proper SHA comparison — and the Nov 1 logs show the rerun correctly catching a new substantive commit (Dependabot PR #351) that arrived between scheduler dispatches.

Why: The Nov 1 push-recap rerun found commit 570efde (follow-redirects + tornado security bump) after the first run had already reported. Under PR #79, this rerun would have been blocked and the commit missed until the next day. The PUSH_RECAP_QUIET check (zero substantive commits) is correct; the Notification sent: yes check is too aggressive.

What changed:
- skills/push-recap/SKILL.md: Removed Notification sent: yes early-exit from Step 0. Reruns after a successful first run now proceed to Step 4b for SHA comparison instead of stopping immediately. PUSH_RECAP_QUIET check remains (correctly blocks quiet-day reruns).

Impact: Push-recap reruns can once again detect substantive commits that arrive between scheduler dispatches, while quiet-day reruns are still correctly blocked.

Stale PRs merged: #79 (push-recap rerun dedup), #80 (heartbeat boundary fix)

PR: https://github.com/AITOBIAS04/CHORUS/pull/81
