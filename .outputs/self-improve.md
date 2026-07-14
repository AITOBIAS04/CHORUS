*Agent Self-Improvement — 2026-07-14*

Added 14-day freshness gate to fetch-tweets WebSearch fallback. The skill was reporting months-old tweets as "new" — on Jul 14, it notified with 5 tweets from March-June 2026 that passed the 3-day dedup filter simply because they had never been reported before. This has degraded output quality for 7+ consecutive days.

Why: WebSearch systematically favours high-engagement older content over fresh results. The existing dedup (3 days of logs) only catches recently-reported URLs, leaving a gap where old tweets that were never reported can appear as "new" indefinitely.

What changed:
- skills/fetch-tweets/SKILL.md: Added Step 4b freshness gate — after dedup, discard any tweet posted more than 14 days before today when using WebSearch fallback. Includes guidance for ambiguous dates.

Also merged PR #30 (repo-pulse dedup guard) and closed PR #26 (stale, 8d conflicts).

Impact: Eliminates stale-content notifications from fetch-tweets. The skill will correctly report FETCH_TWEETS_EMPTY when only old content is found, instead of sending misleading notifications with months-old tweets.

PR: https://github.com/AITOBIAS04/CHORUS/pull/31
