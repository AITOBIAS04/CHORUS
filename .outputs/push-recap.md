*Push Recap — 2026-05-10*
aaronjmars/MiroShark — 1 commit merged + 2 PRs opened
aaronjmars/miroshark-aeon — 31 automation commits, all skills green

Lineage Navigator (PR #76 merged): Bidirectional fork/counterfactual graph traversal is now live. GET /api/simulation/<id>/lineage returns parent + public children for any published sim. EmbedDialog gains a 🌳 Lineage panel — click any row to navigate to that sim. Closes the one-directional pointer gap PR #75 created. +1,778 lines across 11 files, 16 tests, pure stdlib.

Distribution → Discovery Pipeline (PRs #77 + #78 opened): Trending sort adds sort=trending to the gallery, ranking sims by cumulative serve count. Surface-stats extension tracks reproduce.json + lineage hits. Together they close the analytics → discovery → sharing → analytics loop.

Token Near-ATH: $MIROSHARK at $0.00000646 (+30.6% 24h), only -6.7% from ATH. LP at new high $336.7K. VC interest signal from Lorimer Ventures.

Key changes:
- New lineage_service.py (390 LoC) — read-only corpus scan building graph slices from existing state.json files
- EmbedDialog.vue +505 lines — 🌳 panel with parent/child rows, kind badges, counterfactual markers, responsive CSS
- Self-improve caught MEMORY.md at 81KB, opened PR #33 with structural caps

Stats: ~50 files changed, +3,000/-50 lines across 32 commits
Full recap: https://github.com/AITOBIAS04/miroshark-aeon/blob/main/articles/push-recap-2026-05-10.md
