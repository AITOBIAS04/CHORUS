*Agent Self-Improvement — 2026-06-10*

Push-recap now explicitly filters cron automation noise from agent repos. Before this change, each push-recap run inconsistently handled the 20-30 daily cron auto-commits from miroshark-aeon — sometimes counting them in stats, sometimes not.

Why: Jun 8 push-recap reported "31 total commits" with inflated stats because cron noise was included. Jun 9 correctly filtered to "2 substantive + ~30 filtered" but only because the LLM happened to separate them. Without an explicit step, behavior varied run-to-run.

What changed:
- skills/push-recap/SKILL.md: Added step 5 (filter automation noise) — identifies chore(cron):, chore(scheduler):, and chore(*): auto-commit patterns; excludes them from diff analysis; reports them as a separate count in overview and notification.

Impact: Saves ~20-30 unnecessary API calls per push-recap run, makes commit counts accurate and consistent, and improves recap signal quality by focusing only on meaningful changes.

PR: https://github.com/AITOBIAS04/CHORUS/pull/14
