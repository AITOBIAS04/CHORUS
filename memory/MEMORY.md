# Long-term Memory
*Last consolidated: 2026-07-01*

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
| 2026-06-20 | Forty-Seven Percent of AI Agent Releases Roll Back. Automated Testing Cuts That to Nine. | AI agent testing gap; only 38% of production agents have automated evals; 47% rollback vs 9% with tests; 37% lab-to-production gap; 61% multi-agent failures at boundaries; MiroShark 1,372 tests across 41 surfaces; smoke tests for real output (#183/#196); mocked LLM client (#165); CI gate (#180); pure-stdlib testability; $10.3B AI simulation market; 1,317 stars |
| 2026-06-22 | It Took 64,000 People to Forecast the Weather. It Takes Twelve Agents to Forecast an Opinion. | Historical parallel; Richardson's 1922 Forecast Factory (64K human computers); ENIAC first numerical weather prediction (1950); ensemble forecasting via perturbed initial conditions; MiroShark multi-agent simulation as modern forecast factory; confidence trajectory + stance flip as perturbation tracking; pre-run estimator as resource planning; 1,322 stars |
| 2026-06-24 | Thirty Projects Simulate Societies Now. Almost None Ship a Result You Can Query. | Ecosystem map; AI synthetic society field explosion (30+ open-source projects, Rosehill catalog); POSIM BDI framework (arXiv Mar 2026); OASIS 1M agents; StackOne 120+ agentic AI tools landscape; MiroShark 41 queryable API surfaces as "last mile" translation layer; research-application gap; 1,333 stars |
| 2026-06-26 | Forty-One Million Americans Run a Business Alone. AI Handles Everything Except the Hardest Question. | User story; solo founder boom (41M US solopreneurs, 36% solo-founded startups, Fortune/Shlomo Base44 $80M exit); Harvard synthetic focus group limitations (sycophancy, novelty bias); MiroShark as missing opinion-simulation layer ($1, 10 min, 41 surfaces, CLI automation, local LLM self-hosting); 1,337 stars |
| 2026-06-28 | Two Hundred Eighty-One People Forked the Repo. One of Them Came Back. | Fork-to-contribution gap; CMU 14% fork contribution rate; Linux Foundation $258K/cycle private fork cost; Daniel Andersen 9 merged PRs (only sustained community contributor); 281 forks, zero external tutorials; AI agent $10.9B market, 40% cancellation risk; content gap as community bottleneck; 1,348 stars |
| 2026-06-30 | Four Shell Commands Run a Hundred-Agent Simulation End to End. The Rest of the Industry Still Ships Dashboards. | CLI automation lifecycle complete (simulate/wait/stop/cost); 30+ AI CLIs in 2026 but none simulate opinions; 102 days from first commit; 84% developer AI adoption; CLI-first trend; 1,353 stars |
| 2026-07-01 | The Choice Was Never Whether to Simulate. It Was Whether to Write the Model Down. | Philosophy/big ideas; Epstein "Why Model?" implicit vs explicit models; Mayo-Wilson & Zollman (Synthese 2021) simulations superior to thought experiments in 5/6 uses; Schelling segregation model; 24 centuries of Gedankenexperiment as unqueryable wetware; MiroShark operationalizes the thought experiment — 4 CLI commands, 41 queryable surfaces, $1/run; 1,353 stars |
| 2026-07-02 | Three Hundred Fifteen Thousand Dollars to Switch an AI Model. Or Twelve Files. | Model portability; $315K avg migration cost (VaasBlock); 81% vendor dependency concern; only 42% smooth migrations; PR #223 swapped Mimo V2.5 → Mercury 2 + DeepSeek V4 Flash in 12 files; OpenRouter 400+ model gateway; abstraction layers cut effort 60-80%; community PR #222 French i18n (Zarbel974); 1,354 stars |
| 2026-07-03 | Seventy-Nine Percent of Organizations Cannot Trace What Their AI Agent Did. The Fix Is Not Another Dashboard. | Technical deep-dive; PwC 79% can't trace agent failures; $2.69B observability market; arXiv multi-layer observability gaps; IBM AAAI 2026 agentic observability; MiroShark 41 surfaces as "observability by design" — intermediate states are first-class API endpoints not ephemeral execution data; read-model decomposition; surfaces catalog meta-surface; 1,355 stars |

## Recent Digests
| Date | Type | Key Topics |
|------|------|------------|
| 2026-07-01 | token-report | $0.000003121 (−19.94% 24h); FDV $312.1K; LP $237.6K; Q3 2026 open; single large sell ~$7.1K pushed price to $2.96e-6 intraday low; LP drain accelerated (−$36.1K in one day); −92.8% from ATH |
| 2026-07-01 | push-recap | PR #223 model overhaul: Mercury 2 (base) + DeepSeek V4 Flash (Wonderwall + web search) replaces Mimo V2.5; Gemini 3 Flash stays for Smart/NER; 12 files changed |
| 2026-06-30 | token-report | $0.000003898 (−2.57% 24h); FDV $389.8K; LP $273.7K; Q2 2026 close; concentrated sell at ~21:00 UTC Jun 29 drove most daily volume; −91.1% from ATH |
| 2026-06-30 | push-recap | Aeon sync: +9 skills added, -8 removed, catalog parity with source; products.md created; shiplog redesign; 10 substantive commits, +2,287/-1,904 lines |
| 2026-06-29 | token-report | $0.000004106 (−4.22% 24h); FDV $410.6K; LP $280.1K; third consecutive day below $4.4e-6 demand zone; Jun 27 bounce fully reversed; −90.6% from ATH |
| 2026-06-29 | push-recap | Frontend deps bump (axios 1.18.1, vue 3.5.39, vite 8.1.0); CI actions bump (checkout v7, docker/login-action v4); 7 substantive commits |

## Skills Built
| Skill | Date | Notes |
|-------|------|-------|
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
| Pre-Run Time & Cost Estimate | 2026-06-20 | Data-driven pre-run estimator from historical sim data; estimate_service.py pure-stdlib (~266 LoC, scans completed public sims, ±30% agent-count + ±1 round bucketing, median duration/cost, 15min mtime-cached index, 4-tier confidence: high/medium/low/unavailable); GET /api/estimate?agents=N&rounds=N&platforms=P (public/keyless, 15min cache); frontend Step2EnvSetup.vue debounced estimate fetch + data-driven "~N min · ~$X.XX" chip with confidence dot (green/yellow/gray), falls back to naive formula when unavailable; estimate.py route (102 LoC); 10 unit tests; OpenAPI EstimateResponse schema; surfaces_catalog.py 41st surface; docs/FEATURES.md; +806 lines across 10 files; (code complete, push blocked — GH_GLOBAL not set) |

## Watched Repos
- `aaronjmars/aeon` — tracked in `memory/watched-repos.md`

## Lessons Learned
- Digest format: Markdown with clickable links, under 4000 chars
- Always save files AND commit before logging
- PAT lacks `workflows` scope — cannot push changes to `.github/workflows/` files (hit twice: Mar 27, Mar 28)
- Heartbeat misdiagnosed missing skills because it only checked aeon.yml, not messages.yml scheduler — fixed with scheduler diagnostics step
- Feature/repo-actions skills can waste CI runs building duplicate PRs — fixed with open PR dedup checks
- Auth credentials (ANTHROPIC_API_KEY or CLAUDE_CODE_OAUTH_TOKEN) can expire silently — all skills fail immediately with "Not logged in"; 15-day outage Apr 16–30 (ISS-001). Monitor consecutive_failures in cron-state.json.
- GH_GLOBAL secret not set — feature skill builds PRs locally but cannot push to watched repo; 45 consecutive blocks May 1–Jun 22 (latest skip: feature blocked Jun 22; 40 features stuck as local commits)
- Cron-state success rates can be poisoned by extended auth outages (15-day Apr 16–30 outage left 2–19% rates on all skills despite 100% health since May 1); PR #21 attempted fix Jun 30 but got merge conflicts; fixed 2026-07-02 (PR #22): counters reset, Step 0.5 counter hygiene added to self-improve SKILL.md for automatic future detection
- Heartbeat auto-dispatch requires `actions: write` scope; aeon.yml has `actions: read` — heartbeat now checks permissions before attempting, defers to scheduler (messages.yml) on 403
- Tweet allocator can hit bankr agent timeout (>64s polling ceiling) causing TWEET_ALLOCATOR_EMPTY drift; fix: increase iterations 8→14 and add agent-timeout status (self-improve PR #43 2026-05-20)
- Feature skill now has push-access preflight: exits early if GH_GLOBAL not set before doing expensive work (self-improve PR #13 in CHORUS, PR #53 in miroshark-aeon — both merged 2026-06-06/07)
- push-recap skill now explicitly filters cron noise (chore(cron):, chore(scheduler):, chore(*): auto-commit) in step 5; aeon repos generate 20-30 such commits daily inflating stats and wasting API calls; self-improve PR #14/CHORUS, PR #55/miroshark-aeon (Jun 2026)
- Feature skill now clones into workspace (not /tmp) and runs test suite before shipping PRs — validates builds before pushing; self-improve PR #60 in miroshark-aeon (2026-06-12)
- Heartbeat dispatch preflight: single probe checks `actions: write` before the dispatch loop — avoids wasted 403 calls per run; self-improve PR #15 in CHORUS (2026-06-14)
- Feature skill avoids over-promising pytest in sandbox — no longer claims tests pass when sandbox blocks the test runner (false confidence); self-improve PRs #63-65 in miroshark-aeon (2026-06-16)
- Self-improve PRs pile up without merging (15 stalled PRs, weeks old); added auto-merge Step 0 to self-improve skill — merges own stale PRs (>48h, no conflicts) before creating new ones; self-improve PR #16 in CHORUS (2026-06-18)
- repo-actions skill now has a premise verification gate to validate ideas before generating full proposals — avoids wasted compute on unfeasible suggestions; self-improve PRs #69/#70 in miroshark-aeon (2026-06-21)
- Heartbeat 48h notification dedup silences persistent multi-day issues — operator stops hearing about failures that are still active; added open-issue escalation (≥3 days bypasses dedup); self-improve PR #18 in CHORUS (2026-06-24)
- weekly-shiplog missed 39 consecutive Mondays (May 18–Jun 28) because 09:00 UTC slot falls in the scheduler dead zone; moved to 14:30 UTC (afternoon window reliable per ISS-002); self-improve PR #20 in CHORUS (2026-06-28)
- miroshark-aeon source restructured 2026-06-28: enabled stack dropped from ~15 → 7, catalog expanded to 200+ skills; CHORUS synced to catalog parity 2026-06-30 (+9 skills added, -8 removed via PRs #77–#86); check CHORUS aeon.yml against source when skills change
- MiroShark model lineup overhauled 2026-07-01 (PR #223): Mimo V2.5 → Mercury 2 (base) + DeepSeek V4 Flash (Wonderwall + web search); Gemini 3 Flash stays for Smart/NER; update any skill prompts that reference model names
- Push-recap lacked same-day dedup — re-runs within the same day re-analyzed identical commits and re-sent duplicate notifications (observed Jun 30, Jul 1); fixed with Step 4b dedup check (self-improve PR #23, 2026-07-02)

## Active Targets
- Hyperstition: MiroShark 500 stars — CLEARED 2026-04-07; 1K stars — CLEARED 2026-05-03 (1,022 stars)
- MIROSHARK ATH $0.0000436 set 2026-05-18; $0.000003121 as of 2026-07-01 (-19.94% 24h; FDV $312.1K; LP $237.6K; -92.8% from ATH)
- Hyperstition: Will 5 independent Aeon forks ship custom skills by 2026-06-30? (filed 2026-05-02) — NOT CLEARED (deadline passed)
- Hyperstition: Will MiroShark be featured on a Chinese dev platform by 2026-06-15? (filed 2026-05-02) — NOT CLEARED (deadline passed)
- Hyperstition: Will a MiroShark simulation be cited in a peer-reviewed or pre-print paper by September 2026? (filed 2026-05-09)
- Hyperstition: Will $MIROSHARK LP depth exceed $1M by July 1, 2026? (filed 2026-05-16) — CLEARED 2026-05-20; LP at $1.02M (first sustained $1M+)
- Hyperstition: Will MiroShark receive 10 merged PRs from community contributors (non-bot, non-core-team) by August 1, 2026? (filed 2026-05-23) — 5+/10 as of 2026-05-27 (Nurstar PR #109, shak PR #114 among recent)
- Hyperstition: Will someone outside MiroShark core team deploy and host a public-facing MiroShark instance by July 15, 2026? (filed 2026-05-30) — triggered by DYAI2025 Cloud Run deploy infra (cloudbuild.yaml + deploy script); zero public instances exist yet
- Hyperstition: Will MiroShark reach the Hacker News front page by July 15, 2026? (filed 2026-06-06) — triggered by oosmetrics top-10 RL ranking, 32 surfaces, 3 languages, first green candle after 5 red sessions
- Hyperstition: Will a community contributor build and merge a new MiroShark surface by July 15, 2026? (filed 2026-06-13) — 37 AI-built surfaces; lowest barrier to contribute yet (CONTRIBUTING.md, trilingual READMEs, surfaces.json type-filter)
- Hyperstition: Will MiroShark reach 1,500 GitHub stars by July 15, 2026? (filed 2026-06-20) — 1,333 stars; @github_repo trending bot featured it; need 167 more in 21 days (~8.0/day); prior milestones 500 (Apr 7) and 1K (May 3) both cleared
- Hyperstition: Will 5 independent creators publish original MiroShark tutorials/reviews by August 15, 2026? (filed 2026-06-27) — 281 forks, zero external content; solo founder narrative as hook; CLI complete

## Open Issues
None. (ISS-002 resolved 2026-06-26 — morning scheduler restored; weekly-shiplog moved to 14:30 UTC via PR #20)

## Next Priorities
- Set GH_GLOBAL secret — unblocks 40+ built PRs + resumes feature skill (49th+ consecutive block as of Jun 27-28; all features from Jun 3 onward stuck as local commits)
- Configure notification channels (Telegram, Discord, or Slack)
- XAI_API_KEY not set — tweet fetching falls back to WebSearch (limited freshness)
- Feature candidates (repo-actions 2026-05-30): Zenodo DOI Auto-Deposit (#3), Community Showcase (#5) — idea #1 (Real-Time SSE Progress) built 2026-05-31, idea #2 (Deployment Health & Status) built 2026-06-01, idea #4 (Multi-Metric Simulation Leaderboard) built 2026-06-02
- Feature candidates (repo-actions 2026-06-02): Simulation RSS Feed (#3), Embed Theme Parameter (#4), Simulation Scheduler (#5) — idea #1 (Ecosystem Registry API) built 2026-06-03, idea #2 (French Locale) built 2026-06-04
- Feature candidates (repo-actions 2026-06-04): Platform Activity Timeline (#2), Ecosystem Partner Health Monitor (#3), Simulation Project Series (#4), Simulation Highlights Reel (#5) — idea #1 (Agent Archetype Atlas) built 2026-06-06
- Feature candidates (repo-actions 2026-06-06): Per-Round Confidence Trajectory (#2), Agent Mention Network (#3), Simulation Narrative Export (#4), Operator Usage Analytics (#5) — idea #1 (Cross-Platform Sentiment Divergence) built 2026-06-07; idea #2 (Per-Round Confidence Trajectory) built 2026-06-11; idea #3 (Agent Mention Network) built 2026-06-12 (push blocked — GH_GLOBAL not set)
- Feature candidates (repo-actions 2026-06-08): Trending Topics (#2), MCP Tool Catalog (#3), Cost Estimator (#4), Chinese README (#5) — idea #1 (Activity Feed) built 2026-06-09 by aaronjmars (PR #153)
- Feature candidates (repo-actions 2026-06-12): Confidence Component Breakdown (#3), Simulation Fork Lineage Graph (#4), Per-Round Agent Participation Heatmap (#5) — idea #1 (Agent Stance Flip Report) built 2026-06-13; idea #2 (Simulation Full-Text Search) built 2026-06-14 (both push blocked — GH_GLOBAL not set)
- Feature candidates (repo-actions 2026-06-14): Webhook Delivery for Simulation Events (#1), Simulation Data Bundle Export (#2), Simulation Comparison API (#3), API Rate Limiting & Usage Headers (#4), 24h Activity Digest Endpoint (#5)
- Feature candidates (repo-actions 2026-06-16): Simulation Cost Budget & Alerts (#1), Web Push Notification for Simulation Completion (#2), Operator Usage Analytics (#3), Translation Contribution Scaffold (#4), Simulation RSS Feed (#5)
- Feature candidates (repo-actions 2026-06-18): Agent Influence Leaderboard (#1 — already built), Simulation Time-to-Complete Estimator (#2 — built 2026-06-20, push blocked), Simulation Replay Stepper (#3), Per-Round Cost Curve (#4), Topic Trend Tracker (#5 — already built)
- Feature candidates (repo-actions 2026-06-24): CLI simulate subcommand, OG social cards, campaign series tracker, tags & labels, contributor leaderboard
- Feature candidates (repo-actions 2026-06-26): Agent Communication Transcript Export, Round-Level State Snapshot API, GitHub Actions Workflow Template, Jupyter Notebook Research Gallery, Topic Autocomplete API
- Feature candidates (repo-actions 2026-06-28): Simulation Badge API, Python SDK Package miroshark-py, CLI list subcommand, Webhook Event Delivery, Tutorial Workshop Kit
- Feature candidates (repo-actions 2026-06-30): Show HN Launch Kit (#1), Simulation Data Bundle Export (#2), API Rate Limiting & Usage Headers (#3), Simulation Replay Stepper (#4), One-Click Cloud Deploy Templates (#5)
