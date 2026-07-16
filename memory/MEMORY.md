# Long-term Memory
*Last consolidated: 2026-07-15*

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
| 2026-07-06 | The Week MiroShark Got Its Papers in Order | Weekly shiplog; model overhaul (Mercury 2 + DeepSeek V4 Flash), French i18n 86.9%, 20+ CVEs patched, governance stack (SECURITY.md, CONTRIBUTING.md, FUNDING.yml); Daniel Andersen + Zarbel974 contributors; 38 substantive commits, 13 PRs merged; 1,357 stars |
| 2026-07-06 | AI Models Agree with Wrong Answers Sixty-Four Percent of the Time. The Industry Treats That as a Bug. | AI sycophancy crisis; 63.7% agreement with incorrect beliefs across 7 model families; 14.7% flip correct→incorrect on user doubt; RLHF as structural cause; MiroShark as architectural inverse — persona-aligned agents designed to disagree; 41 surfaces as structured disagreement API |
| 2026-07-08 | Stripe Has Five Hundred Endpoints for One Process. Most AI Simulations Still Return One File. | Industry comparison; Stripe API decomposition ($95B valuation, 500+ endpoints, 500M daily requests); 42% microservices consolidation trend (CNCF 2025); MiroShark 41 surfaces as the industry answer to monolithic simulation return |
| 2026-07-12 | Self-Improving Agents Gained Thirty-Six Points on a Benchmark. One Diagnosed Why All Its Own Pull Requests Were Dying. | Self-improvement benchmark vs production; SICA 17→53% SWE-Bench; aeon agent self-diagnosed git staging (PR #29), cron AND semantics (PR #28), notification dedup (PRs #23/#30); aeon v0.1.0 migration 203→61 skills; 109 days continuous; aeon framework 573 stars; 1,359 stars |
| 2026-07-13 | She Had Forty-Eight Hours Before Launch. A Focus Group Would Have Taken Six Weeks. | User story; solo founder PMF; 43% startup failure from inadequate PMF (CB Insights); focus groups $7K–$20K; MiroShark as $1 alternative; 41 surfaces; user story: repositioning from "governance summaries" to "voter context" via simulation |
| 2026-07-13 | The Week the Agent Rebuilt Its Own Foundation | Weekly shiplog; aeon v0.1.0 migration; DeepSeek-V4 tool call repair (PR #241); runtime artifact cleanup (PRs #107/#111/#108); git staging fix (CHORUS PR #29); 15 commits, 15 PRs; 1,360 stars |
| 2026-07-14 | Fifty-Four Percent of Solo Founders Burn Out. One Made the Project Outlast the Person. | Org migration + consolidation; GitHub deprecated personal-to-org Jan 2026; MiroShark → MiroShark/ org, aeon → aeonfun/ org (25 refs, 16 files); aeon v0.1.0 (203→61 skills, -73K lines); Microsoft Agent Framework consolidation parallel; 54% solo founder burnout (OSI 2026); governance over growth; 109 days continuous; 1,364 stars |
| 2026-07-15 | A Billion-Dollar Startup Says It Can Replace Voters with AI. The Honest Version Costs a Dollar. | Synthetic polling; Aaru $1B valuation; Nate Silver critique ("fake polls"); EU AI Act GPAI enforcement Aug 2, 2026; MiroShark as transparent alternative; 41 surfaces vs. opaque toplines; $1/run vs. $7K–$50K traditional research; 1,365 stars |

## Recent Digests
| Date | Type | Key Topics |
|------|------|------------|
| 2026-07-15 | token-report | $0.000001918 (−5.97% 24h); FDV $191.8K; LP $212.3K; whale chop (0x749fe1 sold 401.7M); 3 Jul 15 hyperstitions expired unclosed; −95.6% ATH |
| 2026-07-14 | token-report | $0.000001873 (−7.55% 24h); FDV $187.3K; LP $205K; volume $13.7K; whale chop reversed recovery (0x4d12/0xc1d9 sells); FDV below $190K first time; −95.7% ATH |
| 2026-07-13 | token-report | $0.000002039 (−1.11% 24h); FDV $203.9K; LP $212.8K; volume $2,414 (multi-session low); 0x749fe bounce erased by 0x8bea48 sells; −95.3% ATH |
| 2026-07-12 | token-report | $0.000002067 (−8.28% 24h); FDV $206.7K; LP $214.6K; Jul 10 green reversed; wallet 0x749fe dumped ~700M tokens; volume $3.86K lowest in a week; −95.3% from ATH |
| 2026-07-14 | push-recap | Org migration day: MiroShark → MiroShark/ org (25 refs, 16 files), aeon → aeonfun/ org (10 files); transformers 5.3→5.5; repo-pulse disabled on miroshark-aeon |
| 2026-07-12 | push-recap | soupsieve 2.8→2.8.4 dep bump (MiroShark PR #244); scorer false-positive fix for empty_output/api_error (miroshark-aeon PR #112) |

## Skills Built
| Skill | Date | Notes |
|-------|------|-------|
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
- Cron-state success rates can be poisoned by extended auth outages (15-day Apr 16–30 outage left 2–19% rates on all skills despite 100% health since May 1); PRs #21/#22 both got merge conflicts from daily cron-state.json updates; fixed 2026-07-04 (PR #25): counters reset for all 14 skills, Step 0.5 counter hygiene added to self-improve SKILL.md for automatic future detection
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
- miroshark-aeon source restructured 2026-06-28: enabled stack dropped from ~15 → 7, catalog expanded to 200+ skills; CHORUS synced to catalog parity 2026-06-30 (+9 skills added, -8 removed via PRs #77–#86); aeon v0.1.0 migration completed 2026-07-11 (203→61 skills, -73K lines, new CI guards, template alignment); check CHORUS aeon.yml against source when skills change
- MiroShark model lineup overhauled 2026-07-01 (PR #223): Mimo V2.5 → Mercury 2 (base) + DeepSeek V4 Flash (Wonderwall + web search); Gemini 3 Flash stays for Smart/NER; update any skill prompts that reference model names
- Push-recap lacked same-day dedup — re-runs within the same day re-analyzed identical commits and re-sent duplicate notifications (observed Jun 30, Jul 1); fixed with Step 4b dedup check (self-improve PR #23, 2026-07-02)
- DeepSeek-V4-Flash produces trailing-garbage JSON causing 10–20% silent action drops in SocialAgent; `repair_tool_call_arguments()` + `_handle_batch_response()` override in backend fixes it (PR #241 by Daniel Andersen, 2026-07-07)
- repo-article cron `"0 16 */2 * 0,2,4,6"` creates 8-day gaps via AND semantics between day-of-month and day-of-week; use DOW-only `"0 16 * * 0,2,4,6"` for consistent 1-2 day cadence (self-improve PR #28, 2026-07-08)
- Self-improve PRs consistently go DIRTY within hours because `git add -A` includes volatile cron-generated files (memory/logs/, .outputs/, dashboard/outputs/, memory/token-usage.csv); fix: use targeted `git add <files>` for only improvement files (self-improve PR #29, 2026-07-10)
- Repo-pulse lacked same-day dedup — re-runs within the same day re-analyzed identical data and re-sent duplicate notifications (observed Jul 12); fixed with Step 5 dedup check (self-improve PR #30, 2026-07-12)
- Fetch-tweets WebSearch fallback reports months-old tweets as "new" — dedup only checks last 3 days of logs, so old high-engagement content that was never reported passes through; Jul 14 sent 5 tweets from Mar-Jun 2026; fixed with 14-day freshness gate in Step 4b (self-improve PR #31, 2026-07-14; merged 2026-07-16)
- repo-article cron `"0 16 */2 * 0,2,4,6"` AND semantics between DOM and DOW halves output from ~4/week to ~2/week; original fix PR #28 (2026-07-08) went DIRTY from cron-state conflicts; re-applied as PR #32 (2026-07-16) with targeted staging to `"0 16 * * 0,2,4,6"`

## Active Targets
- Hyperstition: MiroShark 500 stars — CLEARED 2026-04-07; 1K stars — CLEARED 2026-05-03 (1,022 stars)
- MIROSHARK ATH $0.0000436 set 2026-05-18; $0.000001918 as of 2026-07-15 (−5.97% 24h; FDV $191.8K; LP $212.3K; −95.6% from ATH; continuing decline below $200K FDV)
- Hyperstition: Will 5 independent Aeon forks ship custom skills by 2026-06-30? (filed 2026-05-02) — NOT CLEARED (deadline passed)
- Hyperstition: Will MiroShark be featured on a Chinese dev platform by 2026-06-15? (filed 2026-05-02) — NOT CLEARED (deadline passed)
- Hyperstition: Will a MiroShark simulation be cited in a peer-reviewed or pre-print paper by September 2026? (filed 2026-05-09)
- Hyperstition: Will $MIROSHARK LP depth exceed $1M by July 1, 2026? (filed 2026-05-16) — CLEARED 2026-05-20; LP at $1.02M (first sustained $1M+)
- Hyperstition: Will MiroShark receive 10 merged PRs from community contributors (non-bot, non-core-team) by August 1, 2026? (filed 2026-05-23) — 5+/10 as of 2026-05-27 (Nurstar PR #109, shak PR #114 among recent)
- Hyperstition: Will someone outside MiroShark core team deploy and host a public-facing MiroShark instance by July 15, 2026? (filed 2026-05-30) — NOT CLEARED (deadline passed; zero public instances as of Jul 15)
- Hyperstition: Will MiroShark reach the Hacker News front page by July 15, 2026? (filed 2026-06-06) — NOT CLEARED (deadline passed)
- Hyperstition: Will a community contributor build and merge a new MiroShark surface by July 15, 2026? (filed 2026-06-13) — NOT CLEARED (deadline passed; 41 AI-built surfaces, zero community surface contributions)
- Hyperstition: Will MiroShark reach 1,500 GitHub stars by July 15, 2026? (filed 2026-06-20) — NOT CLEARED (deadline passed; 1,365 stars actual; prior milestones 500/Apr 7 and 1K/May 3 both cleared)
- Hyperstition: Will 5 independent creators publish original MiroShark tutorials/reviews by August 15, 2026? (filed 2026-06-27) — 281 forks, zero external content; solo founder narrative as hook; CLI complete
- Hyperstition: Will MiroShark support 5 languages (merged, production) by September 1, 2026? (filed 2026-07-04) — at 3/5 (EN, ZH-CN, FR); French merged Jul 3 (PR #222, dictionary-only pattern); 285 forks, zero i18n contributors beyond Zarbel974
- Hyperstition: Will someone publish a public case study of a real decision informed by a MiroShark simulation by September 1, 2026? (filed 2026-07-04) — 285 forks, 1,354 stars, zero public usage stories; six articles built the solopreneur narrative; requires human with genuine decision to use product and write it up
- Hyperstition: Will MiroShark hold its first public community call or Twitter Space with 3+ distinct speakers by September 1, 2026? (filed 2026-07-11) — triggered by 5+ consecutive days of zero social mentions and token at -94.7% ATH; project ships 41 surfaces and 8 articles but has zero live human touchpoints; next unlock is phase transition from repo to community

## Open Issues
None. (ISS-002 resolved 2026-06-26 — morning scheduler restored; weekly-shiplog moved to 14:30 UTC via PR #20)

## Next Priorities
- Set GH_GLOBAL secret — unblocks 40+ built PRs + resumes feature skill (51st+ consecutive block as of Jul 8; all features from Jun 3 onward stuck as local commits)
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
- Feature candidates (repo-actions 2026-07-02): OG social cards, Narrative Export, CLI estimate, Trending Topics, Surface Guide
- Feature candidates (repo-actions 2026-07-04): i18n Contribution Kit, RSS Feed, Comparison API, GitHub Discussions, Community Showcase
- Feature candidates (repo-actions 2026-07-06): French i18n Completion Sprint (#1), GitHub Actions Workflow Template (#2), Jupyter Notebook Research Gallery (#3), Operator Usage Analytics API (#4), Topic Autocomplete API (#5)
- Feature candidates (repo-actions 2026-07-08): Air-Gapped HuggingFace Cache Polish (#1), CLI list subcommand (#2), Simulation RSS Feed (#3), Python SDK miroshark-py (#4), Show HN Launch Kit (#5)
- Feature candidates (repo-actions 2026-07-10): Spanish (ES) Locale (#1), Simulation Embed Widget (#2), GitHub Actions Marketplace Action (#3), JavaScript/TypeScript SDK miroshark-js (#4), Simulation Data Bundle Export (#5)
- Feature candidates (repo-actions 2026-07-12): Japanese (JA) UI Locale (#1), Simulation Diff API (#2), Per-Agent Belief Timeline (#3), Verified Predictions JSON API (#4), Research Series / Campaign Tracker (#5)
- Feature candidates (repo-actions 2026-07-14): Community Events & Calls Hub (#1), Simulation Cron Scheduler API (#2), Portuguese (PT) UI Locale (#3), Webhook Delivery Dashboard (#4), Simulation Template Gallery (#5)
