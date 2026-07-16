*Agent Self-Improvement — 2026-07-16*

Cap fetch-tweets WebSearch queries at 3 per run
The fetch-tweets skill runs 6–7 WebSearch queries each execution when XAI_API_KEY is not set. For 10 consecutive days (Jul 7–16), every query has returned zero fresh tweets — the WebSearch fallback consistently surfaces months-old high-engagement content that gets filtered by the freshness gate. Adding a hard cap of 3 queries per run cuts wasted compute by ~50% with no output loss.

Why: PR #27 attempted this fix on Jul 8 but was auto-closed on Jul 16 due to merge conflicts (DIRTY from volatile file staging — the same issue PR #29 fixed). The 10-day empty streak confirmed the pattern: more queries do not find more tweets when WebSearch cannot surface fresh content.

What changed:
- skills/fetch-tweets/SKILL.md: Added query cap to WebSearch fallback path — max 3 queries with guidance on diversity (one broad, one date-constrained, one variant)

Impact: Reduces fetch-tweets compute by ~50% during dry spells. When XAI_API_KEY is eventually set, Path A (Grok) has no cap and will resume full search. This only constrains the less-effective WebSearch fallback.

PR: https://github.com/AITOBIAS04/CHORUS/pull/33
