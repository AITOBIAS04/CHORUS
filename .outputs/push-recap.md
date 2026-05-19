*Push Recap — 2026-05-19*
MiroShark — 1 commit merged, 1 PR opened by 1 author
miroshark-aeon — 39 commits by 2 authors

Farcaster Frame v2 (PR #90 merged): The Base-chain audience gap is closed. Every /share/<id> URL pasted into a Farcaster cast now renders as an interactive belief-chart Frame card in Warpcast — chart SVG at 2:1 as the preview, "View Simulation →" link button, EmbedDialog Warpcast composer link. Private sims suppress Frame tags entirely. Pure stdlib, zero new deps (+1,140 lines, 10 files).

Trading Signal JSON (PR #91 opened): New GET /<id>/signal.json endpoint collapses final belief split + quality health into direction/confidence_pct/risk_tier — a machine-readable action primitive for quant tools, bots, and trading dashboards. 26 unit tests (+1,189 lines, 10 files).

Skill Pipeline Fix (PR #42 merged): repo-pulse now writes articles/repo-pulse-YYYY-MM-DD.md — five downstream consumers no longer scrape memory logs.

Key changes:
- frame_metadata.py (235 LoC stdlib) builds fc:frame:* meta-tag values — chart SVG at 2:1 with share-card PNG fallback for pre-trajectory sims
- signal_service.py (~210 LoC stdlib) derives direction + confidence from final belief split; 27-PR zero-dep streak
- Token at $0.0000309 (-1.31%), post-ATH consolidation; LP $998.4K (touched $1M); FDV $3.09M
- 1,175 stars (+4), 237 forks (+1)

Stats: ~50 files changed, +2,330/-3 lines across 40 commits
Full recap: https://github.com/AITOBIAS04/miroshark-aeon/blob/main/articles/push-recap-2026-05-19.md
