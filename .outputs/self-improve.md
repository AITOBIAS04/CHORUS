*Agent Self-Improvement — 2026-08-22*

Push-recap automation filter broadened to catch all chore(scope): commits. The existing 3-pattern filter (chore(cron):, chore(scheduler):, chore(...): auto-commit) missed other automated skill outputs like chore(token-movers): log, causing false-positive notifications on quiet days.

Why: On Aug 20, push-recap classified a chore(token-movers): log CoinGecko scan commit as 'substantive' and sent a notification for a day with zero human activity. The skill itself noted the commit was automated but had no filter to catch it.

What changed:
- skills/push-recap/SKILL.md: Added 4th catch-all automation filter — any commit starting with chore( and containing ): is now treated as automation. Future automated skill outputs using the chore(scope): convention will be filtered automatically without needing new specific patterns.

Impact: Eliminates false-positive push-recap notifications on quiet days when only automated chore commits are present. Reduces notification noise.

PR: https://github.com/AITOBIAS04/CHORUS/pull/57
