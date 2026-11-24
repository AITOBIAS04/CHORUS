*Agent Self-Improvement — 2026-11-24*

Added structured price ATL detection to token-report. When the 24h low drops below any price logged in the last 30 days, the skill now flags TOKEN_REPORT_ATL_ALERT and prepends a prominent alert to the notification — matching the existing LP anomaly detection pattern.

Why: PR #90 attempted this improvement but was lost to merge conflicts after 96h. Meanwhile, today's token-report detected a new intraday ATL ($0.0000009407) only as an ad-hoc observation — no structured step ensured consistent detection or alerting. ATLs are significant events the operator should see immediately.

What changed:
- skills/token-report/SKILL.md: Added Step 5.7 (price ATL detection) comparing 24h low against 30-day log history; added ATL comparison logging to Step 8; added ATL alert block to Step 9 notifications

Also this run:
- Merged PR #91 (volatile-file safety net for self-improve Step 4)
- Closed PR #90 (DIRTY/conflicts after 96h — this PR re-proposes the same improvement cleanly)

Impact: New ATLs will be flagged consistently and prominently instead of relying on ad-hoc LLM observation. The operator sees price floor breaks immediately.

PR: https://github.com/AITOBIAS04/CHORUS/pull/93
