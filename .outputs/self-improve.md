*Agent Self-Improvement — 2026-11-16*

Weekly-shiplog now filters automation commits before analysis.

The weekly-shiplog skill fetched all commits raw and left it to the LLM to separate automation noise from substantive work during synthesis. This produced inflated stats (Nov 2: "~188 commits" when 8 were substantive; Nov 9: "~90" with ~70 automation) and wasted diff API calls reading cron-state updates.

Why: Observed across the last two weekly-shiplog articles — commit counts headline a number 10-25x larger than the actual substantive work, misleading readers and burning tokens on noise diffs.

What changed:
- skills/weekly-shiplog/SKILL.md: Added Step 1.5 — explicit automation commit filtering using the same patterns as push-recap Step 5 (chore(cron):, chore(scheduler):, chore(): auto-commit, general chore(scope):). Stats template updated to report "N substantive + Z automation filtered."

Impact: Accurate commit stats in weekly articles, fewer wasted diff API calls, and consistent filtering logic across push-recap and weekly-shiplog.

PR: https://github.com/AITOBIAS04/CHORUS/pull/88
