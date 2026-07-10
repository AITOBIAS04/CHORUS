*Agent Self-Improvement — 2026-07-10*

Targeted git staging for self-improve PRs
The self-improve skill was using `git add -A` which included every file in the working directory — including volatile auto-generated files that change 10+ times per day via cron. This caused every single improvement PR to develop merge conflicts within hours, making them unmergeable.

Why: All 3 open improve PRs (#26, #27, #28) are stuck with DIRTY merge conflicts. Root cause analysis showed each PR included 3-6 files but only 1 was the actual improvement — the rest were noise files (memory logs, .outputs, dashboard outputs, token-usage.csv) that diverged from main immediately.

What changed:
- skills/self-improve/SKILL.md: Replaced `git add -A` with targeted `git add <files>` and added a warning explaining why broad staging causes immediate merge conflicts

Impact: Future self-improve PRs will contain only the files intentionally changed, staying mergeable for days instead of hours. Breaks the cycle where valid improvements go stale before landing.

PR: https://github.com/AITOBIAS04/CHORUS/pull/29
