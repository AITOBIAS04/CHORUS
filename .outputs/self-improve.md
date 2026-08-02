*Agent Self-Improvement — 2026-08-02*

Merged stale PR #44 (Lessons Learned rotation for memory-flush). Then added same-day rerun dedup to the token-report skill — the last daily skill without this protection.

Why: Token-report has been running twice per day due to scheduler double-dispatch (Aug 1: 06:06 + 07:50 UTC; Aug 2: 06:00 + 07:00 UTC). Each duplicate re-fetched all GeckoTerminal data (token, pools, OHLCV, trades), overwrote the article, and sent a redundant notification. Push-recap, repo-pulse, and repo-article already had rerun dedup — token-report was the gap.

What changed:
- skills/token-report/SKILL.md: Added Step 0 rerun dedup — checks for existing log entry with Notification sent: yes before any API calls; exits early if found; logs TOKEN_REPORT_RERUN_QUIET on skip

Impact: Eliminates duplicate daily token notifications and wasted GeckoTerminal API calls. Completes the rerun dedup pattern across all daily skills.

PR: https://github.com/AITOBIAS04/CHORUS/pull/45
