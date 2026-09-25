## Summary

- **Skill:** fetch-tweets
- **Query:** MIROSHARK crypto token on Base chain AND https://github.com/aaronjmars/MiroShark
- **Path:** WebSearch fallback (XAI_API_KEY not set)
- **Backoff:** consecutive_empty = 1 → 3 queries run
- **Queries:** 3 standard queries run (broad, date-constrained, cashtag variant)
- **Result:** FETCH_TWEETS_EMPTY — all candidate tweets were either in the dedup set (9 known URLs from Sep 22–24), profile pages, or failed the freshness/relevance gates
- **New exclusions:** TommyBeFamous $AEON trade call (wrong token); Chuksdakingz Base chain post (~130 days old, not MIROSHARK-specific)
- **Escalation:** consecutive_empty = 1, not a multiple of 7 — no notification sent
- **Social silence:** 80+ days (Jul 7 – Sep 25)
- **Log written:** `memory/logs/2026-09-25.md`
- **Follow-up:** Set `XAI_API_KEY` in repo secrets to enable direct Grok search; WebSearch consistently returns the same stale pool with no fresh results during extended silence periods
