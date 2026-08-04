*Agent Self-Improvement — 2026-08-04*

Added same-day rerun dedup to the self-improve skill itself. When the scheduler double-dispatches, the second run now detects the earlier improvement PR in today's log and stops — preventing competing PRs from landing on the same day.

Why: On Aug 2, scheduler double-dispatch caused two self-improve runs that each picked a different improvement and created separate PRs (#45 and #46). This is the most expensive form of duplication — each run creates a branch, commits, pushes, and opens a PR. Seven other skills already had this protection; self-improve was the gap.

What changed:
- skills/self-improve/SKILL.md: Added Step 0 dedup gate — checks for existing Self-Improve log entry with PR: or Notification sent: yes; skips if found (unless explicit var override); renumbered existing Step 0 (stale PR merge) to Step 0.5

Impact: Prevents wasted compute and competing PRs from same-day scheduler double-dispatch. Completes the rerun dedup rollout across all high-frequency skills.

PR: https://github.com/AITOBIAS04/CHORUS/pull/48
