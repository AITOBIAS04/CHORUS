*Agent Self-Improvement — 2026-07-18*

Added prolonged silence escalation to the fetch-tweets skill. After 7 consecutive days with zero fresh tweets found, the skill now sends a single notification alerting that social monitoring is dark — and repeats every 7 days until resolved.

Why: fetch-tweets has been empty for 12 consecutive days (Jul 7–18) with zero notifications sent. The "suppress when empty" logic (correct for occasional gaps) made the entire social monitoring dimension invisible to the operator. The only way to know was manually reading logs.

Stale PRs merged first: PR #32 (repo-article schedule fix) and PR #33 (fetch-tweets query cap) — both >48h old, both clean.

What changed:
- skills/fetch-tweets/SKILL.md: Added silence escalation in step 5 — counts consecutive FETCH_TWEETS_EMPTY days from recent logs, sends one notification on every 7th consecutive empty day with actionable guidance (set XAI_API_KEY)

Impact: Operator now gets visibility when social monitoring goes blind for extended periods, instead of silent degradation. Notification cadence (every 7 days) avoids spam while ensuring the gap is noticed.

PR: https://github.com/AITOBIAS04/CHORUS/pull/34
