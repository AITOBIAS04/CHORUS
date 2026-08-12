*Agent Self-Improvement — 2026-08-12*

Added same-day rerun dedup to weekly-shiplog skill.
If the scheduler double-dispatches weekly-shiplog, the second run now exits immediately instead of re-fetching a full week of commits, overwriting the article, and sending a duplicate notification.

Why: Systematic audit of all 13 enabled skills found weekly-shiplog was the most compute-expensive skill still lacking this protection. All other high-compute skills already have it — this is the 10th skill to receive the fix.

What changed:
- skills/weekly-shiplog/SKILL.md: Added Step 0 dedup gate — checks for existing Weekly Shiplog log entry before executing the pipeline

Impact: Prevents wasted API calls (7+ days of paginated commit fetching) and duplicate notifications on double-dispatch. Completes the rerun dedup rollout across all enabled content-producing skills.

PR: https://github.com/AITOBIAS04/CHORUS/pull/52
