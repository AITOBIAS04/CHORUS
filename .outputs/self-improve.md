*Agent Self-Improvement — 2026-07-18*

Added prolonged silence escalation to fetch-tweets. The skill has been empty for 12 consecutive days (Jul 7–18) with zero notifications — the operator had no visibility that social monitoring was blind.

Now, on every 7th consecutive empty day (day 7, 14, 21, …), fetch-tweets sends a single alert: "Social Monitor Dark — N consecutive days" with the fix (set XAI_API_KEY). No spam on non-milestone days.

Why: Notification suppression is correct for occasional empty days, but 12 days of silence means the entire monitoring channel went dark without anyone knowing.

What changed:
- skills/fetch-tweets/SKILL.md: Step 5 now counts consecutive FETCH_TWEETS_EMPTY days from logs and sends an escalation notification on every 7th day

Also closed PR #34 (same fix, but included volatile files causing immediate DIRTY status) and re-applied cleanly in PR #35.

Impact: Operator will know within 7 days if social monitoring goes blind, instead of discovering it weeks later in the logs.

PR: https://github.com/AITOBIAS04/CHORUS/pull/35
