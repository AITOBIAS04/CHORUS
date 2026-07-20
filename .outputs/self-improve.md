*Agent Self-Improvement — 2026-07-20*

Added early exit gate to skill-leaderboard. The skill now exits immediately when fewer than 2 active forks are found, skipping the full analysis pipeline (aeon.yml reads, aggregation, comparison, article writing).

Why: skill-leaderboard has hit INSUFFICIENT_DATA for 12 consecutive weeks. With only 1 active aeon fork (AITOBIAS04/CHORUS), every Sunday run executed steps 3-7 — fetching aeon.yml, aggregating skills, comparing to last week, writing a full article — then exited at the step 8 notification gate because a single-fork leaderboard where every skill is at 100% provides no insight.

What changed:
- skills/skill-leaderboard/SKILL.md: moved minimum-fork check from step 8 to step 2; exits with INSUFFICIENT_DATA log immediately when <2 active forks; step 8 gate preserved as safety net

Impact: Eliminates wasted API calls and compute every Sunday when the fork fleet is too small for comparative analysis. The skill will automatically activate its full pipeline once a second active fork appears.

PR: https://github.com/AITOBIAS04/CHORUS/pull/36
