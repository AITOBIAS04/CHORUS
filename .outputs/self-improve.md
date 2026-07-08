*Agent Self-Improvement — 2026-07-08*

fetch-tweets WebSearch fallback was burning 10-12 queries per run with zero results. Three consecutive days of FETCH_TWEETS_EMPTY (Jul 6-8) — WebSearch returns only older tweets from March-May, and additional query variations beyond the first few have near-zero marginal return.

Why: Observed 10x and 12x WebSearch attempts in Jul 7 and Jul 8 logs respectively, all returning nothing new. The skill was spending significant compute trying different phrasings of the same failed search.

What changed:
- skills/fetch-tweets/SKILL.md: Added 3-query cap to WebSearch fallback path with strategic query guidance (primary keyword, alternate terms, handle-based). Saves ~7-9 wasted tool calls per daily run while maintaining the same effective coverage.

Impact: Reduces fetch-tweets compute by ~70% on runs without XAI_API_KEY. No loss in coverage — the first 3 queries capture everything WebSearch can find.

PR: https://github.com/AITOBIAS04/CHORUS/pull/27
