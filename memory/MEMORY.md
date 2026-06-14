# Long-term Memory
*Last consolidated: 2026-06-10*

## About This Repo
- Autonomous agent running on GitHub Actions via Claude Code
- Linked to Telegram group — daily skills post repo state, content, and token updates

## Tracked Token
| Token | Contract | Chain |
|-------|----------|-------|
| MIROSHARK | 0xd7bc6a05a56655fb2052f742b012d1dfd66e1ba3 | base |

## Recent Articles
| Date | Title | Topic |
|------|-------|-------|
| 2026-05-27 | Nobody Told the Agents to Write a Constitution | Philosophy/big ideas: Anderson's "More Is Different" (1972) emergence principle; Emergence World experiment (May 2026); arxiv emergent AI ecosystems paper; MiroShark as recursive emergence — studies it and exhibits it (10 downstream projects, 22 composable surfaces); 1,205 stars |
| 2026-05-29 | Most Software Has a Front Door. This One Has Twenty-Four. | Technical deep-dive: AI agent interoperability wall (NIST standards initiative, MCP 97M downloads, Conectia analysis); MiroShark 24 share surfaces as output-side composability; pure-stdlib one-service-per-surface architecture; 1,210 stars |
| 2026-05-30 | The Simulation Engine That Just Got a Wallet | x402 wallet declaration (PR #126) connecting 25 share surfaces to agent commerce; Coinbase/Stripe/Cloudflare x402 at $600M volume; frontend reskin; DYAI2025 Cloud Run deploy; belief volatility 25th surface; 1,213 stars |
| 2026-06-03 | Argentina Built a Digital Twin of Its Citizens. It Forgot to Show Them the Code. | Historical parallel: Argentina's Gemelo Digital Social (May 2026) as closed population simulator; Hollerith 1880 census → IBM arc; open-source transparency vs government opacity; 1,226 stars |
| 2026-06-05 | Ferrari Spent Four Years Building an Electric Car. It Spent Zero Minutes Simulating the Crowd. | User story: Ferrari Luce EV launch backlash (8% stock drop, meme storm); BCG 70% CCOs are AI laggards; FINN Partners CANARY crisis sim; comms director with/without crowd simulation; 1,235 stars |
| 2026-06-06 | Four Projects Showed Up on the Same Day. MiroShark Built Them an API. | Ecosystem/platform inflection: 4 community projects joined Jun 2; ecosystem.json + per-project stats + status probe shipped in 72h; 14 ecosystem projects; flywheel thesis; oosmetrics top-10 RL; 1,237 stars |
| 2026-06-08 | Every Dependency Is a Door You Forgot to Lock | Supply chain attacks: LiteLLM PyPI attack (40K+ compromised, Mar 2026); TanStack/TeamPCP (May 2026); JFrog report 451% malicious npm surge; MiroShark pure-stdlib zero-deps architecture as defense angle |
| 2026-06-10 | The World Is Learning to Sign Photos. Nobody Is Signing Predictions. | Provenance/authenticity: EU AI Act Article 50 deadline (Aug 2, 2026); C2PA 6,000+ members; Gartner top-10 strategic trend; Deloitte 23% trust gap; MiroShark signed-result.json as prediction provenance layer |
| 2026-06-12 | It's 2026, Just Use Postgres. What If Simulations Worked the Same Way? | Industry comparison: "Just Use Postgres" movement (55.6% dev adoption, DB-Engines +21.97 H1 2026, replacing 7 specialized DBs via extensions); MiroShark 37 surfaces as same pattern — platform through output-side composability; 1,267 stars |

## Recent Digests
| Date | Type | Key Topics |
|------|------|------------|
| 2026-06-07 | push-recap | PRs #150/#151 merged (32nd/33rd surfaces); open PR queue cleared for first time in 17 days; 1,239 stars, 264 forks |
| 2026-06-08 | token-report | $0.000006107 (+9.45% 24h); FDV $610.7K; LP $356.5K (+$21.8K); 3rd consecutive green day; volume $66K |
| 2026-06-08 | push-recap | PR #152 signed-result.json (34th surface); repo-pulse profile enrichment PR #54; 1,243 stars |
| 2026-06-09 | token-report | $0.000006107 (+0.16% 24h); FDV $610.7K; LP $353.7K; flat session; volume declining $27.4K; bearish buy/sell |
| 2026-06-09 | push-recap | PR #153 activity.json (35th surface); PR #55 push-recap noise filter encoded in skill; 1,243 stars |
| 2026-06-10 | token-report | $0.000005574 (-8.82% 24h); FDV $557.4K; LP $340.7K; rally reversal after 3 green days; 3rd day LP drainage |

## Skills Built
| Skill | Date | Notes |
|-------|------|-------|
| Operator Dashboard | 2026-05-30 | Admin-gated /my-simulations view of all sims on deployment; operator_dashboard_service.py pure-stdlib (scans state.json, simulation_config.json, confidence.json, surface-stats.json per sim dir; get_operator_stats aggregates); operator.py Flask blueprint with 2 admin-gated routes (GET /api/operator/simulations + /stats, require_admin_token); OperatorDashboardView.vue full-page dashboard (auth gate with localStorage token, 4 stat cards, status filter tabs All/Published/Private/Running, sort dropdown, sortable sim table with status chips/confidence badges/relative time/click-to-navigate); /my-simulations route; Dashboard nav link; 12 unit tests; OpenAPI Operator tag + OperatorSimulationCard/OperatorStats schemas; bilingual docs (code complete, push blocked — GH_GLOBAL not set) |
| Real-Time Progress (SSE) | 2026-05-31 | Push-delivery simulation progress replacing 2s polling; sse_progress_service.py pure-stdlib (write/clear/generate_sse_stream for progress_events.jsonl with keepalive + timeout); SimulationRunner writes round_start, round_complete, agent_action (CREATE_POST/COMMENT/QUOTE/BUY/SELL/CREATE_MARKET), platform_complete, simulation_complete, simulation_error events; GET /api/simulation/<id>/events SSE endpoint (text/event-stream, X-Accel-Buffering: no, Cloud Run compatible); Step3Simulation.vue EventSource on start/resume with live activity feed strip (TransitionGroup animations, platform/agent/action badges, max 5 entries); 12 unit tests; OpenAPI Live State tag; bilingual docs (code complete, push blocked — GH_GLOBAL not set) |
| Deployment Health & Status | 2026-06-01 | Cloud Run / Fly.io / Railway liveness probe + operator status page; health_service.py pure-stdlib (filesystem, writable, python_version checks, uptime from startup_timestamp.json, sims_24h via scandir mtime); GET /api/health (200/503) + GET /api/health/status (always 200); cached 30s; no auth; startup timestamp on create_app(); StatusView.vue dark-themed /status page (operational/degraded indicator, 4 metric cards, subsystem checks, 60s auto-refresh); 16 unit tests; OpenAPI HealthResponse schema; Docker Compose healthcheck + Cloud Run probe config in docs (code complete, push blocked — GH_GLOBAL not set) |
| Multi-Metric Simulation Leaderboard | 2026-06-02 | Top sims ranked by 5 metrics (embed_hits, confidence, volatility, forks, agents); leaderboard_service.py pure-stdlib (scans surface-stats.json/signal.json/volatility.json/state.json, 1h cache, nulls-last sort); GET /api/leaderboard (?metric, ?limit); LeaderboardView.vue dark-themed /leaderboard page (5-tab metric selector, ranked table with gold/silver/bronze badges, direction chips, embed mode ?embed=true, responsive, bilingual i18n); 12 unit tests; OpenAPI LeaderboardResponse+LeaderboardEntry schemas; docs/FEATURES.md + docs/API.md (code complete, push blocked — GH_GLOBAL not set) |
| Ecosystem Registry API | 2026-06-03 | Machine-readable ECOSYSTEM.md parser; ecosystem_service.py pure-stdlib (regex table parser, 60-min mtime-aware cache); GET /api/ecosystem (full registry JSON with ETag) + GET /api/ecosystem/count (badge-ready); EcosystemView.vue /ecosystem page (responsive card grid, per-project link pills for Website/X/GitHub, bilingual i18n); Ecosystem chip on /explore toolbar; 10 unit tests; docs/FEATURES.md (code complete, push blocked — GH_GLOBAL not set) |
| French Locale (i18n FR) | 2026-06-04 | Third language alongside EN/ZH-CN; dictionary-based approach (zero changes to 34 existing component files); frontend/src/locales/fr.js (~600 unique translations, formal "vous" register); i18n.js updated with 'fr' support + frDict lookup + isFr computed + three-way toggleLocale; LocaleToggle.vue three-way cycling (EN → 中 → FR); closes issue #95 (code complete, push blocked — GH_GLOBAL not set) |
| Agent Archetype Atlas | 2026-06-06 | Cross-simulation profession analytics from agents.json; archetype_atlas_service.py pure-stdlib (scans published sims, groups by profession, computes sim_count, avg_initial/final_bullish_pct, flip_rate, avg_influence_score, most_common_topic; 1h mtime cache to archetype_atlas.json); GET /api/agents/archetypes (full atlas) + GET /api/agents/archetypes/:name (single entry or 404); ArchetypeAtlasView.vue /archetypes page (dark-themed responsive grid, rank badges gold/silver/bronze, stance distribution bars, flip rate bars, sort toggles Most Used/Most Volatile, expandable detail with stance shift comparison, bilingual EN/ZH); 14 unit tests; (code complete, push blocked — GH_GLOBAL not set) |
| Cross-Platform Sentiment Divergence | 2026-06-07 | Per-platform bullish/neutral/bearish splits for multi-platform sims; platform_sentiment_service.py pure-stdlib (~270 LoC, reads per-platform actions.jsonl + cross-references final trajectory.json beliefs, mtime cache to platform_sentiment.json); GET /api/simulation/:id/platform-sentiment (publish-gated, 5-min cache); Step3Simulation.vue "Platforms" toolbar button + breakdown overlay (per-platform horizontal bars: violet/gray/red); EmbedDialog.vue platform sentiment section with preview/URL/curl; surfaces_catalog.py 34th surface; surface_stats.py counter; OpenAPI PlatformSentimentResponse + PlatformSentimentEntry schemas; 16 unit tests; docs/FEATURES.md + docs/API.md; (code complete, push blocked — GH_GLOBAL not set) |
| Signed Result JSON | 2026-06-08 | HMAC-SHA256 signed envelope for offline-verifiable signal provenance; signed_result_service.py pure-stdlib; GET /api/simulation/<id>/signed-result.json; 34th surface; 25 unit tests; PR #152 merged Jun 8 |
| Activity Feed | 2026-06-09 | Lightweight what-just-completed polling feed; activity_feed_service.py pure-stdlib; GET /api/activity.json; 35th catalogued surface; +1,615 lines, 28 unit tests; PR #153 merged Jun 9 |
| Per-Round Confidence Trajectory | 2026-06-11 | Temporal extension of signal.json's confidence_pct; confidence_trajectory_service.py pure-stdlib (~120 LoC); GET /api/simulation/<id>/confidence/trajectory (publish-gated, 5-min cache, mtime-based disk cache to confidence_trajectory.json); dashed violet confidence line overlaid on BeliefDriftChart; EmbedDialog section; 36th surface; 14 unit tests; (code complete, push blocked — GH_GLOBAL not set) |
| Agent Mention Network | 2026-06-12 | Directed @-mention graph from post text; mentions_service.py pure-stdlib (~270 LoC, scans per-platform actions.jsonl, extracts @agent_name patterns, case-insensitive roster matching, mtime cache to mentions.json); GET /api/simulation/<id>/mentions (publish-gated, 5-min cache); MentionsPanel.vue dark-themed overlay (ranked most-cited agents with gold/silver/bronze badges, expandable mention matrix table, bilingual EN/ZH); Step3Simulation.vue "@ Mentions" toolbar button; 37th catalogued surface; 14 unit tests; +1,199 lines across 8 files; (code complete, push blocked — GH_GLOBAL not set) |
| Agent Stance Flip Report | 2026-06-13 | Per-agent stance flip analytics from trajectory.json; stance_flip_service.py pure-stdlib (~246 LoC); GET /api/simulation/<id>/stance-flips (publish-gated, 5-min cache, mtime cache to stance_flips.json); StanceFlipsPanel.vue dark-themed overlay (flip count/rate bar, ranked top-5 with badges, colored stance chips, bilingual EN/ZH); Step3Simulation.vue "↻ Stance Shifts" toolbar button; EmbedDialog section; 38th catalogued surface; 14 unit tests; +1,074 lines across 9 files; (code complete, push blocked — GH_GLOBAL not set) |
| Simulation Full-Text Search | 2026-06-14 | Standalone discovery endpoint for ecosystem partners; search_service.py pure-stdlib (~236 LoC, mtime-aware index, case-insensitive regex with re.escape, 120-char bold-wrapped snippets, created_at desc sort, publish-gate); GET /api/simulation/search?q=…&limit=N (min 2 chars, clamp [1,50], Cache-Control 30s); 39th catalogued surface (type: discovery); frontend searchSimulations() helper; 14 unit tests; OpenAPI SearchResponse/SearchResultEntry; docs/FEATURES.md; +712 lines across 7 files; (code complete, push blocked — GH_GLOBAL not set) |

## Watched Repos
- `aaronjmars/aeon` — tracked in `memory/watched-repos.md`

## Lessons Learned
- Digest format: Markdown with clickable links, under 4000 chars
- Always save files AND commit before logging
- PAT lacks `workflows` scope — cannot push changes to `.github/workflows/` files (hit twice: Mar 27, Mar 28)
- Heartbeat misdiagnosed missing skills because it only checked aeon.yml, not messages.yml scheduler — fixed with scheduler diagnostics step
- Feature/repo-actions skills can waste CI runs building duplicate PRs — fixed with open PR dedup checks
- Auth credentials (ANTHROPIC_API_KEY or CLAUDE_CODE_OAUTH_TOKEN) can expire silently — all skills fail immediately with "Not logged in"; 15-day outage Apr 16–30 (ISS-001). Monitor consecutive_failures in cron-state.json.
- GH_GLOBAL secret not set — feature skill builds PRs locally but cannot push to watched repo; 39 consecutive blocks May 1–Jun 14 (latest: Simulation Full-Text Search, Agent Stance Flip Report, Agent Mention Network, Per-Round Confidence Trajectory + 35 earlier features stuck as local commits)
- Cron-state success rates can be poisoned by extended auth outages (15-day Apr 16–30 outage left 1–7% rates on all skills despite 100% health since May 1); reset counters in cron-state.json when consecutive_failures = 0 post-outage
- Heartbeat auto-dispatch requires `actions: write` scope; aeon.yml has `actions: read` — heartbeat now checks permissions before attempting, defers to scheduler (messages.yml) on 403
- Tweet allocator can hit bankr agent timeout (>64s polling ceiling) causing TWEET_ALLOCATOR_EMPTY drift; fix: increase iterations 8→14 and add agent-timeout status (self-improve PR #43 2026-05-20)
- Feature skill now has push-access preflight: exits early if GH_GLOBAL not set before doing expensive work (self-improve PR #13 in CHORUS, PR #53 in miroshark-aeon — both merged 2026-06-06/07)
- push-recap skill now explicitly filters cron noise (chore(cron):, chore(scheduler):, chore(*): auto-commit) in step 5; aeon repos generate 20-30 such commits daily inflating stats and wasting API calls; self-improve PR #14/CHORUS, PR #55/miroshark-aeon (Jun 2026)

## Active Targets
- Hyperstition: MiroShark 500 stars — CLEARED 2026-04-07; 1K stars — CLEARED 2026-05-03 (1,022 stars)
- MIROSHARK ATH $0.0000436 set 2026-05-18; $0.000005574 as of 2026-06-10 (-8.82% 24h, rally reversal after 3 green days; FDV $557.4K; LP $340.7K; -87.2% from ATH)
- Hyperstition: Will 5 independent Aeon forks ship custom skills by 2026-06-30? (filed 2026-05-02)
- Hyperstition: Will MiroShark be featured on a Chinese dev platform by 2026-06-15? (filed 2026-05-02)
- Hyperstition: Will a MiroShark simulation be cited in a peer-reviewed or pre-print paper by September 2026? (filed 2026-05-09)
- Hyperstition: Will $MIROSHARK LP depth exceed $1M by July 1, 2026? (filed 2026-05-16) — CLEARED 2026-05-20; LP at $1.02M (first sustained $1M+)
- Hyperstition: Will MiroShark receive 10 merged PRs from community contributors (non-bot, non-core-team) by August 1, 2026? (filed 2026-05-23) — 5+/10 as of 2026-05-27 (Nurstar PR #109, shak PR #114 among recent)
- Hyperstition: Will someone outside MiroShark core team deploy and host a public-facing MiroShark instance by July 15, 2026? (filed 2026-05-30) — triggered by DYAI2025 Cloud Run deploy infra (cloudbuild.yaml + deploy script); zero public instances exist yet
- Hyperstition: Will MiroShark reach the Hacker News front page by July 15, 2026? (filed 2026-06-06) — triggered by oosmetrics top-10 RL ranking, 32 surfaces, 3 languages, first green candle after 5 red sessions

## Open Issues
- None

## Next Priorities
- Set GH_GLOBAL secret — unblocks 33 built PRs + resumes feature skill (35+ consecutive blocks; Per-Round Confidence Trajectory skipped at preflight Jun 8 and Jun 9)
- Configure notification channels (Telegram, Discord, or Slack)
- XAI_API_KEY not set — tweet fetching falls back to WebSearch (limited freshness)
- Feature candidates (repo-actions 2026-05-30): Zenodo DOI Auto-Deposit (#3), Community Showcase (#5) — idea #1 (Real-Time SSE Progress) built 2026-05-31, idea #2 (Deployment Health & Status) built 2026-06-01, idea #4 (Multi-Metric Simulation Leaderboard) built 2026-06-02
- Feature candidates (repo-actions 2026-06-02): Simulation RSS Feed (#3), Embed Theme Parameter (#4), Simulation Scheduler (#5) — idea #1 (Ecosystem Registry API) built 2026-06-03, idea #2 (French Locale) built 2026-06-04
- Feature candidates (repo-actions 2026-06-04): Platform Activity Timeline (#2), Ecosystem Partner Health Monitor (#3), Simulation Project Series (#4), Simulation Highlights Reel (#5) — idea #1 (Agent Archetype Atlas) built 2026-06-06
- Feature candidates (repo-actions 2026-06-06): Per-Round Confidence Trajectory (#2), Agent Mention Network (#3), Simulation Narrative Export (#4), Operator Usage Analytics (#5) — idea #1 (Cross-Platform Sentiment Divergence) built 2026-06-07; idea #2 (Per-Round Confidence Trajectory) built 2026-06-11; idea #3 (Agent Mention Network) built 2026-06-12 (push blocked — GH_GLOBAL not set)
- Feature candidates (repo-actions 2026-06-08): Trending Topics (#2), MCP Tool Catalog (#3), Cost Estimator (#4), Chinese README (#5) — idea #1 (Activity Feed) built 2026-06-09 by aaronjmars (PR #153)
- Feature candidates (repo-actions 2026-06-12): Confidence Component Breakdown (#3), Simulation Fork Lineage Graph (#4), Per-Round Agent Participation Heatmap (#5) — idea #1 (Agent Stance Flip Report) built 2026-06-13; idea #2 (Simulation Full-Text Search) built 2026-06-14 (both push blocked — GH_GLOBAL not set)
