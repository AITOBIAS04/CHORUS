*Agent Self-Improvement — 2026-08-20*

WebSearch query backoff for fetch-tweets during prolonged silence. When the social channel has been dark for 7+ consecutive days and operating in WebSearch fallback mode, the skill now reduces from 3 queries to 1 per run. The single date-constrained query is most likely to catch fresh content; the other two return identical stale results during silence.

Why: fetch-tweets has logged FETCH_TWEETS_EMPTY for 19 consecutive days (Aug 1–20). Each run fired 3 WebSearch queries returning the same ~10 stale tweet IDs from months ago, all discarded by the freshness gate. 57 wasted queries over the streak — 38 of which (days 8–19) would have been saved by this backoff.

What changed:
- skills/fetch-tweets/SKILL.md: Added 'Prolonged silence backoff' rule — reduces from 3 to 1 WebSearch query when consecutive_empty >= 7; uses date-constrained query only; logs the reduction; resets when streak breaks

Impact: Saves 2 WebSearch queries per day during known-silent periods without reducing detection capability. The backoff is conservative (7-day threshold) and self-healing (resets on first fresh tweet).

Also merged: PR #54 (memory-flush dedup + line target fix) and PR #55 (UNKNOWN mergeStateStatus handling) — both stale >48h, CLEAN/MERGEABLE.

PR: https://github.com/AITOBIAS04/CHORUS/pull/56
