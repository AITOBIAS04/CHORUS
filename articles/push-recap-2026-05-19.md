# Push Recap — 2026-05-19

## Overview
40 commits by 2 authors across both repos. The headliner: Farcaster Frame v2 (PR #90) merged on MiroShark, closing the Base-chain audience gap so every share URL pasted into a Farcaster cast renders as an interactive belief-chart card. A second feature — Trading Signal JSON (PR #91) — was built and opened in the same session. On miroshark-aeon, 39 commits ran the daily skill cycle plus an infrastructure fix for the repo-pulse article pipeline.

**Stats:** ~50 files changed, +2,330/-3 lines across 40 commits

---

## aaronjmars/MiroShark

### Farcaster Frame v2 — Interactive Belief-Chart Cards in Warpcast
**Summary:** PR #90 merged, closing the one remaining audience surface gap. $MIROSHARK lives on Base; the Base-native social network is Farcaster / Warpcast. Before this PR, a `/share/<id>` URL pasted into a cast showed a blank link card — every other paste context (Twitter/X, Discord, Slack, LinkedIn, iMessage, Notion, Ghost, Substack) already got a rich unfurl. Now the cast renders the belief trajectory chart SVG as a Frame card with a "View Simulation →" link button.

**Commits:**
- `4d5c576` — feat: Farcaster Frame v2 — interactive belief-chart cards in Warpcast (#90)
  - New file `backend/app/services/frame_metadata.py`: 235-line pure-stdlib Frame metadata builder — assembles `fc:frame:*` meta-tag values from trajectory data. Chart SVG at 2:1 when trajectory exists, share-card PNG at 1.91:1 as fallback for pre-first-round sims. Title truncation at 80 chars (matching chart SVG cap). `warpcast_compose_url()` helper for the EmbedDialog (+235 lines)
  - Changed `backend/app/api/share.py`: Emits `fc:frame:*` meta tags in the share-page `<head>` alongside existing OG/Twitter tags. Frame block gated on `is_public` — private sims suppress injection entirely so scenario titles never leak through a cast preview (+84 lines)
  - Changed `backend/app/api/simulation.py`: New `GET /<simulation_id>/frame-metadata` endpoint — publish-gated, 5-min cache, returns structured JSON for the EmbedDialog Warpcast composer link (+75 lines)
  - New file `backend/tests/test_unit_frame_metadata.py`: 403 lines — 8 test groups covering shape, image URL switching, button shape, base URL normalization, title truncation, Warpcast compose URL encoding, route existence, and private-sim Frame suppression (+403 lines)
  - Changed `backend/openapi.yaml`: `/api/simulation/{simulation_id}/frame-metadata` operation under "Publish & Embed" tag; new `FrameMetadata` and `FrameMetadataButton` schemas (+165 lines)
  - Changed `frontend/src/components/EmbedDialog.vue`: New "🟣 Farcaster Frame" section — lazy-loaded Frame image preview, Warpcast composer link, copyable share URL, trajectory fallback notice, bilingual i18n (+124 lines)
  - Changed `frontend/src/api/simulation.js`: `getFrameMetadata()` and `buildWarpcastComposeUrl()` helpers (+39 lines)
  - Changed `docs/FEATURES.md`: "Farcaster Frame v2" section with endpoint reference and meta-tag list (+13 lines)
  - Changed `docs/API.md`: Frame-metadata row in the API endpoint table (+1 line)
  - Changed `README.md`: Features table row for Farcaster Frame (+1 line)

**Impact:** Every Farcaster cast containing a MiroShark share URL now renders as an interactive card — the belief trajectory visible inline in the feed without clicking through. This closes the distribution gap for the Base-chain native audience. Zero new dependencies — 26-PR zero-dep streak continues.

### Trading Signal JSON — Machine-Readable Action Primitive
**Summary:** PR #91 opened (not yet merged). Collapses the final-state belief split and quality health into a `signal.json` endpoint — a single action primitive that quant tools, bots, and trading dashboards can consume without parsing the full simulation output.

**Commits:**
- PR #91 opened via miroshark-aeon feature skill (code pushed to `feat/trading-signal-json` branch)
  - New file `backend/app/services/signal_service.py`: ~210 LoC pure stdlib — `compute_signal()` derives direction/confidence_pct/risk_tier from final belief split + quality health
  - New file `backend/tests/test_unit_signal_service.py`: 26 offline tests covering payload shape, plurality tie-break, confidence anchors, risk-tier mapping, ISO-8601 timestamps
  - Changed `backend/app/api/simulation.py`: `GET /<id>/signal.json` route, publish-gated, 5-min cache
  - Changed `frontend/src/components/EmbedDialog.vue`: "📡 Trading signal" section with direction/confidence badge, preview rows, Download/Copy actions
  - Changed `frontend/src/api/simulation.js`: `getSignalJsonUrl()` + `getSignalJson()` helpers
  - Changed `backend/openapi.yaml`, `docs/FEATURES.md`, `README.md`: Schema + documentation
  - Total: +1,189/-2 lines, 10 files

**Impact:** Gives quant tools a clean JSON primitive — direction, confidence percentage, risk tier — without needing to parse raw simulation output. 27-PR zero-dep streak.

### Open PRs
- **#91** — Trading Signal JSON (opened today, pending merge)
- **#89** — Neo4j password security fix (opened May 18 by external contributor @teifurin — first security contribution from outside the team)

---

## aaronjmars/miroshark-aeon

### Skill Pipeline Fix — Repo Pulse Article Writer
**Summary:** PR #42 merged. Five downstream skills (operator-scorecard, thread-formatter, star-momentum-alert, show-hn-draft, skill-freshness) reference `articles/repo-pulse-*.md`, but the producer only logged to `memory/logs/` and never wrote the article. The May 17 skill-freshness audit flagged this as an architectural gap.

**Commits:**
- `7ea2f61` — improve: have repo-pulse write articles/repo-pulse-YYYY-MM-DD.md (#42)
  - Changed `skills/repo-pulse/SKILL.md`: Added step 7 with structured article format (stargazers_count, forks_count, delta fields) matching operator-scorecard's parser expectations. Renumbered step 8 (logging) with article path reference (+33, -1 lines)

**Impact:** Closes the producer-consumer mismatch — five skills that read repo-pulse data no longer have to scrape memory logs. The article is the canonical structured artifact.

### Daily Skill Operations
**Summary:** 39 commits running the full Monday skill cycle — token report, fetch-tweets, tweet-allocator, repo-pulse, star-momentum-alert, feature build, star-milestone, project-lens, plus cron state tracking.

**Commits:**
- `f29f587` — feat(token-report): $MIROSHARK daily report 2026-05-19
  - Post-ATH consolidation: $0.0000309 (-1.31%), FDV $3.09M. LP at $998.4K (touched $1M during yesterday's ATH session). Buy ratio 1.34x. Volume $1.38M (+17%). Social: official @miroshark_ ecosystem map dominated (108L/30RT/20.5K views); @blueagent_ integration announced
  - Saved to `articles/token-report-2026-05-19.md` (+48 lines)

- `86bc37d` — chore(repo-pulse): 2026-05-19 — 1175 stars +4, 237 forks +1
  - New stargazers: Gawc1uuu, skylarbarrera, BXSWSSMBDX, ALPHAlcl
  - New fork: aigen-x/MiroShark

- `363c098` — project-lens: historical parallel — HyperCard 1987 to Farcaster Frames
  - Article: "The Card Was Always the Right Unit. It Just Needed a Network." — traces the lineage from Bill Atkinson's HyperCard (1987) through Facebook Platform (2007), Twitter Cards (2012), Open Graph, to Farcaster Frames v2 as the moment the card gets its runtime back on a network
  - Saved to `articles/project-lens-2026-05-18.md` (+47 lines)

- `e3603fe` — chore(star-momentum-alert): MiroShark 1172→1500 stars projected ~55 days (July 13)
  - Verdict: OUT_OF_WINDOW — not yet within the 7-14 day Show HN launch window

- `2022069` — chore(feature): auto-commit 2026-05-19
  - Weekly Simulation Digest built (18th push-blocked feature — GH_GLOBAL not set). Also pushed Trading Signal JSON (PR #91) to MiroShark

- ~25 cron state / scheduler update commits maintaining skill execution state

**Impact:** Full daily reporting cycle completed. Token consolidating after 5th consecutive ATH session. Repo steady at +4 stars/day pace.

---

## Developer Notes
- **New dependencies:** None. The zero-new-dep streak extends to 27 consecutive PRs (#57–#91) on MiroShark
- **Breaking changes:** None
- **Architecture shifts:** Frame metadata is a new share surface type — the `frame_metadata.py` service follows the same pattern as chart_svg.py and shares the trajectory loader
- **Tech debt:** GH_GLOBAL secret still unset — 18 feature PRs blocked as local commits (Pre-Run Cost Estimator through Weekly Simulation Digest). This is the longest-standing operational gap

## What's Next
- PR #91 (Trading Signal JSON) and PR #89 (Neo4j security fix) pending merge on MiroShark
- Curator Collections and Scenario Pre-flight Analyzer are the remaining candidates from the May 16 repo-actions batch
- LP approaching $1M — touched it during the ATH session yesterday ($998.4K current). Hyperstition target: $1M LP by July 1, 2026
- 1,175 stars — next milestone target is 1,500 (projected ~July 13 at current pace)
