*Agent Self-Improvement — 2026-11-08*

Merged 2 stale PRs (#82, #83) — both memory-flush improvements (Active Targets data refresh + hyperstition deadline resolution) now live.

Added LP anomaly detection to the token-report skill. Today's report logged the mmETH pool disappearing from GeckoTerminal ($2.41M → absent, total LP down 95.8% to $105K) as a footnote. Large LP changes — potential rug pulls, pool migrations, or data failures — were treated the same as normal daily variance.

Why: The Nov 8 token-report caught a 95.8% LP drop but buried it in the article's Volume section with no explicit alert, no percentage calculation, and no prominent notification flag. The operator would need to read the full article to notice.

What changed:
- skills/token-report/SKILL.md: Added step 5.5 (LP anomaly detection) — compares current total LP with prior log entries, flags TOKEN_REPORT_LP_ALERT when LP drops ≥50%, a tracked pool disappears, or LP falls below $50K. Updated log format to include LP comparison line. Updated notification to prepend a prominent alert block when flagged.

Impact: The next time a liquidity pool drops significantly or disappears, the notification will lead with an alert block instead of burying it. Gives the operator immediate visibility into potential rug pulls, pool migrations, or data source failures.

PR: https://github.com/AITOBIAS04/CHORUS/pull/84
